library trigger35 initializer init requires RandomShit

    function Trig_Wisp_Func001Func001C takes nothing returns boolean
        if(not(GetOwningPlayer(GetEnumUnit())==GetOwningPlayer(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func002C takes nothing returns boolean
        local location unitLocation = GetUnitLoc(GetEnumUnit())
        local location heroLocation = GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
        local boolean result = true

        if(not(DistanceBetweenPoints(unitLocation,heroLocation)>= 800.00))then
            set result = false
        endif

        call RemoveLocation(unitLocation)
        call RemoveLocation(heroLocation)
        set unitLocation = null
        set heroLocation = null
        return result
    endfunction


    function Trig_Wisp_Func001Func001Func002Func001C takes nothing returns boolean
        local location unitLocation = GetUnitLoc(GetEnumUnit())
        local location heroLocation = GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
        local boolean result = true

        if(not(DistanceBetweenPoints(unitLocation,heroLocation)<= 450.00))then
            set result = false
        endif

        call RemoveLocation(unitLocation)
        call RemoveLocation(heroLocation)
        set unitLocation = null
        set heroLocation = null
        return result
    endfunction


    function Trig_Wisp_Func001Func001Func003C takes nothing returns boolean
        if(not(GetUnitStateSwap(UNIT_STATE_MANA,GetEnumUnit())==GetUnitStateSwap(UNIT_STATE_MAX_MANA,GetEnumUnit())))then
            return false
        endif
        return true
    endfunction


    function Trig_Wisp_Func001Func001Func003Func001C takes nothing returns boolean
        local location unitLocation = GetUnitLoc(GetEnumUnit())
        local location heroLocation = GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
        local boolean result = true

        if(not(DistanceBetweenPoints(unitLocation,heroLocation)>= 200.00))then
            set result = false
        endif

        call RemoveLocation(unitLocation)
        call RemoveLocation(heroLocation)
        set unitLocation = null
        set heroLocation = null
        return result
    endfunction


    function Trig_Wisp_Func001A takes nothing returns nothing
        local location unitLocation = GetUnitLoc(GetEnumUnit())
        local location heroLocation = GetUnitLoc(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])

        if(Trig_Wisp_Func001Func001C())then
            if(Trig_Wisp_Func001Func001Func002C())then
                call AddSpecialEffectLocBJ(unitLocation,"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
                call SetUnitPositionLoc(GetEnumUnit(),heroLocation)
                call IssueImmediateOrderBJ(GetEnumUnit(),"stop")
                call AddSpecialEffectTargetUnitBJ("origin",GetEnumUnit(),"Abilities\\Spells\\NightElf\\FaerieDragonInvis\\FaerieDragon_Invis.mdl")
                call DestroyEffectBJ(GetLastCreatedEffectBJ())
            else
                if(Trig_Wisp_Func001Func001Func002Func001C())then
                    call SetUnitAbilityLevelSwapped('A01H',GetEnumUnit(),(GetHeroLevel(PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])/ 2))
                    call IssueTargetOrderBJ(GetEnumUnit(),"healingwave",PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer(GetEnumUnit()))])
                else
                endif
            endif
            if(Trig_Wisp_Func001Func001Func003C())then
                call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(heroLocation,GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
                call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
            else
                if(Trig_Wisp_Func001Func001Func003Func001C())then
                    call SetUnitMoveSpeed(GetEnumUnit(),(DistanceBetweenPoints(unitLocation,heroLocation)/ 2.00))
                    call IssuePointOrderLocBJ(GetEnumUnit(),"move",OffsetLocation(heroLocation,GetRandomReal(- 150.00,150.00),GetRandomReal(- 150.00,150.00)))
                    call SetUnitManaBJ(GetEnumUnit(),GetRandomReal(0,1.00))
                else
                    call SetUnitMoveSpeed(GetEnumUnit(),GetUnitDefaultMoveSpeed(GetEnumUnit()))
                endif
            endif
        else
        endif

        call RemoveLocation(unitLocation)
        call RemoveLocation(heroLocation)
        set unitLocation = null
        set heroLocation = null
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
