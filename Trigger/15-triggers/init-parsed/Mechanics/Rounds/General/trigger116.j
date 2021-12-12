library trigger116 initializer init requires RandomShit

    function Trig_AntiStuck_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction

    function Trig_AntiStuck_Func002Func001Func005Func001001001002001 takes nothing returns boolean
        return (IsUnitAliveBJ(GetFilterUnit())==true) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0
    endfunction
    
    function Trig_AntiStuck_Func002Func001Func005Func001001001002002 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction
    
    function Trig_AntiStuck_Func002Func001Func005Func001001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_AntiStuck_Func002Func001Func005Func001001001002001(),Trig_AntiStuck_Func002Func001Func005Func001001001002002())
    endfunction

    function Trig_AntiStuck_Func002Func001Func005C takes nothing returns boolean
        if((CountUnitsInGroup(GetUnitsInRectMatching(udg_rects01[udg_integer27],Condition(function Trig_AntiStuck_Func002Func001Func005Func001001001002))) != 0))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(udg_units01[udg_integer27]),udg_force02)!=true))then
            return false
        endif
        if(not(IsPlayerInForce(GetOwningPlayer(udg_units01[udg_integer27]),udg_force03)!=true))then
            return false
        endif
        if(not(udg_units01[udg_integer27]!=null))then
            return false
        endif
        return true
    endfunction


    function Trig_AntiStuck_Func002Func001C takes nothing returns boolean
        if(not Trig_AntiStuck_Func002Func001Func005C())then
            return false
        endif
        return true
    endfunction


    function Trig_AntiStuck_Actions takes nothing returns nothing
        set udg_integer27 = 1
        loop
            exitwhen udg_integer27 > 8
            if RectContainsUnit(udg_rect09, udg_units01[udg_integer27]) and CountUnitsInGroup(GetUnitsInRectMatching(udg_rects01[udg_integer27],Condition(function Trig_AntiStuck_Func002Func001Func005Func001001001002))) != 0 then
                call ForGroupBJ(GetUnitsInRectMatching(udg_rects01[udg_integer27],Condition( function Trig_Hero_Dies_Func024Func001Func0010010025551) ),function Trig_Hero_Dies_Func024Func001Func001A111a)
            endif
    
            if(Trig_AntiStuck_Func002Func001C())then
                call CreateNUnitsAtLoc(1,'n00T',Player(11),GetRectCenter(udg_rects01[udg_integer27]),bj_UNIT_FACING)
                call SuspendHeroXPBJ(false,udg_units01[udg_integer27])
                call UnitDamageTargetBJ(udg_units01[udg_integer27],GetLastCreatedUnit(),500,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL)
                call SuspendHeroXPBJ(true,udg_units01[udg_integer27])
            endif
    
            set udg_integer27 = udg_integer27 + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger116 = CreateTrigger()
        call DisableTrigger(udg_trigger116)
        call TriggerRegisterTimerEventPeriodic(udg_trigger116,0.50)
        call TriggerAddCondition(udg_trigger116,Condition(function Trig_AntiStuck_Conditions))
        call TriggerAddAction(udg_trigger116,function Trig_AntiStuck_Actions)
    endfunction


endlibrary
