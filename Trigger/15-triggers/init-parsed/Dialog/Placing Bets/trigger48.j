library trigger48 initializer init requires RandomShit

    function Trig_Place_Bet_Gold_Func002C takes nothing returns boolean
        if(not(GetClickedButtonBJ()==DialogButtons[4]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Gold_Conditions takes nothing returns boolean
        if(not Trig_Place_Bet_Gold_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Gold_Func001C takes nothing returns boolean
        if(not(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)> 0))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Gold_Func001Func001001 takes nothing returns boolean
        return(udg_boolean18!=true)
    endfunction


    function Trig_Place_Bet_Gold_Actions takes nothing returns nothing
        if(Trig_Place_Bet_Gold_Func001C())then
            call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
            call DialogDisplayBJ(true,Dialogs[3],GetTriggerPlayer())
            set udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]= true
            set udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]= false
        else
            if(Trig_Place_Bet_Gold_Func001Func001001())then
                return
            else
                call DoNothing()
            endif
            call DialogDisplayBJ(true,Dialogs[2],GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger48 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger48,Dialogs[2])
        call TriggerAddCondition(udg_trigger48,Condition(function Trig_Place_Bet_Gold_Conditions))
        call TriggerAddAction(udg_trigger48,function Trig_Place_Bet_Gold_Actions)
    endfunction


endlibrary
