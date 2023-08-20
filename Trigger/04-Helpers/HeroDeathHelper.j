library HeroDeathHelper requires UnitItems

    function CanUnitReincarnate takes unit u returns boolean
        if (GetUnitItem(u, 'ankh') != null) then
            return true
        endif

        if (GetUnitAbilityLevel(u, REINCARNATION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u, REINCARNATION_ABILITY_ID) == 0) then
            return true
        endif

        return false
    endfunction
    
endlibrary