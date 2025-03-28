library RemoveBuffs requires BuffRepository

    //remove single buff
    function RemoveUnitBuff takes unit u, integer buffId returns nothing
        if IsBuff(buffId) then
            if RemoveBuffAssociatedAbility(buffId) then
                call UnitRemoveAbility(u, GetBuffAssociatedAbility(buffId))
            endif

            call UnitRemoveAbility(u, buffId)
        endif
    endfunction

    function RemoveFirstUnitBuff takes unit u, integer amount, integer buffType returns nothing
        local integer abilId
        local integer i = 0
        local integer removed = 0

        loop
            set abilId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(u, i))
            exitwhen abilId == 0

            if IsBuff(abilId) and (GetBuffType(abilId) == buffType or buffType == 0) and IsBuffPurgeable(abilId) then
                if RemoveBuffAssociatedAbility(abilId) then
                    call UnitRemoveAbility(u, GetBuffAssociatedAbility(abilId))
                endif

                call UnitRemoveAbility(u, abilId)

                set removed = removed + 1
                exitwhen removed >= amount
            endif
    
            set i = i + 1
        endloop
    endfunction

    //Remove all buffs of buffType from unit u
    //BUFFTYPE_NEGATIVE, BUFFTYPE_POSITIVE, BUFFTYPE_BOTH
    function RemoveUnitBuffs takes unit u, integer buffType, boolean removeUnpurgeable returns nothing
        local integer abilId
        local integer i = 0

        loop
            set abilId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(u, i))
            exitwhen abilId == 0

            if IsBuff(abilId) and (GetBuffType(abilId) == buffType or buffType == 0) and (removeUnpurgeable or IsBuffPurgeable(abilId)) then
                if RemoveBuffAssociatedAbility(abilId) then
                    call UnitRemoveAbility(u, GetBuffAssociatedAbility(abilId))
                endif

                call UnitRemoveAbility(u, abilId)
            endif
    
            set i = i + 1
        endloop
    endfunction
endlibrary
