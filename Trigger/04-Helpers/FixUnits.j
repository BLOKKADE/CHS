library FixDeleteUnit requires DummyOrder
//Not sure of the exact purpose of these
    function FixUnit takes unit u returns nothing
        if IsUnitIllusion(u) then
            call FlushChildHashtable(DataUnitHT,GetHandleId(u))  
        endif

        if IsHeroUnitId(GetUnitTypeId(u)) == false then
            call FlushChildHashtable(HT,GetHandleId(u)) 
        endif

        if GetUnitTypeId(u) == PRIEST_1_UNIT_ID then
            set GetDummyOrder(GetDummyId(u)).stopDummy = true
        endif
    endfunction

    function DeleteUnit takes unit u returns nothing
        call FixUnit(u)
        call RemoveUnit(u)
    endfunction
endlibrary