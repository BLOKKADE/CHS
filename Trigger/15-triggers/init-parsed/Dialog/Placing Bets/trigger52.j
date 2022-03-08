library trigger52 initializer init requires RandomShit

    function Trig_Eligible_Amount_Func003C takes nothing returns boolean
        if(not((udg_integer62 - udg_integer56)>((udg_integer62 - udg_integer56)- 5)))then
            return false
        endif
        return true
    endfunction


    function Trig_Eligible_Amount_Actions takes nothing returns nothing
        set udg_integer56 = 5
        //call ConditionalTriggerExecute(udg_trigger53)
        if(Trig_Eligible_Amount_Func003C())then
            set udg_integer62 = udg_integer56
        else
            set udg_integer62 =(udg_integer56 - 5)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger52 = CreateTrigger()
        call TriggerAddAction(udg_trigger52,function Trig_Eligible_Amount_Actions)
    endfunction


endlibrary
