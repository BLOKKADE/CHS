library FixDeleteUnit
//Not sure of the exact purpose of these
    function FixUnit takes unit u returns nothing
        if IsUnitIllusion(u) then
            call FlushChildHashtable(DataUnitHT,GetHandleId(u))  
        endif

        if IsHeroUnitId(GetUnitTypeId(GetTriggerUnit())) == false then
            call FlushChildHashtable(HT,GetHandleId(GetTriggerUnit())) 
        endif
    endfunction

    function DeleteUnit takes unit u returns nothing
        call FixUnit(u)
        call RemoveUnit(u)
    endfunction
endlibrary