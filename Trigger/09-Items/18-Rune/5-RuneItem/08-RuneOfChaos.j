library ChaosRune initializer init requires ChaosMagic
    globals
        boolexpr RuneOfChaos_b
        Table RuneOfChaosMagicPower
        integer GLOB_LVL_abil = 0
        integer unitsHit
    endglobals


    function CastRuneOfChaos takes unit u returns boolean
        
        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(u)) and GetWidgetLife(u) > 0.405 then
            set RandomSpellLoc = Location(GetUnitX(u), GetUnitY(u))
            call CastRandomSpell(GLOB_RUNE_U, 0, u, RandomSpellLoc, false, GLOB_LVL_abil)
            call RemoveLocation(RandomSpellLoc)
            set RandomSpellLoc = null
        endif
            
        call GroupRemoveUnit(ENUM_GROUP, u)
        return false
    endfunction

    function RuneOfChaos takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        local integer lvl = 10 + R2I((power - 1)* 10)
        local integer lp = 0
        local integer pid = GetPlayerId(GetOwningPlayer(u))

        if lvl > 30 then
            set lp = (lvl - 30) / 2
            set RuneOfChaosMagicPower.real[pid] = lp * 10
            set lvl = 30
        endif

        set GLOB_LVL_abil = lvl
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 400 + 75 * power, GetOwningPlayer(u), false, Target_Any)
        call CastRuneOfChaos(BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP))))
        call CastRuneOfChaos(BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP))))
        call CastRuneOfChaos(BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP))))

        set RuneOfChaosMagicPower.real[pid] = 0

        set u = null
        return false
    endfunction

    private function init takes nothing returns nothing
        set RuneOfChaosMagicPower = Table.create()
    endfunction
endlibrary