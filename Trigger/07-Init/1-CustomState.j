globals
    hashtable HT_unitstate = InitHashtable()
endglobals

function SetUnitMagicDmg takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,r)
endfunction

function GetUnitMagicDmg takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),1)
endfunction

function AddUnitMagicDmg takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,LoadReal(HT_unitstate,GetHandleId(u),1)+r)
endfunction

function SetUnitMagicDef takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),2,r)
endfunction


function GetUnitMagicDef takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),2)
endfunction

function AddUnitMagicDef takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),2,LoadReal(HT_unitstate,GetHandleId(u),2)+r)
endfunction



function SetUnitEvasion takes unit u,real r returns nothing
    call BlzSetAbilityRealLevelField(BlzGetUnitAbility(u,'A057'),ABILITY_RLF_CHANCE_TO_EVADE_EEV1,0,1-(50/(50+r)) )
    call SaveReal(HT_unitstate,GetHandleId(u),3,r)
endfunction


function AddUnitEvasion takes unit u,real r returns nothing
    set r =  LoadReal(HT_unitstate,GetHandleId(u),3)+r
    call BlzSetAbilityRealLevelField(BlzGetUnitAbility(u,'A057'),ABILITY_RLF_CHANCE_TO_EVADE_EEV1,0,1-(50/(50+r)) )
    call SaveReal(HT_unitstate,GetHandleId(u),3,r)    
endfunction


function GetUnitEvasion takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),3)
endfunction

function GetUnitRealEvade takes unit u returns real
    return  1 - (50/(50+LoadReal(HT_unitstate,GetHandleId(u),3))) 
endfunction



function SetUnitBlock takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,4)
endfunction

function GetUnitBlock takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),4)
endfunction

function AddUnitBlock takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),4,LoadReal(HT_unitstate,GetHandleId(u),4)+r)
endfunction


function SetUnitLuck takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,5)
endfunction

//function GetUnitLuck takes unit u returns real
//    return LoadReal(HT_unitstate,GetHandleId(u),5)+1
//endfunction

function AddUnitLuck takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),5,LoadReal(HT_unitstate,GetHandleId(u),5)+r)
endfunction


function SetUnitPowerRune takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,6)
endfunction

//function GetUnitPowerRune takes unit u returns real
//    return LoadReal(HT_unitstate,GetHandleId(u),6)
//endfunction

function AddUnitPowerRune takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),6,LoadReal(HT_unitstate,GetHandleId(u),6)+r)
endfunction



function SetUnitSummonStronger takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,7)
endfunction

function GetUnitSummonStronger takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),7)
endfunction

function AddUnitSummonStronger takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),7,LoadReal(HT_unitstate,GetHandleId(u),7)+r)
endfunction



function SetUnitPvpBonus takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),1,8)
endfunction

function GetUnitPvpBonus takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),8)
endfunction

function AddUnitPvpBonus takes unit u,real r returns nothing
    call SaveReal(HT_unitstate,GetHandleId(u),8,LoadReal(HT_unitstate,GetHandleId(u),8)+r)
endfunction


function endTimerState takes nothing returns nothing
local timer t = GetExpiredTimer()

local integer i = LoadInteger(HT,GetHandleId(t),1)
local real r = LoadReal(HT,GetHandleId(t),2)

local unit u = LoadUnitHandle(HT,GetHandleId(t),3)

   call SaveReal(HT_unitstate,GetHandleId(u),i,LoadReal(HT_unitstate,GetHandleId(u),i) - r  )   
    if i == 3 then
            call BlzSetAbilityRealLevelField(BlzGetUnitAbility(u,'A057'),ABILITY_RLF_CHANCE_TO_EVADE_EEV1,0,1-(50/(50+GetUnitEvasion(u) )) )
    endif  
    
call FlushChildHashtable(HT,GetHandleId(t))
call DestroyTimer(t)
set u = null
set t = null
endfunction

function AddStateTemp takes unit u,integer i, real r, real time returns nothing
    local timer t = CreateTimer()
    
    call SaveInteger(HT,GetHandleId(t),1,i)
    call SaveReal(HT,GetHandleId(t),2,r)  
    call SaveUnitHandle(HT,GetHandleId(t),3,u)
    
    call SaveReal(HT_unitstate,GetHandleId(u),i,LoadReal(HT_unitstate,GetHandleId(u),i)+r)   
    
    
    if i == 3 then
            call BlzSetAbilityRealLevelField(BlzGetUnitAbility(u,'A057'),ABILITY_RLF_CHANCE_TO_EVADE_EEV1,0,1-(50/(50+GetUnitEvasion(u) )) )
    endif
    call TimerStart(t,time,false,function endTimerState)
    
    set t = null
endfunction


function GetHeroMaxAbsoluteAbility takes unit u returns integer
    return LoadInteger(HT,GetHandleId(u),-8852352)
endfunction


function AddHeroMaxAbsoluteAbility takes unit u returns boolean 


if GetHeroMaxAbsoluteAbility(u) < 10 then

    call SaveInteger(HT,GetHandleId(u),-8852352,LoadInteger(HT,GetHandleId(u),-8852352)+1)
    return true
else
    return false

endif



    
endfunction


