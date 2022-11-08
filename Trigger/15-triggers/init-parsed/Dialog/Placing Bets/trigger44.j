library trigger44 initializer init requires RandomShit

    function Trig_Betting_Initialization_Conditions takes nothing returns boolean
        if(not(BettingEnabled==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Betting_Initialization_Actions takes nothing returns nothing
        call DialogSetMessageBJ(Dialogs[2],"Betting Menu")
        call DialogAddButtonBJ(Dialogs[2],"Gold")
        set DialogButtons[4]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Lumber")
        set DialogButtons[5]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Gold & Lumber")
        set DialogButtons[6]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[2],"Cancel")
        set DialogButtons[7]= GetLastCreatedButtonBJ()
        call DialogSetMessageBJ(Dialogs[3],"Betting Menu")
        call DialogAddButtonBJ(Dialogs[3],"25%")
        set DialogButtons[8]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"50%")
        set DialogButtons[9]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"100%")
        set DialogButtons[10]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(Dialogs[3],"Cancel")
        set DialogButtons[11]= GetLastCreatedButtonBJ()
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger44 = CreateTrigger()
        call TriggerRegisterTimerEventSingle(udg_trigger44,30.00)
        call TriggerAddCondition(udg_trigger44,Condition(function Trig_Betting_Initialization_Conditions))
        call TriggerAddAction(udg_trigger44,function Trig_Betting_Initialization_Actions)
    endfunction


endlibrary
