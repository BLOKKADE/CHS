function Trig_FixUnit_Actions takes nothing returns nothing



if GetUnitTypeId(GetTriggerUnit()) == 'N02K' then
    call BlzSetUnitSkin(GetTriggerUnit(),'nrvs')
endif


if GetUnitTypeId(GetTriggerUnit()) == 'N00Q' then
    call BlzSetUnitSkin(GetTriggerUnit(),'nfrl')
endif
endfunction

//===========================================================================
function InitTrig_FixUnit takes nothing returns nothing
    set gg_trg_FixUnit = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_FixUnit, GetEntireMapRect() )
    call TriggerAddAction( gg_trg_FixUnit, function Trig_FixUnit_Actions )
endfunction

