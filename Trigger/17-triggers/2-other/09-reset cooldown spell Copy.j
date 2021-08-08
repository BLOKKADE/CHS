function Trig_reset_cooldown_spell_Copy_Conditions takes nothing returns boolean
    if   GetSpellAbilityId() == 'A024'   then
        return true
    endif
    return false
endfunction

function Trig_reset_cooldown_spell_Copy_Actions takes nothing returns nothing
    call UnitResetCooldown( GetTriggerUnit() )
    call DisableTrigger( GetTriggeringTrigger() )
    call IssueImmediateOrderBJ( GetTriggerUnit(), "scout" )
    call EnableTrigger( GetTriggeringTrigger() )
endfunction

//===========================================================================
function InitTrig_reset_cooldown_spell_Copy takes nothing returns nothing
    set gg_trg_reset_cooldown_spell_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_reset_cooldown_spell_Copy, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_reset_cooldown_spell_Copy, Condition( function Trig_reset_cooldown_spell_Copy_Conditions ) )
    call TriggerAddAction( gg_trg_reset_cooldown_spell_Copy, function Trig_reset_cooldown_spell_Copy_Actions )
endfunction

