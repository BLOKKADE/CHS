function MultiUnitBonus takes nothing returns nothing
    local timer TimerT = GetExpiredTimer()
    local integer id_spell = LoadInteger(HY2,GetHandleId(TimerT),1)
    local unit    caster = LoadUnitHandle(HY2,GetHandleId(TimerT),2)
    local unit    Beg    = LoadUnitHandle(HY2,GetHandleId(TimerT),3)
    local real    GetX = LoadReal(HY2,GetHandleId(TimerT),4)
    local real    GetY = LoadReal(HY2,GetHandleId(TimerT),5)
    local integer OrderUnit = LoadInteger(HY2,GetHandleId(TimerT),6)
    local unit DummyU = CreateUnit(GetOwningPlayer(caster),'h015',GetUnitX(caster),GetUnitY(caster),GetUnitFacing(caster))
    
    
    

    call AbilityChanelCst(caster,Beg,GetX,GetY,id_spell)
    
    call UnitAddAbility(DummyU,id_spell)
    call SetUnitAbilityLevel(DummyU,id_spell,GetUnitAbilityLevel(caster,id_spell))
    call UnitApplyTimedLife(DummyU,  'BTLF', 9) 

    call IssueImmediateOrderById(DummyU,OrderUnit)
    if Beg != null then
    call IssueTargetOrderById(DummyU,OrderUnit,Beg)
    else
       if IssuePointOrderById(DummyU,OrderUnit,GetX,GetY) then
       endif
    endif
    call FlushChildHashtable(HY2,GetHandleId(TimerT))
    call DestroyTimer(TimerT)
    
    set TimerT = null
    set caster = null
    set Beg    = null
    set DummyU = null
endfunction


