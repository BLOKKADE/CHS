library trigger16 initializer init requires RandomShit

    function Trig_Faerie_Dragon_or_Wisp_Dies_Func002C takes nothing returns boolean
        /*if((GetUnitTypeId(GetTriggerUnit())=='e001'))then
            return true
        endif*/
        if((GetUnitTypeId(GetTriggerUnit())=='e003'))then
            return true
        endif
        return false
    endfunction


    function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions takes nothing returns boolean
        if(not Trig_Faerie_Dragon_or_Wisp_Dies_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Faerie_Dragon_or_Wisp_Dies_Actions takes nothing returns nothing
        local location unitLocation = GetUnitLoc(GetTriggerUnit())
        call CreateNUnitsAtLoc(1,GetUnitTypeId(GetTriggerUnit()),GetOwningPlayer(GetTriggerUnit()),unitLocation,GetUnitFacing(GetTriggerUnit()))
        call RemoveLocation(unitLocation)
        set unitLocation = null
    endfunction


    private function init takes nothing returns nothing
        set HeroPassivePetDeathTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(HeroPassivePetDeathTrigger,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(HeroPassivePetDeathTrigger,Condition(function Trig_Faerie_Dragon_or_Wisp_Dies_Conditions))
        call TriggerAddAction(HeroPassivePetDeathTrigger,function Trig_Faerie_Dragon_or_Wisp_Dies_Actions)
    endfunction


endlibrary
