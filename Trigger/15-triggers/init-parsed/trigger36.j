library trigger36 initializer init requires RandomShit

    function Trig_Disable_Abilities_Actions takes nothing returns nothing
        if(Trig_Disable_Abilities_Func001C(GetTriggerUnit()))then
            call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
            //call BJDebugMsg(GetUnitName(GetTriggerUnit()) +  "disable abilities stop")
        else
            //call ConditionalTriggerExecute(udg_trigger37)
        endif
    endfunction


    function Trig_Cast_Channeling_Ability_Func001Func002C takes nothing returns boolean
        local integer abilId = GetSpellAbilityId()
        return abilId == 'AHbz' or abilId == 'ANrf' or abilId == 'ANst' or abilId == 'ANvc' or abilId == 'AEtq' or abilId == 'Aclf' or abilId == 'ANmo' or abilId == 'AEsf'
    endfunction


    function Trig_Cast_Channeling_Ability_Func001C takes nothing returns boolean
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not Trig_Cast_Channeling_Ability_Func001Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Cast_Channeling_Ability_Conditions takes nothing returns boolean
        if(not Trig_Cast_Channeling_Ability_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Cast_Channeling_Ability_Actions takes nothing returns nothing
        local integer order = GetUnitCurrentOrder(GetTriggerUnit())
        local location spellLoc = GetSpellTargetLoc()
        local integer abilId = GetSpellAbilityId()
        local real manaCost = BlzGetAbilityManaCost(abilId, GetUnitAbilityLevel(GetTriggerUnit(), abilId))
        if GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) - manaCost > 0 then
            if abilId != 'AEtq' and abilId != 'AEsf'then
                call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),PolarProjectionBJ(GetSpellTargetLoc(),256.00,AngleBetweenPoints(GetSpellTargetLoc(),GetUnitLoc(GetTriggerUnit()))),bj_UNIT_FACING)
            else
                call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            endif
    
            call UnitApplyTimedLifeBJ(60.00,'BTLF',GetLastCreatedUnit())
            call UnitAddAbilityBJ(GetSpellAbilityId(),GetLastCreatedUnit())
            call SetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetLastCreatedUnit(),GetUnitAbilityLevelSwapped(GetSpellAbilityId(),GetTriggerUnit()))
    
            if order == 852183 or order == 852184 then
                call IssueImmediateOrderById(GetLastCreatedUnit(), order)
            else
                call IssuePointOrderById(GetLastCreatedUnit(), order, GetLocationX(spellLoc), GetLocationY(spellLoc))
            endif
            /*
            if GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"blizzard",GetSpellTargetLoc())
            elseif GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"rainoffire",GetSpellTargetLoc())
            elseif GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"stampede",GetSpellTargetLoc())
            elseif GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"volcano",GetSpellTargetLoc())
            elseif GetSpellAbilityId()=='ANmo' then
                call IssueImmediateOrderBJ(GetLastCreatedUnit(),"tranquility")
            elseif GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"cloudoffog",GetSpellTargetLoc())
            elseif GetSpellAbilityId()=='ANmo' then
                call IssuePointOrderLocBJ(GetLastCreatedUnit(),"monsoon",GetSpellTargetLoc())
            elseif 
            endif
            */
            call TriggerSleepAction(0.00)
            call IssueImmediateOrderBJ(GetTriggerUnit(),"stop")
            call SetUnitAnimation(GetTriggerUnit(),"spell")
            call QueueUnitAnimationBJ(GetTriggerUnit(),"stand")
            call SetUnitState(GetTriggerUnit(), UNIT_STATE_MANA, GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) - manaCost)
            call AbilStartCD(GetTriggerUnit(), abilId, BlzGetUnitAbilityCooldown(GetTriggerUnit(), abilId, GetUnitAbilityLevel(GetTriggerUnit(), abilId)))
        endif
        call RemoveLocation(spellLoc)
        set spellLoc = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger36 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger36,EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction(udg_trigger36,function Trig_Disable_Abilities_Actions)
        /*set udg_trigger37=CreateTrigger()
        call TriggerAddCondition(udg_trigger37,Condition(function Trig_Cast_Channeling_Ability_Conditions))
        call TriggerAddAction(udg_trigger37,function Trig_Cast_Channeling_Ability_Actions)*/
    endfunction


endlibrary
