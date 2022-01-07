library BattleRoar requires RuneInit
    function CastBattleRoar takes unit caster, integer abilId, integer lvl returns nothing
        local integer i = 0
        local unit p

        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 650, GetOwningPlayer(caster), false, Target_Ally)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null

            call TempBonus.create(p, BONUS_DAMAGE, GetSpellValue(abilId, 0, 50, 20, lvl), 10).addBuffLink('BNbr')
            call TempBonus.create(p, BONUS_ARMOR, GetSpellValue(abilId, 1, 5, 1, lvl), 10).addBuffLink('BNbr')

            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary