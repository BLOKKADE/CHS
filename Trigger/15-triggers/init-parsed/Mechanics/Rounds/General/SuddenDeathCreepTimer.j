library SuddenDeathCreepTimer initializer init requires RandomShit

    private function BuffCreepUnit takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()

        if (GetUnitTypeId(currentUnit) != dummyId) then
            call SetUnitMoveSpeed(currentUnit, GetUnitMoveSpeed(currentUnit) + 25.00)

            if (GetUnitAbilityLevel(currentUnit, CRITICAL_STRIKE_ABILITY_ID) == 0) then
                call UnitAddAbility(currentUnit, CRITICAL_STRIKE_ABILITY_ID)
            elseif (GetUnitAbilityLevel(currentUnit, CRITICAL_STRIKE_ABILITY_ID) < 10) then
                call SetUnitAbilityLevel(currentUnit, CRITICAL_STRIKE_ABILITY_ID, 10)
            endif
        endif

        // Cleanup
        set currentUnit = null
    endfunction

    private function FurtherBuffCreepUnit takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()

        if (GetUnitTypeId(currentUnit) != dummyId) then
            call UnitAddAbility(currentUnit, 'Atru')
            call UnitAddAbility(currentUnit, HURL_BOULDER_CREEP_ABILITY_ID)
            call UnitAddAbility(currentUnit, THUNDER_CLAP_CREEP_ABILITY_ID)

            if (GetUnitBonus(currentUnit, BONUS_DAMAGE) < 1000000) then
                if (GetUnitBonus(currentUnit, BONUS_DAMAGE) == 0) then
                    call SetUnitBonus(currentUnit, BONUS_DAMAGE, R2I(BlzGetUnitBaseDamage(currentUnit, 0) * 0.1) + 1)
                endif

                call SetUnitBonus(currentUnit, BONUS_DAMAGE, R2I(GetUnitBonus(currentUnit, BONUS_DAMAGE) * 1.1) + 1)
            endif
        endif

        // Cleanup
        set currentUnit = null
    endfunction

    private function PlayerNotDoneWithRoundFilter takes nothing returns boolean
        return (IsPlayerInForce(GetFilterPlayer(), RoundPlayersCompleted) != true)
    endfunction

    private function DamagePlayerHero takes nothing returns nothing
        local unit u = PlayerHeroes[GetPlayerId(GetEnumPlayer())]

        if (GetUnitState(u, UNIT_STATE_LIFE) > 1) then
            call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) - GetUnitState(u, UNIT_STATE_LIFE) * 0.8)
        endif

        // Cleanup
        set u = null
    endfunction

    private function SuddenDeathCreepTimerActions takes nothing returns nothing
        local group creepUnits
        local force playersNotDoneWithRound

        set SuddenDeathTick = SuddenDeathTick + 1

        if (CreepEnrageEnabled) then
            if (SuddenDeathTick == 120 or SuddenDeathTick == 180 or SuddenDeathTick == 240 or SuddenDeathTick == 300) then
                call UpdateSuddenDeathTimer()
            endif

            if (SuddenDeathTick >= 120) then
                set creepUnits = GetUnitsInRectOfPlayer(GetPlayableMapRect(), Player(11))
                call ForGroup(creepUnits, function BuffCreepUnit)

                if (SuddenDeathTick >= 240) then
                    call ForGroup(creepUnits, function FurtherBuffCreepUnit)

                    if (SuddenDeathTick >= 300) then
                        set playersNotDoneWithRound = GetPlayersMatching(Condition(function PlayerNotDoneWithRoundFilter))
                        call ForForce(playersNotDoneWithRound, function DamagePlayerHero)

                        // Cleanup
                        call DestroyForce(playersNotDoneWithRound)
                        set playersNotDoneWithRound = null
                    endif
                endif
            endif
        endif

        // Cleanup
        if (creepUnits != null) then
            call DestroyGroup(creepUnits)
            set creepUnits = null
        endif
    endfunction

    private function init takes nothing returns nothing
        set SuddenDeathCreepTimerTrigger = CreateTrigger()
        call DisableTrigger(SuddenDeathCreepTimerTrigger)
        call TriggerRegisterTimerEventPeriodic(SuddenDeathCreepTimerTrigger, 0.25)
        call TriggerAddAction(SuddenDeathCreepTimerTrigger, function SuddenDeathCreepTimerActions)
    endfunction

endlibrary
