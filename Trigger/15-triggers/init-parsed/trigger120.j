library trigger120 initializer init requires RandomShit

    function Trig_Playtime_Actions takes nothing returns nothing
        set udg_integers06[2]=(udg_integers06[2]+ 1)
        if(Trig_Playtime_Func002C())then
            set udg_integers06[2]= 0
            set udg_integers06[1]=(udg_integers06[1]+ 1)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger120 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger120,1.00)
        call TriggerAddAction(udg_trigger120,function Trig_Playtime_Actions)
    endfunction


endlibrary
