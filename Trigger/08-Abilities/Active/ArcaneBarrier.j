library ArcaneBarrier initializer Init

    globals
        // ===================== CONFIG =====================
        private constant real    BASE_WIDTH      = 550.
        private constant real    WIDTH_PER_LVL   = 15.
        private constant real    DURATION        = 11.
        private constant real    DAMAGE_RANGE    = 120.    // enemies this close to the wall take damage
        private constant real    DMG_PER_HLVL    = 25.     // x hero level
        private constant real    DMG_INTERVAL    = 0.5
        private constant real    BLOCK_HALF      = 25.     // half thickness of the barrier enemies can't cross

        private constant real    AIM_TIMEOUT     = 8.      // auto-places the wall if you never click
        private constant real    MIN_AIM_TIME    = 0.15

        // Visual: stacked lightning sheets tinted like glass, plus shimmering shards
        private constant string  WALL_LIGHTNING  = "DRAM"
        private constant integer LAYERS          = 5
        private constant real    LAYER_STEP      = 45.
        private constant real    LAYER_BASE      = 15.
        private constant string  SFX_SHARD       = "Abilities\\Spells\\Human\\Invisibility\\InvisibilityTarget.mdl"
        private constant real    SHARD_SPACING   = 100.

        private constant string  SFX_HIT         = "Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl"
        private constant string  SFX_HIT_ATTACH  = "chest"

        private constant real    INTERVAL        = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)

        // Aim state, indexed by player id
        private unit    array AimCaster
        private integer array AimLevel
        private boolean array AimActive
        private boolean array AimPressed
        private real    array AimX
        private real    array AimY
        private real    array AimAngle
        private real    array AimAge
        private timer         AimTick = CreateTimer()
    endglobals

    //==================================================================
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    //==================================================================
    // The drawn wall: several thin lightning sheets stacked in height,
    // tinted pale blue and see-through, plus shimmering shards.
    //==================================================================
    private struct WallVisual
        lightning array bolts[5]
        effect array shards[12]
        integer shardN

        static method create takes boolean preview, real halfLen returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0
            local integer n

            set .shardN = 0
            loop
                exitwhen i >= LAYERS
                set .bolts[i] = AddLightningEx(WALL_LIGHTNING, false, 0., 0., 0., 1., 1., 0.)
                if preview then
                    call SetLightningColor(.bolts[i], 0.4, 1., 0.4, 0.5)
                else
                    call SetLightningColor(.bolts[i], 0.6, 0.9, 1., 0.55)
                endif
                set i = i + 1
            endloop

            if not preview then
                set n = R2I(halfLen * 2. / SHARD_SPACING) + 1
                if n > 12 then
                    set n = 12
                endif
                loop
                    exitwhen .shardN >= n
                    set .shards[.shardN] = AddSpecialEffect(SFX_SHARD, 0., 0.)
                    set .shardN = .shardN + 1
                endloop
            endif
            return this
        endmethod

        method move takes real cx, real cy, real ang, real halfLen returns nothing
            local real ax = cx - halfLen * Cos(ang)
            local real ay = cy - halfLen * Sin(ang)
            local real bx = cx + halfLen * Cos(ang)
            local real by = cy + halfLen * Sin(ang)
            local real za = GetZ(ax, ay)
            local real zb = GetZ(bx, by)
            local real h
            local real f
            local real px
            local real py
            local integer i = 0

            loop
                exitwhen i >= LAYERS
                set h = LAYER_BASE + LAYER_STEP * I2R(i)
                call MoveLightningEx(.bolts[i], false, ax, ay, za + h, bx, by, zb + h)
                set i = i + 1
            endloop

            set i = 0
            loop
                exitwhen i >= .shardN
                set f = (I2R(i) + 0.5) / I2R(.shardN)
                set px = ax + (bx - ax) * f
                set py = ay + (by - ay) * f
                call BlzSetSpecialEffectPosition(.shards[i], px, py, GetZ(px, py) + 80.)
                set i = i + 1
            endloop
        endmethod

        method onDestroy takes nothing returns nothing
            local integer i = 0
            loop
                exitwhen i >= LAYERS
                call DestroyLightning(.bolts[i])
                set .bolts[i] = null
                set i = i + 1
            endloop
            set i = 0
            loop
                exitwhen i >= .shardN
                call DestroyEffect(.shards[i])
                set .shards[i] = null
                set i = i + 1
            endloop
        endmethod
    endstruct

    //==================================================================
    private function IsValidEnemy takes unit u, player owner returns boolean
        return GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    //==================================================================
    // The placed wall. Damages enemies near it and stops enemies from
    // crossing it. Allies are ignored entirely, so they walk through.
    //==================================================================
    private struct WallInstance
        unit caster
        player owner
        real cx
        real cy
        real ang
        real half
        real age
        real dmgT
        real dmg
        WallVisual vis

        static method create takes unit caster, real cx, real cy, real ang, integer lvl returns thistype
            local thistype this = thistype.allocate()

            set .caster = caster
            set .owner  = GetOwningPlayer(caster)
            set .cx     = cx
            set .cy     = cy
            set .ang    = ang
            set .half   = (BASE_WIDTH + WIDTH_PER_LVL * I2R(lvl)) * 0.5
            set .age    = 0.
            set .dmgT   = 0.
            set .dmg    = DMG_PER_HLVL * I2R(GetHeroLevel(caster))

            set .vis = WallVisual.create(false, .half)
            call .vis.move(cx, cy, ang, .half)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        method step takes nothing returns boolean
            local unit u
            local real dx
            local real dy
            local real along
            local real side
            local real over
            local real d
            local real sgn
            local boolean doDmg = false

            set .age  = .age + INTERVAL
            set .dmgT = .dmgT + INTERVAL
            if .dmgT >= DMG_INTERVAL then
                set .dmgT = .dmgT - DMG_INTERVAL
                set doDmg = true
            endif

            call GroupEnumUnitsInRange(Grp, .cx, .cy, .half + DAMAGE_RANGE + 60., null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)

                if IsValidEnemy(u, .owner) then
                    set dx = GetUnitX(u) - .cx
                    set dy = GetUnitY(u) - .cy
                    set along = dx * Cos(.ang) + dy * Sin(.ang)
                    set side  = -dx * Sin(.ang) + dy * Cos(.ang)

                    // distance from the unit to the wall segment
                    set over = 0.
                    if along > .half then
                        set over = along - .half
                    elseif along < -.half then
                        set over = along + .half
                    endif
                    set d = SquareRoot(over * over + side * side)

                    if doDmg and d <= DAMAGE_RANGE then
                        call UnitDamageTarget(.caster, u, .dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                        call DestroyEffect(AddSpecialEffectTarget(SFX_HIT, u, SFX_HIT_ATTACH))
                    endif

                    // barrier: push enemies back out of the thin band along the wall
                    if not IsUnitType(u, UNIT_TYPE_STRUCTURE) and along >= -.half and along <= .half and side > -BLOCK_HALF and side < BLOCK_HALF then
                        if side >= 0. then
                            set sgn = 1.
                        else
                            set sgn = -1.
                        endif
                        set side = sgn * (BLOCK_HALF + 2.)
                        call SetUnitX(u, .cx + along * Cos(.ang) - side * Sin(.ang))
                        call SetUnitY(u, .cy + along * Sin(.ang) + side * Cos(.ang))
                    endif
                endif
            endloop
            set u = null

            return .age >= DURATION or IsUnitType(.caster, UNIT_TYPE_DEAD) 
        endmethod

        method onDestroy takes nothing returns nothing
            call .vis.destroy()
            set .caster = null
        endmethod

        static method tickAll takes nothing returns nothing
            local integer i = Count - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = Active[i]
                if this.step() then
                    call this.destroy()
                    set Count = Count - 1
                    set Active[i] = Active[Count]
                endif
                set i = i - 1
            endloop

            if Count == 0 then
                call PauseTimer(Tick)
            endif
        endmethod
    endstruct

    //==================================================================
    // Aiming. Preview visuals are kept per player.
    //==================================================================
    private struct Preview
        WallVisual vis
        real half
    endstruct

    globals
        private Preview array Pv
    endglobals

    private function UpdatePreview takes integer pid returns nothing
        if Pv[pid] != 0 then
            call Pv[pid].vis.move(AimX[pid], AimY[pid], AimAngle[pid], Pv[pid].half)
        endif
    endfunction

    private function EndAim takes integer pid, boolean place returns nothing
        if not AimActive[pid] then
            return
        endif

        if place and GetWidgetLife(AimCaster[pid]) > 0.405 then
            call WallInstance.create(AimCaster[pid], AimX[pid], AimY[pid], AimAngle[pid], AimLevel[pid])
        endif

        if Pv[pid] != 0 then
            call Pv[pid].vis.destroy()
            call Pv[pid].destroy()
            set Pv[pid] = 0
        endif

        set AimActive[pid]  = false
        set AimPressed[pid] = false
        set AimCaster[pid]  = null
    endfunction

    private function OnMouseDown takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if AimActive[pid] and BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT then
            set AimPressed[pid] = true
        endif
        return false
    endfunction

    private function OnMouseUp takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if AimActive[pid] and AimPressed[pid] and BlzGetTriggerPlayerMouseButton() == MOUSE_BUTTON_TYPE_LEFT then
            if AimAge[pid] >= MIN_AIM_TIME then
                call EndAim(pid, true)
            endif
        endif
        return false
    endfunction

    private function OnMouseMove takes nothing returns boolean
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local real mx
        local real my

        if AimActive[pid] then
            set mx = BlzGetTriggerPlayerMouseX()
            set my = BlzGetTriggerPlayerMouseY()
            // wall is perpendicular to the line from its center to the mouse
            set AimAngle[pid] = Atan2(my - AimY[pid], mx - AimX[pid]) + bj_PI * 0.5
            call UpdatePreview(pid)
        endif
        return false
    endfunction

    private function AimTickFn takes nothing returns nothing
        local integer pid = 0
        loop
            exitwhen pid >= bj_MAX_PLAYER_SLOTS
            if AimActive[pid] then
                set AimAge[pid] = AimAge[pid] + INTERVAL
                if AimAge[pid] >= AIM_TIMEOUT then
                    call EndAim(pid, true)
                endif
            endif
            set pid = pid + 1
        endloop
    endfunction

    //==================================================================
    // Public entry point - point-target cast. The point is the wall's center.
    //==================================================================
    function CastArcaneBarrier takes unit caster, real x, real y, integer lvl returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(caster))
        local Preview p

        call EndAim(pid, false)

        set AimCaster[pid]  = caster
        set AimLevel[pid]   = lvl
        set AimActive[pid]  = true
        set AimPressed[pid] = false
        set AimX[pid]       = x
        set AimY[pid]       = y
        set AimAge[pid]     = 0.
        // start perpendicular to the line from the caster
        set AimAngle[pid]   = Atan2(y - GetUnitY(caster), x - GetUnitX(caster)) + bj_PI * 0.5

        set p = Preview.create()
        set p.half = (BASE_WIDTH + WIDTH_PER_LVL * I2R(lvl)) * 0.5
        set p.vis  = WallVisual.create(true, p.half)
        set Pv[pid] = p
        call UpdatePreview(pid)
    endfunction

    private function Init takes nothing returns nothing
        local trigger down = CreateTrigger()
        local trigger up   = CreateTrigger()
        local trigger move = CreateTrigger()
        local integer i = 0

        loop
            exitwhen i >= bj_MAX_PLAYER_SLOTS
            call TriggerRegisterPlayerEvent(down, Player(i), EVENT_PLAYER_MOUSE_DOWN)
            call TriggerRegisterPlayerEvent(up,   Player(i), EVENT_PLAYER_MOUSE_UP)
            call TriggerRegisterPlayerEvent(move, Player(i), EVENT_PLAYER_MOUSE_MOVE)
            set i = i + 1
        endloop
        call TriggerAddCondition(down, Condition(function OnMouseDown))
        call TriggerAddCondition(up,   Condition(function OnMouseUp))
        call TriggerAddCondition(move, Condition(function OnMouseMove))
        call TimerStart(AimTick, INTERVAL, true, function AimTickFn)
    endfunction

endlibrary