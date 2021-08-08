function UsOrderUTimer51 takes unit u1, unit u2, real dmg returns nothing
    local real x = GetUnitX(u1)
    local real y = GetUnitY(u1)
    local boolean check = false
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, 0  )
    call UnitAddAbility(Caster1,'A07Y' ) 

    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,'A07Y'),ABILITY_RLF_DAMAGE_CTB1,0,dmg)
    set check  = IssueTargetOrder(Caster1,"thunderbolt",u2)
    
    call UnitApplyTimedLife(Caster1,'B000',3)
    
    set Caster1  = null
    set u1 = null
    set u2 = null
endfunction

function realaisFrostBolt takes nothing returns nothing 
    local timer t = GetExpiredTimer()
    local unit u1 = LoadUnitHandle(HT,GetHandleId(t),3)
    local unit u2 = LoadUnitHandle(HT,GetHandleId(t),4)    
    local integer count = LoadInteger(HT,GetHandleId(t),1)
    
    
    
    if count == 0 then
        call FlushChildHashtable(HT,GetHandleId(t))
        call DestroyTimer(t)
    else 
        set count = count - 1 
        call UsOrderUTimer51(u1,u2,LoadReal(HT,GetHandleId(t),2))   
        call SaveInteger(HT,GetHandleId(t),1,count)
    endif


    
    

    set t = null
    set u1 = null
    set u2 = null
endfunction

function UsFrostBolt takes unit u1, unit u2,real dmg, integer count returns nothing
    local timer t = CreateTimer()
    call SaveInteger(HT,GetHandleId(t),1,count)
    call SaveReal(HT,GetHandleId(t),2,dmg)
    call SaveUnitHandle(HT,GetHandleId(t),3,u1)
    call SaveUnitHandle(HT,GetHandleId(t),4,u2)
    
    call TimerStart(t,0.45,true,function realaisFrostBolt)
    
    set t = null
endfunction