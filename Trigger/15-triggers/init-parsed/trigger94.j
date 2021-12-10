library trigger94 initializer init requires RandomShit

    function Trig_Scepter_of_Confusion_Conditions takes nothing returns boolean
        if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03R')==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Scepter_of_Confusion_Func002C takes nothing returns boolean
        if(not(udg_integer14!=1))then
            return false
        endif
        return true
    endfunction


    function Trig_Scepter_of_Confusion_Actions takes nothing returns nothing
        set udg_integer14 = GetRandomInt(1,4)
        if(Trig_Scepter_of_Confusion_Func002C())then
            call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(5.00,'BTLF',GetLastCreatedUnit())
            call UnitAddAbility(GetLastCreatedUnit(), 'A014')
            call IssueTargetOrderById(GetLastCreatedUnit(), 852274, GetTriggerUnit())
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger94 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger94,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger94,Condition(function Trig_Scepter_of_Confusion_Conditions))
        call TriggerAddAction(udg_trigger94,function Trig_Scepter_of_Confusion_Actions)
    endfunction


endlibrary
