library AegisWard

    globals

        // Hit points: the ward's hit points are literally how many hits it can take
        private constant integer WARD_BASE_HP        = 10
        private constant integer WARD_HP_PER_LEVEL   = 1
        private constant real    WARD_LIFETIME       = 45.     // seconds the ward lasts. 0 = until its hit points run out

        // Protection
        private constant real    PROTECT_RANGE       = 2500.   // a ward only soaks hits for friendly units this close (match your aura's range)
        private constant real    PROTECT_HP_FRACTION = 0.1     // a hit bigger than this share of a unit's MAX hp is cut down to it
        private constant real    HP_COST_PER_SAVE    = 1.      // hit points the ward loses each time it saves someone

        // Casting up a cliff: the ward can't be put on higher ground than the hero is standing on.
        // If you try, it appears in front of the cliff instead.
        private constant boolean BLOCK_ANY_LEVEL_CHANGE = false // false = only casting UP a cliff is blocked. true = casting down one is blocked too
        private constant real    CLIFF_SEARCH_STEP  = 32.      // how finely it looks for the foot of the cliff
        private constant real    CLIFF_MARGIN       = 80.      // how far in front of the cliff the ward is placed

        private constant boolean DEBUG_MODE          = false    // prints why a hit was or wasn't reduced. Turn off when done

        // Look. A golden shield-ward: a gold-tinted ward model inside a golden bubble, with four gold orbs circling it.
        private constant integer WARD_SKIN_ID        = 'ohwd'  // the dummy takes on this unit type's model (Healing Ward). Swap it for any model you like
        private constant real    WARD_SCALE          = 1.4
        private constant integer WARD_RED            = 255
        private constant integer WARD_GREEN          = 215
        private constant integer WARD_BLUE           = 110
        private constant string  SHIELD_MODEL        = "Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl"
        private constant real    SHIELD_SCALE        = 1.2
        private constant string  ORB_MODEL           = "Abilities\\Weapons\\WaterElementalMissile\\WaterElementalMissile.mdl"
        private constant real    MODEL_NATIVE_WIDTH  = 50.     // rough width of the orb model at scale 1. Tune if the orbs look off
        private constant real    ORB_DIAMETER        = 30.
        private constant real    ORB_RADIUS          = 90.
        private constant real    ORB_HEIGHT          = 100.
        private constant real    ORB_SPIN            = 1.8     // radians per second
        private constant string  SPAWN_MODEL         = "Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl"   // when the ward appears
        private constant string  BREAK_MODEL         = "Abilities\\Spells\\Human\\ThunderClap\\ThunderClapCaster.mdl" // when the ward shatters
        private constant string  SAVE_MODEL          = "Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl" // flash on a unit the ward just saved
        private constant string  LINK_LIGHTNING      = "CLPB"  // a bolt from the ward to the unit it just saved
        private constant real    LINK_TIME           = 0.25
        private constant integer GOLD_RED            = 255
        private constant integer GOLD_GREEN          = 215
        private constant integer GOLD_BLUE           = 90
        private constant real    GOLD_RED_F          = 1.00    // the same gold, as 0-1 values for lightning
        private constant real    GOLD_GREEN_F        = 0.84
        private constant real    GOLD_BLUE_F         = 0.35
        private constant string  WARD_NAME           = "Aegis Ward"
        private constant real    INTERVAL            = 0.03125
        // ====================================================

        private integer array Active
        private integer       Count = 0
        private timer         Tick  = CreateTimer()
        private location     ZLoc  = Location(0., 0.)
        private hashtable     LinkHash = InitHashtable()
    endglobals

    //==================================================================
    private function GroundZ takes real x, real y returns real
        call MoveLocation(ZLoc, x, y)
        return GetLocationZ(ZLoc)
    endfunction

    private function BoolStr takes boolean b returns string
        if b then
            return "yes"
        endif
        return "no"
    endfunction

    private function Dbg takes string s returns nothing
        if DEBUG_MODE then
            call BJDebugMsg("|cff66ccffAegis:|r " + s)
        endif
    endfunction

    // A one-shot gold-tinted effect at a spot
    private function GoldFlash takes string model, real x, real y returns nothing
        local effect e

        if model != "" then
            set e = AddSpecialEffect(model, x, y)
            call BlzSetSpecialEffectColor(e, GOLD_RED, GOLD_GREEN, GOLD_BLUE)
            call DestroyEffect(e)
            set e = null
        endif
    endfunction

    // The bolt from the ward to a unit it saved goes away after a moment
    private function LinkEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)

        call DestroyLightning(LoadLightningHandle(LinkHash, id, 0))
        call FlushChildHashtable(LinkHash, id)
        call DestroyTimer(t)
        set t = null
    endfunction

    private function ShowSave takes unit ward, unit target returns nothing
        local real x1 = GetUnitX(ward)
        local real y1 = GetUnitY(ward)
        local real x2 = GetUnitX(target)
        local real y2 = GetUnitY(target)
        local lightning l = AddLightningEx(LINK_LIGHTNING, false, x1, y1, GroundZ(x1, y1) + ORB_HEIGHT, x2, y2, GroundZ(x2, y2) + 70.)
        local timer t = CreateTimer()

        call SetLightningColor(l, GOLD_RED_F, GOLD_GREEN_F, GOLD_BLUE_F, 1.)
        call SaveLightningHandle(LinkHash, GetHandleId(t), 0, l)
        call TimerStart(t, LINK_TIME, false, function LinkEnd)

        if SAVE_MODEL != "" then
            call DestroyEffect(AddSpecialEffectTarget(SAVE_MODEL, target, "origin"))
        endif

        set l = null
        set t = null
    endfunction

    //==================================================================
    // One ward. Its hit points ARE its life: every hit that lands on it, and every
    // big hit it soaks up for a friend, takes exactly one hit point away.
    //==================================================================
    private struct AegisWardInstance
        unit ward
        effect shield
        effect array orb[4]
        real t

        //--------------------------------------------------------
        static method create takes unit hero, real x, real y, integer lvl returns thistype
            local thistype this = thistype.allocate()
            local integer hp = WARD_BASE_HP + WARD_HP_PER_LEVEL * lvl
            local integer i = 0

            set .t = 0.
            set .ward = CreateUnit(GetOwningPlayer(hero), AEGIS_WARD_UNIT_ID, x, y, 270.)
            
            call BlzSetUnitName(.ward, WARD_NAME)

            // hit points
            call BlzSetUnitMaxHP(.ward, hp)
            call SetWidgetLife(.ward, I2R(hp))
            call BlzSetUnitRealField(.ward, UNIT_RF_HIT_POINTS_REGENERATION_RATE, 0.)
            call BlzSetUnitArmor(.ward, 0.)

            // magic immune, and it stays where it's put
            call UnitAddAbility(.ward, 'Amim')
            call SetUnitMoveSpeed(.ward, 0.)

            // the aura that gives friendly units within range the Aegis Ward buff
            call UnitAddAbility(.ward, AEGIS_WARD_AURA_ABILITY_ID)

            // the look: the dummy becomes a gold-tinted ward inside a golden bubble
            call BlzSetUnitSkin(.ward, WARD_SKIN_ID)
            call SetUnitScale(.ward, WARD_SCALE, WARD_SCALE, WARD_SCALE)
            call SetUnitVertexColor(.ward, WARD_RED, WARD_GREEN, WARD_BLUE, 255)

            set .shield = AddSpecialEffectTarget(SHIELD_MODEL, .ward, "origin")
            call BlzSetSpecialEffectScale(.shield, SHIELD_SCALE)

            loop
                exitwhen i >= 4
                set .orb[i] = AddSpecialEffect(ORB_MODEL, x, y)
                call BlzSetSpecialEffectColor(.orb[i], GOLD_RED, GOLD_GREEN, GOLD_BLUE)
                call BlzSetSpecialEffectScale(.orb[i], ORB_DIAMETER / MODEL_NATIVE_WIDTH)
                set i = i + 1
            endloop

            call GoldFlash(SPAWN_MODEL, x, y)

            set Active[Count] = this
            set Count = Count + 1
            if Count == 1 then
                call TimerStart(Tick, INTERVAL, true, function thistype.tickAll)
            endif
            return this
        endmethod

        //--------------------------------------------------------
        // returns true when the ward is gone
        method step takes nothing returns boolean
            local real wx
            local real wy
            local real a
            local real x
            local real y
            local integer i = 0

            // removed from the game by something else
            if GetUnitTypeId(.ward) == 0 then
                return true
            endif

            set wx = GetUnitX(.ward)
            set wy = GetUnitY(.ward)

            // out of hit points (or out of time): it shatters
            if GetWidgetLife(.ward) < 0.405 then
                call GoldFlash(BREAK_MODEL, wx, wy)
                call RemoveUnit(.ward)
                return true
            endif

            set .t = .t + INTERVAL
            if WARD_LIFETIME > 0. and .t >= WARD_LIFETIME then
                call KillUnit(.ward)       // it shatters on the next tick
            endif

            // the four orbs circling it
            loop
                exitwhen i >= 4
                set a = ORB_SPIN * .t + I2R(i) * bj_PI * 0.5
                set x = wx + ORB_RADIUS * Cos(a)
                set y = wy + ORB_RADIUS * Sin(a)
                call BlzSetSpecialEffectPosition(.orb[i], x, y, GroundZ(x, y) + ORB_HEIGHT + 15. * Sin(.t * 3. + I2R(i)))
                set i = i + 1
            endloop

            return false
        endmethod

        //--------------------------------------------------------
        method onDestroy takes nothing returns nothing
            local integer i = 0

            loop
                exitwhen i >= 4
                if .orb[i] != null then
                    call BlzSetSpecialEffectScale(.orb[i], 0.001)
                    call DestroyEffect(.orb[i])
                    set .orb[i] = null
                endif
                set i = i + 1
            endloop

            if .shield != null then
                call DestroyEffect(.shield)
                set .shield = null
            endif

            set .ward = null
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
    // Called from your damage page, ONLY for a unit that already carries the Aegis Ward buff.
    // Give it the unit about to take a hit and the size of the hit; it returns what the damage should now be.
    //   - if the hit is bigger than 10% of the unit's max hp, AND a friendly ward really is within range
    //     (the buff can linger a moment after a unit steps out of range, so the distance is checked properly),
    //     the hit is cut down to 10% of its max hp and the nearest such ward loses 1 hit point
    //   - otherwise the damage is returned untouched
    function AegisWardAbsorb takes unit target, real dmg returns real
        local real cap
        local integer i = 0
        local integer best = -1
        local real bestD = 0.
        local real dx
        local real dy
        local real d
        local real life
        local unit ward
        local AegisWardInstance w

        call Dbg("called for " + GetUnitName(target) + ", hit " + R2S(dmg) + ", wards registered: " + I2S(Count))

        if Count == 0 or GetUnitTypeId(target) == AEGIS_WARD_UNIT_ID then
            call Dbg("-> exit: no wards registered, or the target is a ward")
            return dmg
        endif

        set cap = BlzGetUnitMaxHP(target) * PROTECT_HP_FRACTION
        call Dbg("cap is " + R2S(cap) + " (max hp " + I2S(BlzGetUnitMaxHP(target)) + ")")
        if dmg <= cap then
            call Dbg("-> exit: the hit is not above the cap, so nothing to reduce")
            return dmg
        endif

        // find the nearest friendly ward in range
        loop
            exitwhen i >= Count
            set w = Active[i]
            set ward = w.ward

            set dx = GetUnitX(ward) - GetUnitX(target)
            set dy = GetUnitY(ward) - GetUnitY(target)
            set d = dx * dx + dy * dy
            call Dbg("ward " + I2S(i) + ": alive=" + BoolStr(GetWidgetLife(ward) > 0.405) + " ally=" + BoolStr(IsUnitAlly(target, GetOwningPlayer(ward))) + " distance=" + R2S(SquareRoot(d)))

            if GetWidgetLife(ward) > 0.405 and IsUnitAlly(target, GetOwningPlayer(ward)) then
                if d <= PROTECT_RANGE * PROTECT_RANGE and (best < 0 or d < bestD) then
                    set best = i
                    set bestD = d
                endif
            endif
            set i = i + 1
        endloop

        if best < 0 then
            call Dbg("-> exit: no living friendly ward within range")
            set ward = null
            return dmg
        endif

        // that ward takes the hit for its friend: it loses a hit point
        set w = Active[best]
        set ward = w.ward
        call ShowSave(ward, target)

        set life = GetWidgetLife(ward) - HP_COST_PER_SAVE
        if life < 0.406 then
            call KillUnit(ward)
        else
            call SetWidgetLife(ward, life)
        endif

        call Dbg("-> SAVED: hit cut from " + R2S(dmg) + " to " + R2S(cap) + ", ward life now " + R2S(life))

        set ward = null
        return cap
    endfunction

    globals
        private timer   DbgClock   = CreateTimer()
        private boolean DbgClockOn = false
        private real    DbgLast    = -10.
    endglobals

    //==================================================================
    // Public entry point, called from your ability dispatcher.
    //
    // The ward can't be cast up a cliff. If the target point is on higher ground than the hero is standing on,
    // the ward goes to the foot of that cliff instead (on the hero's side, a little way in front of it).
    function CastAegisWard takes unit hero, real x, real y, integer lvl returns nothing
        local real hx
        local real hy
        local integer heroLvl
        local integer targetLvl
        local real dx
        local real dy
        local real dist
        local real walked
        local real px
        local real py
        local real mx
        local real my
        local boolean found

        if hero == null then
            return
        endif

        set hx = GetUnitX(hero)
        set hy = GetUnitY(hero)
        set heroLvl = GetTerrainCliffLevel(hx, hy)
        set targetLvl = GetTerrainCliffLevel(x, y)

        if targetLvl > heroLvl or (BLOCK_ANY_LEVEL_CHANGE and targetLvl != heroLvl) then
            // the target is up a cliff: walk back from it toward the hero until we are on the hero's own level of ground again
            set dx = hx - x
            set dy = hy - y
            set dist = SquareRoot(dx * dx + dy * dy)
            set found = false
            set walked = 0.
            set px = hx
            set py = hy

            if dist > 1. then
                loop
                    exitwhen walked >= dist or found

                    set walked = walked + CLIFF_SEARCH_STEP
                    if walked > dist then
                        set walked = dist
                    endif

                    set px = x + dx / dist * walked
                    set py = y + dy / dist * walked
                    if GetTerrainCliffLevel(px, py) == heroLvl then
                        set found = true
                    endif
                endloop
            endif

            if found then
                // a little further back from the cliff, so the ward isn't sitting right on its edge (if that spot is still the hero's ground)
                set walked = walked + CLIFF_MARGIN
                if walked > dist then
                    set walked = dist
                endif
                set mx = x + dx / dist * walked
                set my = y + dy / dist * walked
                if GetTerrainCliffLevel(mx, my) == heroLvl then
                    set px = mx
                    set py = my
                endif

                set x = px
                set y = py
            else
                // couldn't tell where the cliff is: the ward goes where the hero stands
                set x = hx
                set y = hy
            endif
        endif

        call AegisWardInstance.create(hero, x, y, lvl)
    endfunction

endlibrary