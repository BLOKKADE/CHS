library DivineSource requires RemoveBuffs
    function UseDivineSource takes unit caster returns nothing
        call RemoveUnitBuffs(caster, BUFFTYPE_NEGATIVE, false)
    endfunction
endlibrary
