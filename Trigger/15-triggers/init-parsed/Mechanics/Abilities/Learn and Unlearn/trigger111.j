library trigger111 initializer init requires RandomShit, Functions

    globals
        unit BuyingUnit = null
    endglobals

    function Trig_Learn_Ability_Conditions takes nothing returns boolean
        if(not('I00P'!=GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008C takes nothing returns boolean
        if(not(udg_boolean05==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped(udg_integer01,BuyingUnit)==0))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func002Func002C takes nothing returns boolean
        if((udg_integer01=='ANba'))then
            return true
        endif
        if((udg_integer01=='AHca'))then
            return true
        endif
        if((udg_integer01=='AHfa'))then
            return true
        endif
        if((udg_integer01=='Aliq'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func002C takes nothing returns boolean
        if(not(IsUnitType(BuyingUnit,UNIT_TYPE_MELEE_ATTACKER)==true))then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func002Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func003Func002C takes nothing returns boolean
        if((udg_integer01=='ANca'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func003C takes nothing returns boolean
        if(not(IsUnitType(BuyingUnit,UNIT_TYPE_RANGED_ATTACKER)==true))then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func003Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func004Func001C takes nothing returns boolean
        if((IsUnitType(BuyingUnit,UNIT_TYPE_MELEE_ATTACKER)==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func004Func002C takes nothing returns boolean
        if((udg_integer01=='ANba'))then
            return true
        endif
        if((udg_integer01=='Aroc'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func004C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func004Func001C())then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func004Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func005Func001C takes nothing returns boolean
        if((GetUnitTypeId(BuyingUnit)=='H004'))then
            return true
        endif
        if((GetUnitTypeId(BuyingUnit)=='O005'))then
            return true
        endif
        if((GetUnitTypeId(BuyingUnit)=='O001'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func005Func002C takes nothing returns boolean
        if((udg_integer01=='ACvs'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001Func005C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func005Func001C())then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func001Func005Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func001C takes nothing returns boolean
        if((udg_integers01[GetConvertedPlayerId(GetOwningPlayer(BuyingUnit))]>= 10))then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func001Func002C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func001Func003C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func001Func004C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func001Func005C())then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001Func002C takes nothing returns boolean
        if((udg_integer01=='ANba'))then
            return true
        endif
        if((udg_integer01=='AHca'))then
            return true
        endif
        if((udg_integer01=='AHfa'))then
            return true
        endif
        if((udg_integer01=='Aliq'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001C takes nothing returns boolean
        if(not(IsUnitType(BuyingUnit,UNIT_TYPE_MELEE_ATTACKER)==true))then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002Func002C takes nothing returns boolean
        if((udg_integer01=='ANca'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002C takes nothing returns boolean
        if(not(IsUnitType(BuyingUnit,UNIT_TYPE_RANGED_ATTACKER)==true))then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func001C takes nothing returns boolean
        if((IsUnitType(BuyingUnit,UNIT_TYPE_MELEE_ATTACKER)==true))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func002C takes nothing returns boolean
        if((udg_integer01=='ANba'))then
            return true
        endif
        if((udg_integer01=='Aroc'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func001C())then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func001C takes nothing returns boolean
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func002C takes nothing returns boolean
        if((udg_integer01=='ACvs'))then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func001C())then
            return false
        endif
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func002C takes nothing returns boolean
        if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func001C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func002C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func003C())then
            return true
        endif
        if(Trig_Learn_Ability_Func008Func002Func001Func007Func002Func004C())then
            return true
        endif
        return false
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007C takes nothing returns boolean
        if(not Trig_Learn_Ability_Func008Func002Func001Func007Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func001C takes nothing returns boolean
        if(not(udg_boolean06==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func007Func001Func001C takes nothing returns boolean
        if(not(udg_boolean06==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func001Func008C takes nothing returns boolean
        if(not(udg_boolean06==false))then
            return false
        endif
        return true
    endfunction

    function EconomicModeAbility takes integer abilId returns boolean
        return ECONOMIC_ABILITIES.contains(abilId) and IncomeMode == 3
    endfunction


    function BuyLevels takes player p, unit u, integer abil, boolean maxBuy, boolean new returns nothing
        local integer i = GetUnitAbilityLevel(u, abil) + 1
        local integer cost = BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') )
        local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
        //call BJDebugMsg("u: " + GetUnitName(u) + " abil: " + GetObjectName(abil) + " lvl: " + I2S(i) + " new: " + B2S(new))
        if maxBuy and i < 30 then
            loop
                if lumber - cost < 0 then
                    exitwhen true
                endif
                set lumber = lumber - cost
                set i = i + 1
                exitwhen i >= 30
            endloop
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        endif
        //call BJDebugMsg("u: " + GetUnitName(u) + " abil: " + GetObjectName(abil) + " lvl: " + I2S(i) + " new: " + B2S(new))
        if new then
            call UnitAddAbility(u, abil)
            call SpellLearnedFunc(u, abil)
            if AbilityMode == 1 then
                call AddItemToUpgradeShop(GetPlayerId(p), GetItemTypeId(GetManipulatedItem()))
            endif
        endif
        if i > 1 and i < 31 then
            call SetUnitAbilityLevel(u, udg_integer01, i)
        endif

        call SetupDummySpell(u, abil, i, new)
        call FuncEditParam(abil,u)
        call AddSpecialEffectLocBJ(GetUnitLoc(u),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call DisplayTimedTextToPlayer(p, 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(abil, GetUnitAbilityLevel(u, abil) - 1))
    endfunction


    function Trig_Learn_Ability_Func008Func002Func003C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped(udg_integer01,BuyingUnit)< 30))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func002Func003Func001C takes nothing returns boolean
        if(not(udg_boolean06==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func001C takes nothing returns boolean
        if(not(udg_boolean05==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func001Func002C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped(udg_integer01,BuyingUnit)>= 0))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func001Func002Func001C takes nothing returns boolean
        if(not(udg_boolean06==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func001Func002Func002C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped(udg_integer01,BuyingUnit)< 30))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Func008Func001Func002Func002Func001C takes nothing returns boolean
        if(not(udg_boolean06==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Learn_Ability_Actions takes nothing returns nothing
        local integer abilLevel
        local boolean maxAbil = false
        set BuyingUnit = udg_units01[GetPlayerId(GetOwningPlayer(GetTriggerUnit())) + 1]
        set udg_integer01 = GetAbilityFromItem(GetItemTypeId(GetManipulatedItem()))
        //call ConditionalTriggerExecute(udg_trigger112)
        if udg_integer01 == 0 or IsAbsolute(udg_integer01) or GetTriggerUnit() != BuyingUnit then
            return
        endif
        set abilLevel = GetUnitAbilityLevel(BuyingUnit, udg_integer01)
        if HoldCtrl[GetPlayerId(GetOwningPlayer(BuyingUnit))] then
            set maxAbil = true
        endif

        if EconomicModeAbility(udg_integer01) then
            if udg_boolean06 then
                call ConditionalTriggerExecute(udg_trigger114)
                return
            else
                call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffbbff00Failed to learn|r")
                
                if AbilityMode == 1 then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "[|cffffc896Economic|r] spells are |cffff0000unavailable in Economy mode|r: instead you get bonus gold and experience by default.")
                endif

                return
            endif
        endif

        if(Trig_Learn_Ability_Func008C())then
            if(Trig_Learn_Ability_Func008Func002C())then
                if(Trig_Learn_Ability_Func008Func002Func001C())then
                    if(Trig_Learn_Ability_Func008Func002Func001Func007C())then
                        if(Trig_Learn_Ability_Func008Func002Func001Func007Func001C()) then
                            call ConditionalTriggerExecute(udg_trigger114)
                            return
                        else
                            if(Trig_Learn_Ability_Func008Func002Func001Func007Func001Func001C())then
    
                                call AdjustPlayerStateBJ(   BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ) ,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
    
                                call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                                //	call AdjustPlayerStateBJ((GetItemLevel(GetManipulatedItem())*10),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                            else
                                call AdjustPlayerStateBJ(5,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                                call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                            endif
                            //call BJDebugMsg("failed?1")
                            call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffbbff00Failed to learn|r")
                            return
                        endif
                    endif
                    if(Trig_Learn_Ability_Func008Func002Func001Func008C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    endif
                    //call BJDebugMsg("failed?2")
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r")
                    return
                else
                    set udg_integers01[GetConvertedPlayerId(GetOwningPlayer(BuyingUnit))]=(udg_integers01[GetConvertedPlayerId(GetOwningPlayer(BuyingUnit))]+ 1)
                    set udg_integers05[GetConvertedPlayerId(GetOwningPlayer(BuyingUnit))]= udg_integer01
                    call BuyLevels(GetOwningPlayer(BuyingUnit), BuyingUnit, udg_integer01, maxAbil, true)
                endif
            else
                //increase level ap
                if(Trig_Learn_Ability_Func008Func002Func003C())then
                    call BuyLevels(GetOwningPlayer(BuyingUnit), BuyingUnit, udg_integer01, maxAbil, false)
                else
                    //max level reached
                    if(Trig_Learn_Ability_Func008Func002Func003Func001C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    endif
                    //call BJDebugMsg("max lvl ap")
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: Maximum ability level")
                    return
                endif
            endif
        else
            if(Trig_Learn_Ability_Func008Func001C())then
                if(Trig_Learn_Ability_Func008Func001Func002C())then
                    //failed ar
                    if(Trig_Learn_Ability_Func008Func001Func002Func001C())then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    else
                        call AdjustPlayerStateBJ(5,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    endif
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: (Random mode) 3")
                    return
                else
                    //increase level ap
                    if(Trig_Learn_Ability_Func008Func001Func002Func002C())then
                        call IncUnitAbilityLevelSwapped(udg_integer01,BuyingUnit)
                        call FuncEditParam(udg_integer01,BuyingUnit)
                        call AddSpecialEffectLocBJ(GetUnitLoc(BuyingUnit),"Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl")
                        call DestroyEffectBJ(GetLastCreatedEffectBJ())
                        call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(udg_integer01, abilLevel))
                    else
                        if(Trig_Learn_Ability_Func008Func001Func002Func002Func001C())then
                            call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr') ),GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                            call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                        else
                            call AdjustPlayerStateBJ(5,GetOwningPlayer(BuyingUnit),PLAYER_STATE_RESOURCE_LUMBER)
                            call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                        endif
                        //call BJDebugMsg("inc f ap")
                        call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: 4")
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
