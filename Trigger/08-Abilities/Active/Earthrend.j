library Earthrend initializer Init requires AbilityCooldown

    globals
        // ===================== CONFIG =====================
        private constant real    COOLDOWN        = 11.     // applied when the rock returns or the hero lands
        private constant real    RANGE           = 1200.   // distance the rock travels out
        private constant real    SEARCH_RANGE    = 1500.   // how far away the nearest enemy is looked for
        private constant real    ROCK_SPEED      = 600.
        private constant real    PULL_SPEED      = 3000.   // hero speed when pulled to the rock
        private constant real    WIDTH           = 350.    // effect width (hit radius is half)
        private constant real    DMG_PER_LVL     = 500.
        private constant real    END_DIST        = 80.     // rock counts as "home" this close to the hero

        private constant real    ROCK_HEIGHT     = 40.
        private constant real    ROCK_SCALE      = 1.5

        private constant real    CHAIN_SCALE     = 2.0
        private constant real    CHAIN_SPACING   = 48.
        private constant integer CHAIN_RED       = 120
        private constant integer CHAIN_GREEN     = 120
        private constant integer CHAIN_BLUE      = 130
        private constant integer MAX_LINKS       = 47

        private constant string  ROCK_MODEL      = "Doodads\\Terrain\\RockChunks\\RockChunks.mdl"
        private constant string  CHAIN_MODEL     = "Abilities\\Weapons\\WardenMissile\\WardenMissile.mdl"
        private constant string  SFX_HIT         = "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl"

        private constant real    INTERVAL        = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
        private hashtable     ByCaster = InitHashtable()   // caster id -> Earthrend instance

        private boolean BoundsReady = false
        private real    MinX = 0.
        private real    MaxX = 0.
        private real    MinY = 0.
        private real    MaxY = 0.
    endglobals

    //==================================================================
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc) + ROCK_HEIGHT
    endfunction

    private function OutOfBounds takes real x, real y returns boolean
        if not BoundsReady then
            set MinX = GetRectMinX(bj_mapInitialPlayableArea)
            set MaxX = GetRectMaxX(bj_mapInitialPlayableArea)
            set MinY = GetRectMinY(bj_mapInitialPlayableArea)
            set MaxY = GetRectMaxY(bj_mapInitialPlayableArea)
            set BoundsReady = true
        endif
        return x <= MinX or x >= MaxX or y <= MinY or y >= MaxY
    endfunction

    // Angle (radians) from the hero to the nearest enemy, or the hero's facing if none is near.
    private function AimAngle takes unit caster returns real
        local unit u
        local unit best = null
        local real bestD = 999999999.
        local real d
        local real cx = GetUnitX(caster)
        local real cy = GetUnitY(caster)
        local player p = GetOwningPlayer(caster)
        local real result

        call GroupEnumUnitsInRange(Grp, cx, cy, SEARCH_RANGE, null)
        loop
            set u = FirstOfGroup(Grp)
            exitwhen u == null
            call GroupRemoveUnit(Grp, u)
            if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, p) and not IsUnitType(u, UNIT_TYPE_DEAD) and not IsUnitType(u, UNIT_TYPE_STRUCTURE) and GetUnitAbilityLevel(u, 'Aloc') == 0 then
                set d = (GetUnitX(u) - cx) * (GetUnitX(u) - cx) + (GetUnitY(u) - cy) * (GetUnitY(u) - cy)
                if d < bestD then
                    set bestD = d
                    set best = u
                endif
            endif
        endloop

        if best == null then
            set result = GetUnitFacing(caster) * bj_DEGTORAD
        else
            set result = Atan2(GetUnitY(best) - cy, GetUnitX(best) - cx)
        endif

        set u = null
        set best = null
        set p = null
        return result
    endfunction

    //==================================================================
    // phase 0 = rock flying out, 1 = rock returning to the hero,
    // 2 = hero being pulled to the rock
    //==================================================================
    private struct EarthrendInstance
        unit      caster
        player    owner
        integer   level
        effect    rock
        effect array chain[48]
        integer   chainN
        group     hitGroup
        real      x
        real      y
        real      dirX
        real      dirY
        real      traveled
        integer   phase
        boolean   paused
        boolean   startCD

        static method create takes unit caster, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real cx = GetUnitX(caster)
            local real cy = GetUnitY(caster)
            local real angle = AimAngle(caster)

            set .caster   = caster
            set .owner    = GetOwningPlayer(caster)
            set .level    = lvl
            set .chainN   = 0
            set .hitGroup = CreateGroup()
            set .x        = cx
            set .y        = cy
            set .dirX     = Cos(angle)
            set .dirY     = Sin(angle)
            set .traveled = 0.
            set .phase    = 0
            set .paused   = false
            set .startCD  = false

            set .rock = AddSpecialEffect(ROCK_MODEL, cx, cy)
            call BlzSetSpecialEffectScale(.rock, ROCK_SCALE)
            call BlzSetSpecialEffectPosition(.rock, cx, cy, GetZ(cx, cy))

            call SaveInteger(ByCaster, GetHandleId(caster), 0, this)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        method startPull takes nothing returns nothing
            if .phase == 2 then
                return
            endif
            set .phase = 2
            call PauseUnit(.caster, true)
            set .paused = true
        endmethod

        //--------------------------------------------------------
        method hitUnits takes nothing returns nothing
            local unit u
            local real dmg = DMG_PER_LVL * I2R(.level)

            call GroupEnumUnitsInRange(Grp, .x, .y, WIDTH * 0.5, null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)
                if GetWidgetLife(u) > 0.405 and IsUnitEnemy(u, .owner) and not IsUnitType(u, UNIT_TYPE_DEAD) and GetUnitAbilityLevel(u, 'Aloc') == 0 and not IsUnitInGroup(u, .hitGroup) then
                    call GroupAddUnit(.hitGroup, u)
                    call UnitDamageTarget(.caster, u, dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    call DestroyEffect(AddSpecialEffectTarget(SFX_HIT, u, "origin"))
                endif
            endloop
            set u = null
        endmethod

        //--------------------------------------------------------
        method turnBack takes nothing returns nothing
            set .phase = 1
            call GroupClear(.hitGroup)   // units can be hit again on the way back
        endmethod

        //--------------------------------------------------------
        method updateChain takes nothing returns nothing
            local real hx = GetUnitX(.caster)
            local real hy = GetUnitY(.caster)
            local real dx = .x - hx
            local real dy = .y - hy
            local real len = SquareRoot(dx * dx + dy * dy)
            local real yaw = Atan2(dy, dx)
            local real pos = CHAIN_SPACING
            local real lx
            local real ly
            local integer k = 0

            if len > 0.01 then
                loop
                    exitwhen pos > len or k >= MAX_LINKS
                    if k >= .chainN then
                        set .chain[.chainN] = AddSpecialEffect(CHAIN_MODEL, hx, hy)
                        call BlzSetSpecialEffectScale(.chain[.chainN], CHAIN_SCALE)
                        call BlzSetSpecialEffectColor(.chain[.chainN], CHAIN_RED, CHAIN_GREEN, CHAIN_BLUE)
                        set .chainN = .chainN + 1
                    endif
                    set lx = hx + dx / len * pos
                    set ly = hy + dy / len * pos
                    call BlzSetSpecialEffectPosition(.chain[k], lx, ly, GetZ(lx, ly))
                    call BlzSetSpecialEffectYaw(.chain[k], yaw)
                    set k = k + 1
                    set pos = pos + CHAIN_SPACING
                endloop
            endif

            loop
                exitwhen .chainN <= k
                set .chainN = .chainN - 1
                call BlzSetSpecialEffectScale(.chain[.chainN], 0.001)
                call DestroyEffect(.chain[.chainN])
                set .chain[.chainN] = null
            endloop
        endmethod

        //--------------------------------------------------------
        // returns true when the ability has ended
        //--------------------------------------------------------
        method step takes nothing returns boolean
            local real stp
            local real nx
            local real ny
            local real dx
            local real dy
            local real d

            if GetWidgetLife(.caster) < 0.405 then
                return true   // hero died, no cooldown
            endif

            if .phase == 0 then
                set stp = ROCK_SPEED * INTERVAL
                set nx = .x + .dirX * stp
                set ny = .y + .dirY * stp

                // the rock never goes uphill: a higher cliff level (or the map edge) turns it back
                if OutOfBounds(nx, ny) or GetTerrainCliffLevel(nx, ny) > GetTerrainCliffLevel(.x, .y) then
                    call .turnBack()
                else
                    set .x = nx
                    set .y = ny
                    set .traveled = .traveled + stp
                    call .hitUnits()
                    if .traveled >= RANGE then
                        call .turnBack()
                    endif
                endif

            elseif .phase == 1 then
                set stp = ROCK_SPEED * INTERVAL
                set dx = GetUnitX(.caster) - .x
                set dy = GetUnitY(.caster) - .y
                set d  = SquareRoot(dx * dx + dy * dy)

                if d <= stp + END_DIST then
                    set .startCD = true
                    return true
                endif

                set .x = .x + dx / d * stp
                set .y = .y + dy / d * stp
                call .hitUnits()

            else
                set stp = PULL_SPEED * INTERVAL
                set dx = .x - GetUnitX(.caster)
                set dy = .y - GetUnitY(.caster)
                set d  = SquareRoot(dx * dx + dy * dy)

                if d <= stp then
                    call SetUnitX(.caster, .x)
                    call SetUnitY(.caster, .y)
                    set .startCD = true
                    return true
                endif

                call SetUnitX(.caster, GetUnitX(.caster) + dx / d * stp)
                call SetUnitY(.caster, GetUnitY(.caster) + dy / d * stp)
            endif

            call BlzSetSpecialEffectPosition(.rock, .x, .y, GetZ(.x, .y))
            call .updateChain()
            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            if .paused and GetWidgetLife(.caster) > 0.405 then
                call PauseUnit(.caster, false)
            endif
            call RemoveSavedInteger(ByCaster, GetHandleId(.caster), 0)

            if .startCD and GetWidgetLife(.caster) > 0.405 then
                call AbilStartCD(.caster, EARTHREND_ABILITY_ID, COOLDOWN)
            endif

            loop
                exitwhen .chainN <= 0
                set .chainN = .chainN - 1
                call BlzSetSpecialEffectScale(.chain[.chainN], 0.001)
                call DestroyEffect(.chain[.chainN])
                set .chain[.chainN] = null
            endloop

            call BlzSetSpecialEffectScale(.rock, 0.001)
            call DestroyEffect(.rock)
            set .rock = null

            call DestroyGroup(.hitGroup)
            set .hitGroup = null
            set .caster   = null
        endmethod

        //--------------------------------------------------------
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
    // No-target ability. The first cast throws the rock at the nearest enemy.
    // A cast while that rock is out pulls the hero to it.
    //==================================================================
    function CastEarthrend takes unit caster, integer lvl returns nothing
        local integer id = GetHandleId(caster)
        local EarthrendInstance e

        if caster == null or GetWidgetLife(caster) < 0.405 then
            return
        endif

        // The engine has already started the native cooldown. Cancel it so the
        // ability can be cast again for the pull.
        call BlzEndUnitAbilityCooldown(caster, EARTHREND_ABILITY_ID)

        if HaveSavedInteger(ByCaster, id, 0) then
            set e = LoadInteger(ByCaster, id, 0)
            call e.startPull()
            return
        endif

        call EarthrendInstance.create(caster, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary