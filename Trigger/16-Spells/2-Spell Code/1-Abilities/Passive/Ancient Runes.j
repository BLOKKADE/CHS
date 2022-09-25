library AncientRunes requires RuneInit
    function ActivateAncientRunes takes unit caster, integer level returns nothing
        call ElemFuncStart(caster,ANCIENT_RUNES_ABILITY_ID)
        call AbilStartCD(caster, ANCIENT_RUNES_ABILITY_ID, 11)
        call CreateRandomRune(10 + 7 * level, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)
        call CreateRandomRune(10 + 7 * level, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)
        call CreateRandomRune(10 + 7 * level, GetRandomReal(- 100, 100) + GetUnitX(caster), GetRandomReal(- 100, 100) + GetUnitY(caster), caster)   
    endfunction
endlibrary