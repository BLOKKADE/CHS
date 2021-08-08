function Trig_FixUnit_Copy_Actions takes nothing returns nothing



if GetUnitTypeId(GetTriggerUnit()) == 'N02K' then
    call BlzSetUnitSkin(GetTriggerUnit(),'nrvs')
endif


if GetUnitTypeId(GetTriggerUnit()) == 'N00Q' then
    call BlzSetUnitSkin(GetTriggerUnit(),'nfrl')
endif
endfunction

//===========================================================================
function InitTrig_FixUnit_Copy takes nothing returns nothing
    set gg_trg_FixUnit_Copy = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_FixUnit_Copy, GetEntireMapRect() )
    call TriggerAddAction( gg_trg_FixUnit_Copy, function Trig_FixUnit_Copy_Actions )
endfunction

