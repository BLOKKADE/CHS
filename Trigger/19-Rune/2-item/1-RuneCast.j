function Trig_RuneCast_Actions takes nothing returns nothing
    if Trig_Disable_Abilities_Func001C() == false then
        call ElementStartAbility(GetTriggerUnit(),GetSpellAbilityId())
    endif
endfunction

//===========================================================================
function InitTrig_RuneCast takes nothing returns nothing
    set gg_trg_RuneCast = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_RuneCast, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddAction( gg_trg_RuneCast, function Trig_RuneCast_Actions )
endfunction

