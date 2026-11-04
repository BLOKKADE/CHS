library TentacleLine initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer TENTACLE_UNIT_ID          = 'nfgt' // tentacle unit-type

        private constant integer NUM_TENTACLES = 6
        private constant real    LINE_RANGE    = 400.   // total length, centered on the cast point

        // Thicker lightning type for better visibility. If this doesn't look right,
        // try alternatives like "FORK" or "CHAL" from the Object Editor's lightning list.
        private constant string  LIGHTNING_CODE   = "DRAM"
        private constant real    INDICATOR_HEIGHT = 50.

        // Small ground markers at each future tentacle spawn point, for extra clarity
        private constant string  SFX_PREVIEW_DOT  = "Abilities\\Spells\\Other\\Stampede\\stompImpact.mdl"

        private constant real    TICK            = 0.03125
        private constant real    AIM_TIMEOUT     = 8.0   // auto-confirms if the player never releases the mouse
        private constant real    MIN_HOLD_TIME   = 0.15  // ignores a mouse-up that fires too fast (same click as the cast)

        private constant boolean DEBUG_MODE = false
        // ====================================================

        unit     array AimCaster
        integer  array AimLevel
        boolean  array AimActive
        real     array AimCenterX
        real     array AimCenterY
        real     array AimAngle
        real     array AimAge
        lightning array AimLightning
        effect   array AimPreviewFx // indexed as pid * 6 + i, up to 6 preview dots per player slot

        private trigger MouseUpTrig
        private trigger MouseMoveTrig
        private timer    TickTimer
    endglobals

    //==================================================================
    private function DebugMsg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg(s)
        endif
    endfunction

    private function ClearPreviewDots takes integer pid returns nothing
        local integer i = 0
        loop
            exitwhen i >= NUM_TENTACLES
            if AimPreviewFx[pid * 6 + i] != null then
                call DestroyEffect(AimPreviewFx[pid * 6 + i])
                set AimPreviewFx[pid * 6 + i] = null
            endif
            set i = i + 1
        endloop
    endfunction

    private function UpdateIndicator takes integer pid returns nothing
        local real cx = AimCenterX[pid]
        local real cy = AimCenterY[pid]
        local real angle = AimAngle[pid]
        local real halfLen = LINE_RANGE * 0.5
        local real startX = cx - halfLen * Cos(angle)
        local real startY = cy - halfLen * Sin(angle)
        local real endX   = cx + halfLen * Cos(angle)
        local real endY   = cy + halfLen * Sin(angle)
        local real spacing = LINE_RANGE / NUM_TENTACLES
        local integer i = 0
        local real offset
        local real px
        local real py

        if AimLightning[pid] != null then
            call MoveLightningEx(AimLightning[pid], true, startX, startY, INDICATOR_HEIGHT, endX, endY, INDICATOR_HEIGHT)
        endif

        // Reposition the 6 preview dots to match the current angle
        loop
            exitwhen i >= NUM_TENTACLES
            set offset = -halfLen + (spacing * 0.5) + (i * spacing)
            set px = cx + offset * Cos(angle)
            set py = cy + offset * Sin(angle)

            if AimPreviewFx[pid * 6 + i] != null then
                call DestroyEffect(AimPreviewFx[pid * 6 + i])
            endif
            set AimPreviewFx[pid * 6 + i] = AddSpecialEffect(SFX_PREVIEW_DOT, px, py)

            set i = i + 1
        endloop
    endfunction

    //==================================================================
    private function StartAim takes unit caster, real x, real y, integer lvl returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(caster))

        // Clean up any stray previous aim for this player, just in case
        if AimActive[pid] then
            if AimLightning[pid] != null then
                call DestroyLightning(AimLightning[pid])
                set AimLightning[pid] = null
            endif
            call ClearPreviewDots(pid)
        endif

        set AimCaster[pid]  = caster
        set AimLevel[pid]   = lvl
        set AimActive[pid]  = true
        set AimCenterX[pid] = x
        set AimCenterY[pid] = y
        set AimAngle[pid]   = Atan2(y - GetUnitY(caster), x - GetUnitX(caster)) // initial angle: caster -> cast point
        set AimAge[pid]     = 0.

        set AimLightning[pid] = AddLightningEx(LIGHTNING_CODE, true, x, y, INDICATOR_HEIGHT, x, y, INDICATOR_HEIGHT)

        call UpdateIndicator(pid) // draws the initial line + preview dots immediately

        call DebugMsg("Tentacle aim started for pid=" + I2S(pid) + " at (" + R2S(x) + ", " + R2S(y) + ")")
    endfunction

    private function SpawnTentacles takes integer pid returns nothing
        local unit caster = AimCaster[pid]
        local real angle  = AimAngle[pid]
        local real cx = AimCenterX[pid]
        local real cy = AimCenterY[pid]
        local real halfLen = LINE_RANGE * 0.5
        local real spacing = LINE_RANGE / NUM_TENTACLES
        local integer i = 0
        local real offset
        local real spawnX
        local real spawnY
        local unit tentacle

        loop
            exitwhen i >= NUM_TENTACLES
            set offset = -halfLen + (spacing * 0.5) + (i * spacing) // centered, evenly spaced along the line
            set spawnX = cx + offset * Cos(angle)
            set spawnY = cy + offset * Sin(angle)

            set tentacle = CreateUnit(GetOwningPlayer(caster), TENTACLE_UNIT_ID, spawnX, spawnY, angle * bj_RADTODEG)
            // Hook up whatever the tentacle should actually DO here.

            set i = i + 1
        endloop

        set tentacle = null
        set caster = null
    endfunction

    private function FinishAim takes integer pid returns nothing
        if not AimActive[pid] then
            return
        endif

        call SpawnTentacles(pid)

        if AimLightning[pid] != null then
            call DestroyLightning(AimLightning[pid])
            set AimLightning[pid] = null
        endif
        call ClearPreviewDots(pid)

        set AimActive[pid] = false
        set AimCaster[pid] = null

        call DebugMsg("Tentacle line confirmed for pid=" + I2S(pid))
    endfunction

    //==================================================================
    private function OnMouseUp takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())

        if (BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT) and AimActive[pid] then
            // Ignore a mouse-up that fires too soon - likely the same click that cast the spell
            if AimAge[pid] >= MIN_HOLD_TIME then
                call FinishAim(pid)
            else
                call DebugMsg("Ignored too-fast mouse-up for pid=" + I2S(pid) + " (age=" + R2S(AimAge[pid]) + ")")
            endif
        endif

        return false
    endfunction

    private function OnMouseMove takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local location loc
        local real mx
        local real my

        if AimActive[pid] then
            set loc = BlzGetTriggerPlayerMousePosition()
            if loc != null then
                set mx = GetLocationX(loc)
                set my = GetLocationY(loc)
                call RemoveLocation(loc)

                set AimAngle[pid] = Atan2(my - AimCenterY[pid], mx - AimCenterX[pid])
                call UpdateIndicator(pid)
            endif
            set loc = null
        endif

        return false
    endfunction

    private function OnTick takes nothing returns nothing
        local integer pid = 0
        loop
            exitwhen pid >= bj_MAX_PLAYER_SLOTS
            if AimActive[pid] then
                set AimAge[pid] = AimAge[pid] + TICK
                if AimAge[pid] >= AIM_TIMEOUT then
                    call DebugMsg("Tentacle aim timed out for pid=" + I2S(pid) + " - auto-confirming")
                    call FinishAim(pid)
                endif
            endif
            set pid = pid + 1
        endloop
    endfunction

    //==================================================================
    // Public entry point — point-target cast; the clicked point becomes
    // the fixed CENTER of the line, not the caster's position.
    //==================================================================
    function CastTentacleLine takes unit hero, real x, real y, integer lvl returns nothing
        call StartAim(hero, x, y, lvl)
    endfunction

    private function Init takes nothing returns nothing
        local integer i = 0

        set MouseUpTrig   = CreateTrigger()
        set MouseMoveTrig = CreateTrigger()
        set TickTimer     = CreateTimer()

        loop
            exitwhen i >= bj_MAX_PLAYER_SLOTS
            call TriggerRegisterPlayerEvent(MouseUpTrig, Player(i), EVENT_PLAYER_MOUSE_UP)
            call TriggerRegisterPlayerEvent(MouseMoveTrig, Player(i), EVENT_PLAYER_MOUSE_MOVE)
            set i = i + 1
        endloop

        call TriggerAddCondition(MouseUpTrig, Condition(function OnMouseUp))
        call TriggerAddCondition(MouseMoveTrig, Condition(function OnMouseMove))

        call TimerStart(TickTimer, TICK, true, function OnTick)
    endfunction

endlibrary