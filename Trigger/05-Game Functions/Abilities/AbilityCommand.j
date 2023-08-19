library AbilityCommand initializer init requires AbilityData, CastSpellOnTarget, DummySpell, Cooldown
    globals
        Table TriggerAbilityId
    endglobals

    function AbilityCommandAction takes nothing returns boolean
        local integer abilId = TriggerAbilityId[GetHandleId(GetTriggeringTrigger())]
        local unit u = GetTriggerUnit()
        local real manaCost = 0
        //call BJDebugMsg("cast: " + GetObjectName(abilId) + ", assoc: " + GetObjectName(GetOriginalSpellIfExists(u, abilId)))
        if HoldShift[GetPlayerId(GetOwningPlayer(u))] and BlzGetUnitAbilityCooldownRemaining(u, abilId) == 0 and  (not HasPlayerFinishedLevel(u, GetOwningPlayer(u))) then
            set manaCost = BlzGetUnitAbilityManaCost(u, abilId, GetUnitAbilityLevel(u, abilId) - 1)
            if GetUnitState(u, UNIT_STATE_MANA) >= manaCost then
                set abilId = GetOriginalSpellIfExists(u, abilId)
                
                //call IssueImmediateOrderById(u, 851972)
                if CastSpell(u, u, abilId, GetUnitAbilityLevel(u, abilId), GetAbilityOrderType(abilId), GetUnitX(u), GetUnitY(u)).activate() then
                    call SetCooldown(u, abilId, true)
                    call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - manaCost)
                endif
            endif
        endif

        return false
    endfunction

    function InitializeAbilityCommand takes unit u, integer abilId returns nothing
        local trigger t
        if (GetAbilityTargetType(abilId) == Target_Ally and GetAbilityOrderType(abilId) == Order_Target) or GetAbilityOrderType(abilId) == Order_Point then
            set t = CreateTrigger()
            set abilId = GetDummySpell(u, abilId)
            set TriggerAbilityId[GetHandleId(t)] = abilId
            //call BJDebugMsg("register: " + GetObjectName(abilId))
            call TriggerRegisterCommandEvent(t, abilId, OrderId2String(GetAbilityOrder(abilId)))
            call TriggerAddCondition(t, Condition(function AbilityCommandAction))
        endif
        set t = null
    endfunction

    private function init takes nothing returns nothing
        set TriggerAbilityId = Table.create()
    endfunction
endlibrary
