library Mimicry initializer Init requires Cooldown, TooltipFrame, HeroAbilityTable

    globals
        // ===================== CONFIG =====================
        private constant real    COOLDOWN      = 30.
        private constant integer MAX_POSITIONS = 21
        private constant integer MAX_INDEX     = 24

        // ---- Frame placement ----
        // The button is anchored above the TOP-RIGHT slot of the command card.
        // Offsets are in screen units (the screen is 0.8 wide x 0.6 high).
        // +X moves right, +Y moves up.
        private constant integer FRAME_ANCHOR_INDEX = 3     // command button index: 0 = top-left, 3 = top-right
        private constant real    FRAME_OFFSET_X = 0.0
        private constant real    FRAME_OFFSET_Y = 0.05
        private constant real    FRAME_SIZE     = 0.034     // about the size of one command card slot

        // Tooltip box width (height comes from your GetTooltipSize)
        private constant real    TIP_WIDTH     = 0.29

        private constant real    CLICK_PICK_RANGE = 150.  // target pick radius around the mouse for unit-target abilities
        private constant string  SFX_COPY      = "Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl"
        private constant boolean DEBUG_MODE    = false
        // ====================================================

        // Per player (index = player id)
        private unit    array Caster
        private integer array CopiedId
        private integer array CopiedLevel
        private boolean array Pending       // waiting for a ground/unit click to finish a targeted cast

        // Learned or registered cast data, keyed by ability id:  0 = order id, 1 = kind (0 immediate, 1 unit, 2 point)
        private hashtable CastData = InitHashtable()

        private framehandle Btn = null
        private framehandle Icon = null
        private framehandle CdText = null
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    // Call this from anywhere to tell Mimicry how to cast an ability that was never cast
    // before. kind: 0 = no target, 1 = unit target, 2 = point target.
    // Example: call Mimicry_RegisterCast('AHtb', "thunderbolt", 1)
    function Mimicry_RegisterCast takes integer abilId, string order, integer kind returns nothing
        call SaveInteger(CastData, abilId, 0, OrderId(order))
        call SaveInteger(CastData, abilId, 1, kind)
    endfunction

    //==================================================================
    // Candidate picking
    //==================================================================
    private function IsBlacklisted takes integer id returns boolean
        return id == 'Aatk' or id == 'Amov' or id == 'Aloc' or id == 'AInv' or id == 'Avul' or id == 'Abun' or id == 'Aneu' /*
            */ or id == 'Asla' or id == 'Asl2'
    endfunction

    private function HasRealArt takes integer id returns boolean
        local string tip = BlzGetAbilityTooltip(id, 0)
        return BlzGetAbilityIcon(id) != "" and tip != "" and tip != "Tool tip missing!"
    endfunction

    private function IsCandidate takes unit caster, integer id returns boolean
        return id != 0 and id != MIMICRY_ABILITY_ID and not IsBlacklisted(id) and GetUnitAbilityLevel(caster, id) == 0 and HasRealArt(id)
    endfunction

    private function RawToString takes integer id returns string
        local string chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" // not used for lookup, see below
        local string result = ""
        local integer i = 0
        local integer c
        local integer shift = 16777216
        loop
            exitwhen i >= 4
            set c = id / shift
            set id = id - c * shift
            set shift = shift / 256
            set result = result + SubString("................................ !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", c, c + 1)
            set i = i + 1
        endloop
        return result
    endfunction

    private function PickAbility takes unit caster, unit target returns integer
        local integer array candidates
        local integer count = 0
        local integer i
        local integer j
        local integer id
        local ability a
        local boolean dup

        if IsUnitType(target, UNIT_TYPE_HERO) then
            set i = 1
            loop
                exitwhen i > MAX_POSITIONS
                set id = GetHeroSpellAtPosition(target, i)
                if IsCandidate(caster, id) then
                    set dup = false
                    set j = 0
                    loop
                        exitwhen j >= count
                        if candidates[j] == id then
                            set dup = true
                        endif
                        set j = j + 1
                    endloop
                    if not dup then
                        set candidates[count] = id
                        set count = count + 1
                    endif
                endif
                set i = i + 1
            endloop
        else
            set i = 0
            loop
                exitwhen i >= MAX_INDEX
                set a = BlzGetUnitAbilityByIndex(target, i)
                if a != null then
                    set id = BlzGetAbilityId(a)
                    if IsCandidate(caster, id) and BlzGetAbilityIcon(id) != "" then
                        set dup = false
                        set j = 0
                        loop
                            exitwhen j >= count
                            if candidates[j] == id then
                                set dup = true
                            endif
                            set j = j + 1
                        endloop
                        if not dup then
                            set candidates[count] = id
                            set count = count + 1
                        endif
                    endif
                endif
                set i = i + 1
            endloop
            set a = null
        endif

        if count == 0 then
            return 0
        endif
        return candidates[GetRandomInt(0, count - 1)]
    endfunction

    //==================================================================
    // Learn how abilities are cast by watching every spell cast in the map
    //==================================================================
    private function OnSpellEffect takes nothing returns boolean
        local integer id = GetSpellAbilityId()
        local unit c = GetTriggerUnit()
        local unit t = GetSpellTargetUnit()
        local real dx = GetSpellTargetX() - GetUnitX(c)
        local real dy = GetSpellTargetY() - GetUnitY(c)
        local integer kind

        if t != null then
            set kind = 1
        elseif dx * dx + dy * dy < 4. then
            set kind = 0
        else
            set kind = 2
        endif

        // never overwrite something registered by hand
        if not HaveSavedInteger(CastData, id, 0) then
            call SaveInteger(CastData, id, 0, GetIssuedOrderId())
            call SaveInteger(CastData, id, 1, kind)
        endif

        set c = null
        set t = null
        return false
    endfunction

    //==================================================================
    // Frame refresh (runs 4x per second): icon, cooldown text, visibility
    //==================================================================
    private function Refresh takes nothing returns nothing
        local integer pid = GetPlayerId(GetLocalPlayer())
        local boolean show = (CopiedId[pid] != 0)
        local real cd = 0.
        local string cdTxt = ""

        if show and Caster[pid] != null then
            set cd = BlzGetUnitAbilityCooldownRemaining(Caster[pid], CopiedId[pid])
            if cd > 0. then
                set cdTxt = I2S(R2I(cd) + 1)
            endif
            call BlzFrameSetTexture(Icon, BlzGetAbilityIcon(CopiedId[pid]), 0, true)
            call BlzFrameSetText(CdText, cdTxt)
        endif
        call BlzFrameSetVisible(Btn, show)
    endfunction

    //==================================================================
    // Starting a targeted cast once the player has clicked
    //==================================================================
    private function IssueCast takes integer pid, real x, real y, unit target returns nothing
        local unit c = Caster[pid]
        local integer id = CopiedId[pid]
        local integer order = LoadInteger(CastData, id, 0)
        local integer kind = LoadInteger(CastData, id, 1)

        if kind == 1 and target != null then
            call IssueTargetOrderById(c, order, target)
        elseif kind == 2 then
            call IssuePointOrderById(c, order, x, y)
        endif
        set c = null
    endfunction

    private function OnFrameEvent takes nothing returns nothing
        local framehandle f = BlzGetTriggerFrame()
        local player p = GetTriggerPlayer()
        local integer pid = GetPlayerId(p)
        local integer id = CopiedId[pid]
        local integer lvl
        local string tip
        local string title
        local real size
        local frameeventtype ev = BlzGetTriggerFrameEvent()

        if ev == FRAMEEVENT_CONTROL_CLICK then
            if p == GetLocalPlayer() then
                call BlzFrameSetEnable(f, false)
                call BlzFrameSetEnable(f, true)
            endif

            if id != 0 and Caster[pid] != null and GetWidgetLife(Caster[pid]) > 0.405 then
                if BlzGetUnitAbilityCooldownRemaining(Caster[pid], id) <= 0. then
                    if not HaveSavedInteger(CastData, id, 0) then
                        call DisplayTextToPlayer(p, 0., 0., "|cffff0000Mimicry doesn't know how to cast this ability yet (see Mimicry_RegisterCast).|r")
                    elseif LoadInteger(CastData, id, 1) == 0 then
                        call IssueImmediateOrderById(Caster[pid], LoadInteger(CastData, id, 0))
                    else
                        set Pending[pid] = true
                        call DisplayTextToPlayer(p, 0., 0., "Click a target.")
                    endif
                endif
            endif

        elseif ev == FRAMEEVENT_MOUSE_ENTER then
            if id != 0 and Caster[pid] != null then
                set lvl = GetUnitAbilityLevel(Caster[pid], id) - 1
                if lvl < 0 then
                    set lvl = 0
                endif
                set title = BlzGetAbilityTooltip(id, lvl)
                set tip = BlzGetAbilityExtendedTooltip(id, lvl)
                set size = GetTooltipSize(tip)

                if p == GetLocalPlayer() then
                    call BlzFrameSetText(TooltipTitleFrame, title)
                    call BlzFrameSetText(TooltipTextFrame, tip)
                    call BlzFrameSetSize(TooltipFrame, TIP_WIDTH, size)
                    call BlzFrameSetVisible(TooltipFrame, true)
                endif
            endif

        elseif ev == FRAMEEVENT_MOUSE_LEAVE then
            if p == GetLocalPlayer() then
                call BlzFrameSetText(TooltipTextFrame, "")
                call BlzFrameSetVisible(TooltipFrame, false)
            endif
        endif

        set f = null
        set p = null
    endfunction

    //==================================================================
    // Finishes a targeted cast on the player's next left click
    //==================================================================
    private function OnMouseDown takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local real mx
        local real my
        local group g
        local unit u
        local unit best = null
        local real bestD = 999999.
        local real d
        local integer kind

        if not Pending[pid] then
            return false
        endif

        if BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_RIGHT then
            set Pending[pid] = false
            return false
        endif
        if BlzGetTriggerPlayerMouseButton() != MOUSE_BUTTON_TYPE_LEFT then
            return false
        endif

        set mx = BlzGetTriggerPlayerMouseX()
        set my = BlzGetTriggerPlayerMouseY()
        set kind = LoadInteger(CastData, CopiedId[pid], 1)

        if kind == 1 then
            set g = CreateGroup()
            call GroupEnumUnitsInRange(g, mx, my, CLICK_PICK_RANGE, null)
            loop
                set u = FirstOfGroup(g)
                exitwhen u == null
                call GroupRemoveUnit(g, u)
                if GetWidgetLife(u) > 0.405 and GetUnitAbilityLevel(u, 'Aloc') == 0 then
                    set d = (GetUnitX(u) - mx) * (GetUnitX(u) - mx) + (GetUnitY(u) - my) * (GetUnitY(u) - my)
                    if d < bestD then
                        set bestD = d
                        set best = u
                    endif
                endif
            endloop
            call DestroyGroup(g)
            set g = null
            if best == null then
                return false // nothing close to the click, keep waiting
            endif
        endif

        set Pending[pid] = false
        call IssueCast(pid, mx, my, best)
        set best = null
        return false
    endfunction

    //==================================================================
    // Builds the button once, anchored above the command card.
    //==================================================================
    private function BuildFrames takes nothing returns nothing
        local framehandle gameUI = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
        local framehandle cmd = BlzGetOriginFrame(ORIGIN_FRAME_COMMAND_BUTTON, FRAME_ANCHOR_INDEX)
        local trigger frameTrig = CreateTrigger()
        local trigger mouseTrig = CreateTrigger()
        local integer i = 0

        set Btn = BlzCreateFrame("ScriptDialogButton", gameUI, 0, 0)
        call BlzFrameSetSize(Btn, FRAME_SIZE, FRAME_SIZE)
        call BlzFrameSetPoint(Btn, FRAMEPOINT_BOTTOM, cmd, FRAMEPOINT_TOP, FRAME_OFFSET_X, FRAME_OFFSET_Y)
        call BlzFrameSetLevel(Btn, 5)
        call BlzFrameSetVisible(Btn, false)

        set Icon = BlzCreateFrameByType("BACKDROP", "MimicryIcon", Btn, "", 1)
        call BlzFrameSetAllPoints(Icon, Btn)
        

        set CdText = BlzCreateFrameByType("TEXT", "MimicryCd", Btn, "", 0)
        call BlzFrameSetAllPoints(CdText, Btn)
        call BlzFrameSetLevel(CdText, 2)
        call BlzFrameSetTextAlignment(CdText, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)

        call BlzTriggerRegisterFrameEvent(frameTrig, Btn, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(frameTrig, Btn, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(frameTrig, Btn, FRAMEEVENT_MOUSE_LEAVE)
        call TriggerAddAction(frameTrig, function OnFrameEvent)

        loop
            exitwhen i >= bj_MAX_PLAYER_SLOTS
            call TriggerRegisterPlayerEvent(mouseTrig, Player(i), EVENT_PLAYER_MOUSE_DOWN)
            set i = i + 1
        endloop
        call TriggerAddCondition(mouseTrig, Condition(function OnMouseDown))

        call TimerStart(CreateTimer(), 0.25, true, function Refresh)

        set gameUI = null
        set cmd = null
        set frameTrig = null
        set mouseTrig = null
        call DestroyTimer(GetExpiredTimer())
    endfunction

    //==================================================================
    // Public entry point - unit-target cast on any enemy unit or hero.
    // The copy stays until Mimicry is cast again.
    //==================================================================
    function CastMimicry takes unit caster, unit target, integer lvl returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(caster))
        local integer id

        if target == null or target == caster or GetWidgetLife(target) < 0.405 then
            return
        endif

        set id = PickAbility(caster, target)
        if id == 0 then
            call BJDebugMsg("Mimicry picked: " + GetObjectName(id) + " (" + I2S(id) + ")")
            call DebugMsg("Mimicry: nothing to copy")
            return
        endif

        // Replace the previous copy, if any
        if CopiedId[pid] != 0 and Caster[pid] != null then
            call UnitRemoveAbility(Caster[pid], CopiedId[pid])
        endif

        // Add the new one hidden, so it takes no command card slot
        call UnitAddAbility(caster, id)
        call SetUnitAbilityLevel(caster, id, lvl)
        call BlzUnitHideAbility(caster, id, true)

        set Caster[pid]      = caster
        set CopiedId[pid]    = id
        set CopiedLevel[pid] = lvl
        set Pending[pid]     = false

        call DestroyEffect(AddSpecialEffectTarget(SFX_COPY, caster, "origin"))
        call AbilStartCD(caster, MIMICRY_ABILITY_ID, COOLDOWN)

        call DebugMsg("Mimicry copied ability " + I2S(id))
    endfunction

    private function Init takes nothing returns nothing
        local trigger t = CreateTrigger()
        local integer i = 0

        loop
            exitwhen i >= bj_MAX_PLAYER_SLOTS
            call TriggerRegisterPlayerUnitEvent(t, Player(i), EVENT_PLAYER_UNIT_SPELL_EFFECT, null)
            set i = i + 1
        endloop
        call TriggerAddCondition(t, Condition(function OnSpellEffect))

        call TimerStart(CreateTimer(), 1.0, false, function BuildFrames)
        set t = null
    endfunction

endlibrary