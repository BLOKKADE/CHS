library trigger16 initializer init requires RandomShit

    function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions takes nothing returns boolean
        if(not Trig_Faerie_Dragon_or_Wisp_Dies_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Faerie_Dragon_or_Wisp_Dies_Actions takes nothing returns nothing
        call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),GetUnitFacing(GetTriggerUnit()))
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger16 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger16,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger16,Condition(function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions))
        call TriggerAddAction(udg_trigger16,function Trig_Faerie_Dragon_or_Wisp_Dies_Actions)
    endfunction


endlibrary
