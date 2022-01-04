library StoneProtection requires DummyOrder
    globals
        hashtable ShateHT = InitHashtable()
    endglobals

    function endTimerStone takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit source = LoadUnitHandle(HT,GetHandleId(t),1)
        local unit target = LoadUnitHandle(HT,GetHandleId(t),2)
        call UnitShareVision(target,GetOwningPlayer(source),false)
        call SaveBoolean(ShateHT,GetHandleId(target),GetHandleId(source),false)
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
        set source = null
        set target = null
    endfunction

    function CastStoneProtect takes unit source, unit target returns nothing
        local timer t
        local integer lvl = GetUnitAbilityLevel(source, STONE_PROTECTION_ABILITY_ID)
        local boolean success = false
        local DummyOrder dummy

        if BlzGetUnitAbilityCooldownRemaining(source,STONE_PROTECTION_ABILITY_ID) <= 0.001 and IsUnitEnemy(target, GetOwningPlayer(source)) then    
            
            if LoadBoolean(ShateHT, GetHandleId(target), GetHandleId(source)) == false and IsUnitVisible(target, GetOwningPlayer(source)) == false then
                call UnitShareVision(target, GetOwningPlayer(source), true)
                set t = NewTimer()
                call SaveUnitHandle(HT, GetHandleId(t), 1, target)
                call SaveUnitHandle(HT, GetHandleId(t), 2, source)
                call TimerStart(t, 3, false, function endTimerStone)
                call SaveBoolean(ShateHT, GetHandleId(target), GetHandleId(source), true)
                
                set t = null
            endif

            set dummy = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 6)
            call dummy.addActiveAbility('A061', 1, 852252)
            call dummy.setAbilityRealField('A061', ABILITY_RLF_DAMAGE_CTB1, 200 * lvl)
            call dummy.target(target)
            set success = dummy.activate()
        endif

        if success then
            if IsHeroUnitId(GetUnitTypeId(target)) then
                call AbilStartCD(source,STONE_PROTECTION_ABILITY_ID,9)
            else
                call AbilStartCD(source,STONE_PROTECTION_ABILITY_ID,0.9)
            endif
        endif
    endfunction
endlibrary