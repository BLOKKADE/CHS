library EditAbilityInfo
    function SetAbilityIntegerField takes unit u, integer abilId, integer level, abilityintegerlevelfield abilField, integer value returns nothing

    if GetUnitAbilityLevel(u, abilId) == 0 then
        call UnitAddAbility(u, abilId)
        call SetUnitAbilityLevel(u, abilId, level)
    endif

    if BlzSetAbilityIntegerLevelField(BlzGetUnitAbility(u, abilId), abilField, level - 1, value) then
        call IncUnitAbilityLevel(u, abilId)
        call DecUnitAbilityLevel(u, abilId)
    endif
    endfunction

    function SetAbilityRealField takes unit u, integer abilId, integer level, abilityreallevelfield  abilField, real value returns nothing

    if GetUnitAbilityLevel(u, abilId) == 0 then
        call UnitAddAbility(u, abilId)
        call SetUnitAbilityLevel(u, abilId, level)
    endif

    if BlzSetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), abilField, level - 1, value) then
        call IncUnitAbilityLevel(u, abilId)
        call DecUnitAbilityLevel(u, abilId)
    endif
    endfunction
endlibrary