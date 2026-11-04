library VoidRip

    globals
        // ===================== CONFIG =====================
        // Timeline (seconds)
        private constant real    WINDUP_TIME        = 2.0     // charge-up before the swap
        private constant real    WARP_TIME          = 0.3     // the swap itself: both units are dragged through the rip
        private constant real    SCAR_FADE_TIME     = 0.6     // the rip's scar lingers and fades after the swap

        // Slow on the enemy once the swap lands
        private constant real    SLOW_PER_LEVEL     = 0.01    // 1% per ability level
        private constant real    SLOW_DURATION      = 4.0

        // The swap
        private constant boolean GHOST_DURING_WARP  = true    // both units go semi-transparent while they're dragged through
        private constant integer GHOST_ALPHA        = 70      // 0-255: how see-through they get at the midpoint

        // Charge-up visuals: void orbs spiral in around BOTH units, and pulses run along the tether between them
        private constant integer RING_ORBS          = 6       // per unit (the arrays are sized for 6)
        private constant real    RING_RADIUS_START  = 120.
        private constant real    RING_RADIUS_END    = 45.
        private constant real    RING_DIAMETER_START = 25.
        private constant real    RING_DIAMETER_END  = 60.
        private constant real    RING_HEIGHT        = 70.
        private constant real    RING_SPIN          = 4.      // radians per second (speeds up as the charge builds)
        private constant integer PULSE_COUNT        = 6       // (the arrays are sized for 6)
        private constant real    PULSE_DIAMETER     = 45.
        private constant real    PULSE_SPEED        = 1.2     // laps per second along the tether

        // The rip itself: a line of orbs laid between the two start points while the units are dragged along it
        private constant real    PATH_SPACING       = 90.
        private constant real    PATH_DIAMETER      = 70.
        private constant real    TETHER_HEIGHT      = 80.

        // Look. Everything shares one void purple.
        private constant string  ORB_MODEL          = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH = 50.     // rough width of that model at scale 1. Tune if sizes look off
        private constant string  TETHER_LIGHTNING   = "DRAL"
        private constant real    TETHER_REFRESH_TIME = 0.15   // the bolt is rebuilt this often so it can't die off
        private constant string  FLASH_MODEL        = "Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl"   // flash where each unit arrives
        private constant string  SLOW_MODEL         = "Abilities\\Spells\\Human\\slow\\slowtarget.mdl"        // shown on the enemy while slowed
        private constant integer VOID_RED           = 150
        private constant integer VOID_GREEN         = 60
        private constant integer VOID_BLUE          = 230
        private constant real    VOID_RED_F         = 0.58    // the same purple, as 0-1 values for lightning
        private constant real    VOID_GREEN_F       = 0.24
        private constant real    VOID_BLUE_F        = 0.90

        private constant real    INTERVAL           = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private location     ZLoc  = Location(0., 0.)
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    // A void-purple orb, hidden until it's positioned
    private function NewOrb takes real x, real y returns effect
        local effect e = AddSpecialEffect(ORB_MODEL, x, y)

        call BlzSetSpecialEffectColor(e, VOID_RED, VOID_GREEN, VOID_BLUE)
        call BlzSetSpecialEffectScale(e, 0.001)
        return e
    endfunction

    private function KillEffect takes effect e returns nothing
        call BlzSetSpecialEffectScale(e, 0.001)    // hides the death animation
        call DestroyEffect(e)
    endfunction

    // A one-shot purple flash at a spot
    private function Flash takes real x, real y returns nothing
        local effect e

        if FLASH_MODEL != "" then
            set e = AddSpecialEffect(FLASH_MODEL, x, y)
            call BlzSetSpecialEffectColor(e, VOID_RED, VOID_GREEN, VOID_BLUE)
            call DestroyEffect(e)
            set e = null
        endif
    endfunction

    //==================================================================
    // The whole spell.
    //
    //   0.0s - 2.0s   TELEGRAPH. A void-purple tether links the hero and the target and follows them
    //                 wherever they move. Void orbs spiral in around BOTH units, tightening and growing
    //                 as the charge builds, and pulses run back and forth along the tether.
    //   2.0s          THE RIP. Both units are caught in the rip and dragged along the line through each
    //                 other to the other's spot, fading to a ghost on the way. A scar of void orbs and
    //                 the tether lock between the two original spots to show exactly where they went.
    //   2.3s          They land with a flash, facing each other. The enemy is slowed.
    //   +0.6s         the scar fades.
    //   +4s           the slow ends.
    //==================================================================
    private struct VoidRipInstance
        unit caster
        unit target
        integer level
        real t

        boolean warpStarted
        boolean warpDone
        boolean pausedC       // true if WE paused the caster (so we only release our own pause)
        boolean pausedT
        real sx               // where the hero started...
        real sy
        real ex               // ...and where the enemy started: the two ends of the rip
        real ey
        integer pathN

        real slowAmt
        boolean slowApplied
        effect slowFx

        lightning tether
        real tetherRefresh
        effect array ring[12]
        effect array pulse[6]
        effect array path[46]

        //--------------------------------------------------------
        static method create takes unit caster, unit target, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local integer i = 0
            local real x = GetUnitX(caster)
            local real y = GetUnitY(caster)

            set .caster       = caster
            set .target       = target
            set .level        = lvl
            set .t            = 0.
            set .warpStarted  = false
            set .warpDone     = false
            set .pausedC      = false
            set .pausedT      = false
            set .pathN        = 0
            set .slowAmt      = 0.
            set .slowApplied  = false
            set .slowFx       = null
            set .tether       = null
            set .tetherRefresh = 0.

            loop
                exitwhen i >= RING_ORBS * 2
                set .ring[i] = NewOrb(x, y)
                set i = i + 1
            endloop

            set i = 0
            loop
                exitwhen i >= PULSE_COUNT
                set .pulse[i] = NewOrb(x, y)
                set i = i + 1
            endloop

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // The line of lightning. Rebuilt every so often so it can never die off.
        method drawTether takes real x1, real y1, real z1, real x2, real y2, real z2, real alpha returns nothing
            set .tetherRefresh = .tetherRefresh + INTERVAL
            if .tether != null and .tetherRefresh >= TETHER_REFRESH_TIME then
                call DestroyLightning(.tether)
                set .tether = null
            endif
            if .tether == null then
                set .tetherRefresh = 0.
                set .tether = AddLightningEx(TETHER_LIGHTNING, false, x1, y1, z1, x2, y2, z2)
            endif

            if alpha > 1. then
                set alpha = 1.
            endif
            if alpha < 0. then
                set alpha = 0.
            endif
            call SetLightningColor(.tether, VOID_RED_F, VOID_GREEN_F, VOID_BLUE_F, alpha)
            call MoveLightningEx(.tether, false, x1, y1, z1, x2, y2, z2)
        endmethod

        //--------------------------------------------------------
        // The orbs spiralling in around both units while charging (p = charge progress 0..1)
        method drawRings takes real p returns nothing
            local integer i = 0
            local integer who
            local integer k
            local real dir
            local real ang
            local real rad
            local real sc
            local real x
            local real y
            local unit u

            loop
                exitwhen i >= RING_ORBS * 2

                set who = i / RING_ORBS
                set k = i - who * RING_ORBS
                if who == 0 then
                    set u = .caster
                    set dir = 1.
                else
                    set u = .target
                    set dir = -1.      // the two rings spin opposite ways
                endif

                set ang = 2. * bj_PI * I2R(k) / I2R(RING_ORBS) + dir * RING_SPIN * .t * (1. + 2. * p)
                set rad = RING_RADIUS_START + (RING_RADIUS_END - RING_RADIUS_START) * p
                set sc = (RING_DIAMETER_START + (RING_DIAMETER_END - RING_DIAMETER_START) * p) / MODEL_NATIVE_WIDTH

                set x = GetUnitX(u) + rad * Cos(ang)
                set y = GetUnitY(u) + rad * Sin(ang)

                call BlzSetSpecialEffectScale(.ring[i], sc)
                call BlzSetSpecialEffectPosition(.ring[i], x, y, GroundZ(x, y) + RING_HEIGHT + 20. * Sin(.t * 6. + I2R(k)))
                set i = i + 1
            endloop

            set u = null
        endmethod

        //--------------------------------------------------------
        // Pulses travelling back and forth along the tether
        method drawPulses takes real ax, real ay, real bx, real by, real p returns nothing
            local integer i = 0
            local real f
            local real x
            local real y
            local real sc

            loop
                exitwhen i >= PULSE_COUNT

                set f = .t * PULSE_SPEED + I2R(i) / I2R(PULSE_COUNT)
                set f = f - I2R(R2I(f))
                if i - (i / 2) * 2 == 1 then
                    set f = 1. - f          // every other pulse runs the opposite way
                endif

                set x = ax + (bx - ax) * f
                set y = ay + (by - ay) * f
                set sc = (PULSE_DIAMETER / MODEL_NATIVE_WIDTH) * (0.4 + 0.6 * p)

                call BlzSetSpecialEffectScale(.pulse[i], sc)
                call BlzSetSpecialEffectPosition(.pulse[i], x, y, GroundZ(x, y) + TETHER_HEIGHT + 10. * Sin(.t * 10. + I2R(i)))
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // The scar left by the rip: orbs spread evenly along the line between the two start points
        method drawPath takes real fade returns nothing
            local integer i = 0
            local real f
            local real x
            local real y
            local real sc

            loop
                exitwhen i >= .pathN

                set f = I2R(i) / I2R(.pathN - 1)
                set x = .sx + (.ex - .sx) * f
                set y = .sy + (.ey - .sy) * f
                set sc = (PATH_DIAMETER / MODEL_NATIVE_WIDTH) * (0.8 + 0.3 * Sin(.t * 25. + I2R(i))) * fade
                if sc < 0.001 then
                    set sc = 0.001
                endif

                call BlzSetSpecialEffectScale(.path[i], sc)
                call BlzSetSpecialEffectPosition(.path[i], x, y, GroundZ(x, y) + TETHER_HEIGHT)
                set i = i + 1
            endloop
        endmethod

        //--------------------------------------------------------
        // The moment of the rip: note both start points, freeze both units, lay the scar
        method beginWarp takes nothing returns nothing
            local real dx
            local real dy
            local integer i = 0
            local integer n

            set .warpStarted = true
            set .sx = GetUnitX(.caster)
            set .sy = GetUnitY(.caster)
            set .ex = GetUnitX(.target)
            set .ey = GetUnitY(.target)

            // pause them for the drag (only release a pause that is ours)
            if not IsUnitPaused(.caster) then
                set .pausedC = true
                call PauseUnit(.caster, true)
            endif
            if not IsUnitPaused(.target) then
                set .pausedT = true
                call PauseUnit(.target, true)
            endif

            // the scar: orbs along the line between the start points
            set dx = .ex - .sx
            set dy = .ey - .sy
            set n = R2I(SquareRoot(dx * dx + dy * dy) / PATH_SPACING) + 2
            if n > 46 then
                set n = 46
            endif
            set .pathN = n
            loop
                exitwhen i >= n
                set .path[i] = NewOrb(.sx, .sy)
                set i = i + 1
            endloop

            // the telegraph orbs and pulses give way to the scar
            set i = 0
            loop
                exitwhen i >= PULSE_COUNT
                if .pulse[i] != null then
                    call KillEffect(.pulse[i])
                    set .pulse[i] = null
                endif
                set i = i + 1
            endloop

            // the tether stops following the units and locks to the rip's path
            if .tether != null then
                call DestroyLightning(.tether)
                set .tether = null
            endif
        endmethod

        //--------------------------------------------------------
        // The landing: exact final spots, facing each other, a flash at each, the slow
        method endWarp takes nothing returns nothing
            local integer i = 0
            local real face

            set .warpDone = true

            call SetUnitX(.caster, .ex)
            call SetUnitY(.caster, .ey)
            call SetUnitX(.target, .sx)
            call SetUnitY(.target, .sy)

            if GHOST_DURING_WARP then
                call SetUnitVertexColor(.caster, 255, 255, 255, 255)
                call SetUnitVertexColor(.target, 255, 255, 255, 255)
            endif

            if .pausedC then
                set .pausedC = false
                call PauseUnit(.caster, false)
            endif
            if .pausedT then
                set .pausedT = false
                call PauseUnit(.target, false)
            endif

            // each turns (instantly) to look back across the rip at the other
            set face = Atan2(.sy - .ey, .sx - .ex) * bj_RADTODEG
            call BlzSetUnitFacingEx(.caster, face)
            call BlzSetUnitFacingEx(.target, face + 180.)

            call Flash(.ex, .ey)
            call Flash(.sx, .sy)

            // the orbs that were circling them are done
            loop
                exitwhen i >= RING_ORBS * 2
                if .ring[i] != null then
                    call KillEffect(.ring[i])
                    set .ring[i] = null
                endif
                set i = i + 1
            endloop

            // the slow
            set .slowAmt = GetUnitMoveSpeed(.target) * SLOW_PER_LEVEL * I2R(.level)
            call SetUnitMoveSpeed(.target, GetUnitMoveSpeed(.target) - .slowAmt)
            set .slowApplied = true
            if SLOW_MODEL != "" then
                set .slowFx = AddSpecialEffectTarget(SLOW_MODEL, .target, "origin")
            endif
        endmethod

        //--------------------------------------------------------
        // returns true when the spell is finished
        method step takes nothing returns boolean
            local real ax
            local real ay
            local real bx
            local real by
            local real p
            local real sp
            local real x
            local real y
            local real fade
            local real tAfter
            local real alpha
            local integer i

            // if either unit dies the spell simply ends (everything is tidied up in onDestroy)
            if GetWidgetLife(.caster) < 0.405 or GetWidgetLife(.target) < 0.405 then
                return true
            endif

            set .t = .t + INTERVAL

            if .t < WINDUP_TIME then
                // ---------- telegraph ----------
                set p = .t / WINDUP_TIME
                set ax = GetUnitX(.caster)
                set ay = GetUnitY(.caster)
                set bx = GetUnitX(.target)
                set by = GetUnitY(.target)

                call .drawTether(ax, ay, GroundZ(ax, ay) + TETHER_HEIGHT, bx, by, GroundZ(bx, by) + TETHER_HEIGHT, 0.35 + 0.65 * p)
                call .drawRings(p)
                call .drawPulses(ax, ay, bx, by, p)
                return false
            endif

            if not .warpStarted then
                call .beginWarp()
            endif

            if not .warpDone then
                // ---------- the rip: both units are dragged through each other along the line ----------
                set p = (.t - WINDUP_TIME) / WARP_TIME
                if p > 1. then
                    set p = 1.
                endif
                set sp = p * p * (3. - 2. * p)      // eases in and out

                call SetUnitX(.caster, .sx + (.ex - .sx) * sp)
                call SetUnitY(.caster, .sy + (.ey - .sy) * sp)
                call SetUnitX(.target, .ex + (.sx - .ex) * sp)
                call SetUnitY(.target, .ey + (.sy - .ey) * sp)

                if GHOST_DURING_WARP then
                    set alpha = 255. - (255. - I2R(GHOST_ALPHA)) * Sin(bj_PI * p)
                    call SetUnitVertexColor(.caster, 255, 255, 255, R2I(alpha))
                    call SetUnitVertexColor(.target, 255, 255, 255, R2I(alpha))
                endif

                // the circling orbs stay with the units as they're dragged
                call .drawRings(1.)

                // the scar and tether lock to the original line
                call .drawPath(1.)
                call .drawTether(.sx, .sy, GroundZ(.sx, .sy) + TETHER_HEIGHT, .ex, .ey, GroundZ(.ex, .ey) + TETHER_HEIGHT, 1.)

                if p >= 1. then
                    call .endWarp()
                endif
                return false
            endif

            // ---------- aftermath: the scar fades, the slow runs ----------
            set tAfter = .t - (WINDUP_TIME + WARP_TIME)

            if .pathN > 0 then
                set fade = 1. - tAfter / SCAR_FADE_TIME
                if fade <= 0. then
                    // the scar is gone
                    set i = 0
                    loop
                        exitwhen i >= .pathN
                        call KillEffect(.path[i])
                        set .path[i] = null
                        set i = i + 1
                    endloop
                    set .pathN = 0
                    if .tether != null then
                        call DestroyLightning(.tether)
                        set .tether = null
                    endif
                else
                    call .drawPath(fade)
                    call .drawTether(.sx, .sy, GroundZ(.sx, .sy) + TETHER_HEIGHT, .ex, .ey, GroundZ(.ex, .ey) + TETHER_HEIGHT, fade)
                endif
            endif

            return tAfter >= SLOW_DURATION
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            // if the spell was cut short mid-rip, never leave anyone frozen or see-through
            if .pausedC then
                call PauseUnit(.caster, false)
            endif
            if .pausedT then
                call PauseUnit(.target, false)
            endif
            if .warpStarted and GHOST_DURING_WARP then
                call SetUnitVertexColor(.caster, 255, 255, 255, 255)
                call SetUnitVertexColor(.target, 255, 255, 255, 255)
            endif

            // give the enemy its speed back (adds back exactly what was taken, so other speed effects aren't disturbed)
            if .slowApplied then
                call SetUnitMoveSpeed(.target, GetUnitMoveSpeed(.target) + .slowAmt)
                set .slowApplied = false
            endif
            if .slowFx != null then
                call DestroyEffect(.slowFx)
                set .slowFx = null
            endif

            if .tether != null then
                call DestroyLightning(.tether)
                set .tether = null
            endif

            loop
                exitwhen i >= 12
                if .ring[i] != null then
                    call KillEffect(.ring[i])
                    set .ring[i] = null
                endif
                set i = i + 1
            endloop

            set i = 0
            loop
                exitwhen i >= 6
                if .pulse[i] != null then
                    call KillEffect(.pulse[i])
                    set .pulse[i] = null
                endif
                set i = i + 1
            endloop

            set i = 0
            loop
                exitwhen i >= .pathN
                if .path[i] != null then
                    call KillEffect(.path[i])
                    set .path[i] = null
                endif
                set i = i + 1
            endloop

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
    // Public entry point, called from your ability dispatcher.
    function CastVoidRip takes unit hero, unit target, integer lvl returns nothing
        if hero == null or target == null or hero == target then
            return
        endif
        if GetWidgetLife(target) < 0.405 or IsUnitType(target, UNIT_TYPE_DEAD) or IsUnitType(target, UNIT_TYPE_STRUCTURE) then
            return
        endif
        if not IsUnitEnemy(target, GetOwningPlayer(hero)) then
            return
        endif

        call VoidRipInstance.create(hero, target, lvl)
    endfunction

endlibrary