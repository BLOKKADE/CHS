library CarrionSwarm requires TempAbilSystem, TempElementBonus
    function ActivateCarrionSwarmDarkBonus takes unit source returns nothing
        call TempAbil.create(source, 'A0DO', 8)
        call TempElementBonus.create(source, Element_Dark, 1, 8, 'A0DO')
        //unit source, integer elementId, integer bonus, real duration, integer abilSource
    endfunction
endlibrary
