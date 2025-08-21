library StormHorn initializer init requires RandomShit, AbilityData, CastSpellOnTarget 

    globals 
        integer array StormHornS 
        integer CountStormHornS 
    endglobals

        // Custom function to check if a unit is an enemy
    private function IsEnemyUnit takes unit u, unit caster returns boolean
        return IsUnitEnemy(u, GetOwningPlayer(caster)) and IsUnitAliveBJ(u) and GetUnitState(u, UNIT_STATE_LIFE) > 0.405
    endfunction

    // Custom function to get the nearest unit in range
    private function GetNearestUnitInRange takes unit caster, real range returns unit
        local group g = CreateGroup()
        local unit nearest = null
        local real dist
        local real minDist = range + 1.0
        local real casterX = GetUnitX(caster)
        local real casterY = GetUnitY(caster)
        local unit u

        call GroupEnumUnitsInRange(g, casterX, casterY, range, null)
        loop
            set u = FirstOfGroup(g)
            exitwhen u == null
            call GroupRemoveUnit(g, u)
            if IsEnemyUnit(u, caster) then
                set dist = SquareRoot((GetUnitX(u) - casterX) * (GetUnitX(u) - casterX) + (GetUnitY(u) - casterY) * (GetUnitY(u) - casterY))
                if dist < minDist then
                    set minDist = dist
                    set nearest = u
                endif
            endif
        endloop

        call DestroyGroup(g)
        set g = null
        return nearest
    endfunction

    private function init takes nothing returns nothing
        set StormHornS[0] = SUMMON_HAWK_ABILITY_ID
        set StormHornS[1] = CHAIN_LIGHTNING_ABILITY_ID
        set StormHornS[2] = FORKED_LIGHTNING_ABILITY_ID
        set StormHornS[3] = FAN_OF_KNIVES_ABILITY_ID
        set StormHornS[4] = LIGHTNING_SHIELD_ABILITY_ID
        set StormHornS[5] = CYCLONE_ABILITY_ID
        set StormHornS[6] = WHIRLWIND_ABILITY_ID
        set StormHornS[7] = THUNDER_CLAP_ABILITY_ID
        set StormHornS[8] = STORM_BOLT_ABILITY_ID

        set CountStormHornS = 8
    endfunction

    function UseSpellsStormHorn takes unit caster returns nothing
        local integer i = 0
        local integer learnedCount = 0
        local integer array learnedSpells
        local integer randomIndex
        local unit target = null
        local real targetX
        local real targetY
        
        loop
            if GetHeroPositionOfSpell(caster, StormHornS[i]) != 0 then
                set learnedSpells[learnedCount] = i
                set learnedCount = learnedCount + 1
            endif
            set i = i + 1
            exitwhen i > CountStormHornS
        endloop
        
        if learnedCount > 0 then
            set randomIndex = GetRandomInt(0, learnedCount - 1)
            if learnedSpells[randomIndex] == 1 or learnedSpells[randomIndex] == 2 or learnedSpells[randomIndex] == 5 or learnedSpells[randomIndex] == 8 then
                set target = GetNearestUnitInRange(caster, 600.0)
                if target != null then
                    set targetX = GetUnitX(target)
                    set targetY = GetUnitY(target)
                else
                    set targetX = GetUnitX(caster)
                    set targetY = GetUnitY(caster)
                endif
                call CastSpell(caster, target, StormHornS[learnedSpells[randomIndex]], GetUnitAbilityLevel(caster, StormHornS[learnedSpells[randomIndex]]), GetAbilityOrderType(StormHornS[learnedSpells[randomIndex]]), targetX, targetY).activate()
            else
                call CastSpell(caster, caster, StormHornS[learnedSpells[randomIndex]], GetUnitAbilityLevel(caster, StormHornS[learnedSpells[randomIndex]]), GetAbilityOrderType(StormHornS[learnedSpells[randomIndex]]), GetUnitX(caster), GetUnitY(caster)).activate()
            endif
            set target = null
        endif
    endfunction

endlibrary