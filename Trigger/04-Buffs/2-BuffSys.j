globals

    constant integer IdBuffAbility = 'A06H'
    constant integer IdDeBuffAbility = 'A06I'
    constant integer IdBuffUnit = 'h015'
    
    integer array BufLvl
    integer array DeBufLvl
    integer array DeBufLvlA
endglobals

function TimerBuff1 takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local integer abil = LoadInteger(HT,i,1)
    local integer abilA = LoadInteger(HT,i,2)
    local unit u = LoadUnitHandle(HT,i,3)
    

    call UnitRemoveAbility(u,abilA)
    call UnitRemoveAbility(u,abil)
    call SaveTimerHandle(HT,GetHandleId(u),abilA,null)
    
    call FlushChildHashtable(HT,i)
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction



function SetBuff takes unit u, integer level,real time returns nothing

    local timer t = LoadTimerHandle(HT,GetHandleId(u),DeBufLvlA[level])
    if GetUnitAbilityLevel(u,DeBufLvl[level]) == 0 then
        if t == null  then
            set t = CreateTimer()

            call SaveInteger(HT,GetHandleId(t),1,DeBufLvl[level])
            call SaveInteger(HT,GetHandleId(t),2,DeBufLvlA[level])
            call SaveUnitHandle(HT,GetHandleId(t),3,u)
            call SaveTimerHandle(HT,GetHandleId(u),DeBufLvlA[level],t)
            call UnitAddAbility(u,DeBufLvlA[level])
           // call BlzUnitHideAbility(u,DeBufLvlA[level],false)
            call BlzUnitDisableAbility(u,DeBufLvlA[level],false,true)
            call TimerStart(t,time,false,function TimerBuff1)
        else
            call SaveInteger(HT,GetHandleId(t),1,DeBufLvl[level])
            call SaveInteger(HT,GetHandleId(t),2,DeBufLvlA[level])
            call SaveUnitHandle(HT,GetHandleId(t),3,u)
            call SaveTimerHandle(HT,GetHandleId(u),DeBufLvlA[level],t)
            call UnitAddAbility(u,DeBufLvlA[level])
            call TimerStart(t,time,false,function TimerBuff1)
        endif
    else
        if t == null then
 
        else
            call TimerStart(t,time,false,function TimerBuff1)
        endif
    endif
    
    
    
    
    set t = null
    set u = null
endfunction



function InitBuffForLevel takes nothing returns nothing
set DeBufLvlA[1] = 'A06L'
set DeBufLvl[1] = 'B014'

set DeBufLvlA[2] = 'A06P'
set DeBufLvl[2] = 'B015'

set DeBufLvlA[3] = 'A06R'
set DeBufLvl[3] = 'B016'

set DeBufLvlA[4] = 'A08O'
set DeBufLvl[4] = 'B01I'
endfunction