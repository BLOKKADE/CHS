library trigger138 initializer init requires RandomShit

    function Trig_Receive_Prize_Conditions takes nothing returns boolean
        return CountUnitsInGroup(DuelWinners) > 0
    endfunction

    function Trig_Receive_Prize_Func002A takes nothing returns nothing
        if(BettingPlayerCount > 0 and IsUnitAliveBJ(GetEnumUnit())==true)then
            call SetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(GetEnumUnit()), PLAYER_STATE_RESOURCE_GOLD) + udg_integer15)
            call GroupRemoveUnitSimple(GetEnumUnit(),DuelWinners)
        endif
    endfunction

    function Trig_Receive_Prize_Actions takes nothing returns nothing
        call ForGroupBJ(DuelWinners,function Trig_Receive_Prize_Func002A)
        call TriggerSleepAction(0.50)
        call ConditionalTriggerExecute(GetTriggeringTrigger())
    endfunction

    private function init takes nothing returns nothing
        set udg_trigger138 = CreateTrigger()
        call TriggerAddCondition(udg_trigger138,Condition(function Trig_Receive_Prize_Conditions))
        call TriggerAddAction(udg_trigger138,function Trig_Receive_Prize_Actions)
    endfunction

endlibrary
