library ArcaneStrike requires Cooldown, GetObjectElement
    function UseArcaneStrike takes unit caster returns nothing
        call AbilStartCD(caster, ARCANE_STRIKE_ABILITY_ID, (15 * GetUnitElementCount(caster, Element_Arcane) ))
    endfunction
endlibrary