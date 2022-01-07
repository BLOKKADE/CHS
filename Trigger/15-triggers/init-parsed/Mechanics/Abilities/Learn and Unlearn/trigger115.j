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
        local integer Pid = GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))
    
        if(Trig_Unlearn_Ability_Func001C()) and AbilityMode != 2 then
    
            set CountS = LoadCountHeroSpell(GetTriggerUnit(), 0)
            if CountS > 0 then
    
                set udg_integers01[Pid]=(udg_integers01[Pid]- 1)
                set udg_integers05[Pid] = GetLastLearnedSpell(GetTriggerUnit(), SpellList_Normal, true)
                call SetInfoHeroSpell(GetTriggerUnit(),CountS,0 )
                call SaveCountHeroSpell(GetTriggerUnit() ,CountS - 1,0 ) 
    
                call DisplayTimedTextToPlayer(GetOwningPlayer(GetTriggerUnit()), 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(udg_integers05[Pid], GetUnitAbilityLevel(GetTriggerUnit(), udg_integers05[Pid]) - 1))
                call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call UnitRemoveAbilityBJ(udg_integers05[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())
                call FunResetAbility (udg_integers05[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],GetTriggerUnit())
                call RemoveDummyspell(GetTriggerUnit(), udg_integers05[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])
            endif
    
        else
            call AdjustPlayerStateBJ(20,GetOwningPlayer(GetTriggerUnit()),PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(GetOwningPlayer(GetTriggerUnit()) )
            call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),bj_FORCE_PLAYER[11])
    
            if(Trig_Unlearn_Ability_Func001Func003C()) or AbilityMode == 2 then
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn!")
            else
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11],2.00,"|cffffcc00Failed to unlearn! (Random Mode)")
            endif
    
            call ForceRemovePlayerSimple(GetOwningPlayer(GetTriggerUnit()),bj_FORCE_PLAYER[11])
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger115 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger115,EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(udg_trigger115,Condition(function Trig_Unlearn_Ability_Conditions))
        call TriggerAddAction(udg_trigger115,function Trig_Unlearn_Ability_Actions)
    endfunction


endlibrary
