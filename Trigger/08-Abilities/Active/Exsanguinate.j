library Exsanguinate initializer Init requires GetObjectElement

    globals
        // ===================== CONFIG =====================
        // Movement
        private constant real    BASE_SPEED        = 750.     // units/second, outbound
        private constant real    RETURN_SPEED      = 1200.    // fixed inbound speed, ignores agility and upgrades
        private constant real    SPEED_PER_AGI     = 0.15     // +15% of the hero's agility (outbound)
        private constant real    BASE_RANGE        = 1000.    // total travel (including bounces) before it turns back
        private constant real    RANGE_PER_BLOOD   = 250.     // extra range per Element_Blood
        private constant real    BASE_WIDTH        = 80.      // collision width (also scales the saw)
        private constant real    WIDTH_PER_1000_INT = 5.      // +5 width per 1000 intelligence
        private constant real    END_DIST          = 100.     // hook finishes this far from the caster

        // Cliff bouncing
        private constant real    SUBSTEP           = 16.      // outgoing hook checks terrain every this many units (keep under 32)
        private constant real    PROBE_RADIUS      = 24.      // distance used to estimate the cliff's angle (probes at 1x and 2x)
        private constant integer MAX_BOUNCES       = 20       // hook turns back after this many bounces (must be 23 or less)

        // Damage
        private constant real    DMG_PCT_PER_100   = 0.04     // 4% of max HP per 100 units pulled
        private constant boolean PAUSE_TARGET      = true     // freeze the hooked unit while it is dragged

        // Hook head (saw)
        private constant string  SAW_MODEL         = "war3mapImported\\Bloodied_Sawblade_Hook.mdx"
        private constant string  SAW_BLOCKED_MODEL = "war3mapImported\\Bloodied_Sawblade_Blocked.mdx"
        private constant real    SAW_BASE_WIDTH    = 80.      // width at which the saw is scale 1.0; tune this to your model

        // Sound (looping saw, follows the blade and revs up while dragging a unit)
        private constant string  SAW_SOUND         = "war3mapImported\\SawLoop.wav"
        private constant integer SAW_VOLUME        = 90       // 0-127, while flying out
        private constant integer SAW_VOLUME_REV    = 127      // 0-127, fully revved
        private constant real    SAW_PITCH         = 1.0      // while flying out
        private constant real    SAW_PITCH_REV     = 1.8      // fully revved
        private constant real    SAW_REV_TIME      = 0.6      // seconds to rev up after hooking a unit
        private constant real    SAW_FULL_DIST     = 600.     // full volume within this distance
        private constant real    SAW_CUTOFF        = 3000.    // silent beyond this distance

        // Tether: chain links
        private constant string  CHAIN_MODEL       = "war3mapImported\\Bloodied_Saw_Chain.mdx"
        private constant real    CHAIN_SCALE       = 1.
        private constant real    CHAIN_SPACING     = 40.
        private constant real    CHAIN_END_GAP     = 55.      // chain stops this far before the saw's center

        // Fallback: if CHAIN_MODEL is "", the tether is a lightning rope instead
        private constant string  ROPE_LIGHTNING    = "DRAL"
        private constant real    ROPE_RED          = 1.00
        private constant real    ROPE_GREEN        = 0.00
        private constant real    ROPE_BLUE         = 0.00
        private constant real    ROPE_ALPHA        = 1.00

        // Blood
        private constant string  BLEED_MODEL       = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodFootman.mdl"
        private constant real    BLEED_INTERVAL    = 0.15
        private constant boolean TETHER_DRIPS      = true
        private constant real    FLY_HEIGHT        = 60.

        // Droplet trail behind the saw
        private constant string  DROP_MODEL        = "war3mapImported\\Bloodied_Saw_Droplet.mdx"
        private constant boolean DROP_TRAIL        = true
        private constant real    DROP_INTERVAL     = 0.16
        private constant real    DROP_LIFE         = 0.82
        private constant real    DROP_RADIUS       = 22.

        // Breaking
        private constant boolean BREAK_ON_INVULNERABLE = true   // hook breaks on invulnerable enemies
        private constant boolean BREAK_ON_MAGIC_IMMUNE = true   // hook breaks on magic immune enemies
        private constant real    FALL_SECONDS      = 0.70       // time the saw takes to drop to the ground
        private constant real    BREAK_TIME_BLOCKED   = 2.0     // total time of the "blocked" break
        private constant real    BREAK_TIME_INTERRUPT = 1.8     // total time of the "interrupted" break

        private constant real    INTERVAL          = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private group         Grp   = CreateGroup()
        private location     ZLoc  = Location(0., 0.)
        private hashtable     SpeedBonus = InitHashtable()

        // playable map bounds (filled on first use)
        private boolean BoundsReady = false
        private real    MinX = 0.
        private real    MaxX = 0.
        private real    MinY = 0.
        private real    MaxY = 0.
    endglobals

    //==================================================================
    private function GetZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc) + FLY_HEIGHT
    endfunction

    // hides an effect completely before destroying it (so no death animation shows)
    private function KillFx takes effect e returns nothing
        if e != null then
            call BlzSetSpecialEffectAlpha(e, 0)
            call BlzSetSpecialEffectScale(e, 0.001)
            call DestroyEffect(e)
        endif
    endfunction

    private function Clamp01 takes real x returns real
        if x < 0. then
            return 0.
        elseif x > 1. then
            return 1.
        endif
        return x
    endfunction

    // The saw model moves down 70 units on its own during its Death/Dissipate animation.
    // This reproduces that built-in drop (piecewise linear, 100ms keyframes) so the
    // visible blade can be placed at the height we actually want.
    private function ModelDrop takes real u returns real
        local real x
        local real f
        local integer i

        set u = Clamp01(u)
        if u >= 1. then
            return 70.
        endif
        set x = u * 7.
        set i = R2I(x)
        set f = x - I2R(i)
        return 70. * (I2R(i * i) + I2R(2 * i + 1) * f) / 49.
    endfunction

    // A "wall" is a spot that is neither walkable nor floatable (cliffs, pathing blockers),
    // or the edge of the map. Deep water is unwalkable but floatable, so the hook flies over it.
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

        return IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) and IsTerrainPathable(x, y, PATHING_TYPE_FLOATABILITY)
    endfunction

    // Estimates which way the wall faces by probing a ring of points around (x, y),
    // then mirrors the travel direction off it. Returns the new angle in radians.
    private function BounceAngle takes real x, real y, real angle returns real
        local integer i = 0
        local integer ring
        local real a
        local real sx = 0.
        local real sy = 0.
        local real len
        local real nx
        local real ny
        local real vx = Cos(angle)
        local real vy = Sin(angle)
        local real dot

        loop
            exitwhen i >= 16
            set a = 2. * bj_PI * I2R(i) / 16.
            set ring = 1
            loop
                exitwhen ring > 2
                if IsWall(x + Cos(a) * PROBE_RADIUS * I2R(ring), y + Sin(a) * PROBE_RADIUS * I2R(ring)) then
                    set sx = sx + Cos(a)
                    set sy = sy + Sin(a)
                endif
                set ring = ring + 1
            endloop
            set i = i + 1
        endloop

        set len = SquareRoot(sx * sx + sy * sy)
        if len < 0.001 then
            return angle + bj_PI          // can't tell the wall's direction: just turn around
        endif

        // (sx, sy) points into the wall, so the surface normal is the opposite
        set nx = -sx / len
        set ny = -sy / len
        set dot = vx * nx + vy * ny
        if dot >= 0. then
            return angle + bj_PI
        endif

        set vx = vx - 2. * dot * nx
        set vy = vy - 2. * dot * ny
        return Atan2(vy, vx)
    endfunction

    private function IsValidTarget takes unit u, unit caster, player owner returns boolean
        return u != caster /*
            */ and GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0
    endfunction

    // A unit the hook cannot grab: it breaks the saw instead
    private function IsBlocker takes unit u returns boolean
        return (BREAK_ON_INVULNERABLE and BlzIsUnitInvulnerable(u)) /*
            */ or (BREAK_ON_MAGIC_IMMUNE and IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE))
    endfunction

    // Returns a hookable unit if one is touching the saw, otherwise a blocker (immune unit), otherwise null
    private function FindHit takes real x, real y, unit caster, player owner, real width returns unit
        local unit u
        local unit found = null
        local unit blocker = null

        call GroupEnumUnitsInRange(Grp, x, y, width * 0.5 + 32., null)
        loop
            set u = FirstOfGroup(Grp)
            exitwhen u == null
            call GroupRemoveUnit(Grp, u)
            if IsValidTarget(u, caster, owner) then
                if IsBlocker(u) then
                    if blocker == null then
                        set blocker = u
                    endif
                elseif found == null then
                    set found = u
                endif
            endif
        endloop
        set u = null

        if found != null then
            set blocker = null
            return found
        endif
        return blocker
    endfunction

    //==================================================================
    // Outbound speed upgrades. Call these from your upgrade/learn code.
    // The bonus is added on top of BASE_SPEED + agility, and only affects the outbound throw.
    // The inbound speed is always RETURN_SPEED.
    function SetExsanguinateSpeedBonus takes unit u, real bonus returns nothing
        call SaveReal(SpeedBonus, GetHandleId(u), 0, bonus)
    endfunction

    function GetExsanguinateSpeedBonus takes unit u returns real
        return LoadReal(SpeedBonus, GetHandleId(u), 0)
    endfunction

    function AddExsanguinateSpeedBonus takes unit u, real amount returns nothing
        call SaveReal(SpeedBonus, GetHandleId(u), 0, LoadReal(SpeedBonus, GetHandleId(u), 0) + amount)
    endfunction

    //==================================================================
    private struct ExsanguinateInstance
        unit      caster
        player    owner
        effect    saw
        effect array chain[96]
        integer   chainN
        lightning array rope[24]
        integer   ropeN
        unit      target
        boolean   paused
        boolean   returning
        boolean   canLatch     // true only if the hook turned back without hitting anything on the way out
        real      x
        real      y
        real      angle        // radians, travel direction
        real      hookYaw      // radians, direction the saw faces (away from the previous path point)
        real      traveled
        real      bleedT

        // Per-cast stats, worked out from the hero when the hook is thrown
        real      speed        // outbound: 750 + 15% of agility + upgrade bonus
        real      maxDist      // 1000 + 250 per blood element
        real      width        // 80 + 5 per 1000 intelligence
        real      hitDamage    // initial damage = hero's strength
        real      sawScale

        // Sound
        sound     snd
        real      revT         // 0..SAW_REV_TIME, how far the saw has revved up

        // Visual state
        boolean   pulling      // saw plays Walk while dragging a unit, Stand otherwise
        integer   alpha        // chain opacity (fades out when the hook breaks)
        real      fallDz       // how far the chain has drooped (negative) during a break
        effect array drop[8]
        real array dropT[8]
        integer   dropCount
        real      dropClock

        // Break state
        boolean   broken
        real      breakTime
        real      fallT
        real      fallStartZ
        real      groundZ
        real      frzX         // caster position frozen when the hook breaks
        real      frzY

        // Bounce points the hook has passed through, in order. The tether runs
        // caster -> wx/wy[0] -> wx/wy[1] -> ... -> hook, and the return trip retraces it.
        real array wx[24]
        real array wy[24]
        integer   wn

        //--------------------------------------------------------
        // path point i: 0 = caster, 1..wn = bounce points, wn+1 = hook head
        method px takes integer i returns real
            if i <= 0 then
                if .broken then
                    return .frzX
                endif
                return GetUnitX(.caster)
            elseif i >= .wn + 1 then
                return .x
            endif
            return .wx[i - 1]
        endmethod

        method py takes integer i returns real
            if i <= 0 then
                if .broken then
                    return .frzY
                endif
                return GetUnitY(.caster)
            elseif i >= .wn + 1 then
                return .y
            endif
            return .wy[i - 1]
        endmethod

        //--------------------------------------------------------
        method addWaypoint takes nothing returns nothing
            local real dx
            local real dy

            // skip duplicates (corner bounces on the same spot)
            if .wn > 0 then
                set dx = .x - .wx[.wn - 1]
                set dy = .y - .wy[.wn - 1]
                if dx * dx + dy * dy < 4. then
                    return
                endif
            endif

            set .wx[.wn] = .x
            set .wy[.wn] = .y
            set .wn = .wn + 1
        endmethod

        //--------------------------------------------------------
        static method create takes unit caster, real tx, real ty returns thistype
            local thistype this = thistype.allocate()
            local real cx = GetUnitX(caster)
            local real cy = GetUnitY(caster)

            set .caster    = caster
            set .owner     = GetOwningPlayer(caster)
            set .target    = null
            set .paused    = false
            set .returning = false
            set .canLatch  = false
            set .ropeN     = 0
            set .chainN    = 0
            set .wn        = 0
            set .x         = cx
            set .y         = cy
            set .traveled  = 0.
            set .bleedT    = 0.
            set .pulling   = false
            set .alpha     = 255
            set .fallDz    = 0.
            set .dropCount = 0
            set .dropClock = 0.
            set .broken    = false
            set .revT      = 0.
            set .snd       = null

            // hero stats, read once at cast time
            set .speed     = BASE_SPEED + SPEED_PER_AGI * I2R(GetHeroAgi(caster, true)) + GetExsanguinateSpeedBonus(caster)
            set .maxDist   = BASE_RANGE + RANGE_PER_BLOOD * I2R(GetUnitElementCount(caster, Element_Blood))
            set .width     = BASE_WIDTH + WIDTH_PER_1000_INT * (I2R(GetHeroInt(caster, true)) / 1000.)
            set .hitDamage = I2R(GetHeroStr(caster, true))
            set .sawScale  = .width / SAW_BASE_WIDTH

            if tx == cx and ty == cy then
                set .angle = GetUnitFacing(caster) * bj_DEGTORAD
            else
                set .angle = Atan2(ty - cy, tx - cx)
            endif
            set .hookYaw = .angle

            // the saw is a free-standing effect that we move ourselves (no dummy unit needed)
            set .saw = AddSpecialEffect(SAW_MODEL, cx, cy)
            call BlzSetSpecialEffectScale(.saw, .sawScale)
            call BlzSetSpecialEffectPosition(.saw, cx, cy, GetZ(cx, cy))
            call BlzSetSpecialEffectYaw(.saw, .hookYaw)
            call BlzPlaySpecialEffect(.saw, ANIM_TYPE_STAND)

            // looping saw sound that follows the blade
            set .snd = CreateSound(SAW_SOUND, true, true, true, 10, 10, "DefaultEAXON")
            call SetSoundDistances(.snd, SAW_FULL_DIST, SAW_CUTOFF * 1.5)
            call SetSoundDistanceCutoff(.snd, SAW_CUTOFF)
            call SetSoundVolume(.snd, SAW_VOLUME)
            call SetSoundPitch(.snd, SAW_PITCH)
            call SetSoundPosition(.snd, cx, cy, GetZ(cx, cy))
            call StartSound(.snd)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // Draws the tether along the whole path: caster -> bounce points -> hook
        method updateChain takes nothing returns nothing
            local integer i
            local integer segs
            local integer k
            local real ax
            local real ay
            local real bx
            local real by
            local real dx
            local real dy
            local real len
            local real lim
            local real yaw
            local real pitch
            local real z0
            local real z1
            local real pos
            local real carry
            local real lx
            local real ly
            local real total = 0.
            local real acc = 0.

            if CHAIN_MODEL == "" then
                // ---------- fallback: one lightning bolt per path segment ----------
                set segs = .wn + 1

                loop
                    exitwhen .ropeN >= segs
                    set .rope[.ropeN] = AddLightningEx(ROPE_LIGHTNING, true, .x, .y, 0., .x, .y, 0.)
                    call SetLightningColor(.rope[.ropeN], ROPE_RED, ROPE_GREEN, ROPE_BLUE, ROPE_ALPHA)
                    set .ropeN = .ropeN + 1
                endloop
                loop
                    exitwhen .ropeN <= segs
                    set .ropeN = .ropeN - 1
                    call DestroyLightning(.rope[.ropeN])
                    set .rope[.ropeN] = null
                endloop

                set i = 0
                loop
                    exitwhen i >= segs
                    set ax = .px(i)
                    set ay = .py(i)
                    set bx = .px(i + 1)
                    set by = .py(i + 1)
                    call MoveLightningEx(.rope[i], true, ax, ay, GetZ(ax, ay), bx, by, GetZ(bx, by))
                    set i = i + 1
                endloop
                return
            endif

            // ---------- total path length (used to droop the chain when the hook breaks) ----------
            set i = 0
            loop
                exitwhen i > .wn
                set dx = .px(i + 1) - .px(i)
                set dy = .py(i + 1) - .py(i)
                set total = total + SquareRoot(dx * dx + dy * dy)
                set i = i + 1
            endloop
            if total < 1. then
                set total = 1.
            endif

            // ---------- chain links laid evenly along the whole path ----------
            set k = 0
            set carry = CHAIN_SPACING
            set i = 0
            loop
                exitwhen i > .wn
                set ax = .px(i)
                set ay = .py(i)
                set bx = .px(i + 1)
                set by = .py(i + 1)
                set dx = bx - ax
                set dy = by - ay
                set len = SquareRoot(dx * dx + dy * dy)

                if len > 0.01 then
                    set yaw = Atan2(dy, dx)
                    set z0 = GetZ(ax, ay) + .fallDz * acc / total
                    set z1 = GetZ(bx, by) + .fallDz * (acc + len) / total
                    set pitch = -Atan2(z1 - z0, len)

                    // the last segment stops short of the saw
                    set lim = len
                    if i == .wn then
                        set lim = len - CHAIN_END_GAP
                    endif

                    set pos = carry
                    loop
                        exitwhen pos > lim or k >= 96
                        if k >= .chainN then
                            set .chain[.chainN] = AddSpecialEffect(CHAIN_MODEL, ax, ay)
                            call BlzSetSpecialEffectScale(.chain[.chainN], CHAIN_SCALE)
                            set .chainN = .chainN + 1
                        endif
                        set lx = ax + dx / len * pos
                        set ly = ay + dy / len * pos
                        call BlzSetSpecialEffectPosition(.chain[k], lx, ly, GetZ(lx, ly) + .fallDz * (acc + pos) / total)
                        call BlzSetSpecialEffectOrientation(.chain[k], yaw, pitch, 0.)
                        if .alpha < 255 then
                            call BlzSetSpecialEffectAlpha(.chain[k], .alpha)
                        endif
                        set k = k + 1
                        set pos = pos + CHAIN_SPACING
                    endloop
                    set carry = pos - len
                    set acc = acc + len
                endif
                set i = i + 1
            endloop

            // remove surplus links
            loop
                exitwhen .chainN <= k
                set .chainN = .chainN - 1
                call KillFx(.chain[.chainN])
                set .chain[.chainN] = null
            endloop
        endmethod

        //--------------------------------------------------------
        // blood droplets that fall off the saw
        method spawnDrop takes nothing returns nothing
            local real a = I2R(.dropCount) * 2.399963229728653
            local integer slot = ModuloInteger(.dropCount, 8)
            local real dx = .x + DROP_RADIUS * Cos(a)
            local real dy = .y + DROP_RADIUS * Sin(a)

            if .drop[slot] != null then
                call KillFx(.drop[slot])
            endif
            set .drop[slot] = AddSpecialEffect(DROP_MODEL, dx, dy)
            call BlzSetSpecialEffectPosition(.drop[slot], dx, dy, GetZ(.x, .y) - 5.)
            call BlzPlaySpecialEffect(.drop[slot], ANIM_TYPE_BIRTH)
            set .dropT[slot] = DROP_LIFE
            set .dropCount = .dropCount + 1
        endmethod

        method tickDrops takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i > 7
                if .drop[i] != null then
                    set .dropT[i] = .dropT[i] - INTERVAL
                    if .dropT[i] <= 0. then
                        call KillFx(.drop[i])
                        set .drop[i] = null
                    endif
                endif
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // Applies the impact damage and hooks the unit if it survived
        method latch takes unit hit returns nothing
            call UnitDamageTarget(.caster, hit, .hitDamage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)

            if GetWidgetLife(hit) > 0.405 then
                set .target = hit
                if PAUSE_TARGET then
                    call PauseUnit(hit, true)
                    set .paused = true
                endif
            endif
        endmethod

        //--------------------------------------------------------
        method killSound takes nothing returns nothing
            if .snd != null then
                call StopSound(.snd, true, true)
                set .snd = null
            endif
        endmethod

        // follows the saw; revs up (pitch and volume) while a unit is being dragged
        method updateSound takes nothing returns nothing
            local real r

            if .snd == null then
                return
            endif

            if .pulling then
                set .revT = .revT + INTERVAL
            else
                set .revT = .revT - INTERVAL
            endif
            if .revT < 0. then
                set .revT = 0.
            elseif .revT > SAW_REV_TIME then
                set .revT = SAW_REV_TIME
            endif

            set r = .revT / SAW_REV_TIME
            call SetSoundPitch(.snd, SAW_PITCH + (SAW_PITCH_REV - SAW_PITCH) * r)
            call SetSoundVolume(.snd, SAW_VOLUME + R2I(I2R(SAW_VOLUME_REV - SAW_VOLUME) * r))
            call SetSoundPosition(.snd, .x, .y, GetZ(.x, .y))
        endmethod

        //--------------------------------------------------------
        // The hook stops, the saw drops to the ground and the chain fades.
        // blocked = true: hit an invulnerable / magic immune unit (Death animation, blocked model)
        // blocked = false: interrupted (Dissipate animation)
        method breakHook takes boolean blocked returns nothing
            local effect e

            call .killSound()

            // release the dragged unit
            if .paused and .target != null then
                call PauseUnit(.target, false)
            endif
            set .paused = false
            set .target = null

            set .broken     = true
            set .frzX       = GetUnitX(.caster)
            set .frzY       = GetUnitY(.caster)
            set .fallStartZ = GetZ(.x, .y)
            set .groundZ    = .fallStartZ - FLY_HEIGHT
            set .fallT      = 0.
            set .fallDz     = 0.

            if blocked then
                set .breakTime = BREAK_TIME_BLOCKED
                // companion model that exposes the Death animation as plain "Death"
                set e = AddSpecialEffect(SAW_BLOCKED_MODEL, .x, .y)
                call BlzSetSpecialEffectScale(e, .sawScale)
                call BlzSetSpecialEffectPosition(e, .x, .y, .fallStartZ)
                call BlzSetSpecialEffectYaw(e, .hookYaw)
                call BlzPlaySpecialEffect(e, ANIM_TYPE_DEATH)
                call KillFx(.saw)
                set .saw = e
                set e = null
            else
                set .breakTime = BREAK_TIME_INTERRUPT
                call BlzPlaySpecialEffect(.saw, ANIM_TYPE_DISSIPATE)
            endif
        endmethod

        //--------------------------------------------------------
        // runs every tick while the hook is breaking. returns true when it is over
        method stepBreak takes nothing returns boolean
            local real u
            local real vz
            local real fade

            set .fallT = .fallT + INTERVAL
            if .fallT > .breakTime then
                set .fallT = .breakTime
            endif

            set u  = Clamp01(.fallT / FALL_SECONDS)
            set vz = .fallStartZ + (.groundZ + 4. - .fallStartZ) * u * u

            // the model drops by itself too, so compensate to keep the visible height right
            call BlzSetSpecialEffectPosition(.saw, .x, .y, vz + ModelDrop(u))

            set fade   = 1. - Clamp01((.fallT - FALL_SECONDS) / (.breakTime - FALL_SECONDS))
            set .alpha = R2I(255. * fade + 0.5)
            set .fallDz = vz - .fallStartZ

            call .updateChain()
            call .tickDrops()
            return .fallT >= .breakTime
        endmethod

        //--------------------------------------------------------
        // returns true when the hook is finished
        method step takes nothing returns boolean
            local real stp
            local real rem
            local real sub
            local real nx
            local real ny
            local real tx
            local real ty
            local real dx
            local real dy
            local real d
            local real seg
            local real m
            local real moved = 0.
            local real dmg
            local real f
            local real ax
            local real ay
            local real bx
            local real by
            local integer s
            local boolean finished = false
            local boolean pull
            local unit hit

            if .broken then
                return .stepBreak()
            endif

            if GetUnitTypeId(.caster) == 0 then
                return true
            endif

            if IsUnitType(.caster, UNIT_TYPE_DEAD) then
                call .breakHook(false)      // caster died: the hook is interrupted
                return false
            endif

            // outbound uses the upgradeable speed, inbound is fixed
            if .returning then
                set stp = RETURN_SPEED * INTERVAL
            else
                set stp = .speed * INTERVAL
            endif

            if not .returning then
                // ---------- going out (bounces off cliffs, remembering each bounce) ----------
                set rem = stp
                loop
                    exitwhen rem <= 0. or .returning or .broken
                    set sub = rem
                    if sub > SUBSTEP then
                        set sub = SUBSTEP
                    endif

                    set nx = .x + sub * Cos(.angle)
                    set ny = .y + sub * Sin(.angle)

                    if IsWall(nx, ny) and not IsWall(.x, .y) then
                        if .wn >= MAX_BOUNCES then
                            set .returning = true
                            set .canLatch  = true
                        else
                            // record the bounce point, then mirror the direction off the cliff
                            call .addWaypoint()
                            set .angle = BounceAngle(.x, .y, .angle)
                            if IsWall(.x + SUBSTEP * Cos(.angle), .y + SUBSTEP * Sin(.angle)) then
                                set .angle = .angle + bj_PI     // stuck in a corner: reverse
                            endif
                        endif
                    else
                        set .x = nx
                        set .y = ny

                        set hit = FindHit(.x, .y, .caster, .owner, .width)
                        if hit != null then
                            if IsBlocker(hit) then
                                call .breakHook(true)         // invulnerable / magic immune: the saw breaks
                            else
                                set .returning = true         // canLatch stays false: something was hit
                                call .latch(hit)
                            endif
                        endif
                    endif

                    set rem = rem - sub
                endloop
                set hit = null

                if not .broken then
                    set .traveled = .traveled + stp
                    if not .returning and .traveled >= .maxDist then
                        set .returning = true
                        set .canLatch  = true
                    endif
                endif
            else
                // ---------- coming back: retrace the bounce points, then go to the caster ----------
                set rem = stp
                loop
                    exitwhen rem <= 0. or finished

                    if .wn > 0 then
                        set tx = .wx[.wn - 1]
                        set ty = .wy[.wn - 1]
                    else
                        set tx = GetUnitX(.caster)
                        set ty = GetUnitY(.caster)
                    endif

                    set dx = tx - .x
                    set dy = ty - .y
                    set d  = SquareRoot(dx * dx + dy * dy)

                    if .wn > 0 then
                        set seg = d
                    else
                        set seg = d - END_DIST
                    endif

                    if seg <= 0.001 then
                        if .wn > 0 then
                            set .wn = .wn - 1          // reached this bounce point
                        else
                            set finished = true        // reached the caster
                        endif
                    else
                        set .angle = Atan2(dy, dx)
                        set m = rem
                        if m > seg then
                            set m = seg
                        endif

                        if .wn > 0 and m >= seg then
                            set .x = tx                // land exactly on the bounce point
                            set .y = ty
                            set .wn = .wn - 1
                        else
                            set .x = .x + m * Cos(.angle)
                            set .y = .y + m * Sin(.angle)
                            if .wn == 0 and m >= seg then
                                set finished = true
                            endif
                        endif

                        set rem = rem - m
                        set moved = moved + m
                    endif
                endloop

                // empty hook: grab the first enemy that touches it on the way back
                if .canLatch and .target == null then
                    set hit = FindHit(.x, .y, .caster, .owner, .width)
                    if hit != null then
                        set .canLatch = false
                        if IsBlocker(hit) then
                            call .breakHook(true)
                        else
                            call .latch(hit)
                        endif
                    endif
                    set hit = null
                endif

                if .target != null and not .broken then
                    if GetWidgetLife(.target) < 0.405 then
                        // target died, bring the empty hook home
                        if .paused then
                            call PauseUnit(.target, false)
                            set .paused = false
                        endif
                        set .target = null
                    elseif IsBlocker(.target) then
                        // the dragged unit became invulnerable / magic immune: the hook breaks
                        call .breakHook(false)
                    else
                        call SetUnitX(.target, .x)
                        call SetUnitY(.target, .y)

                        // 4% max HP per 100 units pulled along the path
                        set dmg = GetUnitState(.target, UNIT_STATE_MAX_LIFE) * DMG_PCT_PER_100 * (moved / 100.)
                        if .paused and GetWidgetLife(.target) <= dmg then
                            call PauseUnit(.target, false)   // so a lethal hit can play its death
                            set .paused = false
                        endif
                        call UnitDamageTarget(.caster, .target, dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_UNIVERSAL, WEAPON_TYPE_WHOKNOWS)

                        // bleed
                        set .bleedT = .bleedT + INTERVAL
                        if .bleedT >= BLEED_INTERVAL then
                            set .bleedT = 0.
                            call DestroyEffect(AddSpecialEffectTarget(BLEED_MODEL, .target, "chest"))

                            // blood spatter at a random point along the tether path
                            if TETHER_DRIPS then
                                set s = GetRandomInt(0, .wn)
                                set f = GetRandomReal(0., 1.)
                                set ax = .px(s)
                                set ay = .py(s)
                                set bx = .px(s + 1)
                                set by = .py(s + 1)
                                call DestroyEffect(AddSpecialEffect(BLEED_MODEL, ax + (bx - ax) * f, ay + (by - ay) * f))
                            endif
                        endif
                    endif
                endif
            endif

            // the hook broke this tick: stepBreak takes over from the next tick
            if .broken then
                return false
            endif

            // saw animation: Walk while dragging a unit, Stand otherwise
            set pull = .returning and .target != null
            if pull != .pulling then
                set .pulling = pull
                if pull then
                    call BlzPlaySpecialEffect(.saw, ANIM_TYPE_WALK)
                else
                    call BlzPlaySpecialEffect(.saw, ANIM_TYPE_STAND)
                endif
            endif

            // the saw always faces away from the previous point of the tether
            set dx = .x - .px(.wn)
            set dy = .y - .py(.wn)
            if dx * dx + dy * dy > 1. then
                set .hookYaw = Atan2(dy, dx)
            endif

            call BlzSetSpecialEffectPosition(.saw, .x, .y, GetZ(.x, .y))
            call BlzSetSpecialEffectYaw(.saw, .hookYaw)

            // saw sound follows the blade and revs up while dragging
            call .updateSound()

            // blood droplet trail
            if DROP_TRAIL then
                set .dropClock = .dropClock + INTERVAL
                loop
                    exitwhen .dropClock < DROP_INTERVAL
                    set .dropClock = .dropClock - DROP_INTERVAL
                    call .spawnDrop()
                endloop
            endif
            call .tickDrops()

            call .updateChain()
            return finished
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            if .paused and .target != null then
                call PauseUnit(.target, false)
            endif

            loop
                exitwhen .ropeN <= 0
                set .ropeN = .ropeN - 1
                call DestroyLightning(.rope[.ropeN])
                set .rope[.ropeN] = null
            endloop

            loop
                exitwhen .chainN <= 0
                set .chainN = .chainN - 1
                call KillFx(.chain[.chainN])
                set .chain[.chainN] = null
            endloop

            loop
                exitwhen i > 7
                if .drop[i] != null then
                    call KillFx(.drop[i])
                    set .drop[i] = null
                endif
                set i = i + 1
            endloop

            call .killSound()

            call KillFx(.saw)
            set .saw = null

            set .caster = null
            set .target = null
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
    function CastExsanguinate takes unit hero, real x, real y returns nothing
        if hero == null then
            return
        endif
        call ExsanguinateInstance.create(hero, x, y)
    endfunction

    private function Init takes nothing returns nothing
    endfunction

endlibrary