library GetSpellType
    function GetSpellType takes unit target, location spellLoc returns integer
        if target == null then
            if spellLoc == null then
                return Order_Instant
            else
                return Order_Point
            endif
        else
            return Order_Target
        endif
    endfunction
endlibrary