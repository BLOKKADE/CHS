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


    function Trig_Faerie_Dragon_Func001A takes nothing returns nothing
        if(Trig_Faerie_Dragon_Func001Func001C())then
            if(Trig_Faerie_Dragon_Func001Func001Func002C())then
                call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\Blink\\BlinkCaster.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
                call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
                call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\Blink\\BlinkTarget.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
            endif
            if(Trig_Faerie_Dragon_Func001Func001Func003C())then
                set MysticFaerie[GetPlayerId(GetOwningPlayer(GetEnumUnit()))] = GetEnumUnit()
                call BlzSetUnitAttackCooldown(GetEnumUnit(), BlzGetUnitAttackCooldown(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))], 0), 0)
                call SetUnitAbilityLevelSwapped('A000',GetEnumUnit(),R2I(GetHeroLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 3))
                call UnitSetAttackSpeed(GetEnumUnit(), GetHeroLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]) * 0.03)
                call IssuePointOrderLocBJ(GetEnumUnit(),"attack",OffsetLocation(GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 300.00,300.00),GetRandomReal(- 300.00,300.00)))
                call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
            endif
        endif
    endfunction


    function Trig_Faerie_Dragon_Actions takes nothing returns nothing
        local group GRP = GetUnitsOfTypeIdAll('e001')
        call ForGroupBJ(GRP,function Trig_Faerie_Dragon_Func001A)
        call DestroyGroup(GRP)
        set GRP = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger14 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger14,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger14,Condition(function Trig_Dreadlords_Thirst_Conditions))
        call TriggerAddAction(udg_trigger14,function Trig_Dreadlords_Thirst_Actions)
        /*set udg_trigger15 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger15,1.00)
        call TriggerAddAction(udg_trigger15,function Trig_Faerie_Dragon_Actions)*/
    endfunction


endlibrary
