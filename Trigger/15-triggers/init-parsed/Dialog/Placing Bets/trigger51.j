library trigger51 initializer init requires RandomShit

    function Trig_Place_Bet_Func001C takes nothing returns boolean
        if((GetClickedButtonBJ()==DialogButtons[8]))then
            return true
        endif
        if((GetClickedButtonBJ()==DialogButtons[9]))then
            return true
        endif
        if((GetClickedButtonBJ()==DialogButtons[10]))then
            return true
        endif
        return false
    endfunction


    function Trig_Place_Bet_Conditions takes nothing returns boolean
        if(not Trig_Place_Bet_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Func002C takes nothing returns boolean
        if(not(GetClickedButtonBJ()==DialogButtons[8]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Func002Func001C takes nothing returns boolean
        if(not(GetClickedButtonBJ()==DialogButtons[9]))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Func004C takes nothing returns boolean
        if(not(udg_booleans04[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Func005C takes nothing returns boolean
        if(not(udg_booleans05[GetConvertedPlayerId(GetTriggerPlayer())]==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Func007001 takes nothing returns boolean
        return(udg_boolean14==false)
    endfunction


    function Trig_Place_Bet_Func008C takes nothing returns boolean
        if(not(IsPlayerInForce(GetTriggerPlayer(),udg_force04)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Place_Bet_Actions takes nothing returns nothing
        if(Trig_Place_Bet_Func002C())then
            set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 25
        else
            if(Trig_Place_Bet_Func002Func001C())then
                set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 50
            else
                set udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())]= 100
            endif
        endif
        if(Trig_Place_Bet_Func004C())then
            set udg_integer62 = udg_integers15[GetConvertedPlayerId(GetTriggerPlayer())]
            set udg_integer62 = R2I(((I2R(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD))/ 100.00)* I2R(udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())])))
            //call ConditionalTriggerExecute(udg_trigger52)
            call AdjustPlayerStateBJ((- 1 * udg_integer62),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(   GetTriggerPlayer() )
            set udg_integers15[GetConvertedPlayerId(GetTriggerPlayer())]= udg_integer62
        else
        endif
        if(Trig_Place_Bet_Func005C())then
            set udg_integer62 = udg_integers16[GetConvertedPlayerId(GetTriggerPlayer())]
            set udg_integer62 = R2I(((I2R(GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER))/ 100.00)* I2R(udg_integers11[GetConvertedPlayerId(GetTriggerPlayer())])))
            //call ConditionalTriggerExecute(udg_trigger52)
            call AdjustPlayerStateBJ((- 1 * udg_integer62),GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
            call ResourseRefresh(   GetTriggerPlayer() )
            set udg_integers16[GetConvertedPlayerId(GetTriggerPlayer())]= udg_integer62
        else
        endif
        if(Trig_Place_Bet_Func007001())then
            return
        else
            call DoNothing()
        endif
        if(Trig_Place_Bet_Func008C())then
            // TODO call DisplayTimedTextToForce(GetPlayersAll(),2.00,("|c00F08000" +(GetPlayerNameColour(GetTriggerPlayer())+(" placed a bet on " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[1]))+ "!")))))
        else
            // TODO call DisplayTimedTextToForce(GetPlayersAll(),2.00,("|c00F08000" +(GetPlayerNameColour(GetTriggerPlayer())+(" placed a bet on " +(GetPlayerNameColour(GetOwningPlayer(DuelingHeroes[2]))+ "!")))))
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger51 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger51,Dialogs[3])
        call TriggerAddCondition(udg_trigger51,Condition(function Trig_Place_Bet_Conditions))
        call TriggerAddAction(udg_trigger51,function Trig_Place_Bet_Actions)
    endfunction


endlibrary
