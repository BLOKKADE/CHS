library MysteriousRuneStone requires RuneInit
    function CastMysteriousRunestone takes unit caster returns nothing
        call UnitAddItem(caster, CreateRandomRune(0, GetUnitX(caster), GetUnitY(caster), caster))
        call UnitAddItem(caster, CreateRandomRune(0, GetUnitX(caster), GetUnitY(caster), caster))   
        call UnitAddItem(caster, CreateRandomRune(0, GetUnitX(caster), GetUnitY(caster), caster))    
    endfunction
endlibrary