library EditAbilityInfo requires DummyRecycler

    function GetAbilityIntegerField takes unit u, integer abilId, integer level, abilityintegerlevelfield abilField returns integer
        local unit dummy
        local integer value

        if GetUnitAbilityLevel(u, abilId) > 0 then
            return BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(u, abilId), abilField, level - 1)
        else
            set dummy = GetRecycledDummyAnyAngle(0, 0, 0)

            call UnitAddAbility(dummy, abilId)
            call SetUnitAbilityLevel(dummy, abilId, level)

            set value = BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(dummy, abilId), abilField, level - 1)

            call UnitRemoveAbility(dummy, abilId)
            call RecycleDummy(dummy) 
            
            set dummy = null

            return value
        endif
    endfunction

    function GetAbilityRealField takes unit u, integer abilId, integer level, abilityreallevelfield abilField returns real
        local unit dummy
        local real value

        if GetUnitAbilityLevel(u, abilId) > 0 then
            return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), abilField, level - 1)
        else
            set dummy = GetRecycledDummyAnyAngle(0, 0, 0)

            call UnitAddAbility(dummy, abilId)
            call SetUnitAbilityLevel(dummy, abilId, level)

            set value = BlzGetAbilityRealLevelField(BlzGetUnitAbility(dummy, abilId), abilField, level - 1)

            call UnitRemoveAbility(dummy, abilId)
            call RecycleDummy(dummy) 

            set dummy = null

            return value
        endif
    endfunction

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

    function SetAbilityStringField takes unit u, integer abilId, integer level, abilitystringlevelfield abilField, string value returns nothing
        if GetUnitAbilityLevel(u, abilId) == 0 then
            call UnitAddAbility(u, abilId)
            call SetUnitAbilityLevel(u, abilId, level)
        endif

        if BlzSetAbilityStringLevelField(BlzGetUnitAbility(u, abilId), abilField, level - 1, value) then
            call IncUnitAbilityLevel(u, abilId)
            call DecUnitAbilityLevel(u, abilId)
        endif
    endfunction

    function SetAbilityRealField takes unit u, integer abilId, integer level, abilityreallevelfield abilField, real value returns nothing

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