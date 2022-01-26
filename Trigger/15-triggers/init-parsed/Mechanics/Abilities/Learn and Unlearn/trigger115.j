library trigger115 initializer init requires RandomShit, Functions, SpellsLearned

    function Trig_Unlearn_Ability_Conditions takes nothing returns boolean
        if(not('I00P'==GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction


    function Trig_Unlearn_Ability_Func001C takes nothing returns boolean
        if(not(udg_boolean05==false))then
            return false
        endif
        if(not(udg_integers05[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]!='Amnz'))then
            return false
        endif
        return true
    endfunction


    function Trig_Unlearn_Ability_Func001Func003C takes nothing returns boolean
        if(not(udg_boolean05==false))then
            return false
        endif
        return true
    endfunction


    function Trig_Unlearn_Ability_Actions takes nothing returns nothing 
        local integer CountS = 0 
        local integer lastLearned = 0
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local integer Pid = GetConvertedPlayerId(p)
    
        if(Trig_Unlearn_Ability_Func001C()) and AbilityMode != 2 then
    
            set CountS = LoadCountHeroSpell(u, 0)
            if CountS > 0 then
    
                set udg_integers01[Pid]=(udg_integers01[Pid]- 1)
                set udg_integers05[Pid] = GetLastLearnedSpell(u, SpellList_Normal, true)
                call SetInfoHeroSpell(u,CountS,0 )
                call SaveCountHeroSpell(u ,CountS - 1,0 ) 
    
                call DisplayTimedTextToPlayer(p, 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(udg_integers05[Pid], GetUnitAbilityLevel(u, udg_integers05[Pid]) - 1))
                call AddSpecialEffectTargetUnitBJ("origin",u,"Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call UnitRemoveAbilityBJ(udg_integers05[Pid],u)
                call FunResetAbility (udg_integers05[Pid],u)
                call RemoveDummyspell(u, udg_integers05[Pid])

                if AbilityMode == 1 then
                    call RemoveItemFromUpgradeShop(Pid - 1, GetItemFromAbility(udg_integers05[Pid]))
                endif
            endif
    
        else
            call AdjustPlayerStateBJ(20,p,PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(p )
            call ForceAddPlayerSimple(p,bj_FORCE_PLAYER[11])
    
            if(Trig_Unlearn_Ability_Func001Func003C()) or AbilityMode == 2 then
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn!")
            else
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn! (Random Mode)")
            endif
    
            call ForceRemovePlayerSimple(p,bj_FORCE_PLAYER[11])
        endif

        set u = null
        set p = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger115 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger115,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger115,Condition(function Trig_Unlearn_Ability_Conditions))
        call TriggerAddAction(udg_trigger115,function Trig_Unlearn_Ability_Actions)
    endfunction


endlibrary
