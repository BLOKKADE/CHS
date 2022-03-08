scope BoolexprInit initializer init
    globals
        conditionfunc PULV1
        conditionfunc PULV2
        conditionfunc AbsoluteIceFuncBool 
        conditionfunc AbsoluteColdBool
    endglobals



    function InitBoolExpr takes nothing returns nothing 

        //set PULV1 = Condition(function Trig_Pulverize_Func003Func004001003 )      
        //set PULV2 = Condition(function Trig_Pulverize_Func003Func005001003 )
        set AbsoluteIceFuncBool = Condition(function AbsoluteIceFunc )
        set AbsoluteColdBool = Condition(function AbsoluteColdFunc)
    endfunction


    function Trig_InitBoolx_Actions takes nothing returns nothing
        call InitBoolExpr()
        call InitDamageArea()
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventSingle( trg, 0.00 )
        call TriggerAddAction( trg, function Trig_InitBoolx_Actions )
        set trg = null
    endfunction
endscope