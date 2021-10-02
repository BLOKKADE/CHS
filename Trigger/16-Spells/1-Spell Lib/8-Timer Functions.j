function GetTimerCD takes unit U1, integer id, real timeT returns boolean
    local timer tim 
    if LoadTimerHandle( DataUnitHT,GetHandleId(U1),id ) == null then
        set tim = NewTimer()
        call TimerStart(tim,timeT,false,null)
        call SaveTimerHandle( DataUnitHT,GetHandleId(U1),id,tim) 
        set tim = null
        return true
    else
        set tim = LoadTimerHandle( DataUnitHT,GetHandleId(U1),id )
        if TimerGetRemaining(tim) <= 0.0001 then
            call TimerStart(tim,timeT,false,null)     
            set tim = null
            return true
        else
            set tim = null
            return false
        endif
    endif
    return false
    
endfunction


function EndZeroTimer takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(DataUnitHT,GetHandleId(tim),1)
    local integer id = LoadInteger(DataUnitHT,GetHandleId(tim),2)

    call RemoveSavedHandle( DataUnitHT,GetHandleId(u),id) 
    call FlushChildHashtable(DataUnitHT,GetHandleId(tim))
    call ReleaseTimer(tim)
    set tim = null
    set u = null
endfunction
 
 
function ZetoTimerStart takes unit u,integer id returns boolean
    local timer tim 
    
    if LoadTimerHandle( DataUnitHT,GetHandleId(u),id ) == null then
        set tim = NewTimer()
        call SaveUnitHandle(DataUnitHT,GetHandleId(tim),1,u)
        call SaveInteger(DataUnitHT,GetHandleId(tim),2,id)
        call SaveTimerHandle( DataUnitHT,GetHandleId(u),id,tim) 
        call TimerStart(tim,0,false,function EndZeroTimer)
        set tim = null
        return true
    endif

 
    return false
endfunction

function CheckTimerZero takes unit u,integer id returns boolean
    if LoadTimerHandle( DataUnitHT,GetHandleId(u),id ) == null then
        return false
    endif
    return true
endfunction