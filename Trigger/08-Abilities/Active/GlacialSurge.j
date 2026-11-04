library GlacialSurge initializer Init

    globals
        // ===================== CONFIG =====================
        private constant integer DUMMY_ID         = 'esen'        // Locust + Invulnerable, no model
        private constant integer STUN_ABILITY_ID  = 'STUN'        // dummy ability (Storm Bolt based): 0 damage, 1.5s stun. Replace the rawcode.
        private constant string  STUN_ORDER       = "thunderbolt"

        // Movement
        private constant real    DISTANCE         = 1000.         // how far the ice block travels
        private constant real    SPEED            = 1200.         // block speed
        private constant real    WIDTH            = 300.          // effective width of the block
        private constant real    BLOCK_DEPTH      = 100.          // front-to-back size of the block
        private constant real    EXTRA_PUSH       = 400.          // extra distance units fly after the block ends
        private constant real    EXTRA_SPEED      = 1200.         // speed of that extra push

        // Collision
        private constant real    DMG_PER_LEVEL    = 500.          // damage = ability level x this
        private constant real    BLAST_RADIUS     = 150.          // AoE where a unit lands or hits a cliff
        private constant real    COLLISION_RADIUS = 70.           // pushed unit slams into a unit closer than this
        private constant real    WALL_PAD         = 24.           // how far ahead of a pushed unit the cliff check looks
        private constant boolean PUSH_ALLIES      = false         // false = only enemies are caught
        private constant boolean HIT_STRUCK_UNIT  = true          // the enemy unit that gets slammed into is also damaged and stunned

        // Visuals
        private constant string  BLOCK_MODEL      = "Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorTarget.mdl"   // stand-in for the ice block; see notes
        private constant real    BLOCK_SCALE      = 1.6
        private constant real    BLOCK_FX_SPACING = 75.           // one model every X units across the width
        private constant real    BLOCK_Z          = 20.           // height above the ground
        private constant string  SHATTER_MODEL    = "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"     // burst when the block ends
        private constant string  IMPACT_MODEL     = "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"     // burst on a damaged unit
        private constant string  BLAST_MODEL      = "Abilities\\Spells\\Undead\\FrostNova\\FrostNovaTarget.mdl"     // AoE burst at the landing / cliff spot
        private constant real    BLAST_SCALE      = 0.8

        private constant real    INTERVAL         = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Tmp   = CreateGroup()   // iterates the carried units
        private group         Cap   = CreateGroup()   // capture enumeration
        private group         Qry   = CreateGroup()   // victim enumeration
        private group         Blt   = CreateGroup()   // blast enumeration
        private location      ZLoc  = Location(0., 0.)

        private boolean BoundsReady = false
        private real    MinX = 0.
        private real    MaxX = 0.
        private real    MinY = 0.
        private real    MaxY = 0.
    endglobals

    //==================================================================
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc) + BLOCK_Z
    endfunction

    // A spot ground units cannot stand on: cliffs, blockers, deep water, or the map edge
    private function IsWall takes real x, real y returns boolean
        if not BoundsReady then
            set MinX = GetRectMinX(bj_mapInitialPlayableArea)
            set MaxX = GetRectMaxX(bj_mapInitialPlayableArea)
            set MinY = GetRectMinY(bj_mapInitialPlayableArea)
            set MaxY = GetRectMaxY(bj_mapInitialPlayableArea)
            set BoundsReady = true
        endif

        if x <= MinX or x >= MaxX or y <= MinY or y >= MaxY then
            return true
        endif
        return IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY)
    endfunction

    private function IsPushable takes unit u, unit caster, player owner returns boolean
        return u != caster /*
            */ and GetWidgetLife(u) > 0.405 /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and not IsUnitType(u, UNIT_TYPE_FLYING) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
            */ and (PUSH_ALLIES or IsUnitEnemy(u, owner))
    endfunction

    private function Stun takes player owner, unit target returns nothing
        local unit d = CreateUnit(owner, DUMMY_ID, GetUnitX(target), GetUnitY(target), 0.)
        call UnitAddAbility(d, STUN_ABILITY_ID)
        call UnitApplyTimedLife(d, 'BTLF', 1.)
        call IssueTargetOrder(d, STUN_ORDER, target)
        set d = null
    endfunction

    //==================================================================
    private struct Surge
        unit   caster
        player owner
        integer level
        real   dx            // unit direction
        real   dy
        real   cx            // block center
        real   cy
        real   traveled
        boolean launching    // true once the block has finished and units are being flung
        real   pushLeft
        group  carried
        group  done          // units already slammed; the block never grabs them again
        group  hurt          // units already damaged by this cast; nobody is damaged twice
        effect array fx[8]
        integer fxN

        //--------------------------------------------------------
        static method create takes unit caster, real tx, real ty, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real px = GetUnitX(caster)
            local real py = GetUnitY(caster)
            local real d
            local real yaw
            local integer i

            set .caster    = caster
            set .owner     = GetOwningPlayer(caster)
            set .level     = lvl
            set .cx        = px
            set .cy        = py
            set .traveled  = 0.
            set .launching = false
            set .pushLeft  = 0.
            set .carried   = CreateGroup()
            set .done      = CreateGroup()
            set .hurt      = CreateGroup()

            set d = SquareRoot((tx - px) * (tx - px) + (ty - py) * (ty - py))
            if d < 1. then
                set yaw = GetUnitFacing(caster) * bj_DEGTORAD
            else
                set yaw = Atan2(ty - py, tx - px)
            endif
            set .dx = Cos(yaw)
            set .dy = Sin(yaw)

            // the block: a row of models across its width
            set .fxN = R2I(WIDTH / BLOCK_FX_SPACING) + 1
            if .fxN > 8 then
                set .fxN = 8
            endif
            set i = 0
            loop
                exitwhen i >= .fxN
                set .fx[i] = AddSpecialEffect(BLOCK_MODEL, px, py)
                call BlzSetSpecialEffectScale(.fx[i], BLOCK_SCALE)
                call BlzSetSpecialEffectYaw(.fx[i], yaw)
                set i = i + 1
            endloop
            call .updateBlock()

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        method updateBlock takes nothing returns nothing
            local integer i = 0
            local real off
            local real px
            local real py

            loop
                exitwhen i >= .fxN
                set off = (I2R(i) - I2R(.fxN - 1) * 0.5) * BLOCK_FX_SPACING
                set px = .cx - .dy * off
                set py = .cy + .dx * off
                call BlzSetSpecialEffectPosition(.fx[i], px, py, GetZ(px, py))
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        method shatter takes nothing returns nothing
            local integer i = 0
            local real off
            local real px
            local real py

            loop
                exitwhen i >= .fxN
                set off = (I2R(i) - I2R(.fxN - 1) * 0.5) * BLOCK_FX_SPACING
                set px = .cx - .dy * off
                set py = .cy + .dx * off
                call DestroyEffect(AddSpecialEffect(SHATTER_MODEL, px, py))
                call BlzSetSpecialEffectScale(.fx[i], 0.001)
                call DestroyEffect(.fx[i])
                set .fx[i] = null
                set i = i + 1
            endloop
            set .fxN = 0
        endmethod

        //--------------------------------------------------------
        // grabs units standing in or just in front of the block
        method capture takes nothing returns nothing
            local unit u
            local real f
            local real l
            local real ahead = SPEED * INTERVAL + 30.

            call GroupEnumUnitsInRange(Cap, .cx + .dx * BLOCK_DEPTH * 0.5, .cy + .dy * BLOCK_DEPTH * 0.5, WIDTH * 0.5 + BLOCK_DEPTH + 80., null)
            loop
                set u = FirstOfGroup(Cap)
                exitwhen u == null
                call GroupRemoveUnit(Cap, u)

                if IsPushable(u, .caster, .owner) and not IsUnitInGroup(u, .carried) and not IsUnitInGroup(u, .done) then
                    set f = (GetUnitX(u) - .cx) * .dx + (GetUnitY(u) - .cy) * .dy
                    set l = -(GetUnitX(u) - .cx) * .dy + (GetUnitY(u) - .cy) * .dx
                    if l < 0. then
                        set l = -l
                    endif
                    if l <= WIDTH * 0.5 and f >= -BLOCK_DEPTH * 0.5 and f <= BLOCK_DEPTH * 0.5 + ahead then
                        call GroupAddUnit(.carried, u)
                    endif
                endif
            endloop
        endmethod

        //--------------------------------------------------------
        // a unit ahead of u that u is slamming into (null if none)
        method findVictim takes unit u, real ux, real uy returns unit
            local unit v
            local unit found = null
            local real f

            call GroupEnumUnitsInRange(Qry, ux, uy, COLLISION_RADIUS, null)
            loop
                set v = FirstOfGroup(Qry)
                exitwhen v == null
                call GroupRemoveUnit(Qry, v)

                if found == null and v != u and v != .caster and GetWidgetLife(v) > 0.405 /*
                    */ and GetUnitAbilityLevel(v, 'Aloc') == 0 and not IsUnitInGroup(v, .carried) then
                    set f = (GetUnitX(v) - ux) * .dx + (GetUnitY(v) - uy) * .dy
                    if f >= 0. then
                        set found = v
                    endif
                endif
            endloop
            set v = null
            return found
        endmethod

        //--------------------------------------------------------
        // damages + stuns a unit, but only once per cast
        method damage takes unit u returns nothing
            if u == null or IsUnitInGroup(u, .hurt) or GetWidgetLife(u) <= 0.405 then
                return
            endif

            call GroupAddUnit(.hurt, u)
            call DestroyEffect(AddSpecialEffectTarget(IMPACT_MODEL, u, "chest"))
            call UnitDamageTarget(.caster, u, DMG_PER_LEVEL * I2R(.level), false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            if GetWidgetLife(u) > 0.405 then
                call Stun(.owner, u)
            endif
        endmethod

        //--------------------------------------------------------
        // small AoE burst: damages every valid unit within BLAST_RADIUS that hasn't been hurt yet
        method blast takes real x, real y returns nothing
            local unit u
            local effect e = AddSpecialEffect(BLAST_MODEL, x, y)

            call BlzSetSpecialEffectScale(e, BLAST_SCALE)
            call DestroyEffect(e)
            set e = null

            call GroupEnumUnitsInRange(Blt, x, y, BLAST_RADIUS, null)
            loop
                set u = FirstOfGroup(Blt)
                exitwhen u == null
                call GroupRemoveUnit(Blt, u)

                if IsPushable(u, .caster, .owner) and not IsUnitInGroup(u, .hurt) then
                    call .damage(u)
                endif
            endloop
        endmethod

        //--------------------------------------------------------
        // a pushed unit hit a cliff (v == null) or another unit (v)
        method slam takes unit u, unit v returns nothing
            call GroupRemoveUnit(.carried, u)
            call GroupAddUnit(.done, u)

            // damage is applied the moment the unit hits
            call .damage(u)

            if v == null then
                // cliff: AoE where it hit
                call .blast(GetUnitX(u), GetUnitY(u))
            elseif HIT_STRUCK_UNIT and IsUnitEnemy(v, .owner) and not IsUnitType(v, UNIT_TYPE_STRUCTURE) then
                call .damage(v)
            endif
        endmethod

        //--------------------------------------------------------
        // end of the push: every unit still being carried is damaged, with an AoE where it lands
        method finish takes nothing returns nothing
            local unit u

            call GroupClear(Tmp)
            call GroupAddGroup(.carried, Tmp)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)

                if GetWidgetLife(u) > 0.405 then
                    call .damage(u)
                    call .blast(GetUnitX(u), GetUnitY(u))
                endif
            endloop
            call GroupClear(.carried)
            set u = null
        endmethod

        //--------------------------------------------------------
        method moveCarried takes real step, boolean withBlock returns nothing
            local unit u
            local unit victim
            local real nx
            local real ny
            local real f

            call GroupClear(Tmp)
            call GroupAddGroup(.carried, Tmp)
            loop
                set u = FirstOfGroup(Tmp)
                exitwhen u == null
                call GroupRemoveUnit(Tmp, u)

                if GetWidgetLife(u) < 0.405 then
                    call GroupRemoveUnit(.carried, u)
                else
                    set nx = GetUnitX(u) + .dx * step
                    set ny = GetUnitY(u) + .dy * step

                    // while the block is alive, never let it pass through a carried unit
                    if withBlock then
                        set f = (nx - .cx) * .dx + (ny - .cy) * .dy
                        if f < BLOCK_DEPTH * 0.5 then
                            set nx = nx + .dx * (BLOCK_DEPTH * 0.5 - f)
                            set ny = ny + .dy * (BLOCK_DEPTH * 0.5 - f)
                        endif
                    endif

                    if IsWall(nx + .dx * WALL_PAD, ny + .dy * WALL_PAD) then
                        call .slam(u, null)
                    else
                        call SetUnitX(u, nx)
                        call SetUnitY(u, ny)
                        set victim = .findVictim(u, nx, ny)
                        if victim != null then
                            call .slam(u, victim)
                        endif
                    endif
                endif
            endloop
            set u = null
            set victim = null
        endmethod

        //--------------------------------------------------------
        // returns true when the whole ability is finished
        method step takes nothing returns boolean
            local real stp = SPEED * INTERVAL

            if not .launching then
                // ---------- the block advances, carrying units in front of it ----------
                if .traveled + stp > DISTANCE then
                    set stp = DISTANCE - .traveled
                endif
                set .cx = .cx + .dx * stp
                set .cy = .cy + .dy * stp
                set .traveled = .traveled + stp

                call .capture()
                call .moveCarried(stp, true)
                call .updateBlock()

                if .traveled >= DISTANCE then
                    set .launching = true
                    set .pushLeft = EXTRA_PUSH
                    call .shatter()
                endif
                return false
            endif

            // ---------- the block is gone: carried units fly on for 400 more ----------
            set stp = EXTRA_SPEED * INTERVAL
            if stp > .pushLeft then
                set stp = .pushLeft
            endif
            call .moveCarried(stp, false)
            set .pushLeft = .pushLeft - stp

            if .pushLeft <= 0. then
                call .finish()
                return true
            endif
            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i >= .fxN
                call BlzSetSpecialEffectScale(.fx[i], 0.001)
                call DestroyEffect(.fx[i])
                set .fx[i] = null
                set i = i + 1
            endloop

            call DestroyGroup(.carried)
            call DestroyGroup(.done)
            call DestroyGroup(.hurt)
            set .carried = null
            set .done    = null
            set .hurt    = null
            set .caster  = null
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
    function CastGlacialSurge takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        if lvl < 1 then
            set lvl = 1
        endif
        call Surge.create(hero, x, y, lvl)
    endfunction

    function CastGlacialSurgeAuto takes unit hero, unit target, real x, real y, integer lvl returns nothing
        if target != null then
            set x = GetUnitX(target)
            set y = GetUnitY(target)
        endif
        call CastGlacialSurge(hero, x, y, lvl)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary