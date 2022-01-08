library Parasite requires PeriodicDamage
    function CastParasite takes unit caster, unit target, integer lvl returns nothing
        call PeriodicDamage.create(caster, target, 30 * lvl, true, 1., 30, 0, false, PARASITE_BUFF_ID, PARASITE_ABILITY_ID)
    endfunction
endlibrary