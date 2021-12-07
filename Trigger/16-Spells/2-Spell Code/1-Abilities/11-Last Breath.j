function LastBreathEnd takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT,GetHandleId(tim),1)
    local effect eff = LoadEffectHandle(HT,GetHandleId(tim),2)
    call SaveInteger(HT,GetHandleId(u),LAST_BREATHS_ABILITY_ID,0) 
    call DestroyEffect(eff)
    call UnitRemoveAbility(u, 'A08B')
    call UnitRemoveAbility(u, 'B01D')
    call FlushChildHashtable(HT,GetHandleId(tim))
    call ReleaseTimer(tim)
    set tim = null
    set eff = null
    set u = null
endfunction
 
 
function LastBreath takes unit target, integer level returns nothing 
    local timer t
    local real Hp

    if LoadInteger(HT,GetHandleId(target),LAST_BREATHS_ABILITY_ID) == 1 and GetUnitAbilityLevel(target, 'A08B') > 0 then
        set Hp = GetWidgetLife(target)
        set Hp = Hp - GetEventDamage()
        if Hp < 1 then
            set Hp = 1
        endif
        call SetWidgetLife(target,Hp)
        call BlzSetEventDamage(0)
    elseif GetWidgetLife(target) <= GetEventDamage()+ 0.405 and BlzGetUnitAbilityCooldownRemaining(target,LAST_BREATHS_ABILITY_ID) <= 0.501 then
        set t = NewTimer()
        call BlzSetEventDamage(0)
        call SetWidgetLife(target,1.405)
        call AbilStartCD(target,LAST_BREATHS_ABILITY_ID, 60 + BlzGetUnitAbilityCooldownRemaining(target,LAST_BREATHS_ABILITY_ID) )  
        call SaveInteger(HT,GetHandleId(target),LAST_BREATHS_ABILITY_ID,1)	             
        call SaveUnitHandle(HT,GetHandleId(t),1,GetTriggerUnit())
        if GetOwningPlayer(target) != Player(11) then
            call SaveEffectHandle(HT,GetHandleId(t),2,AddSpecialEffectTarget( LastBreathAnim , target , "origin" ) ) 
        endif
        call UnitAddAbility(target, 'A08B')
        call TimerStart(t,0.8 + 0.2 * level,false, function LastBreathEnd)

        set t = null
    endif

endfunction