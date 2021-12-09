library trigger62 initializer init requires RandomShit

    function Trig_Skip_Betting_Menu_Actions takes nothing returns nothing
        if(Trig_Skip_Betting_Menu_Func001C())then
            set udg_integer63 =(udg_integer63 + 1)
            call ConditionalTriggerExecute(udg_trigger77)
        else
            call DialogDisplayBJ(true,udg_dialog05,GetTriggerPlayer())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger62 = CreateTrigger()
        call TriggerAddAction(udg_trigger62,function Trig_Skip_Betting_Menu_Actions)
    endfunction


endlibrary
