library ArcaneStrike requires Cooldown, GetObjectElement
    function UseArcaneStrike takes unit caster, integer level returns nothing
        call AbilStartCD(caster, ARCANE_STRIKE_ABILITY_ID, (10 * GetUnitElementCount(DamageSource, Element_Arcane) ))
    endfunction
endlibrary