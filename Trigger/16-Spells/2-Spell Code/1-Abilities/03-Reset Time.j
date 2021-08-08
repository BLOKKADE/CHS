function Trig_Reset_Time_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A024'
endfunction

function Trig_Reset_Time_Actions takes nothing returns nothing
    local unit u = GetTriggerUnit()
    local real cd = 245 - (5 * GetUnitAbilityLevel(u, 'A024'))
    call UnitResetCooldown(GetTriggerUnit())
    call AbilStartCD(GetTriggerUnit(), 'A024', cd)
endfunction

//===========================================================================
function InitTrig_Reset_Time takes nothing returns nothing
    set gg_trg_Reset_Time = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Reset_Time, EVENT_PLAYER_UNIT_SPELL_FINISH )
    call TriggerAddCondition( gg_trg_Reset_Time, Condition( function Trig_Reset_Time_Conditions ) )
    call TriggerAddAction( gg_trg_Reset_Time, function Trig_Reset_Time_Actions )
endfunction

