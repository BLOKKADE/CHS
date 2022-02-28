/*library trigger96 initializer init requires RandomShit

    function Trig_Volcanic_Armor_Conditions takes nothing returns boolean
        if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03T')==true))then
            return false
        endif
        if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Volcanic_Armor_Func003C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance <= 15))then
            return false
        endif
        return true
    endfunction


    function Trig_Volcanic_Armor_Actions takes nothing returns nothing
        set RoundCreepAbilCastChance = GetRandomInt(1,100)
        if RoundCreepAbilCastChance < 15 * GetUnitLuck(GetTriggerUnit()) then
            call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(5.00,'BTLF',GetLastCreatedUnit())
            call UnitAddAbilityBJ('A015',GetLastCreatedUnit())
            call IssueTargetOrderBJ(GetLastCreatedUnit(),"firebolt",GetAttacker())
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger96 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger96,EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(udg_trigger96,Condition(function Trig_Volcanic_Armor_Conditions))
        call TriggerAddAction(udg_trigger96,function Trig_Volcanic_Armor_Actions)
    endfunction


endlibrary
*/