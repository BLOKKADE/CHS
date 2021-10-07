function LastBreathEnd takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT,GetHandleId(tim),1)
    local effect eff = LoadEffectHandle(HT,GetHandleId(tim),2)
    call SaveInteger(HT,GetHandleId(u),'A05R',0) 
    call DestroyEffect(eff)
    call UnitRemoveAbility(u, 'A08B')
    call UnitRemoveAbility(u, 'B01D')
    call FlushChildHashtable(HT,GetHandleId(tim))
    call ReleaseTimer(tim)
    set tim = null
    set eff = null
    set u = null
endfunction
 
 
function LastBreath takes nothing returns nothing 
    local timer tim
    local unit u = GetTriggerUnit()
    local real lvlAbility = GetUnitAbilityLevel(u ,'A05R')
    local real Hp
    
	if lvlAbility > 0 then
        if LoadInteger(HT,GetHandleId(u),'A05R') == 1 and GetUnitAbilityLevel(u, 'A08B') > 0 then
            set Hp = GetWidgetLife(u)
            set Hp = Hp - GetEventDamage()
            if Hp < 1 then
                set Hp = 1
            endif
            call SetWidgetLife(u,Hp)
            call BlzSetEventDamage(0)
        elseif GetWidgetLife(u) <= GetEventDamage()+ 0.405 and BlzGetUnitAbilityCooldownRemaining(u,'A05R') <= 0.501 then
            set tim = NewTimer()
            call BlzSetEventDamage(0)
            call SetWidgetLife(u,1.405)
            call AbilStartCD(u,'A05R', 60 + BlzGetUnitAbilityCooldownRemaining(u,'A05R') )  
            call SaveInteger(HT,GetHandleId(u),'A05R',1)	             
            call SaveUnitHandle(HT,GetHandleId(tim),1,GetTriggerUnit())
            if GetOwningPlayer(u) != Player(11) then
                call SaveEffectHandle(HT,GetHandleId(tim),2,AddSpecialEffectTarget( LastBreathAnim , u , "origin" ) ) 
            endif
            call UnitAddAbility(u, 'A08B')
            call TimerStart(tim,0.8 + 0.2 * lvlAbility,false, function LastBreathEnd)
        
        endif
        
        
	endif
    set tim = null
endfunction