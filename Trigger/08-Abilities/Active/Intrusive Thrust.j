library IntrusiveThrust requires RuneInit, AbilityCooldown

    globals
        // Abomination
        constant integer IT_ABOM_ID          = 'uabo'
        constant real    IT_ABOM_DURATION    = 1.00
        constant real    IT_ABOM_OFFSET      = 90.00   

        // Slide settings
        constant real    IT_SLIDE_DISTANCE   = 600.00
        constant real    IT_SLIDE_DURATION   = 0.30
        constant real    IT_TICK_INTERVAL    = 0.03
        constant real    IT_PATH_SAMPLE      = 16.00   // how often (in units) the path is checked along each step
        constant string  IT_BLEED_EFFECT     = "Objects\\Spawnmodels\\Human\\HumanBlood\\HumanBloodLarge0.mdl"

        // Visual effects
        constant string  IT_SPAWN_POOL       = "Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl"
        constant string  IT_DESPAWN_POOF     = "Abilities\\Spells\\Undead\\AnimateDead\\AnimateDeadTarget.mdl"

        // Hashtable
        hashtable IT_Hash = null
    endglobals

    function IT_Init takes nothing returns nothing
        set IT_Hash = InitHashtable()
    endfunction

    // true if every point between (x1,y1) and (x2,y2) is walkable and inside the map
    function IT_PathClear takes real x1, real y1, real x2, real y2 returns boolean
        local real dx = x2 - x1
        local real dy = y2 - y1
        local real dist = SquareRoot(dx * dx + dy * dy)
        local integer n = R2I(dist / IT_PATH_SAMPLE) + 1
        local integer i = 1
        local real x
        local real y

        loop
            exitwhen i > n
            set x = x1 + dx * I2R(i) / I2R(n)
            set y = y1 + dy * I2R(i) / I2R(n)

            if x <= GetRectMinX(bj_mapInitialPlayableArea) or x >= GetRectMaxX(bj_mapInitialPlayableArea) /*
            */ or y <= GetRectMinY(bj_mapInitialPlayableArea) or y >= GetRectMaxY(bj_mapInitialPlayableArea) then
                return false
            endif

            // true = this spot is NOT walkable (cliff, blocker, deep water)
            if IsTerrainPathable(x, y, PATHING_TYPE_WALKABILITY) then
                return false
            endif
            set i = i + 1
        endloop
        return true
    endfunction

    function IT_SlidePeriodic takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)
        local unit target = LoadUnitHandle(IT_Hash, id, 0)
        local real angle = LoadReal(IT_Hash, id, 1)
        local real distPerTick = LoadReal(IT_Hash, id, 2)
        local integer ticksLeft = LoadInteger(IT_Hash, id, 3)
        local real ox
        local real oy
        local real x
        local real y

        if target == null or GetUnitTypeId(target) == 0 or IsUnitType(target, UNIT_TYPE_DEAD) then
            if target != null and GetUnitTypeId(target) != 0 then
                call SetUnitPathing(target, true)
            endif
            call FlushChildHashtable(IT_Hash, id)
            call DestroyTimer(t)
            set t = null
            set target = null
            return
        endif

        set ox = GetUnitX(target)
        set oy = GetUnitY(target)
        set x = ox + distPerTick * Cos(angle)
        set y = oy + distPerTick * Sin(angle)

        // cliff / blocker / map edge ahead: stop the slide right here
        if not IT_PathClear(ox, oy, x, y) then
            call SetUnitPathing(target, true)
            call FlushChildHashtable(IT_Hash, id)
            call DestroyTimer(t)
            set t = null
            set target = null
            return
        endif

        call SetUnitX(target, x)
        call SetUnitY(target, y)

        call DestroyEffect(AddSpecialEffect(IT_BLEED_EFFECT, x, y))

        set ticksLeft = ticksLeft - 1
        call SaveInteger(IT_Hash, id, 3, ticksLeft)

        if ticksLeft <= 0 then
            call SetUnitPathing(target, true)
            call FlushChildHashtable(IT_Hash, id)
            call DestroyTimer(t)
        endif

        set t = null
        set target = null
    endfunction

    function IT_RemoveAbom takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)
        local unit abom = LoadUnitHandle(IT_Hash, id, 10)
        local real x
        local real y

        if abom != null then
            set x = GetUnitX(abom)
            set y = GetUnitY(abom)
            call DestroyEffect(AddSpecialEffect(IT_DESPAWN_POOF, x, y))
            call RemoveUnit(abom)
        endif

        call FlushChildHashtable(IT_Hash, id)
        call DestroyTimer(t)
        set t = null
        set abom = null
    endfunction

    function CastIntrusiveThrust takes unit hero, unit target, integer lvl returns nothing
        local real facing
        local real maxHp
        local real damage
        local real currentHp
        local timer t
        local integer id
        local real distPerTick
        local integer totalTicks
        local integer cooldown
        local unit abom
        local real abomX
        local real abomY
        local sound s

        if target == null or GetUnitTypeId(target) == 0 or IsUnitType(target, UNIT_TYPE_DEAD) then
            return
        endif

        if IT_Hash == null then
            call IT_Init()
        endif

        // === Life loss (instant) ===
        set maxHp = GetUnitState(target, UNIT_STATE_MAX_LIFE)
        set damage = maxHp * 0.15
        set currentHp = GetWidgetLife(target)
        call SetWidgetLife(target, currentHp - damage)

        // === Spawn Abomination right behind the target, facing it ===
        set facing = GetUnitFacing(target)

        // Position slightly behind the target
        set abomX = GetUnitX(target) - IT_ABOM_OFFSET * Cos(facing * bj_DEGTORAD)
        set abomY = GetUnitY(target) - IT_ABOM_OFFSET * Sin(facing * bj_DEGTORAD)

        // Face the same direction as the target → looking at its back
        set abom = CreateUnit(GetOwningPlayer(hero), IT_ABOM_ID, abomX, abomY, facing)
        call SelectUnit(abom, false)

        // Make it pure visual
        call UnitAddAbility(abom, 'Aloc')         // locust - no collision / selection
        call SetUnitInvulnerable(abom, true)
        call PauseUnit(abom, true)
        call SetUnitPathing(abom, false)

        // Play attack animation so it looks like it's shoving the target
        call SetUnitAnimation(abom, "attack")
        call QueueUnitAnimation(abom, "attack")

        // Spawn pool effect
        call DestroyEffect(AddSpecialEffect(IT_SPAWN_POOL, abomX, abomY))

        // Play an Abomination roar / grunt
        set s = CreateSound("Units\\Undead\\Abomination\\AbominationWhat1.wav", false, false, false, 10, 10, "DefaultEAXON")
        call SetSoundPosition(s, abomX, abomY, 0)
        call StartSound(s)
        call KillSoundWhenDone(s)
        set s = null

        // Remove the Abomination after 1 second with a poof
        set t = CreateTimer()
        set id = GetHandleId(t)
        call SaveUnitHandle(IT_Hash, id, 10, abom)
        call TimerStart(t, IT_ABOM_DURATION, false, function IT_RemoveAbom)
        set t = null
        set abom = null

        // === Start the slide ===
        set facing = facing * bj_DEGTORAD
        set totalTicks = R2I(IT_SLIDE_DURATION / IT_TICK_INTERVAL + 0.5)
        set distPerTick = IT_SLIDE_DISTANCE / I2R(totalTicks)

        call SetUnitPathing(target, false)

        set t = CreateTimer()
        set id = GetHandleId(t)

        call SaveUnitHandle(IT_Hash, id, 0, target)
        call SaveReal(IT_Hash, id, 1, facing)
        call SaveReal(IT_Hash, id, 2, distPerTick)
        call SaveInteger(IT_Hash, id, 3, totalTicks)

        call TimerStart(t, IT_TICK_INTERVAL, true, function IT_SlidePeriodic)

        // Cooldown
        set cooldown = 20 - R2I((I2R(lvl - 1) * 10.0 / 29.0) + 0.5)
        if cooldown < 10 then
            set cooldown = 10
        elseif cooldown > 20 then
            set cooldown = 20
        endif
        call AbilStartCD(hero, INTRUSIVE_THRUST_ABILITY_ID, cooldown)

        set t = null
    endfunction
   
endlibrary