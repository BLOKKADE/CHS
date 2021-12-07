library AttackDamage requires EditAbilityInfo
    function GetUnitAttackDamageAbility takes unit u returns ability
        if GetUnitAbilityLevel(u, DAMAGE_BONUS_ABILITY_ID) == 0 then
            call UnitAddAbility(u, DAMAGE_BONUS_ABILITY_ID)
        endif

        return BlzGetUnitAbility(u, DAMAGE_BONUS_ABILITY_ID)
    endfunction

    function UnitGetAttackDamage takes unit u returns integer
        return BlzGetAbilityIntegerLevelField(GetUnitAttackDamageAbility(u), ABILITY_ILF_ATTACK_BONUS, 0)
    endfunction

    function UnitSetAttackDamage takes unit u, integer bonus returns nothing
        call SetAbilityIntegerField(u, DAMAGE_BONUS_ABILITY_ID, 1, ABILITY_ILF_ATTACK_BONUS, bonus)
    endfunction
    
    function UnitAddAttackDamage takes unit u, integer bonus returns nothing
        call SetAbilityIntegerField(u, DAMAGE_BONUS_ABILITY_ID, 1, ABILITY_ILF_ATTACK_BONUS, UnitGetAttackDamage(u) + bonus)
    endfunction
endlibrary