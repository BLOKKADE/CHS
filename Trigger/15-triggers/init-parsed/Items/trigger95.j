library trigger95 initializer init requires RandomShit

    function Trig_The_Divine_Source_Conditions takes nothing returns boolean
        if(not(GetItemTypeId(GetManipulatedItem())=='I043'))then
            return false
        endif
        return true
    endfunction


    function Trig_The_Divine_Source_Actions takes nothing returns nothing
        call CreateNUnitsAtLoc(1,'h015',GetOwningPlayer(GetTriggerUnit()),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(2.00,'BTLF',GetLastCreatedUnit())
        call UnitRemoveBuffBJ('Bena',GetTriggerUnit())
        call UnitRemoveBuffBJ('Bens',GetTriggerUnit())
        call UnitRemoveBuffBJ('Beng',GetTriggerUnit())
        call UnitRemoveBuffBJ('Bliq',GetTriggerUnit())
        call UnitRemoveBuffBJ('Bpoi',GetTriggerUnit())
        call UnitRemoveBuffBJ('Bpsd',GetTriggerUnit())
        call UnitAddAbilityBJ('Aadm',GetLastCreatedUnit())
        call IssueTargetOrderBJ(GetLastCreatedUnit(),"autodispel",GetTriggerUnit())
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger95 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger95,EVENT_PLAYER_UNIT_USE_ITEM)
        call TriggerAddCondition(udg_trigger95,Condition(function Trig_The_Divine_Source_Conditions))
        call TriggerAddAction(udg_trigger95,function Trig_The_Divine_Source_Actions)
    endfunction


endlibrary
