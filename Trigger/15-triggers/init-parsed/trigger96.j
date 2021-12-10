library trigger96 initializer init requires RandomShit

    function Trig_Volcanic_Armor_Conditions takes nothing returns boolean
        if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03T')==true))then
            return false
        endif
        if(not(IsUnitEnemy(GetTriggerUnit(),GetOwningPlayer(GetAttacker()))==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Volcanic_Armor_Func003C takes nothing returns boolean
        if(not(udg_integer14 <= 15))then
            return false
        endif
        return true
    endfunction


    function Trig_Volcanic_Armor_Actions takes nothing returns nothing
        set udg_integer14 = GetRandomInt(1,100)
        if(Trig_Volcanic_Armor_Func003C())then
            call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            call UnitApplyTimedLifeBJ(5.00,'BTLF',GetLastCreatedUnit())
            call UnitAddAbilityBJ('A015',GetLastCreatedUnit())
            call IssueTargetOrderBJ(GetLastCreatedUnit(),"firebolt",GetAttacker())
        else
        endif
    endfunction


    function Trig_Xesils_Legacy_Conditions takes nothing returns boolean
        if(not(UnitHasItemOfTypeBJ(GetTriggerUnit(),'I03P')==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Xesils_Legacy_Func002C takes nothing returns boolean
        if(not(udg_integer14==1))then
            return false
        endif
        return true
    endfunction


    function Trig_Xesils_Legacy_Actions takes nothing returns nothing
        local unit U = GetTriggerUnit()
        local integer Ib = GetSpellAbilityId()
    
        set udg_integer14 = GetRandomInt(1,4)
        if(Trig_Xesils_Legacy_Func002C())then
            call TriggerSleepAction(0.00)	
            call BlzEndUnitAbilityCooldown(U,Ib)
            call AddSpecialEffectTargetUnitBJ("origin",U,"Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger96 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger96,EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddCondition(udg_trigger96,Condition(function Trig_Volcanic_Armor_Conditions))
        call TriggerAddAction(udg_trigger96,function Trig_Volcanic_Armor_Actions)
        /*set udg_trigger97=CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger97,EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddCondition(udg_trigger97,Condition(function Trig_Xesils_Legacy_Conditions))
        call TriggerAddAction(udg_trigger97,function Trig_Xesils_Legacy_Actions)*/
    endfunction


endlibrary
