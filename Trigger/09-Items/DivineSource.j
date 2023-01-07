library DivineSource requires RemoveBuffs
    function UseDivineSource takes unit caster returns nothing
        call RemoveUnitBuffs(caster, BUFFTYPE_BOTH, false)
    endfunction
endlibrary
