library trigger141 initializer init requires RandomShit, HpRegen

    function Trig_Sudden_Death_Timer_PvP_Func002C takes nothing returns boolean
        if(not(udg_integer39 >= 120))then
            return false
        endif
        return true
    endfunction


    function Trig_Sudden_Death_Timer_PvP_Actions takes nothing returns nothing
        local location hero1Location
        local location hero2Location
        local real reg1 = 0
        local real reg2 = 0

        set udg_integer39 =(udg_integer39 + 1)
        if(Trig_Sudden_Death_Timer_PvP_Func002C())then
            set hero1Location = GetUnitLoc(DuelingHeroes[1])
            set hero2Location = GetUnitLoc(DuelingHeroes[2])
            set reg1 = GetUnitTotalHpRegen(DuelingHeroes[1])
            set reg2 = GetUnitTotalHpRegen(DuelingHeroes[2])

            call DisableTrigger(udg_trigger11)
            call DisableTrigger(udg_trigger26)
            call CreateNUnitsAtLoc(1,SUDDEN_DEATH_UNIT_ID,GetOwningPlayer(DuelingHeroes[1]),hero1Location,bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
            call UnitDamageTargetBJ(GetLastCreatedUnit(),DuelingHeroes[2],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,DuelingHeroes[2])* udg_real03/2 + reg2/2 + 5 * udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
            call CreateNUnitsAtLoc(1,SUDDEN_DEATH_UNIT_ID,GetOwningPlayer(DuelingHeroes[2]),hero2Location,bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(0.25,'BTLF',GetLastCreatedUnit())
            call UnitDamageTargetBJ(GetLastCreatedUnit(),DuelingHeroes[1],(GetUnitStateSwap(UNIT_STATE_MAX_LIFE,DuelingHeroes[1])* udg_real03/2 + reg1/2 + 5 * udg_real03),ATTACK_TYPE_CHAOS,DAMAGE_TYPE_UNIVERSAL)
            call EnableTrigger(udg_trigger11)
            call EnableTrigger(udg_trigger26)

            call RemoveLocation(hero1Location)
            call RemoveLocation(hero2Location)
            set hero1Location = null
            set hero2Location = null
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
