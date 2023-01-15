library PlayerLeavesGame initializer init requires RandomShit

    private function PlayerLeavesGameConditions takes nothing returns boolean
        return (not IsPlayerInForce(GetTriggerPlayer(), DefeatedPlayers))
    endfunction

    private function ResetHero takes unit u returns nothing
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif

        call UnitRemoveAbility(u, REINCARNATION_ABILITY_ID)
    endfunction

    private function RemovePlayerUnit takes nothing returns nothing
        call RemoveUnit(GetEnumUnit())
    endfunction

    private function PlayerLeavesGameActions takes nothing returns nothing
        local player leaverPlayer = GetTriggerPlayer()
        local integer playerId = GetPlayerId(leaverPlayer)
        local group leaverPlayerUnits
        local location arenaLocation

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayer(LeaverPlayers, leaverPlayer)
        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(leaverPlayer) + " |cffffcc00has left the game!|r")
        call ResetHero(PlayerHeroes[playerId])

        // Try to end the game
        if (BrStarted) then
            set leaverPlayerUnits = GetUnitsOfPlayerAll(leaverPlayer)
            call ForGroup(leaverPlayerUnits, function RemovePlayerUnit)

            // Cleanup
            call DestroyGroup(leaverPlayerUnits)
            set leaverPlayerUnits = null

            call ConditionalTriggerExecute(EndGameTrigger)
        endif

        // Find a new host
        if (HostPlayer == leaverPlayer) then
            call ConditionalTriggerExecute(SetHostPlayerTrigger)
        endif

        // Cleanup
        set leaverPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerLeavesGameTrigger = CreateTrigger()
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(0))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(1))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(2))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(3))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(4))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(5))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(6))
        call TriggerRegisterPlayerEventLeave(PlayerLeavesGameTrigger, Player(7))
        call TriggerAddCondition(PlayerLeavesGameTrigger, Condition(function PlayerLeavesGameConditions))
        call TriggerAddAction(PlayerLeavesGameTrigger, function PlayerLeavesGameActions)
    endfunction

endlibrary
