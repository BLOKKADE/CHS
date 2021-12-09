library trigger111 initializer init requires RandomShit

    function Trig_Learn_Ability_Conditions takes nothing returns boolean
        if(not('I00P'!=GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Actions takes nothing returns nothing
        local integer abilLevel
        local boolean maxAbil = false
        set udg_integer01 = GetAbilityFromItem(GetItemTypeId(GetManipulatedItem()))
        //call ConditionalTriggerExecute(udg_trigger112)
        if udg_integer01 == 0 or IsAbsolute(udg_integer01) then
            return
        endif
        set abilLevel = GetUnitAbilityLevel(GetTriggerUnit(), udg_integer01)
        if HoldCtrl[GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] then
            set maxAbil = true
        endif
        if(Trig_Learn_Ability_Func008C())then
            if(Trig_Learn_Ability_Func008Func002C())then
                if(Trig_Learn_Ability_Func008Func002Func001C())then
                    if(Trig_Learn_Ability_Func008Func002Func001Func007C())then
                        if(Trig_Learn_Ability_Func008Func002Func001Func007Func001C())then
                            call ConditionalTriggerExecute(udg_trigger114)
                            return
                        else
                            if(Trig_Learn_Ability_Func008Func002Func001Func007Func001Func001C())then
    
                                call AdjustPlayerStateBJ(   BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ) ,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
    
                                call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                                //	call AdjustPlayerStateBJ((GetItemLevel(GetManipulatedItem())*10),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                            else
                                call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                                call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                            endif
                            //call BJDebugMsg("failed?1")
                            call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffbbff00Failed to learn|r")
                            return
                        endif
                    endif
                    if(Trig_Learn_Ability_Func008Func002Func001Func008C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    endif
                    //call BJDebugMsg("failed?2")
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r")
                    return
                else
                    set udg_integers01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]=(udg_integers01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]+ 1)
                    set udg_integers05[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]= udg_integer01
                    call BuyLevels(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), udg_integer01, maxAbil, true)
                endif
            else
                //increase level ap
                if(Trig_Learn_Ability_Func008Func002Func003C())then
                    call BuyLevels(GetOwningPlayer(GetTriggerUnit()), GetTriggerUnit(), udg_integer01, maxAbil, false)
                else
                    //max level reached
                    if(Trig_Learn_Ability_Func008Func002Func003Func001C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    endif
                    //call BJDebugMsg("max lvl ap")
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: Maximum ability level")
                    return
                endif
            endif
        else
            if(Trig_Learn_Ability_Func008Func001C())then
                if(Trig_Learn_Ability_Func008Func001Func002C())then
                    //failed ar
                    if(Trig_Learn_Ability_Func008Func001Func002Func001C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                    endif
                    call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: (Random mode) 3")
                    return
                else
                    //increase level ap
                    if(Trig_Learn_Ability_Func008Func001Func002Func002C())then
                        call IncUnitAbilityLevelSwapped(udg_integer01,GetTriggerUnit())
                        call FuncEditParam(udg_integer01,GetTriggerUnit())
                        call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
                        call DestroyEffectBJ(GetLastCreatedEffectBJ())
                        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(udg_integer01, abilLevel))
                    else
                        if(Trig_Learn_Ability_Func008Func001Func002Func002Func001C())then
                            call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                            call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                        else
                            call AdjustPlayerStateBJ(5,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_LUMBER)
                            call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
                        endif
                        //call BJDebugMsg("inc f ap")
                        call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 2.0, "|cffffe600Failed to learn|r: 4")
                        return
                    endif
                endif
            else
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger111 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger111,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger111,Condition(function Trig_Learn_Ability_Conditions))
        call TriggerAddAction(udg_trigger111,function Trig_Learn_Ability_Actions)
    endfunction


endlibrary
