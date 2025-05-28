library SwordOfBloodthirst requires TempStateBonus, CustomState
    function ActivateSwordOfBloodthirst takes unit target returns nothing
        call TempAbil.create(target, SWORD_OF_BLOODTHRIST_BUFF_ABIL_ID, 60)
        call TempBonus.create(target, BONUS_BLOCK, -30, 60, SWORD_OF_BLOODTHRIST_BUFF_ABIL_ID).addBuffLink(SWORD_OF_BLOODTHRIST_BUFF_ABIL_ID).activate()
    endfunction
endlibrary