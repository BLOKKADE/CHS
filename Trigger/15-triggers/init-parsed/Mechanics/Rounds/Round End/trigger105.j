library trigger105 initializer init requires RandomShit

    function Trig_Bonus_Exp_Conditions takes nothing returns boolean
        if(not(GetOwningPlayer(GetTriggerUnit())==Player(11)))then
            return false
        endif
        if(not(IsUnitIllusionBJ(GetTriggerUnit())!=true))then
            return false
        endif
        return true
    endfunction


    function Trig_Bonus_Exp_Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Bonus_Exp_Func001Func002001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Bonus_Exp_Func001Func002A takes nothing returns nothing
        local real bonus = 1
        //call BJDebugMsg("be xp bonus pre: " + R2S(bonus))
        set bonus = bonus + GetLearnabilityBonus(GetEnumUnit()) + GetMagicNecklaceBonus(GetEnumUnit(), GetTriggerUnit())
        //call BJDebugMsg("be xp bonus post: " + R2S(bonus))

        call AddHeroXPSwapped(R2I(((RoundCreepPower)* 55) * bonus),GetEnumUnit(),true)
    endfunction


    function Trig_Bonus_Exp_Func001Func001001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction


    function Trig_Bonus_Exp_Func001Func001A takes nothing returns nothing
        local real bonus = 1 
        //call BJDebugMsg("be xp bonus pre: " + R2S(bonus))
        set bonus = bonus + GetLearnabilityBonus(GetEnumUnit()) + GetMagicNecklaceBonus(GetEnumUnit(), GetTriggerUnit())
        //call BJDebugMsg("be xp bonus post: " + R2S(bonus))

        call AddHeroXPSwapped(R2I(((RoundCreepPower)* 35) * bonus),GetEnumUnit(),true)
    endfunction


    function Trig_Bonus_Exp_Actions takes nothing returns nothing
        if(Trig_Bonus_Exp_Func001C())then
            call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(GetKillingUnitBJ()),Condition(function Trig_Bonus_Exp_Func001Func002001002)),function Trig_Bonus_Exp_Func001Func002A)
        else
            call ForGroupBJ(GetUnitsOfPlayerMatching(GetOwningPlayer(GetKillingUnitBJ()),Condition(function Trig_Bonus_Exp_Func001Func001001002)),function Trig_Bonus_Exp_Func001Func001A)
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger105 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger105,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger105,Condition(function Trig_Bonus_Exp_Conditions))
        call TriggerAddAction(udg_trigger105,function Trig_Bonus_Exp_Actions)
    endfunction


endlibrary
