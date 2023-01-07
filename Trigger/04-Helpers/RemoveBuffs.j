library RemoveBuffs requires BuffRepository
    //Remove all buffs of buffType from unit u
    //0 = all, 1 = negative, 2 = positive
    function RemoveUnitBuffs takes unit u, integer buffType returns nothing
        local integer abilId
        local integer i = 0
        loop
            set abilId = BlzGetAbilityId(BlzGetUnitAbilityByIndex(u, i))
            exitwhen abilId == 0

            if IsBuff(abilId) and GetBuffType(abilId) == buffType and IsBuffPurgeable(abilId) then
                if RemoveBuffAssociatedAbility(abilId) then
                    call UnitRemoveAbility(u, GetBuffAssociatedAbility(abilId))
                endif

                call UnitRemoveAbility(u, abilId)
            endif
    
            set i = i + 1
        endloop
    endfunction
endlibrary
