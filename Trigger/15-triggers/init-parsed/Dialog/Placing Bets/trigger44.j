library trigger44 initializer init requires RandomShit

    function Trig_Betting_Initialization_Conditions takes nothing returns boolean
        if(not(udg_boolean13==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Betting_Initialization_Actions takes nothing returns nothing
        call DialogSetMessageBJ(udg_dialogs01[2],"Betting Menu")
        call DialogAddButtonBJ(udg_dialogs01[2],"Gold")
        set udg_buttons02[4]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[2],"Lumber")
        set udg_buttons02[5]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[2],"Gold & Lumber")
        set udg_buttons02[6]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[2],"Cancel")
        set udg_buttons02[7]= GetLastCreatedButtonBJ()
        call DialogSetMessageBJ(udg_dialogs01[3],"Betting Menu")
        call DialogAddButtonBJ(udg_dialogs01[3],"25%")
        set udg_buttons02[8]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[3],"50%")
        set udg_buttons02[9]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[3],"100%")
        set udg_buttons02[10]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialogs01[3],"Cancel")
        set udg_buttons02[11]= GetLastCreatedButtonBJ()
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger44 = CreateTrigger()
        call TriggerRegisterTimerEventSingle(udg_trigger44,30.00)
        call TriggerAddCondition(udg_trigger44,Condition(function Trig_Betting_Initialization_Conditions))
        call TriggerAddAction(udg_trigger44,function Trig_Betting_Initialization_Actions)
    endfunction


endlibrary
