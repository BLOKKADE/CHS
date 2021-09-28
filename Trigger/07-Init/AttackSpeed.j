library AttackSpeed requires EditAbilityInfo
    function GetUnitAttackSpeedAbility takes unit u returns ability
        if GetUnitAbilityLevel(u, 'A0A5') == 0 then
            call UnitAddAbility(u, 'A0A5')
        endif

        return BlzGetUnitAbility(u, 'A0A5')
    endfunction

    function UnitGetAttackSpeed takes unit u returns real
        return BlzGetAbilityRealLevelField(GetUnitAttackSpeedAbility(u), ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, 0)
    endfunction

    function UnitSetAttackSpeed takes unit u, real r returns nothing
        call SetAbilityRealField(u, 'A0A5', 1, ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, r)
    endfunction

    function UnitAddAttackSpeed takes unit u, real r returns nothing
        call SetAbilityRealField(u, 'A0A5', 1, ABILITY_RLF_ATTACK_SPEED_INCREASE_ISX1, UnitGetAttackSpeed(u) + r)
    endfunction
endlibrary