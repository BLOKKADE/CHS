function DamageTimer takes nothing returns nothing
local timer t = GetExpiredTimer()
local unit u1 = LoadUnitHandle(HT,GetHandleId(t),1)
local unit u2 = LoadUnitHandle(HT,GetHandleId(t),2)
local real dmg = LoadReal(HT,GetHandleId(t),3)


set GLOB_ABIL_ID = LoadInteger(HT,GetHandleId(t),4)
call UnitDamageTarget(u1,u2,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)

call FlushChildHashtable(HT,GetHandleId(t))
call DestroyTimer(t)
set t = null
set u1 = null
set u2 = null
endfunction



function MagicDamage takes unit u1, unit u2, real dmg, integer id returns nothing
    local timer t = CreateTimer()

    call SaveUnitHandle(HT,GetHandleId(t),1,u1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,dmg)
    call SaveInteger(HT,GetHandleId(t),4,id)    

    call TimerStart(t,0,false,function DamageTimer)
    set t = null
endfunction