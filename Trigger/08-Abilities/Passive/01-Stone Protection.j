library StoneProtection requires DummyOrder, RandomShit

    private struct timerData
        unit source
        unit target
        integer level
    endstruct

    private function DoDamage takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local timerData td = GetTimerData(t)
        local DummyOrder dummy = DummyOrder.create(td.source, GetUnitX(td.source), GetUnitY(td.source), GetUnitFacing(td.source), 6)
        call dummy.addActiveAbility('A061', 1, 852252)
        call dummy.setAbilityRealField('A061', ABILITY_RLF_DAMAGE_CTB1, 200 * td.level)
        call dummy.target(td.target)
        call dummy.activate()

        set td.source = null
        set td.target = null
        call td.destroy()
        set t = null
    endfunction
    
    function CastStoneProtect takes unit source, unit target returns nothing
        local integer lvl = GetUnitAbilityLevel(source, STONE_PROTECTION_ABILITY_ID)
        local boolean success = false
        local DummyOrder dummy
        local timer t = null
        local timerData td

        if BlzGetUnitAbilityCooldownRemaining(source,STONE_PROTECTION_ABILITY_ID) <= 0.001 and IsUnitEnemy(target, GetOwningPlayer(source)) then    

            set dummy = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 6)
            call dummy.addActiveAbility('A0C9', 1, 852122)
            call dummy.point(GetUnitX(target), GetUnitY(target))
            call dummy.activate()

            if IsUnitVisible(target, GetOwningPlayer(source)) then
                set dummy = DummyOrder.create(source, GetUnitX(source), GetUnitY(source), GetUnitFacing(source), 6)
                call dummy.addActiveAbility('A061', 1, 852252)
                call dummy.setAbilityRealField('A061', ABILITY_RLF_DAMAGE_CTB1, 200 * lvl)
                call dummy.target(target)
                set success = dummy.activate()
            else
                set t = NewTimer()
                set td = timerData.create()
                set td.source = source
                set td.target = target
                set td.level = lvl
                call SetTimerData(t, td)
                call TimerStart(t, 0.2, false, function DoDamage)
                set success = true
            endif
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