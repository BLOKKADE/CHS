library ShadowBladeItem requires HeroForm
    function ShadowBlade takes unit u returns nothing
        call UnitAddForm(u,FORM_SHADOW,5)
    endfunction
endlibrary