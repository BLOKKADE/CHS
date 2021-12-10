library trigger35 initializer init requires RandomShit

    function Trig_Wisp_Func001Func001C takes nothing returns boolean
        if(not(GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func002C takes nothing returns boolean
        if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 800.00))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func002Func001C takes nothing returns boolean
        if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))<= 450.00))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func003C takes nothing returns boolean
        if(not(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())==GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func003Func001C takes nothing returns boolean
        if(not(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))>= 200.00))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001A takes nothing returns nothing
        if(Trig_Wisp_Func001Func001C())then
            if(Trig_Wisp_Func001Func001Func002C())then
                call AddSpecialEffectLocBJ(GetUnitLoc(GetEnumUnit()),"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call SetUnitPositionLoc(GetEnumUnit(),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))
                call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
                call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
            else
                if(Trig_Wisp_Func001Func001Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A01H',GetEnumUnit(),(GetHeroLevel(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 2))
                    call IssueTargetOrderBJ(GetEnumUnit(),"healingwave",udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
                else
                endif
            endif
            if(Trig_Wisp_Func001Func001Func003C())then
                call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
                call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
            else
                if(Trig_Wisp_Func001Func001Func003Func001C())then
                    call SetUnitMoveSpeed(GetEnumUnit(),(DistanceBetweenPoints(GetUnitLoc(GetEnumUnit()),GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]))/ 2.00))
                    call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(GetUnitLoc(udg_units01[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))]),GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
                    call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
                else
                    call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
                endif
            endif
        else
        endif
    endfunction


    function Trig_Wisp_Actions takes nothing returns nothing
        local group GRP = GetUnitsOfTypeIdAll('e003')
        call ForGroupBJ(GRP,function Trig_Wisp_Func001A)
        call DestroyGroup(GRP)
        set GRP = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger35 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger35,1.00)
        call TriggerAddAction(udg_trigger35,function Trig_Wisp_Actions)
    endfunction


endlibrary
