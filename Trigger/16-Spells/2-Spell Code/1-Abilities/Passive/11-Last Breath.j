library LastBreath requires RandomShit, AbilityCooldownBonusPerUse
    function ActivateLastBreath takes unit u, integer level returns nothing
        local ability abil = BlzGetUnitAbility(u, LAST_BREATHS_ABILITY_ID)
        set udg_LethalDamageHP = 100
        call AbilStartCD(u, LAST_BREATHS_ABILITY_ID, 60 + GetAbilityCooldownBonus(abil))
        call SetAbilityCooldownBonus(abil, 5)
        call TempAbil.create(u, 'A08B', 0.8 + (0.2 * level))
    endfunction
endlibrary
