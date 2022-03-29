library Purge requires RandomShit
    function PurgeTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local real duration = LoadReal(HT, GetHandleId(t), 1) - 1
        local unit target = LoadUnitHandle(HT,GetHandleId(t),2)
        if duration <= 0 then
            call ReleaseTimer(t)
            call FlushChildHashtable(HT,GetHandleId(t))
        else
            call CreateTextTagTimer(I2S(R2I(duration)) , 1 , GetUnitX(target) , GetUnitY(target) , 50 , 1)
            call SaveReal(HT, GetHandleId(t), 1, duration)
        endif
        
        set t = null
        set target = null
    endfunction

    function PurgeCast takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit source = LoadUnitHandle(HT,GetHandleId(t),1)
        local unit target = LoadUnitHandle(HT,GetHandleId(t),2)
        if IsUnitType(target, UNIT_TYPE_HERO) != true or IsUnitIllusion(target) then
            call Damage.apply(source, target, BlzGetUnitMaxHP(target) * 0.75, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
        endif
        call UsOrderU(source, target, GetUnitX(target), GetUnitY(target), 'A08A', "purge", 0, null)
        call FlushChildHashtable(HT,GetHandleId(t))
        
        set t = null
        set source = null
        set target = null
    endfunction

    function Purge takes unit source, unit target returns nothing
        local timer t = NewTimer()
        local real delay = 4.2 - (0.14 * GetUnitAbilityLevel(source, PURGE_ABILITY_ID))
        call SaveUnitHandle(HT,GetHandleId(t),1,source)
        call SaveUnitHandle(HT,GetHandleId(t),2,target)
        call TimerStart(t, delay, false, function PurgeCast)    
        
        if delay > 0 then
            call AddSpecialEffectTargetTimer("Abilities\\Spells\\Items\\AIlb\\AIlbTarget.mdl", target, "overhead", delay, false)
        endif
        
        if delay > 1 then
            set t = NewTimer()
            call SaveReal(HT, GetHandleId(t), 1, delay)
            call SaveUnitHandle(HT,GetHandleId(t),2,target)
            call CreateTextTagTimer(I2S(R2I(delay)) , 1 , GetUnitX(target) , GetUnitY(target) , 50 , 1)
            call TimerStart(t, 1, true, function PurgeTimer)
        endif
        
        set t = null
    endfunction
endlibrary