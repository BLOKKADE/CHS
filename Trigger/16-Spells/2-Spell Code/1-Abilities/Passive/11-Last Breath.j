/*function LastBreathEnd takes nothing returns nothing
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

    if GetUnitAbilityLevel(target, 'A08B') > 0 then
        set Hp = GetWidgetLife(target) - Damage.index.damage
       
        if Hp < 100 then
            set Hp = 100
        endif

        call SetWidgetLife(target,Hp)
        set Damage.index.amount = 0
    elseif GetWidgetLife(target) <= Damage.index.damage and BlzGetUnitAbilityCooldownRemaining(target,LAST_BREATHS_ABILITY_ID) <= 0.501 then
        call SetWidgetLife(target, 100)
        call AbilStartCD(target,LAST_BREATHS_ABILITY_ID, 60 + BlzGetUnitAbilityCooldownRemaining(target,LAST_BREATHS_ABILITY_ID) )  
        call TempAbil.create(target, 'A08B', 0.8 + 0.2 * level)
        call TimerStart(t,,false, function LastBreathEnd)

        set t = null
    endif

endfunction
*/