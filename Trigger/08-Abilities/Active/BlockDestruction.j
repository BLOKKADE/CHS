library BlockDestruction requires TempStateBonus, TempAbilSystem

    function CastDestrOfBlock takes unit caster, unit target, integer lvl returns nothing
        call TempAbil.create(target, DESTR_OF_BLOCK_BUFF_ID, 10)
        call TempBonus.create(target, BONUS_BLOCK, 0 - (GetUnitCustomState(target, BONUS_BLOCK) * 0.3), 10, DESTRUCTION_ABILITY_ID).addBuffLink(DESTR_OF_BLOCK_BUFF_ID).activate()
    endfunction
endlibrary