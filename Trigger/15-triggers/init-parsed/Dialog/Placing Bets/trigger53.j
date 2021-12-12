library trigger53 initializer init requires RandomShit

    function Trig_Eligible_Amount_Loop_Conditions takes nothing returns boolean
        if(not(udg_integer56 < udg_integer62))then
            return false
        endif
        return true
    endfunction


    function Trig_Eligible_Amount_Loop_Actions takes nothing returns nothing
        set udg_integer56 =(udg_integer56 + 5)
        call ConditionalTriggerExecute(GetTriggeringTrigger())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger53 = CreateTrigger()
        call TriggerAddCondition(udg_trigger53,Condition(function Trig_Eligible_Amount_Loop_Conditions))
        call TriggerAddAction(udg_trigger53,function Trig_Eligible_Amount_Loop_Actions)
    endfunction


endlibrary
