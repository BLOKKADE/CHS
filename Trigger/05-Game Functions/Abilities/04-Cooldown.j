library Cooldown requires AbilityCooldown, DummySpell
    function SetCooldown takes unit u, integer abilId, boolean startCooldown returns nothing 
        local integer lvl = GetUnitAbilityLevel(u, abilId) - 1
        local real currentCooldown = BlzGetAbilityCooldown(abilId,lvl)
        local real cd = CalculateCooldown(u, abilId, currentCooldown, true)
        local boolean dummyAbil = HasDummySpell(u, abilId)
        
        //when unit has cooldown reduction, and cooldown has already started
        if cd != currentCooldown then
            call BlzSetUnitAbilityCooldown(u, abilId, lvl, cd) 

            if dummyAbil then
                call BlzSetUnitAbilityCooldown(u, GetDummySpell(u, abilId), 0, cd)
            endif
        endif

        if startCooldown then
            call BlzStartUnitAbilityCooldown(u, abilId, cd)

            if dummyAbil then
                call BlzStartUnitAbilityCooldown(u, GetDummySpell(u, abilId), cd)
            endif
        endif

    endfunction
endlibrary