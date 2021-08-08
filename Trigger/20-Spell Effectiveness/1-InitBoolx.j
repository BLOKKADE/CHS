globals
 conditionfunc PULV1
 conditionfunc PULV2
 conditionfunc AbsoluteIceFuncBool 
 conditionfunc AbsoluteColdBool
 
  conditionfunc HealingWave1
endglobals



function InitBoolExpr takes nothing returns nothing 

    set PULV1  =       Condition(function Trig_Pulverize_Func003Func004001003 )      
    set PULV2  =       Condition(function Trig_Pulverize_Func003Func005001003 )
    set AbsoluteIceFuncBool = Condition(function AbsoluteIceFunc )
    set AbsoluteColdBool = Condition(function AbsoluteColdFunc)
        set HealingWardBoolexpr = Condition(function HealingWardStartBoolexpr)
        
     set TranquilityBoolexpr = Condition(function     TranquilityStartBoolexpr)
    
    
    set HealingWave1 = Condition(function HealingWaveFunc)
endfunction


function Trig_InitBoolx_Actions takes nothing returns nothing
call InitBoolExpr()
call InitDamageArea()
endfunction

//===========================================================================
function InitTrig_InitBoolx takes nothing returns nothing
    set gg_trg_InitBoolx = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_InitBoolx, 0.00 )
    call TriggerAddAction( gg_trg_InitBoolx, function Trig_InitBoolx_Actions )
endfunction

