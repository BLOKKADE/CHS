library trigger140 initializer init requires RandomShit

    function Trig_Sudden_Death_Damage_PvP_Conditions takes nothing returns boolean
        if ( not ( IsTriggerEnabled(udg_trigger141) == true ) ) then
            return false
        endif
        if ( not ( udg_integer39 >= 120 ) ) then
            return false
        endif
        return true
    endfunction


    function Trig_Sudden_Death_Damage_PvP_Actions takes nothing returns nothing
        set udg_real03 = udg_real03 * 1.1
        call PvpUpdateDeathTimerDisplay(udg_real03)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger140 = CreateTrigger()
        call DisableTrigger(udg_trigger140)
        call TriggerRegisterTimerEventPeriodic(udg_trigger140,1.25)
        call TriggerAddCondition(udg_trigger140,Condition(function Trig_Sudden_Death_Damage_PvP_Conditions))
        call TriggerAddAction(udg_trigger140,function Trig_Sudden_Death_Damage_PvP_Actions)
    endfunction


endlibrary
