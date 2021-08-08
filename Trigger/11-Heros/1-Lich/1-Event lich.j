globals

hashtable DataUnitHT = InitHashtable()

endglobals


function Trig_Event_lich_Actions takes nothing returns nothing


if  GetUnitTypeId(GetTriggerUnit()) == 'H018' and IsUnitIllusion(GetTriggerUnit()) != true then

 call SaveEffectHandle(DataUnitHT,GetHandleId(GetTriggerUnit()),1,AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl", GetTriggerUnit(), "hand left") )
 call SaveEffectHandle(DataUnitHT,GetHandleId(GetTriggerUnit()),2,AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl", GetTriggerUnit(), "hand right") )
 call SaveInteger(DataUnitHT,GetHandleId(GetTriggerUnit()),3,1)

endif



endfunction




function EndLichTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(DataUnitHT,GetHandleId(t),1)
    
    
  call SaveEffectHandle(DataUnitHT,GetHandleId(u),1,AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl", u, "hand left") )
  call SaveEffectHandle(DataUnitHT,GetHandleId(u),2,AddSpecialEffectTarget("Abilities\\Spells\\Items\\AIob\\AIobTarget.mdl",u, "hand right") )   
  call SaveInteger(DataUnitHT,GetHandleId(u),3,1)  
  
  call FlushChildHashtable(DataUnitHT,GetHandleId(t))
  
  call DestroyTimer(t)
  set t = null
  set u = null


endfunction



//===========================================================================
function InitTrig_Event_lich takes nothing returns nothing
    set gg_trg_Event_lich = CreateTrigger(  )
    call TriggerRegisterEnterRectSimple( gg_trg_Event_lich, GetEntireMapRect() )
    call TriggerAddAction( gg_trg_Event_lich, function Trig_Event_lich_Actions )
endfunction

