library trigger102 initializer init requires RandomShit

    function Trig_Creep_Dies_Conditions takes nothing returns boolean
        if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
            return false
        endif
        if(not(GetOwningPlayer(GetKillingUnitBJ())!=Player(11)))then
            return false
        endif
        if(not(GetKillingUnitBJ()!=null))then
            return false
        endif
        return true
    endfunction


    function Trig_Creep_Dies_Actions takes nothing returns nothing
        call CreepDeath_Death(GetTriggerUnit(), PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnit()))])
        call TriggerSleepAction(0.00)
        call SetUnitOwner(GetTriggerUnit(),Player(PLAYER_NEUTRAL_PASSIVE),false)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger102 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger102,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger102,Condition(function Trig_Creep_Dies_Conditions))
        call TriggerAddAction(udg_trigger102,function Trig_Creep_Dies_Actions)
    endfunction


endlibrary
