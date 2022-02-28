library trigger47 initializer init requires RandomShit

    function Trig_Skip_Bet_Func004C takes nothing returns boolean
        if((GetClickedButtonBJ()==DialogButtons[3]))then
            return true
        endif
        if((GetClickedButtonBJ()==DialogButtons[7]))then
            return true
        endif
        if((GetClickedButtonBJ()==DialogButtons[11]))then
            return true
        endif
        return false
    endfunction


    function Trig_Skip_Bet_Conditions takes nothing returns boolean
        if(not Trig_Skip_Bet_Func004C())then
            return false
        endif
        return true
    endfunction


    function Trig_Skip_Bet_Actions takes nothing returns nothing
        call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force04)
        call ForceRemovePlayerSimple(GetTriggerPlayer(),udg_force05)
        set bj_forLoopAIndex = 1
        set bj_forLoopAIndexEnd = 3
        loop
            exitwhen bj_forLoopAIndex > bj_forLoopAIndexEnd
            call DialogDisplayBJ(false,Dialogs[GetForLoopIndexA()],GetTriggerPlayer())
            set bj_forLoopAIndex = bj_forLoopAIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger47 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger47,Dialogs[1])
        call TriggerAddCondition(udg_trigger47,Condition(function Trig_Skip_Bet_Conditions))
        call TriggerAddAction(udg_trigger47,function Trig_Skip_Bet_Actions)
    endfunction


endlibrary
