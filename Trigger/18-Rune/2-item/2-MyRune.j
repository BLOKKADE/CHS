function Trig_MyRune_Conditions takes nothing returns boolean
    if    GetSpellAbilityId() == 'A072'  and Trig_Disable_Abilities_Func001C() == false then
        call UnitAddItem(GetTriggerUnit(), CreateRandomRune(0,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),GetTriggerUnit() ))
        call UnitAddItem(GetTriggerUnit(), CreateRandomRune(0,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),GetTriggerUnit() ))   
        call UnitAddItem(GetTriggerUnit(), CreateRandomRune(0,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),GetTriggerUnit() ))    
    endif
    return false
endfunction



function InitTrig_MyRune takes nothing returns nothing
    set gg_trg_MyRune = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_MyRune, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_MyRune, Condition( function Trig_MyRune_Conditions ) )

endfunction

