/*function DamageTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u1 = LoadUnitHandle(HT,GetHandleId(t),1)
    local unit u2 = LoadUnitHandle(HT,GetHandleId(t),2)
    local real dmg = LoadReal(HT,GetHandleId(t),3)
    local boolean physDmg = LoadBoolean(HT, GetHandleId(t), 4)
    local boolean typeDmg = LoadBoolean(HT, GetHandleId(t), 5)
    local integer abilId = LoadInteger(HT, GetHandleId(t), 6)

    if typeDmg then
        set udg_NextDamageType = DamageType_Onhit
    endif
    set udg_NextDamageAbilitySource = abilId
    if physDmg then
        //set GLOB_typeDmg = 2
        call Damage.applyPhys(u1,u2,dmg,false,ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
    else
        call Damage.applyMagic(u1,u2,dmg,DAMAGE_TYPE_MAGIC)
    endif

    call FlushChildHashtable(HT,GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set u1 = null
    set u2 = null
endfunction



function MagicDamage takes unit u1, unit u2, real dmg, boolean typeDmg, integer abilId returns nothing
    local timer t = NewTimer()

    call SaveUnitHandle(HT,GetHandleId(t),1,u1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,dmg)
    call SaveBoolean(HT, GetHandleId(t), 4, false)
    call SaveBoolean(HT, GetHandleId(t), 5, typeDmg)
    call SaveInteger(HT, GetHandleId(t), 6, abilId)

    call TimerStart(t,0,false,function DamageTimer)
    set t = null
endfunction

function PhysicalDamage takes unit u1, unit u2, real dmg, boolean typeDmg, integer abilId returns nothing
    local timer t = NewTimer()

    call SaveUnitHandle(HT,GetHandleId(t),1,u1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,dmg)
    call SaveBoolean(HT, GetHandleId(t), 4, true)
    call SaveBoolean(HT, GetHandleId(t), 5, typeDmg)
    call SaveInteger(HT, GetHandleId(t), 6, abilId)

    call TimerStart(t,0,false,function DamageTimer)
    set t = null
endfunction*/