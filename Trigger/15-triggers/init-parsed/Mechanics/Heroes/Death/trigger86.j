library trigger86 initializer init requires RandomShit

    function Trig_Pandaren_Dies_Func001Func001C takes nothing returns boolean
        if(not(IsUnitDeadBJ(GetTriggerUnit())==true))then
            return false
        endif
        if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())=='N00R'))then
            return false
        endif
        return true
    endfunction


    function Trig_Pandaren_Dies_Func001Func002C takes nothing returns boolean
        if(not(IsUnitDeadBJ(GetTriggerUnit())==true))then
            return false
        endif
        if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())=='N00R'))then
            return false
        endif
        if(not(GetItemTypeId(GetManipulatedItem())=='ankh'))then
            return false
        endif
        return true
    endfunction


    function Trig_Pandaren_Dies_Func001C takes nothing returns boolean
        if(Trig_Pandaren_Dies_Func001Func001C())then
            return true
        endif
        if(Trig_Pandaren_Dies_Func001Func002C())then
            return true
        endif
        return false
    endfunction


    function Trig_Pandaren_Dies_Conditions takes nothing returns boolean
        if(not Trig_Pandaren_Dies_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Pandaren_Dies_Actions takes nothing returns nothing
        call ConditionalTriggerExecute(udg_trigger85)
        call PlaySoundOnUnitBJ(udg_sounds01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))],100,GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger86 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger86,EVENT_PLAYER_UNIT_DEATH)
        call TriggerRegisterAnyUnitEventBJ(udg_trigger86,EVENT_PLAYER_UNIT_DROP_ITEM)
        call TriggerAddCondition(udg_trigger86,Condition(function Trig_Pandaren_Dies_Conditions))
        call TriggerAddAction(udg_trigger86,function Trig_Pandaren_Dies_Actions)
    endfunction


endlibrary
