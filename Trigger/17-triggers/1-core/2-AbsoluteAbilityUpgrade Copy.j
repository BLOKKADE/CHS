

function Trig_AbsoluteAbilityUpgrade_Copy_Actions takes nothing returns nothing
    local integer ItemId = GetItemTypeId(GetManipulatedItem())
    local integer counter = 0 
    local integer abilityId =  GetItemAbility(ItemId)
    local integer abilityLevel 
    local unit u 
    if abilityId != 0 then
        set u = GetTriggerUnit()
        set counter = LoadInteger(HT,GetHandleId(u),941561) 
        set abilityLevel = GetUnitAbilityLevel(u,abilityId)
        if abilityLevel > 0 then
        
            if abilityLevel < 30 then
                call SetUnitAbilityLevel(u,abilityId,abilityLevel +1)
            else
                call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(u) )
            endif
            
        else
            if counter < 10 and counter <= GetHeroMaxAbsoluteAbility(u) then
            
                call UnitAddAbility(u,abilityId)
                call BlzUnitDisableAbility(u,abilityId,false,true)
                call AddSpellPlayerInfo(abilityId,u,1)
                call SaveInteger(HT,GetHandleId(GetTriggerUnit()),941561,counter + 1 )
            elseif counter > GetHeroMaxAbsoluteAbility(u) then
                call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"You have the maximum number of abilities of this type. (Max:" +I2S(GetHeroMaxAbsoluteAbility(u) + 1) + ")"  ) 
                call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(u) )

            endif
        endif
        set u = null
    endif
    
    
    
    

endfunction






//===========================================================================
function InitTrig_AbsoluteAbilityUpgrade_Copy takes nothing returns nothing
    set gg_trg_AbsoluteAbilityUpgrade_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AbsoluteAbilityUpgrade_Copy, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_AbsoluteAbilityUpgrade_Copy, function Trig_AbsoluteAbilityUpgrade_Copy_Actions )
endfunction

