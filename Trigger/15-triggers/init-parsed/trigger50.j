library trigger50 initializer init requires RandomShit

    function Trig_Place_Bet_GoldLumber_Conditions takes nothing returns boolean
        if(not Trig_Place_Bet_GoldLumber_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_GoldLumber_Actions takes nothing returns nothing
        if(Trig_Place_Bet_GoldLumber_Func001C())then
            call DialogSetMessageBJ(udg_dialogs01[3],"Betting Menu")
            call DialogDisplayBJ(true,udg_dialogs01[3],GetTriggerPlayer())
            set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= true
            set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= true
        else
            if(Trig_Place_Bet_GoldLumber_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call DialogDisplayBJ(true,udg_dialogs01[2],GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger50 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger50,udg_dialogs01[2])
        call TriggerAddCondition(udg_trigger50,Condition(function Trig_Place_Bet_GoldLumber_Conditions))
        call TriggerAddAction(udg_trigger50,function Trig_Place_Bet_GoldLumber_Actions)
    endfunction


endlibrary
