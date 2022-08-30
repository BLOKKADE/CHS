library ArcaneStrike requires RandomShit, AbsoluteElements, AoeDamage

    //I don't know what I'm doing. Requirements may or may not be needed, just copied stuff from Arcane Element lmao. I need an adult.

    function UseArcaneStrike takes unit caster, integer level returns nothing
        call AbilStartCD(caster, ARCANE_STRIKE_ABILITY_ID, (10 * GetUnitElementCount(DamageSource, Element_Arcane) ))
    endfunction
endlibrary