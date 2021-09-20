function UnlearnAbsolute takes unit u, integer id returns nothing
    local integer count = LoadCountHeroSpell(u, 1)
    call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cfff76863Removed |r" + BlzGetAbilityTooltip(id, GetUnitAbilityLevel(u, id) - 1))
    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
    call UnitRemoveAbility(u, id)
    call SaveCountHeroSpell(u,count-1,1)
    call SaveInteger(HT,GetHandleId(u),941561, LoadInteger(HT,GetHandleId(u),941561)  - 1 )
    call FunResetAbility(id,u)
endfunction

function Trig_AbsoluteAbilityLevelup_Actions takes nothing returns nothing
    local integer ItemId = GetItemTypeId(GetManipulatedItem())
    local integer counter = 0 
    local integer abilityId =  GetAbilityFromItem(ItemId)
    local integer abilityLevel 
    local unit u = GetTriggerUnit()
    //call BJDebugMsg("aalu")
    if ItemId == 'I09R' then
        //call BJDebugMsg("aalu unlearn")
        set counter = LoadInteger(HT,GetHandleId(u),941561) 
        if counter > 0 then
            call UnlearnAbsolute(u, GetLastLearnedSpell(GetHandleId(u), true))
        endif
    endif
    if IsAbsolute(abilityId) then
        //call BJDebugMsg("aalu is absolute")
        set counter = LoadInteger(HT,GetHandleId(u),941561) 
        set abilityLevel = GetUnitAbilityLevel(u,abilityId)
        //call BJDebugMsg("aalu counter: " + I2S(counter))
        if abilityLevel > 0 then
        
            if abilityLevel < 30 then
                call SetUnitAbilityLevel(u,abilityId,abilityLevel +1)
                //call BJDebugMsg("aalu level")
                call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cffbbff00Learned |r" + BlzGetAbilityTooltip(abilityId, abilityLevel))
            else
                call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(u) )
            endif
            
        else
            if counter < 10 and counter <= GetHeroMaxAbsoluteAbility(u) then
                //call BJDebugMsg("aalu add")
                call UnitAddAbility(u,abilityId)
                call BlzUnitDisableAbility(u,abilityId,false,true)
                call AddSpellPlayerInfo(abilityId,u,1)
                call AddSpellLearned(GetHandleId(u), abilityId)
                call SaveInteger(HT,GetHandleId(GetTriggerUnit()),941561,counter + 1 )
                call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cffbbff00Learned |r" + BlzGetAbilityTooltip(abilityId, abilityLevel))
            elseif counter > GetHeroMaxAbsoluteAbility(u) then
                //call BJDebugMsg("aalu acorn")
                call DisplayTextToPlayer(GetOwningPlayer(u),0,0,"Buy an |cffbbff00Absolute Acorn|r at |cffffd900Power Ups Shop II|r to buy more Absolute abilities. (|cffff1100Max:" +I2S(GetHeroMaxAbsoluteAbility(u) + 1) + "|r)"  ) 
                call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(u),PLAYER_STATE_RESOURCE_LUMBER)
                call ResourseRefresh(GetOwningPlayer(u) )

            endif
        endif
    endif
    
    
    
    
    set u = null
endfunction






//===========================================================================
function InitTrig_AbsoluteAbilityLevelup takes nothing returns nothing
    set gg_trg_AbsoluteAbilityLevelup = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_AbsoluteAbilityLevelup, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_AbsoluteAbilityLevelup, function Trig_AbsoluteAbilityLevelup_Actions )
endfunction

