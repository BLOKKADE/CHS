library trigger83 initializer init requires RandomShit

    function Trig_DeathDialog_Initialization_Actions takes nothing returns nothing
        call DialogClearBJ(udg_dialog04)
        call DialogSetMessageBJ(udg_dialog04,"Defeat!")
        call DialogAddButtonBJ(udg_dialog04,"Spectate")
        set udg_buttons03[1]= GetLastCreatedButtonBJ()
        call DialogAddButtonBJ(udg_dialog04,"Leave")
        set udg_buttons03[2]= GetLastCreatedButtonBJ()
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger83 = CreateTrigger()
        call TriggerRegisterTimerEventSingle(udg_trigger83,0.00)
        call TriggerAddAction(udg_trigger83,function Trig_DeathDialog_Initialization_Actions)
    endfunction


endlibrary
