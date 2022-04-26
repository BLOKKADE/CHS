library ScrollOfTransformation requires DummyOrder

    function CastScrollOfTransformation takes unit caster returns nothing
        call TempAbil.create(caster, 'A0CT', 6)
    endfunction
endlibrary