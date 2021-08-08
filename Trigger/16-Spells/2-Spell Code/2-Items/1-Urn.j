function Trig_Urn_Conditions takes nothing returns boolean
    return GetSpellAbilityId() == 'A044'
endfunction

function Trig_Urn_Actions takes nothing returns nothing
    if Trig_Disable_Abilities_Func001C() == false then
        call StartFunctionSpell(GetTriggerUnit(),6)
    endif
endfunction

//===========================================================================
function InitTrig_Urn takes nothing returns nothing
    set gg_trg_Urn = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Urn, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddCondition( gg_trg_Urn, Condition( function Trig_Urn_Conditions ) )
    call TriggerAddAction( gg_trg_Urn, function Trig_Urn_Actions )
endfunction

