library ResetTime requires RandomShit
    function ResetTime takes unit u returns nothing
        local integer abilId = 0
        local integer i = 0
        loop
            set abilId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(u, i))
            exitwhen abilId == 0

            if BlzGetUnitAbilityCooldownRemaining(u, abilId) != 0 and IsSpellResettable(abilId) and IsSpellResettable(GetAssociatedSpell(u, abilId)) then
                call BlzEndUnitAbilityCooldown(u, abilId)
            endif

            set i = i + 1
        endloop
    endfunction
endlibrary
