library trigger36 initializer init requires RandomShit

    function Trig_Disable_Abilities_Func001Func003Func003Func003C takes nothing returns boolean
        if(not(IsUnitInGroup(GetTriggerUnit(),udg_group02)!=true))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(GetTriggerUnit()),udg_force03)==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Disable_Abilities_Func001Func003Func003C takes nothing returns boolean
        if((GetTriggerUnit()==udg_unit05))then
            return true
        endif
        if((RectContainsUnit(udg_rect09,GetTriggerUnit())==true))then
            return true
        endif
        if(Trig_Disable_Abilities_Func001Func003Func003Func003C())then
            return true
        endif
        return false
    endfunction


    function Trig_Disable_Abilities_Func001Func003C takes nothing returns boolean
        if(not(udg_boolean02==false))then
            return false
        endif
        if(not(udg_boolean03==false))then
            return false
        endif
        if(not Trig_Disable_Abilities_Func001Func003Func003C())then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='n00V'))then
            return false
        endif
        if(not(GetUnitTypeId(GetTriggerUnit())!='h015'))then
            return false
        endif	
        if(not(GetUnitTypeId(GetTriggerUnit())!='h014'))then
            return false
        endif		
        return true
    endfunction


    function Trig_Disable_Abilities_Func001C takes nothing returns boolean
        if(not Trig_Disable_Abilities_Func001Func003C())then
            return false
        endif
        return true
    endfunction


    function Trig_Disable_Abilities_Actions takes nothing returns nothing
        if(Trig_Disable_Abilities_Func001C(GetTriggerUnit()))then
            call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
            //call BJDebugMsg(GetUnitName(GetTriggerUnit()) +  "disable abilities stop")
        else
            //call ConditionalTriggerExecute(udg_trigger37)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger36 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger36,EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction(udg_trigger36,function Trig_Disable_Abilities_Actions)
    endfunction


endlibrary
