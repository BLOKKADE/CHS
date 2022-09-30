library BattleRoar requires RuneInit
    function CastBattleRoar takes unit caster, integer abilId, integer lvl returns nothing
        local integer i = 0
        local unit p

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 650, GetOwningPlayer(caster), false, Target_Ally)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            call UniqueTempBonus(p, BONUS_DAMAGE, GetSpellValue(50, 20, lvl) * (1 + I2R(GetHeroLevel(caster))/100), 10, BATTLE_ROAR_ABILITY_ID, BATTLE_ROAR_BUFF_ID)
            call UniqueTempBonus(p, BONUS_ARMOR, GetSpellValue(5, 1, lvl)* (1 + I2R(GetHeroLevel(caster))/100), 10, BATTLE_ROAR_ABILITY_ID, BATTLE_ROAR_BUFF_ID)

            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary