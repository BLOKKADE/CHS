library BloodTendrils requires GetObjectElement, CastSpellOnTarget, RandomShit, optional DummyOrder

    globals
        // ===================== CONFIG =====================
        // These must already exist as global constants:
        //   BLOOD_TENDRIL_DEBUFF_ABILITY_ID   a dummy ability whose only job is to put that debuff on a unit (set up in the editor, see my notes)

        // The tendrils
        private constant integer TENDRIL_COUNT       = 7
        private constant real    ARC_DEGREES         = 30.     // the fan the tendrils spread across, evenly
        private constant real    RANGE               = 600.    // how far a tendril travels before it fizzles
        private constant real    TENDRIL_SPEED       = 400.
        private constant real    HIT_RADIUS          = 60.     // how close a tendril's tip has to come to a unit to hit it

        // Chaining
        private constant integer CHAINS_PER_TENDRIL  = 1       // how many times each tendril can jump on after hitting
        private constant real    CHAIN_RANGE         = 400.    // how far a chain looks for its next target
        private constant real    CHAIN_HIT_DIST      = 40.     // a chain hits once its tip is this close

        // Damage
        private constant real    HIT_PER_LEVEL       = 125.    // physical damage per ability level, on every tendril and chain
        private constant real    DOT_PER_LEVEL       = 75.     // physical damage per ability level, every DOT_INTERVAL
        private constant real    DOT_INTERVAL        = 1.
        private constant real    DOT_DURATION        = 8.
        private constant real    BLOOD_BONUS_FRACTION = 0.10   // extra damage = this share of the hero's attack damage, per Blood element
        private constant boolean BONUS_APPLIES_TO_DOT = true   // false = the Blood bonus only boosts the hit, not the bleeding
        private constant string  DEBUFF_ORDER        = "slow"  // the order string of the dummy ability's base ability (Slow)

        // Look. Each tendril is a rope of blood-red lightning from its source to a glistening droplet at its tip.
        private constant string  ORB_MODEL           = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH  = 50.     // rough width of the orb model at scale 1. Tune if the orbs look off
        private constant real    ORB_DIAMETER        = 36.
        private constant string  ROPE_LIGHTNING      = "DRAL"
        private constant real    ROPE_REFRESH_TIME   = 0.15    // each rope is rebuilt this often so it can't die off mid-flight
        private constant real    ROPE_HEIGHT         = 80.
        private constant real    LINGER_TIME         = 0.3     // a rope stays attached to what it hit for this long, fading
        private constant string  BLOOD_MODEL         = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodFootman.mdl"
        private constant integer BLOOD_RED           = 200
        private constant integer BLOOD_GREEN         = 10
        private constant integer BLOOD_BLUE          = 15
        private constant real    BLOOD_RED_F         = 0.80    // the same red, as 0-1 values for lightning
        private constant real    BLOOD_GREEN_F       = 0.03
        private constant real    BLOOD_BLUE_F        = 0.06

        private constant real    INTERVAL            = 0.03125
        // ====================================================

        private integer array CastActive
        private integer       CastCount = 0
        private timer         CastTick  = CreateTimer()

        private integer array DotActive
        private integer       DotCount = 0
        private timer         DotTick  = CreateTimer()
        private hashtable     DotHash  = InitHashtable()    // unit -> the bleed on it

        private group         Grp  = CreateGroup()
        private location     ZLoc = Location(0., 0.)
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    private function IsValidEnemy takes unit u, unit hero, player owner returns boolean
        return u != hero /*
            */ and GetWidgetLife(u) > 0.405 /*
            */ and IsUnitEnemy(u, owner) /*
            */ and not IsUnitType(u, UNIT_TYPE_DEAD) /*
            */ and not IsUnitType(u, UNIT_TYPE_STRUCTURE) /*
            */ and GetUnitAbilityLevel(u, 'Aloc') == 0 /*
            */ and not IsUnitHidden(u) /*
            */ and not BlzIsUnitInvulnerable(u)
    endfunction

    // The hero's attack damage, for the Blood bonus: base damage + average of the dice + his strongest attribute.
    // (Built from natives only. If you have your own "total attack damage" function that includes item bonuses,
    //  return it from here instead.)
    private function HeroAttackDamage takes unit u returns real
        local real dmg = I2R(BlzGetUnitBaseDamage(u, 0)) + I2R(BlzGetUnitDiceNumber(u, 0)) * (I2R(BlzGetUnitDiceSides(u, 0)) + 1.) * 0.5
        local integer s = GetHeroStr(u, true)
        local integer a = GetHeroAgi(u, true)
        local integer n = GetHeroInt(u, true)

        if a > s then
            set s = a
        endif
        if n > s then
            set s = n
        endif
        return dmg + I2R(s)
    endfunction

    // Puts the Blood Tendril debuff on a unit by having a dummy cast the debuff ability on it.
    // This is the ONLY place that touches your dummy-cast system. If it doesn't suit, replace the body
    // with however you normally apply a buff.
    private function ApplyDebuff takes unit hero, unit target returns nothing
        call DummyOrder.create(hero, GetUnitX(target), GetUnitY(target), GetUnitFacing(hero), 2).addActiveAbility(BLOOD_TENDRIL_DEBUFF_ABILITY_ID, 1, OrderId(DEBUFF_ORDER)).target(target).activate()
    endfunction

    //==================================================================
    // The bleeding on one unit. It only keeps going while the unit still has the debuff,
    // so dispelling the debuff ends it early. Hitting a bleeding unit again refreshes it.
    //==================================================================
    private struct BloodDot
        unit target
        unit source
        real dmg
        real left
        real acc

        //--------------------------------------------------------
        static method apply takes unit source, unit target, real dmg returns nothing
            local integer id = GetHandleId(target)
            local thistype this

            if HaveSavedInteger(DotHash, id, 0) then
                // already bleeding: refresh it
                set this = LoadInteger(DotHash, id, 0)
                set .source = source
                set .dmg    = dmg
                set .left   = DOT_DURATION
                return
            endif

            set this = thistype.allocate()
            set .target = target
            set .source = source
            set .dmg    = dmg
            set .left   = DOT_DURATION
            set .acc    = 0.
            call SaveInteger(DotHash, id, 0, this)

            set DotActive[DotCount] = this
            set DotCount = DotCount + 1
            if DotCount == 1 then
                call TimerStart(DotTick, INTERVAL, true, function thistype.tickAll)
            endif
        endmethod

        //--------------------------------------------------------
        // returns true when the bleeding is over
        method step takes nothing returns boolean
            set .left = .left - INTERVAL
            set .acc  = .acc + INTERVAL

            if GetWidgetLife(.target) < 0.405 then
                return true
            endif

            if .acc >= DOT_INTERVAL then
                set .acc = .acc - DOT_INTERVAL

                // dispelled: the bleeding stops
                if GetUnitAbilityLevel(.target, BLOOD_TENDRIL_BUFF_ID) == 0 then
                    return true
                endif

                set udg_NextDamageAbilitySource = BLOOD_TENDRIL_ABILITY_ID
                call Damage.applyPhys(.source, .target, .dmg, false, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                call DestroyEffect(AddSpecialEffectTarget(BLOOD_MODEL, .target, "chest"))
            endif

            return .left <= 0.
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            call RemoveSavedInteger(DotHash, GetHandleId(.target), 0)
            set .target = null
            set .source = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = DotCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = DotActive[i]
                if this.step() then
                    call this.destroy()
                    set DotCount = DotCount - 1
                    set DotActive[i] = DotActive[DotCount]
                endif
                set i = i - 1
            endloop

            if DotCount == 0 then
                call PauseTimer(DotTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // One cast of the spell. It owns every tendril and chain it spawns ("slots"):
    //   kind 0 - a tendril flying out of the hero, in a straight line
    //   kind 1 - a chain flying from a unit that was just hit to its next target
    //   kind 2 - a tendril that has struck and lingers, attached, while it fades
    // Every unit can only be hit once per cast, by a tendril or a chain.
    //==================================================================
    private struct BloodCast
        unit hero
        player owner
        integer level
        real dmgHit
        real dmgTick
        real hx            // the hero's last known position
        real hy
        group hit          // units already struck by this cast
        group claimed      // units a chain is currently heading for (so two chains never go for the same one)
        integer active

        boolean array used[28]
        integer array kind[28]
        unit array src[28]
        unit array tgt[28]
        real array ox[28]
        real array oy[28]
        real array px[28]
        real array py[28]
        real array ang[28]
        real array trav[28]
        integer array left[28]
        real array lt[28]
        lightning array rope[28]
        real array ropeAge[28]
        effect array orb[28]

        //--------------------------------------------------------
        method newSlot takes nothing returns integer
            local integer i = 0

            loop
                exitwhen i >= 28
                if not .used[i] then
                    set .used[i] = true
                    set .active = .active + 1
                    set .src[i] = null
                    set .tgt[i] = null
                    set .rope[i] = null
                    set .ropeAge[i] = 0.
                    return i
                endif
                set i = i + 1
            endloop
            return -1
        endmethod

        //--------------------------------------------------------
        method freeSlot takes integer i returns nothing
            if .kind[i] == 1 and .tgt[i] != null then
                call GroupRemoveUnit(.claimed, .tgt[i])
            endif

            if .rope[i] != null then
                call DestroyLightning(.rope[i])
                set .rope[i] = null
            endif
            if .orb[i] != null then
                call BlzSetSpecialEffectScale(.orb[i], 0.001)
                call DestroyEffect(.orb[i])
                set .orb[i] = null
            endif

            set .src[i] = null
            set .tgt[i] = null
            set .used[i] = false
            set .active = .active - 1
        endmethod

        //--------------------------------------------------------
        // the glistening droplet at a tendril's tip
        method makeOrb takes integer i returns nothing
            set .orb[i] = AddSpecialEffect(ORB_MODEL, .px[i], .py[i])
            call BlzSetSpecialEffectColor(.orb[i], BLOOD_RED, BLOOD_GREEN, BLOOD_BLUE)
            call BlzSetSpecialEffectScale(.orb[i], ORB_DIAMETER / MODEL_NATIVE_WIDTH)
        endmethod

        //--------------------------------------------------------
        // The rope of lightning from (x1, y1) to (x2, y2). Rebuilt every so often so it can never die off mid-flight.
        method drawRope takes integer i, real x1, real y1, real x2, real y2, real alpha returns nothing
            local real z1 = GroundZ(x1, y1) + ROPE_HEIGHT
            local real z2 = GroundZ(x2, y2) + ROPE_HEIGHT

            set .ropeAge[i] = .ropeAge[i] + INTERVAL
            if .rope[i] != null and .ropeAge[i] >= ROPE_REFRESH_TIME then
                call DestroyLightning(.rope[i])
                set .rope[i] = null
            endif
            if .rope[i] == null then
                set .ropeAge[i] = 0.
                set .rope[i] = AddLightningEx(ROPE_LIGHTNING, false, x1, y1, z1, x2, y2, z2)
            endif

            call SetLightningColor(.rope[i], BLOOD_RED_F, BLOOD_GREEN_F, BLOOD_BLUE_F, alpha)
            call MoveLightningEx(.rope[i], false, x1, y1, z1, x2, y2, z2)
        endmethod

        //--------------------------------------------------------
        // A tendril leaving the hero, along one line of the fan
        method launchTendril takes real a returns nothing
            local integer i = .newSlot()

            if i < 0 then
                return
            endif

            set .kind[i]  = 0
            set .ang[i]   = a
            set .px[i]    = .hx
            set .py[i]    = .hy
            set .ox[i]    = .hx
            set .oy[i]    = .hy
            set .trav[i]  = 0.
            set .left[i]  = CHAINS_PER_TENDRIL
            call .makeOrb(i)
        endmethod

        //--------------------------------------------------------
        // A chain from a unit that was just struck to its next target
        method launchChain takes unit from, unit to, integer chainsLeft returns nothing
            local integer i = .newSlot()

            if i < 0 then
                return
            endif

            set .kind[i]  = 1
            set .src[i]   = from
            set .tgt[i]   = to
            set .ox[i]    = GetUnitX(from)
            set .oy[i]    = GetUnitY(from)
            set .px[i]    = .ox[i]
            set .py[i]    = .oy[i]
            set .trav[i]  = 0.
            set .left[i]  = chainsLeft
            call .makeOrb(i)

            call GroupAddUnit(.claimed, to)
        endmethod

        //--------------------------------------------------------
        // The nearest enemy to a struck unit that nothing has hit or is already heading for
        method findChainTarget takes unit from returns unit
            local unit u
            local unit best = null
            local real bestD = 0.
            local real dx
            local real dy
            local real d
            local real fx = GetUnitX(from)
            local real fy = GetUnitY(from)

            call GroupEnumUnitsInRange(Grp, fx, fy, CHAIN_RANGE + 100., null)
            loop
                set u = FirstOfGroup(Grp)
                exitwhen u == null
                call GroupRemoveUnit(Grp, u)

                if u != from and not IsUnitInGroup(u, .hit) and not IsUnitInGroup(u, .claimed) and IsValidEnemy(u, .hero, .owner) then
                    set dx = GetUnitX(u) - fx
                    set dy = GetUnitY(u) - fy
                    set d = SquareRoot(dx * dx + dy * dy)
                    if d <= CHAIN_RANGE + BlzGetUnitCollisionSize(u) and (best == null or d < bestD) then
                        set best = u
                        set bestD = d
                    endif
                endif
            endloop

            set u = null
            return best
        endmethod

        //--------------------------------------------------------
        // A tendril or chain strikes a unit: damage, the bleed, and possibly a chain on to someone else
        method strike takes unit u, integer i returns nothing
            local unit nextTarget

            call GroupAddUnit(.hit, u)
            call GroupRemoveUnit(.claimed, u)

            // the hit
            set udg_NextDamageAbilitySource = BLOOD_TENDRIL_ABILITY_ID
            call Damage.applyPhys(.hero, u, .dmgHit, false, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            call DestroyEffect(AddSpecialEffectTarget(BLOOD_MODEL, u, "chest"))

            // the bleed: the debuff goes on, and the bleeding starts
            if GetWidgetLife(u) > 0.405 then
                call ApplyDebuff(.hero, u)
                call BloodDot.apply(.hero, u, .dmgTick)
            endif

            // on to the next victim
            if .left[i] > 0 then
                set nextTarget = .findChainTarget(u)
                if nextTarget != null then
                    call .launchChain(u, nextTarget, .left[i] - 1)
                endif
                set nextTarget = null
            endif

            // this tendril now lingers, attached to what it hit, and fades
            if .kind[i] == 1 and .tgt[i] != null then
                call GroupRemoveUnit(.claimed, .tgt[i])
            endif
            set .kind[i] = 2
            set .tgt[i]  = u
            set .lt[i]   = LINGER_TIME
        endmethod

        //--------------------------------------------------------
        static method create takes unit hero, real tx, real ty, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local real x = GetUnitX(hero)
            local real y = GetUnitY(hero)
            local real base
            local real half = ARC_DEGREES * 0.5 * bj_DEGTORAD
            local real bonus
            local integer i = 0

            set .hero   = hero
            set .owner  = GetOwningPlayer(hero)
            set .level  = lvl
            set .hx     = x
            set .hy     = y
            set .active = 0
            set .hit     = CreateGroup()
            set .claimed = CreateGroup()

            // the Blood bonus: 10% of the hero's attack damage for every Blood element he has
            set bonus = BLOOD_BONUS_FRACTION * HeroAttackDamage(hero) * I2R(GetUnitElementCount(hero, Element_Blood))
            set .dmgHit  = HIT_PER_LEVEL * I2R(lvl) + bonus
            set .dmgTick = DOT_PER_LEVEL * I2R(lvl)
            if BONUS_APPLIES_TO_DOT then
                set .dmgTick = .dmgTick + bonus
            endif

            // the fan points toward the target point (or the way the hero faces if there isn't one)
            if tx == x and ty == y then
                set base = GetUnitFacing(hero) * bj_DEGTORAD
            else
                set base = Atan2(ty - y, tx - x)
            endif

            // the tendrils: evenly spaced across the arc, edge to edge
            loop
                exitwhen i >= TENDRIL_COUNT
                if TENDRIL_COUNT > 1 then
                    call .launchTendril(base - half + 2. * half * I2R(i) / I2R(TENDRIL_COUNT - 1))
                else
                    call .launchTendril(base)
                endif
                set i = i + 1
            endloop

            set CastActive[CastCount] = this
            set CastCount = CastCount + 1
            if CastCount == 1 then
                call TimerStart(CastTick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // returns true when every tendril and chain is finished
        method step takes nothing returns boolean
            local integer i = 0
            local real stp = TENDRIL_SPEED * INTERVAL
            local real dx
            local real dy
            local real d
            local real ex
            local real ey
            local real alpha
            local real sc
            local unit u
            local unit found
            local real bestD

            // keep track of the hero
            if GetWidgetLife(.hero) > 0.405 then
                set .hx = GetUnitX(.hero)
                set .hy = GetUnitY(.hero)
            endif

            loop
                exitwhen i >= 28

                if .used[i] then

                    // where this tendril comes from: the hero, or the unit a chain leapt from
                    if .src[i] != null then
                        if GetUnitTypeId(.src[i]) != 0 then
                            set .ox[i] = GetUnitX(.src[i])
                            set .oy[i] = GetUnitY(.src[i])
                        endif
                    else
                        set .ox[i] = .hx
                        set .oy[i] = .hy
                    endif

                    if .kind[i] == 0 then
                        // ---------- a tendril flying straight out of the hero ----------
                        set .px[i] = .px[i] + stp * Cos(.ang[i])
                        set .py[i] = .py[i] + stp * Sin(.ang[i])
                        set .trav[i] = .trav[i] + stp

                        // the nearest unit the tip touches that hasn't been hit yet
                        set found = null
                        set bestD = 0.
                        call GroupEnumUnitsInRange(Grp, .px[i], .py[i], HIT_RADIUS + 100., null)
                        loop
                            set u = FirstOfGroup(Grp)
                            exitwhen u == null
                            call GroupRemoveUnit(Grp, u)

                            if not IsUnitInGroup(u, .hit) and IsValidEnemy(u, .hero, .owner) then
                                set dx = GetUnitX(u) - .px[i]
                                set dy = GetUnitY(u) - .py[i]
                                set d = SquareRoot(dx * dx + dy * dy)
                                if d <= HIT_RADIUS + BlzGetUnitCollisionSize(u) and (found == null or d < bestD) then
                                    set found = u
                                    set bestD = d
                                endif
                            endif
                        endloop

                        if found != null then
                            call .strike(found, i)
                        elseif .trav[i] >= RANGE then
                            call .freeSlot(i)
                        endif
                        set found = null

                    elseif .kind[i] == 1 then
                        // ---------- a chain flying to its next target ----------
                        if .tgt[i] == null or GetWidgetLife(.tgt[i]) < 0.405 or IsUnitHidden(.tgt[i]) or IsUnitInGroup(.tgt[i], .hit) then
                            // the target died, vanished, or was struck by something else first: the chain fizzles
                            call .freeSlot(i)
                        else
                            set dx = GetUnitX(.tgt[i]) - .px[i]
                            set dy = GetUnitY(.tgt[i]) - .py[i]
                            set d = SquareRoot(dx * dx + dy * dy)

                            if d <= stp + CHAIN_HIT_DIST then
                                set .px[i] = GetUnitX(.tgt[i])
                                set .py[i] = GetUnitY(.tgt[i])
                                call .strike(.tgt[i], i)
                            else
                                set .px[i] = .px[i] + dx / d * stp
                                set .py[i] = .py[i] + dy / d * stp
                                set .trav[i] = .trav[i] + stp
                                if .trav[i] > CHAIN_RANGE * 3. then
                                    call .freeSlot(i)
                                endif
                            endif
                        endif

                    else
                        // ---------- lingering: attached to what it struck, fading ----------
                        set .lt[i] = .lt[i] - INTERVAL
                        if .lt[i] <= 0. then
                            call .freeSlot(i)
                        endif
                    endif

                    // ---------- draw whatever is still alive ----------
                    if .used[i] then
                        if .kind[i] == 2 then
                            set ex = GetUnitX(.tgt[i])
                            set ey = GetUnitY(.tgt[i])
                            set alpha = .lt[i] / LINGER_TIME
                            call BlzSetSpecialEffectScale(.orb[i], 0.001)
                        else
                            set ex = .px[i]
                            set ey = .py[i]
                            set alpha = 1.
                            set sc = (ORB_DIAMETER / MODEL_NATIVE_WIDTH) * (0.9 + 0.2 * Sin(.trav[i] * 0.05 + I2R(i)))
                            call BlzSetSpecialEffectScale(.orb[i], sc)
                            call BlzSetSpecialEffectPosition(.orb[i], ex, ey, GroundZ(ex, ey) + ROPE_HEIGHT)
                        endif

                        call .drawRope(i, .ox[i], .oy[i], ex, ey, alpha)
                    endif
                endif

                set i = i + 1
            endloop

            set u = null
            return .active <= 0
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            // (normally everything is already gone by now, but never leave anything behind)
            loop
                exitwhen i >= 28
                if .used[i] then
                    call .freeSlot(i)
                endif
                set i = i + 1
            endloop

            call DestroyGroup(.hit)
            call DestroyGroup(.claimed)
            set .hit = null
            set .claimed = null
            set .hero = null
        endmethod

        //--------------------------------------------------------
        static method tickAll takes nothing returns nothing
            local integer i = CastCount - 1
            local thistype this

            loop
                exitwhen i < 0
                set this = CastActive[i]
                if this.step() then
                    call this.destroy()
                    set CastCount = CastCount - 1
                    set CastActive[i] = CastActive[CastCount]
                endif
                set i = i - 1
            endloop

            if CastCount == 0 then
                call PauseTimer(CastTick)
            endif
        endmethod
    endstruct

    //==================================================================
    // Public entry point, called from your ability dispatcher.
    // The fan points from the hero toward (x, y), or the way he faces if (x, y) is where he stands.
    function CastBloodTendrils takes unit hero, real x, real y, integer lvl returns nothing
        if hero == null then
            return
        endif
        call BloodCast.create(hero, x, y, lvl)
    endfunction

endlibrary