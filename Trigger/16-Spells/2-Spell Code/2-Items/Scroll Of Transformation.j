library ScrollOfTransformation requires DummyOrder

    function CastScrollOfTransformation takes unit caster returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 1)
        call dummy.addActiveAbility('A0B8', 1, 852486)
        call dummy.target(caster)
        call dummy.activate() 
    endfunction
endlibrary