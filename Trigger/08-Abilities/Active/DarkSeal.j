library DarkSeal requires TempStateBonus, TempAbilSystem

    function CastDarkSeal takes unit target, integer lvl returns nothing
        local real reduction = 0.1 + (0.01 * lvl)
        call TempAbil.create(target, DARK_SEAL_BUFF_ID, 10)
        call TempBonus.create(target, BONUS_STRENGTH, 0 - (GetHeroStr(target, true) * reduction), 10, DARK_SEAL_ABILITY_ID).addBuffLink(DARK_SEAL_BUFF_ID).activate()
        call TempBonus.create(target, BONUS_AGILITY, 0 - (GetHeroAgi(target, true) * reduction), 10, DARK_SEAL_ABILITY_ID).addBuffLink(DARK_SEAL_BUFF_ID).activate()
        call TempBonus.create(target, BONUS_INTELLIGENCE, 0 - (GetHeroInt(target, true) * reduction), 10, DARK_SEAL_ABILITY_ID).addBuffLink(DARK_SEAL_BUFF_ID).activate()
    endfunction
endlibrary