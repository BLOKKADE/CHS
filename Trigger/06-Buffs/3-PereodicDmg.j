function peredioc_s takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local real dmg1 = LoadReal(HT,i,3)
    local real dmg2 = LoadReal(HT,i,4)
    local real evary = LoadReal(HT,i,5)
    local real max = LoadReal(HT,i,6)
    local integer id = LoadInteger(HT,i,7)
    local boolean first = LoadBoolean(HT,i,8)
    

    
    if first==false then
        call SaveBoolean(HT,i,8,true)
        set TypeDmg_b = 2
        set GLOB_ABIL_ID = LoadInteger(HT,i,9)
        call UnitDamageTarget(u1,u2,dmg1+GetWidgetLife(u2)*0.01*dmg2,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
        call TimerStart(t,evary,true,function peredioc_s)
        set u1 = null
        set u2 = null
        return
    endif
    
    if GetUnitAbilityLevel(u2,id) > 0 then
        set TypeDmg_b = 2
        set GLOB_ABIL_ID = LoadInteger(HT,i,9)
        call UnitDamageTarget(u1,u2,dmg1+GetWidgetLife(u2)*0.01*dmg2,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)

    else
        call DestroyTimer(t)
        call FlushChildHashtable(HT,i)
    
    endif
    
    set t = null
    set u1 = null
    set u2 = null
endfunction

function PerodicDmg takes unit u1,unit u2,real dmg1,real dmg2,real evary,real max,integer id,boolean first, integer idabil returns nothing
    local timer t = LoadTimerHandle(HT,GetHandleId(u2),id)
    local integer i
    if t == null then
        set t = CreateTimer()
    endif
    
    set i = GetHandleId(t)
        
    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    call SaveReal(HT,i,3,dmg1)
    call SaveReal(HT,i,4,dmg2)
    call SaveReal(HT,i,5,evary)
    call SaveReal(HT,i,6,max)
    call SaveInteger(HT,i,7,id)
    call SaveInteger(HT,i,9,idabil)
    if first then
        call TimerStart(t,0,false,function peredioc_s)
    endif

    set t = null
endfunction