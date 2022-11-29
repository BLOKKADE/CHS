library trigger115 initializer init requires RandomShit, Functions, SpellsLearned, CustomEvent

    function Trig_Unlearn_Ability_Conditions takes nothing returns boolean
        if(not('I00P'==GetItemTypeId(GetManipulatedItem())))then
            return false
        endif
        return true
    endfunction


    function Trig_Unlearn_Ability_Func001C takes nothing returns boolean
        if(not(ArNotLearningAbil==false))then
            return false
        endif
        if(not(PlayerLastLearnedSpell[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]!='Amnz'))then
            return false
        endif
        return true
    endfunction


    function Trig_Unlearn_Ability_Func001Func003C takes nothing returns boolean
        if(not(ArNotLearningAbil==false))then
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
        local customEvent ce = 0
    
        if(Trig_Unlearn_Ability_Func001C()) and AbilityMode != 2 then
    
            set CountS = GetHeroSpellListCount(u, 0)
            if CountS > 0 then
    
                set HeroAbilityCount[Pid]=(HeroAbilityCount[Pid]- 1)
                set PlayerLastLearnedSpell[Pid] = GetLastLearnedSpell(u, SpellList_Normal, true)
                call SetHeroSpellPosition(u,CountS,0 )
                call SetHeroSpellListCount(u ,CountS - 1,0 ) 
    
                call DisplayTimedTextToPlayer(p, 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(PlayerLastLearnedSpell[Pid], GetUnitAbilityLevel(u, PlayerLastLearnedSpell[Pid]) - 1))
                call AddSpecialEffectTargetUnitBJ("origin",u,"Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call UnitRemoveAbilityBJ(PlayerLastLearnedSpell[Pid],u)
                call FunResetAbility (PlayerLastLearnedSpell[Pid],u)
                call RemoveDummyspell(u, PlayerLastLearnedSpell[Pid])

                set ce = customEvent.create()
                set ce.EventUnit = u
                set ce.EventSpellId = PlayerLastLearnedSpell[Pid]

                call DispachEvent(CUSTOM_EVENT_UNLEARN_ABILITY, ce)

                if AbilityMode == 1 then
                    call RemoveItemFromUpgradeShop(Pid - 1, GetItemFromAbility(PlayerLastLearnedSpell[Pid]))
                    call RefreshUpgradeShop(Pid - 1, u)
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
