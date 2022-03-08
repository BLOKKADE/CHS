library trigger120 initializer init requires RandomShit

    function Trig_Playtime_Func002C takes nothing returns boolean
        if(not(Playtime[2]> 59))then
            return false
        endif
        return true
    endfunction


    function Trig_Playtime_Actions takes nothing returns nothing
        set Playtime[2]=(Playtime[2]+ 1)
        if(Trig_Playtime_Func002C())then
            set Playtime[2]= 0
            set Playtime[1]=(Playtime[1]+ 1)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger120 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger120,1.00)
        call TriggerAddAction(udg_trigger120,function Trig_Playtime_Actions)
    endfunction


endlibrary
