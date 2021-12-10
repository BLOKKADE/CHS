library trigger84 initializer init requires RandomShit

    function Trig_DeathDialog_Leave_Conditions takes nothing returns boolean
        if(not(GetClickedButtonBJ()==udg_buttons03[2]))then
            return false
        endif
        return true
    endfunction


    function Trig_DeathDialog_Leave_Actions takes nothing returns nothing
        call CustomDefeatBJ(GetTriggerPlayer(),"Defeat!")
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger84 = CreateTrigger()
        call TriggerRegisterDialogEventBJ(udg_trigger84,udg_dialog04)
        call TriggerAddCondition(udg_trigger84,Condition(function Trig_DeathDialog_Leave_Conditions))
        call TriggerAddAction(udg_trigger84,function Trig_DeathDialog_Leave_Actions)
    endfunction


endlibrary
