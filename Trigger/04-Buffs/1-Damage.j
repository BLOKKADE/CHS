function DamageTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u1 = LoadUnitHandle(HT,GetHandleId(t),1)
    local unit u2 = LoadUnitHandle(HT,GetHandleId(t),2)
    local real dmg = LoadReal(HT,GetHandleId(t),3)
    local boolean physDmg = LoadBoolean(HT, GetHandleId(t), 4)

    if physDmg then
        call UnitDamageTarget(u1,u2,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,null)
    else
        call UnitDamageTarget(u1,u2,dmg,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,null)
    endif

    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t = null
    set u1 = null
    set u2 = null
endfunction



function MagicDamage takes unit u1, unit u2, real dmg returns nothing
    local timer t = CreateTimer()

    call SaveUnitHandle(HT,GetHandleId(t),1,u1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,dmg)
    call SaveBoolean(HT, GetHandleId(t), 4, false)
    

    call TimerStart(t,0,false,function DamageTimer)
    set t = null
endfunction

function PhysicalDamage takes unit u1, unit u2, real dmg returns nothing
    local timer t = CreateTimer()

    call SaveUnitHandle(HT,GetHandleId(t),1,u1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,dmg)
    call SaveBoolean(HT, GetHandleId(t), 4, true)
    

    call TimerStart(t,0,false,function DamageTimer)
    set t = null
endfunction