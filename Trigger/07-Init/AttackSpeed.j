library AttackSpeed requires EditAbilityInfo
    function GetUnitAttackSpeedAbility takes unit u returns ability
        if GetUnitAbilityLevel(u, ATTACK_SPEED_BONUS_ABILITY_ID) == 0 then
            call UnitAddAbility(u, ATTACK_SPEED_BONUS_ABILITY_ID)
        endif

        return BlzGetUnitAbility(u, ATTACK_SPEED_BONUS_ABILITY_ID)
    endfunction

    function UnitGetAttackSpeed takes unit u returns real
        return BlzGetAbilityRealLevelField(GetUnitAttackSpeedAbility(u), ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, 0)
    endfunction

    function UnitSetAttackSpeed takes unit u, real r returns nothing
        call SetAbilityRealField(u, ATTACK_SPEED_BONUS_ABILITY_ID, 1, ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, r)
    endfunction

    function UnitAddAttackSpeed takes unit u, real r returns nothing
        call SetAbilityRealField(u, ATTACK_SPEED_BONUS_ABILITY_ID, 1, ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, UnitGetAttackSpeed(u) + r)
    endfunction
endlibrary