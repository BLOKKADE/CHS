library ShadowBootsItem requires ShadowBootsHeroForm
    function ShadowBoots takes unit u returns nothing
        call UnitAddShadowBootsForm(u,FORM_SHADOWBOOTS,6)
    endfunction
endlibrary