library PlayerLeavesGame initializer init requires RandomShit, Scoreboard, PlayerHeroSelected

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

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(leaverPlayer) + " |cffffcc00has left the game!|r")

        call PlaySoundBJ(udg_sound04)
        call ForceAddPlayer(LeaverPlayers, leaverPlayer)
        call UpdateScoreboardPlayerLeaves(leaverPlayer)

        // Player is only decremented when a hero dies. If the hero doesn't exist yet the game gets messed up in the beginning
        if (ShopsCreated == false) then
            set PlayerCount = PlayerCount - 1
            call AllowSinglePlayerCommands()
            
            call BJDebugMsg("All heroes spawned: " + B2S(AllPlayerHeroesSpawned) + ", Round number: " + I2S(RoundNumber) + ", spawned hero count: " + I2S(SpawnedHeroCount) + ", player count: " + I2S(PlayerCount))
            // Check if someone left during hero selection to prevent softlock
            if (AllPlayerHeroesSpawned == false and RoundNumber == 1 and SpawnedHeroCount == PlayerCount) then
                call BJDebugMsg("Last player to select hero left game, starting waves")
                call PlayerHeroSelected_AllPlayersHaveHeroesActions()
            endif
        endif

        call BJDebugMsg("Updated player count: " + I2S(PlayerCount) + ", Spawned hero count: " + I2S(SpawnedHeroCount))
        call BJDebugMsg("Valid player count: " + I2S(GetValidPlayerForceCount()) + ", Initial player count: " + I2S(InitialPlayerCount))

        // Make sure the auto ready status is wiped
        set PlayerIsAlwaysReady[GetPlayerId(leaverPlayer)] = false

        if (PlayerHeroes[playerId] != null) then
            call ResetHero(PlayerHeroes[playerId])
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
        call TriggerAddAction(PlayerLeavesGameTrigger, function PlayerLeavesGameActions)
    endfunction

endlibrary
