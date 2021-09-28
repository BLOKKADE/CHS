library GetClass requires AbilityData, RandomShit
    function GetClassification takes unit u, integer id, boolean isSpell returns string
        local string s = ""
        local integer i = 1
        local integer count = 0
        loop
            if isSpell then
                set count = GetSpellElementCount(u, id, i)
            else
                set count = GetObjectElementCount(id, i)
            endif
            
            if count > 1 then
                set s = s  + ClassAbil[i] + "x" + I2S(count)
            elseif count == 1 then
                set s = s  + ClassAbil[i]
            endif
            set i = i + 1
            exitwhen i > 15
        endloop
        return s
    endfunction
endlibrary