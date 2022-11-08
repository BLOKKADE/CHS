library MysteriousRuneStone requires RuneInit
    function CastMysteriousRunestone takes unit caster returns nothing
        call CreateRandomRune(0, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)
        call CreateRandomRune(0, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)
        call CreateRandomRune(0, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)
    endfunction
endlibrary