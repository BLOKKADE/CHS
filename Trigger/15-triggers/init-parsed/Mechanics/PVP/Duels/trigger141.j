library trigger141 initializer init requires RandomShit

    function Trig_Sudden_Death_Timer_PvP_Func002C takes nothing returns boolean
        if(not(udg_integer39 >= 240))then
            return false
        endif
        return true
    endfunction


    function Trig_Sudden_Death_Timer_PvP_Actions takes nothing returns nothing
        set udg_integer39 =(udg_integer39 + 1)
        if(Trig_Sudden_Death_Timer_PvP_Func002C())then
            call DisableTrigger(udg_trigger11)
            call DisableTrigger(udg_trigger26)
            call CreateNUnitsAtLoc(1,'n00V',GetOwningPlayer(udg_units03[1]),GetUnitLoc(udg_units03[1]),bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
            call UnitDamageTargetBJ(GetLastCreatedUnit(),udg_units03[2],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,udg_units03[2])* udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
            call CreateNUnitsAtLoc(1,'n00V',GetOwningPlayer(udg_units03[2]),GetUnitLoc(udg_units03[2]),bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
            call UnitDamageTargetBJ(GetLastCreatedUnit(),udg_units03[1],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,udg_units03[1])* udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
            call EnableTrigger(udg_trigger11)
            call EnableTrigger(udg_trigger26)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger141 = CreateTrigger()
        call DisableTrigger(udg_trigger141)
        call TriggerRegisterTimerEventPeriodic(udg_trigger141,0.25)
        call TriggerAddAction(udg_trigger141,function Trig_Sudden_Death_Timer_PvP_Actions)
    endfunction


endlibrary
