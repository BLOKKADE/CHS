function FixTimerD takes unit U, integer NumTimer returns nothing
    call ReleaseTimer( LoadTimerHandle( DataUnitHT,GetHandleId(U),NumTimer ))
endfunction

function FixSkeletonDefender takes integer pid returns nothing


    set SkeletonDefender[pid] = SkeletonDefender[pid] - 1


endfunction



function FixUnit takes unit u returns nothing
    if IsUnitIllusion(u) then
        //call FixTimerD(u,10001)
        //call FixTimerD(u,10002)
        //call FixTimerD(u,10003)
        //call FixTimerD(u,10101)
        //call FixTimerD(u,10102)
        //call FixTimerD(u,10103)
        //call FixTimerD(u,10201)
        //call FixTimerD(u,10301)
        //call FixTimerD(u,10401)
        call FlushChildHashtable(DataUnitHT,GetHandleId(u))  
    endif


    if IsHeroUnitId(GetUnitTypeId(GetTriggerUnit())) == false then
        call FlushChildHashtable(HT,GetHandleId(GetTriggerUnit())) 
    endif


    if GetUnitTypeId(GetTriggerUnit()) == 'u003' then
        call FixSkeletonDefender(GetPlayerId(GetOwningPlayer(GetTriggerUnit())))
    endif
endfunction

function DeleteUnit takes unit u returns nothing


    call FixUnit(u)
    call RemoveUnit(u)
endfunction
