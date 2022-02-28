library trigger101 initializer init requires RandomShit

    function Trig_Creep_AutoCast_Func001001002 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002002 takes nothing returns boolean
        return(GetUnitStateSwap(UNIT_STATE_MANA,GetFilterUnit())>= 10.00)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func001Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func001Func002Func002003001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func001C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A00V',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_HERO)==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002002 takes nothing returns boolean
        return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003001(),Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func002C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A01A',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002002 takes nothing returns boolean
        return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003001(),Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func003C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A00U',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003002 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func004Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func004Func002Func002003001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func004C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A00W',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002001 takes nothing returns boolean
        return(IsUnitAlly(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002002 takes nothing returns boolean
        return(GetUnitLifePercent(GetFilterUnit())<= 75.00)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func005Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func005Func002Func002003001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func005C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A00X',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001001(),Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003002 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func006Func002Func001003001003001(),Trig_Creep_AutoCast_Func001Func006Func002Func001003001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func006C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A013',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003002 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==GetOwningPlayer(GetEnumUnit()))
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003001(),Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001C takes nothing returns boolean
        if(not(UnitHasBuffBJ(GetEnumUnit(),'BOvd')!=true))then
            return false
        endif
        if(not(CountUnitsInGroup(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func007Func002Func001Func001Func002001001003)))> 1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002Func001C takes nothing returns boolean
        if(not Trig_Creep_AutoCast_Func001Func007Func002Func001Func001C())then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func007C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A018',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func001C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001001(),Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003002 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func008Func002Func002003001003001(),Trig_Creep_AutoCast_Func001Func008Func002Func002003001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func008C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A016',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002001 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_MAGIC_IMMUNE)!=true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002002 takes nothing returns boolean
        return(IsUnitType(GetFilterUnit(),UNIT_TYPE_GROUND)==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002001 takes nothing returns boolean
        return(IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002002 takes nothing returns boolean
        return(IsUnitVisible(GetFilterUnit(),GetOwningPlayer(GetEnumUnit()))==true)
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003001(),Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003002())
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001Func002C takes nothing returns boolean
        if(not(udg_boolean08==true))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002Func001C takes nothing returns boolean
        if(not(CountUnitsInGroup(GetUnitsInRangeOfLocMatching(250.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func009Func002Func001Func001001001003)))>= 1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009Func002C takes nothing returns boolean
        if(not(RoundCreepAbilCastChance==1))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001Func009C takes nothing returns boolean
        if(not(GetUnitAbilityLevelSwapped('A01B',GetEnumUnit())> 0))then
            return false
        endif
        return true
    endfunction
    
    function Trig_Creep_AutoCast_Func001A takes nothing returns nothing
    
        if (IsUnitAliveBJ(GetEnumUnit())==true) then
    
            if(Trig_Creep_AutoCast_Func001Func001C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func001Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func001Func002Func001C())then
                        call SetUnitAbilityLevelSwapped('A00V',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A00V',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssueTargetOrderBJ(GetEnumUnit(),"manaburn",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(300.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func001Func002Func002003001003))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func002C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func002Func002C())then
                    call IssuePointOrderLocBJ(GetEnumUnit(),"blink",OffsetLocation(GetUnitLoc(GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func002Func002Func001003001001001003)))),GetRandomReal(- 100.00,100.00),GetRandomReal(- 100.00,100.00)))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func003C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func003Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func003Func002Func001C())then
                        call SetUnitAbilityLevelSwapped('A00U',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A00U',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssuePointOrderLocBJ(GetEnumUnit(),"shockwave",GetUnitLoc(GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func003Func002Func002003001001003)))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func004C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func004Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func004Func002Func001C())then
                        call SetUnitAbilityLevelSwapped('A00W',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A00W',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssueTargetOrderBJ(GetEnumUnit(),"creepthunderbolt",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(800.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func004Func002Func002003001003))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func005C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func005Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func005Func002Func001C())then
                        call SetUnitAbilityLevelSwapped('A00X',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A00X',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssueTargetOrderBJ(GetEnumUnit(),"rejuvination",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(400.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func005Func002Func002003001003))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func006C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func006Func002C())then
                    call IssueTargetOrderBJ(GetEnumUnit(),"slow",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(600.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func006Func002Func001003001003))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func007C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func007Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func007Func002Func001C())then
                        call IssueImmediateOrderBJ(GetEnumUnit(),"voodoo")
                    else
                    endif
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func008C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func008Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func008Func002Func001C())then
                        call SetUnitAbilityLevelSwapped('A016',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                    else
                        call SetUnitAbilityLevelSwapped('A016',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                    endif
                    call IssueTargetOrderBJ(GetEnumUnit(),"faeriefire",GroupPickRandomUnit(GetUnitsInRangeOfLocMatching(700.00,GetUnitLoc(GetEnumUnit()),Condition(function Trig_Creep_AutoCast_Func001Func008Func002Func002003001003))))
                else
                endif
            else
            endif
            if(Trig_Creep_AutoCast_Func001Func009C())then
                set RoundCreepAbilCastChance = GetRandomInt(1,5)
                if(Trig_Creep_AutoCast_Func001Func009Func002C())then
                    if(Trig_Creep_AutoCast_Func001Func009Func002Func001C())then
                        if(Trig_Creep_AutoCast_Func001Func009Func002Func001Func002C())then
                            call SetUnitAbilityLevelSwapped('A01B',GetEnumUnit(),((RoundNumber * 4)/ RoundCreepNumber))
                        else
                            call SetUnitAbilityLevelSwapped('A01B',GetEnumUnit(),(((RoundNumber * 4)/ RoundCreepNumber)/ 2))
                        endif
                        call IssueImmediateOrderBJ(GetEnumUnit(),"thunderclap")
                    else
                    endif
                else
                endif
            else
            endif
        endif
    endfunction
    
    function Trig_Creep_AutoCast_Actions takes nothing returns nothing
        local group GRP = GetUnitsOfPlayerMatching(Player(11),null)
        call ForGroupBJ(GRP,function Trig_Creep_AutoCast_Func001A)
        call DestroyGroup(GRP)
        set GRP = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger101 = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(udg_trigger101,1.00)
        call TriggerAddAction(udg_trigger101,function Trig_Creep_AutoCast_Actions)
    endfunction


endlibrary
