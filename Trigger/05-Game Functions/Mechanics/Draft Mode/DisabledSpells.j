library DisableSpells
    
    function DisableSpell takes integer playerNumber, integer spellId returns nothing
        call SaveIntegerBJ(LoadIntegerBJ(playerNumber, udg_Draft_PlayerSpellsMaxIndex[playerNumber], udg_Draft_PlayerSpells), playerNumber, spellId, udg_Draft_PlayerSpells)
        set udg_Draft_PlayerSpellsMaxIndex[playerNumber] = udg_Draft_PlayerSpellsMaxIndex[playerNumber] - 1
    endfunction

    function DisableEconomicSpells takes integer playerNumber returns nothing
        local integer max = EconomicSpellIndex.integer[0]
        local integer i = 1

        loop
            call DisableSpell(playerNumber, EconomicSpellIndex.integer[i])
            set i = i + 1
            exitwhen i > max
        endloop
    endfunction

endlibrary