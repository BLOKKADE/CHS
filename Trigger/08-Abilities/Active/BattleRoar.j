library BattleRoar requires RuneInit
    function CastBattleRoar takes unit target, integer abilId, integer lvl returns nothing
        local integer i = 0
        local unit p

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(target), GetUnitY(target), 650, GetOwningPlayer(target), false, Target_Ally)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            call UniqueTempBonus(p, BONUS_DAMAGE, GetSpellValue(50, 20, lvl) * (1 + I2R(GetHeroLevel(target))/100), 10, BATTLE_ROAR_ABILITY_ID, BATTLE_ROAR_BUFF_ID)
            call UniqueTempBonus(p, BONUS_ARMOR, GetSpellValue(5, 1, lvl)* (1 + I2R(GetHeroLevel(target))/100), 10, BATTLE_ROAR_ABILITY_ID, BATTLE_ROAR_BUFF_ID)

            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary