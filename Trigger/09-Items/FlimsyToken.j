library FlimsyToken requires TempAbilSystem, TempAttackCd
    function FlimsyToken takes unit source, unit target returns nothing
        call TempAbil.create(target, 'A09B', 5)
        if not IsUnitType(target, UNIT_TYPE_HERO) then
            call AttackCdStruct.createUnique(target, 0.4, 5, FLIMSY_TOKEN_BUFF_ID)
        endif
    endfunction
endlibrary