library trigger99 initializer init requires RandomShit

    function Trig_Add_Unit_Abilities_Func001001 takes nothing returns boolean
        return(udg_integer10==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func002001 takes nothing returns boolean
        return(udg_integer11==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func003001 takes nothing returns boolean
        return(udg_integer12==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func004001 takes nothing returns boolean
        return(udg_integer17==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func005001 takes nothing returns boolean
        return(udg_integer18==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func006001 takes nothing returns boolean
        return(udg_integer20==1)
    endfunction


    function Trig_Add_Unit_Abilities_Func007C takes nothing returns boolean
        if(not(udg_integer21==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func008C takes nothing returns boolean
        if(not(udg_integer23==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func009C takes nothing returns boolean
        if(not(udg_integer24==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func010C takes nothing returns boolean
        if(not(udg_integer25==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func011C takes nothing returns boolean
        if(not(udg_integer49==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func012C takes nothing returns boolean
        if(not(udg_integer50==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func013C takes nothing returns boolean
        if(not(udg_integer51==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func014C takes nothing returns boolean
        if(not(udg_integer54==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Add_Unit_Abilities_Func015C takes nothing returns boolean
        if(not(udg_integer55==1))then
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
            call AddUnitEvasion (GetLastCreatedUnit(),20) 
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
            call SetUnitAbilityLevel(GetLastCreatedUnit(), 'A08F', IMinBJ(R2I(udg_integer02 * 0.4), 30))
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
