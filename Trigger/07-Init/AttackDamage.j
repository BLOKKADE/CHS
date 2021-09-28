library AttackDamage requires EditAbilityInfo
    function GetUnitAttackDamageAbility takes unit u returns ability
        if GetUnitAbilityLevel(u, 'A0A8') == 0 then
            call UnitAddAbility(u, 'A0A8')
        endif

        return BlzGetUnitAbility(u, 'A0A8')
    endfunction

    function UnitGetAttackDamage takes unit u returns integer
        return BlzGetAbilityIntegerLevelField(GetUnitAttackDamageAbility(u), ABILITY_ILF_ATTACK_BONUS, 0)
    endfunction

    function UnitSetAttackDamage takes unit u, integer bonus returns nothing
        call SetAbilityIntegerField(u, 'A0A8', 1, ABILITY_ILF_ATTACK_BONUS, bonus)
    endfunction
    
    function UnitAddAttackDamage takes unit u, integer bonus returns nothing
        call SetAbilityIntegerField(u, 'A0A8', 1, ABILITY_ILF_ATTACK_BONUS, UnitGetAttackDamage(u) + bonus)
    endfunction
endlibrary