library trigger14 initializer init requires RandomShit

    function Trig_Dreadlords_Thirst_Conditions takes nothing returns boolean
        if(not(GetUnitTypeId(GetKillingUnitBJ())=='O002'))then
            return false
        endif
        return true
    endfunction


    function Trig_Dreadlords_Thirst_Actions takes nothing returns nothing
        call SetUnitLifeBJ(GetKillingUnitBJ(),(GetUnitStateSwap(UNIT_STATE_LIFE,GetKillingUnitBJ())+(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,GetKillingUnitBJ())/ 10.00)))
        call AddSpecialEffectTargetUnitBJ("hand right",GetKillingUnitBJ(),"Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("hand left",GetKillingUnitBJ(),"Abilities\\Weapons\\HydraliskImpact\\HydraliskImpact.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
        call AddSpecialEffectTargetUnitBJ("origin",GetTriggerUnit(),"Objects\\Spawnmodels\\Human\\HumanBlood\\BloodElfSpellThiefBlood.mdl")
        call DestroyEffectBJ(GetLastCreatedEffectBJ())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger14 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger14,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger14,Condition(function Trig_Dreadlords_Thirst_Conditions))
        call TriggerAddAction(udg_trigger14,function Trig_Dreadlords_Thirst_Actions)
    endfunction


endlibrary
