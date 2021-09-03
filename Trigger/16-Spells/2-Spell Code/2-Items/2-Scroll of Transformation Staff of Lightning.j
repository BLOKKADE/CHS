globals

    hashtable HT_it = InitHashtable()
endglobals

function EndTimerTr takes nothing returns nothing
    local timer Tr = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT_it,GetHandleId(Tr),1)
    local integer i1 = LoadInteger(HT_it,GetHandleId(Tr),2)
    local integer i2 = LoadInteger(HT_it,GetHandleId(Tr),3)
    
    call SetHeroAgi(u,GetHeroAgi(u,false)+i1,false)
    call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0) - i2 ,0) 
    
    
    
    call FlushChildHashtable(HT_it,GetHandleId(Tr))
    call ReleaseTimer(Tr)
    set Tr = null
    set u = null
endfunction

function Trig_Scroll_of_Transformation_Staff_of_Lightning_Actions takes nothing returns nothing
local timer Tr = null
local integer i1 = 0
local integer i2 = 0
local unit u =  GetTriggerUnit()

if GetSpellAbilityId() == 'A03B' then

        
call BlzSetAbilityRealLevelField( GetSpellAbility(),ConvertAbilityRealLevelField('Ocl1'),0,  GetHeroInt(u,true)*5 )



elseif   GetSpellAbilityId() == 'A049' and  Trig_Disable_Abilities_Func001C() == false then

    set i1 = GetHeroAgi(u,true)*3
    set i2 = i1 * 2
    
    call SetHeroAgi(u,GetHeroAgi(u,false)-i1,false)
    call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0) + i2 ,0)

     set Tr = NewTimer()
     call SaveUnitHandle(HT_it,GetHandleId(Tr),1,u)
     call SaveInteger(HT_it,GetHandleId(Tr),2,i1)
     call SaveInteger(HT_it,GetHandleId(Tr),3,i2)
     call TimerStart(Tr,15,false,function EndTimerTr )
     
     set Tr = null

endif

    set u = null
endfunction

//===========================================================================
function InitTrig_Scroll_of_Transformation_Staff_of_Lightning takes nothing returns nothing
    set gg_trg_Scroll_of_Transformation_Staff_of_Lightning = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Scroll_of_Transformation_Staff_of_Lightning, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddAction( gg_trg_Scroll_of_Transformation_Staff_of_Lightning, function Trig_Scroll_of_Transformation_Staff_of_Lightning_Actions )
endfunction

