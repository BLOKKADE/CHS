library HeroDeathHelper requires UnitItems

    function CanUnitReincarnate takes unit u returns boolean
        call BJDebugMsg(GetUnitName(u) + " ankh status: " + B2S(GetUnitItem(u, ANKH_ITEM_ID) != null))

        if (GetUnitItem(u, ANKH_ITEM_ID) != null) then
            return true
        endif*/

        call BJDebugMsg(GetUnitName(u) + " has reinc ability: " + B2S(GetUnitAbilityLevel(u, REINCARNATION_ABILITY_ID) > 0) + " cooldown " + R2S(BlzGetUnitAbilityCooldownRemaining(u, REINCARNATION_ABILITY_ID)))

        /*if (GetUnitAbilityLevel(u, REINCARNATION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u, REINCARNATION_ABILITY_ID) == 0) then
            return true
        endif*/

        return false
    endfunction
    
endlibrary