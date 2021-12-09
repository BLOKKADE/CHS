library trigger30 initializer init requires RandomShit

    function Trig_Summon_Bear_Conditions takes nothing returns boolean
        if(not Trig_Summon_Bear_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Summon_Bear_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('ANsg',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 2))
        set bj_forLoopBIndex = 1
        set bj_forLoopBIndexEnd =((GetUnitAbilityLevelSwapped('ANsg',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 4)* 2)
        loop
            exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
            call UnitAddItemByIdSwapped('I022',GetTriggerUnit())
            set bj_forLoopBIndex = bj_forLoopBIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger30 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger30,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger30,Condition(function Trig_Summon_Bear_Conditions))
        call TriggerAddAction(udg_trigger30,function Trig_Summon_Bear_Actions)
    endfunction


endlibrary
