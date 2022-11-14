library trigger49 initializer init requires RandomShit

    function Trig_Place_Bet_Lumber_Func002C takes nothing returns boolean
        if(not(GetClickedButtonBJ()==DialogButtons[5]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Lumber_Conditions takes nothing returns boolean
        if(not Trig_Place_Bet_Lumber_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Lumber_Func001C takes nothing returns boolean
        if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)> 0))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Lumber_Func001Func001001 takes nothing returns boolean
        return(AllowBetSelection!=true)
    endfunction


    function Trig_Place_Bet_Lumber_Actions takes nothing returns nothing
        if(Trig_Place_Bet_Lumber_Func001C())then
            call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
            call DialogDisplayBJ(true,Dialogs[3],GetTriggerPlayer())
            set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= false
            set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= true
        else
            if(Trig_Place_Bet_Lumber_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger49 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger49,Dialogs[2])
        call TriggerAddCondition(udg_trigger49,Condition(function Trig_Place_Bet_Lumber_Conditions))
        call TriggerAddAction(udg_trigger49,function Trig_Place_Bet_Lumber_Actions)
    endfunction


endlibrary
