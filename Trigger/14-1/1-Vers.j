function Trig_Vers_Actions takes nothing returns nothing

call DisplayTextToPlayer(GetLocalPlayer(),0,0,    BlzGetUnitStringField(gg_unit_Edem_0012  ,ConvertUnitStringField('umdl')  ) )

    call RemoveUnit( gg_unit_Edem_0012 )
endfunction

//===========================================================================
function InitTrig_Vers takes nothing returns nothing
    set gg_trg_Vers = CreateTrigger(  )
    call TriggerAddAction( gg_trg_Vers, function Trig_Vers_Actions )
endfunction

