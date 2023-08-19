library Locust requires EditAbilityInfo
    function LocustStats takes unit u, integer totalLevel returns nothing
        call UnitAddAbility(u, 'A0EL')
        call SetAbilityRealField(u, 'AOEL', 1, ABILITY_RLF_INITIAL_DAMAGE_PXF1, (totalLevel * 60))
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A0EL', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(u), 'A0EL', true)
    endfunction
endlibrary