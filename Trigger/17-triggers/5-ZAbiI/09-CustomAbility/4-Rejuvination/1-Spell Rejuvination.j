function RejuvinationTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local real duration = LoadReal(HT,i,3) 
    local real heal = LoadReal(HT,i,4)
    local real manaR = LoadReal(HT,i,5)
    
    
    if GetUnitAbilityLevel(u2,'Brej') > 0 then 
        call HealUnit(u1,u2,0.1*heal/duration)
        call SetUnitState(u2,UNIT_STATE_MANA,GetUnitState(u2,UNIT_STATE_MANA)+ 0.1*manaR/duration)
    else
        call DestroyTimer(t)
        call FlushChildHashtable(HT,i)
    endif
    

    
    set u1 = null
    set u2 = null
    set t = null
endfunction




function RejuvinationStart takes unit u1, unit u2, real heal, real manaR, real duration1, real duration2 returns nothing 
    local timer t = CreateTimer()
    local integer i = GetHandleId(t)

    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    
    if  IsUnitType(u2, UNIT_TYPE_HERO) then
        call SaveReal(HT,i,3, duration1 )
        call SetBuff(u2,4,duration1)
    else
        call SaveReal(HT,i,3, duration2 )
        call SetBuff(u2,4,duration2)
    endif
    call SaveReal(HT,i,4, heal )
    call SaveReal(HT,i,5, manaR )    
    
            
    call TimerStart(t,0.1,true,function RejuvinationTimer)
    

    set t = null
endfunction