library ScrollOfTransformation requires DummyOrder

    function CastScrollOfTransformation takes unit target returns nothing
        call TempAbil.create(target, 'A0CT', 6)
    endfunction
endlibrary