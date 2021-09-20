library GetClass requires AbilityData, RandomShit
    function GetClassification takes unit u, integer id, boolean isSpell returns string
        local string s = ""
        local integer i = 1
        loop
            exitwhen i > 15
            if (isSpell and IsSpellElement(u, id, i)) or (isSpell == false and IsObjectElement(id, i)) then
                set s = s + ClassAbil[i]
            endif
            set i = i + 1
        endloop
        return s
    endfunction
endlibrary