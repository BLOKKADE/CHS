library trigger32 initializer init requires RandomShit

    function Trig_Summon_Quilbeast_Func001C takes nothing returns boolean
        if((GetUnitTypeId(GetTriggerUnit())=='nqb1'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='nqb2'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='nqb3'))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='nqb4'))then
            return true
        endif
        return false
    endfunction


    function Trig_Summon_Quilbeast_Conditions takes nothing returns boolean
        if(not Trig_Summon_Quilbeast_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Summon_Quilbeast_Func003Func001C takes nothing returns boolean
        if(not(GetUnitTypeId(GetTriggerUnit())=='nqb4'))then
            return false
        endif
        if(not(GetUnitAbilityLevelSwapped('Arsq',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])> 4))then
            return false
        endif
        return true
    endfunction


    function Trig_Summon_Quilbeast_Func003C takes nothing returns boolean
        if(not Trig_Summon_Quilbeast_Func003Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Summon_Quilbeast_Actions takes nothing returns nothing
        call SetUnitAbilityLevelSwapped('Aspo',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arsq',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 0))
        if(Trig_Summon_Quilbeast_Func003C())then
            call SetUnitAbilityLevelSwapped('A000',GetTriggerUnit(),(GetUnitAbilityLevelSwapped('Arsq',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])+ 2))
            set bj_forLoopBIndex = 1
            set bj_forLoopBIndexEnd =((GetUnitAbilityLevelSwapped('Arsq',udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))])- 4)* 1)
            loop
                exitwhen bj_forLoopBIndex > bj_forLoopBIndexEnd
                call UnitAddItemByIdSwapped('I01B',GetTriggerUnit())
                set bj_forLoopBIndex = bj_forLoopBIndex + 1
            endloop
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger32 = CreateTrigger()
        call TriggerRegisterEnterRectSimple(udg_trigger32,GetPlayableMapRect())
        call TriggerAddCondition(udg_trigger32,Condition(function Trig_Summon_Quilbeast_Conditions))
        call TriggerAddAction(udg_trigger32,function Trig_Summon_Quilbeast_Actions)
    endfunction


endlibrary
