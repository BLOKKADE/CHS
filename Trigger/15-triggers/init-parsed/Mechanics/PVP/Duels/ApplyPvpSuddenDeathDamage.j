library ApplyPvpSuddenDeathDamage initializer init requires RandomShit, HpRegen

    globals
        private unit SuddenDeathUnit
    endglobals

    private function ApplyPvpSuddenDeathDamageToPlayer takes nothing returns nothing
        local unit playerHeroToAttack = PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1] // Stored as converted player id. Rip.

        call UnitDamageTargetBJ(SuddenDeathUnit, playerHeroToAttack, GetUnitStateSwap(UNIT_STATE_MAX_LIFE, playerHeroToAttack) * SuddenDeathDamageMultiplier / 2 + 100 * SuddenDeathDamageMultiplier, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_UNIVERSAL)

        // Cleanup
        set playerHeroToAttack = null
    endfunction

    private function ApplyPvpSuddenDeathDamageToForce takes force forceAttackSource, force forceToAttack returns nothing
        local location unitLocation
        local unit playerHero
        local player randomPlayer

        // Make sure there are players in each force
        if (CountPlayersInForceBJ(forceAttackSource) > 0 and CountPlayersInForceBJ(forceToAttack) > 0) then
            set randomPlayer = ForcePickRandomPlayer(forceAttackSource)
            set playerHero = PlayerHeroes[GetPlayerId(randomPlayer) + 1] // Stored as converted player id. Rip.
            set unitLocation = GetUnitLoc(playerHero)
            set SuddenDeathUnit = CreateUnitAtLoc(randomPlayer, SUDDEN_DEATH_UNIT_ID, unitLocation, bj_UNIT_FACING) // Make the Creeps player deal the sudden death damage
            call UnitApplyTimedLife(SuddenDeathUnit, 'BTLF', 0.25)

            // Damage the other units
            call ForForce(forceToAttack, function ApplyPvpSuddenDeathDamageToPlayer)

            // Cleanup
            call RemoveLocation(unitLocation)
            set SuddenDeathUnit = null
            set unitLocation = null
            set playerHero = null
            set randomPlayer = null
        endif
    endfunction

    private function ApplyPvpSuddenDeathDamageActions takes nothing returns nothing
        local IntegerListItem node = DuelGameList.first
        local DuelGame currentDuelGame

        set SuddenDeathTick = SuddenDeathTick + 1

        if (SuddenDeathTick >= 120) then
            loop
                exitwhen node == 0
                
                set currentDuelGame = node.data
    
                if (currentDuelGame != 0 and (not currentDuelGame.isDuelOver)) then
                    call ApplyPvpSuddenDeathDamageToForce(currentDuelGame.team1, currentDuelGame.team2)
                    call ApplyPvpSuddenDeathDamageToForce(currentDuelGame.team2, currentDuelGame.team1)
                endif

                set node = node.next
            endloop
        endif
    endfunction

    private function init takes nothing returns nothing
        set ApplyPvpSuddenDeathDamageTrigger = CreateTrigger()
        call DisableTrigger(ApplyPvpSuddenDeathDamageTrigger)
        call TriggerRegisterTimerEventPeriodic(ApplyPvpSuddenDeathDamageTrigger, 0.25)
        call TriggerAddAction(ApplyPvpSuddenDeathDamageTrigger, function ApplyPvpSuddenDeathDamageActions)
    endfunction

endlibrary
