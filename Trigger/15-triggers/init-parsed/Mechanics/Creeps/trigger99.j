library trigger99 initializer init requires RandomShit

    function Trig_Add_Unit_Abilities_Func001001 takes nothing returns boolean
        return(RoundCreepChanceBash==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func002001 takes nothing returns boolean
        return(RoundCreepChanceCritStrike==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func003001 takes nothing returns boolean
        return(RoundCreepChanceEvasion==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func004001 takes nothing returns boolean
        return(RoundCreepChanceCleave==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func005001 takes nothing returns boolean
        return(RoundCreepChanceLifesteal==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func006001 takes nothing returns boolean
        return(RoundCreepChanceThorns==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func007C takes nothing returns boolean
        if(not(RoundCreepChanceShockwave==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func008C takes nothing returns boolean
        if(not(RoundCreepChanceManaBurn==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func009C takes nothing returns boolean
        if(not(RoundCreepChanceHurlBoulder==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func010C takes nothing returns boolean
        if(not(RoundCreepChanceRejuv==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func011C takes nothing returns boolean
        if(not(RoundCreepChanceSlow==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func012C takes nothing returns boolean
        if(not(RoundCreepChanceBigBadV==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func013C takes nothing returns boolean
        if(not(RoundCreepChanceFaerieFire==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func014C takes nothing returns boolean
        if(not(RoundCreepChanceBlink==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func015C takes nothing returns boolean
        if(not(RoundCreepChanceThunderClap==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Actions takes nothing returns nothing
        if(Trig_Add_Unit_Abilities_Func001001())then
            call UnitAddAbilityBJ('ACbh',GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func002001())then
            call UnitAddAbilityBJ('AOcr',GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func003001())then
            call AddUnitCustomState(GetLastCreatedUnit(), BONUS_EVASION, 20)
            //	call UnitAddAbilityBJ('ACev',GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func004001())then
            call UnitAddAbilityBJ('ACce',GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func005001())then
            call UnitAddAbilityBJ('SCva',GetLastCreatedUnit())
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func006001())then
            call UnitAddAbilityBJ('A08F',GetLastCreatedUnit())
            call SetUnitAbilityLevel(GetLastCreatedUnit(), 'A08F', IMinBJ(R2I(RoundNumber * 0.4), 30))
        else
            call DoNothing()
        endif
        if(Trig_Add_Unit_Abilities_Func007C())then
        else
            call UnitRemoveAbilityBJ('A00U',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func008C())then
        else
            call UnitRemoveAbilityBJ('A00V',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func009C())then
        else
            call UnitRemoveAbilityBJ('A00W',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func010C())then
        else
            call UnitRemoveAbilityBJ('A00X',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func011C())then
        else
            call UnitRemoveAbilityBJ('A013',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func012C())then
        else
            call UnitRemoveAbilityBJ('A018',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func013C())then
        else
            call UnitRemoveAbilityBJ('A016',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func014C())then
        else
            call UnitRemoveAbilityBJ('A01A',GetLastCreatedUnit())
        endif
        if(Trig_Add_Unit_Abilities_Func015C())then
        else
            call UnitRemoveAbilityBJ('A01B',GetLastCreatedUnit())
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger99 = CreateTrigger()
        call TriggerAddAction(udg_trigger99,function Trig_Add_Unit_Abilities_Actions)
    endfunction


endlibrary
