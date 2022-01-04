library Whirlwind requires Utility, AoeDamage

    function CastWhirlwind takes unit caster, real x, real y, integer lvl returns nothing
        call AreaDamage(caster, x, y, RMaxBJ(GetUnitDamage(caster, 0), 50 * lvl), 500, false, 'A025')
    endfunction
endlibrary