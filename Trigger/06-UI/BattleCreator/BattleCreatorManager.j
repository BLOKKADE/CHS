library BattleCreatorManager initializer init requires HeroPassiveDesc, HeroRefresh

    globals
        // Player force array representing all teams. Can be up to 8 teams.
        force array BRPlayerForce
        force array BRRandomPlayerForce
        force array BRUsedTeams
        force BRPlayers
        boolean array UsedPlayerForce
        
        // Colors
        constant string BR_COLOR_END_TAG                           = "|r"
        constant string BR_OBSERVERS_COLOR                         = "|cffff2af4"
        constant string BR_SOLO_COLOR                              = "|cffff8420"
        constant string BR_RANDOM_TEAM_COLOR                       = "|cffff9e20"
        constant string BR_TEAM_1_COLOR                            = "|cffff2a2a"
        constant string BR_TEAM_2_COLOR                            = "|cff5cff2a"
        constant string BR_TEAM_3_COLOR                            = "|cff00ccff"
        constant string BR_TEAM_4_COLOR                            = "|cffbcf520"
        constant string BR_MESSAGE_COLOR                           = "|cffeb5701"

        integer UsedTeamCount

        // The amount of teams in the BRPlayerForce
        integer BRTeamCount

        // The amount of total players
        integer BRRoundPlayerCount

        // Dynamic information
        force BRObservers
        force BRSolo
        force BRRandomTeam
        force BRTeam1
        force BRTeam2
        force BRTeam3
        force BRTeam4
        
        boolean BRLockedIn = false

        // UI elements
        framehandle array PlayerSlotNameFramehandles
        framehandle array PlayerSlotIconFramehandles
        framehandle array PlayerSlotIconParentFramehandles
        framehandle BRCheckboxTextFrameHandle
        framehandle BRMessageTextFrameHandle

        // Framehandles for each button
        framehandle ObserverHandle
        framehandle SoloHandle
        framehandle RandomTeamHandle
        framehandle Team1Handle
        framehandle Team2Handle
        framehandle Team3Handle
        framehandle Team4Handle

        Table BRHandleTitles
        Table BRHandleDescriptions

        // Temp variables
        private integer TempPlayerForceIndex
        private boolean ForceHasHeroesAlive
        private boolean AddedPlayerToForce
        force BRTempForce
        integer BRPlayerSlotIndex
    endglobals
    
    function UpdateRandomTeamVoteText takes nothing returns nothing
        call BlzFrameSetText(BRCheckboxTextFrameHandle, BR_RANDOM_TEAM_COLOR + "Random Teams (" + I2S(CountPlayersInForceBJ(BRRandomTeam)) + "/" + I2S(BRRoundPlayerCount - CountPlayersInForceBJ(BRObservers)) + ")" + BR_COLOR_END_TAG)
    endfunction
    
    function SetBRLockStatus takes boolean enabled returns nothing
        set BRLockedIn = not enabled

        call BlzFrameSetEnable(ObserverHandle, enabled) 
        call BlzFrameSetEnable(SoloHandle, enabled) 
        call BlzFrameSetEnable(RandomTeamHandle, enabled) 
        call BlzFrameSetEnable(Team1Handle, enabled) 
        call BlzFrameSetEnable(Team2Handle, enabled) 
        call BlzFrameSetEnable(Team3Handle, enabled) 
        call BlzFrameSetEnable(Team4Handle, enabled) 
    endfunction

    private function UpdateEnumPlayerSlot takes nothing returns nothing
        local player p = GetEnumPlayer()
        local integer playerId = GetPlayerId(p)
        local unit playerHero = PlayerHeroes[playerId]

        // Update the player hero icon
        call BlzFrameSetTexture(PlayerSlotIconFramehandles[BRPlayerSlotIndex], BlzGetAbilityIcon(GetUnitTypeId(playerHero)), 0, true)
        call BlzFrameSetVisible(PlayerSlotIconParentFramehandles[BRPlayerSlotIndex], true)

        set BRHandleDescriptions.string[GetHandleId(PlayerSlotIconParentFramehandles[BRPlayerSlotIndex])] = GetHeroTooltip(playerHero)
        set BRHandleTitles.string[GetHandleId(PlayerSlotIconParentFramehandles[BRPlayerSlotIndex])] = GetPlayerNameColour(p) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(playerHero))

        // Update the player name
        call BlzFrameSetText(PlayerSlotNameFramehandles[BRPlayerSlotIndex], GetPlayerNameColour(p))
        call BlzFrameSetVisible(PlayerSlotNameFramehandles[BRPlayerSlotIndex], true)

        // Cleanup
        set p = null
        set playerHero = null

        set BRPlayerSlotIndex = BRPlayerSlotIndex + 1
    endfunction

    private function CleanupRemainingSlots takes integer startIndex, integer endIndex returns nothing
        local integer playerSlotIndex = startIndex

        loop
            exitwhen playerSlotIndex > endIndex

            call BlzFrameSetVisible(PlayerSlotIconParentFramehandles[playerSlotIndex], false)
            call BlzFrameSetVisible(PlayerSlotNameFramehandles[playerSlotIndex], false)

            set playerSlotIndex = playerSlotIndex + 1
        endloop
    endfunction

    function IsBRSetupValid takes nothing returns boolean
        return BRTeamCount > 1
    endfunction

    function UpdateBRPlayerSlots takes nothing returns nothing
        set BRPlayerSlotIndex = 0
        set BRTempForce = BRObservers
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 7)

        set BRPlayerSlotIndex = 8
        set BRTempForce = BRSolo
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 15)

        set BRPlayerSlotIndex = 16
        set BRTempForce = BRTeam1
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 23)

        set BRPlayerSlotIndex = 24
        set BRTempForce = BRTeam2
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 31)

        set BRPlayerSlotIndex = 32
        set BRTempForce = BRTeam3
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 39)

        set BRPlayerSlotIndex = 40
        set BRTempForce = BRTeam4
        call ForForce(BRTempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(BRPlayerSlotIndex, 47)
    endfunction

    private function RemovePlayerFromEverything takes player p returns nothing
        // Reset the hero and remove it from the game
        call ResetHero(PlayerHeroes[GetPlayerId(p)])
        call RemoveUnit(PlayerHeroes[GetPlayerId(p)])
        
        call ForceRemovePlayer(BRRandomTeam, p)
        call ForceRemovePlayer(BRSolo, p)
        call ForceRemovePlayer(BRTeam1, p)
        call ForceRemovePlayer(BRTeam2, p)
        call ForceRemovePlayer(BRTeam3, p)
        call ForceRemovePlayer(BRTeam4, p)
        call ForceRemovePlayer(BRObservers, p)
    endfunction

    function TryMovePlayerToForce takes player p, force destinationForce returns boolean
        // Remove the player from everything if they left the game
        if (IsPlayerInForce(p, LeaverPlayers)) then
            call RemovePlayerFromEverything(p)

            return true
        endif

        // Don't do anything if the player is already in the destination force
        if (IsPlayerInForce(p, destinationForce) or IsPlayerInForce(p, BRRandomTeam)) then
            return false
        endif

        call ForceRemovePlayer(BRSolo, p)
        call ForceRemovePlayer(BRTeam1, p)
        call ForceRemovePlayer(BRTeam2, p)
        call ForceRemovePlayer(BRTeam3, p)
        call ForceRemovePlayer(BRTeam4, p)
        call ForceRemovePlayer(BRObservers, p)

        call ForceAddPlayer(destinationForce, p)

        return true
    endfunction

    function TryMovePlayerFromForceToForce takes player p, force sourceFource, force destinationForce returns boolean
        // Remove the player from everything if they left the game
        if (IsPlayerInForce(p, LeaverPlayers)) then
            call RemovePlayerFromEverything(p)

            return true
        endif

        // Don't do anything if the player is already in the destination force
        if (IsPlayerInForce(p, destinationForce) or IsPlayerInForce(p, BRRandomTeam)) then
            return false
        endif

        call ForceRemovePlayer(sourceFource, p)
        call ForceAddPlayer(destinationForce, p)

        return true
    endfunction

    private function MoveEnumPlayerToObservers takes nothing returns nothing
        call TryMovePlayerFromForceToForce(GetEnumPlayer(), BRTempForce, BRObservers)
    endfunction

    private function IsPlayerHeroAlive takes nothing returns nothing
        local integer pid = GetPlayerId(GetEnumPlayer())

        // Don't check if we already know there is a hero alive for this force
        if (ForceHasHeroesAlive) then
            return
        endif

        set ForceHasHeroesAlive = UnitAlive(PlayerHeroes[pid]) or (BRLivesMode == 2 and PlayerBRDeaths[pid] <= MaxBRDeathCount)
    endfunction

    // This only returns correct data assuming IsBROver has returned true
    function GetBRWinningForce takes nothing returns force
        local integer brPlayerForceIndex = 0

        loop
            exitwhen brPlayerForceIndex == BRTeamCount

            set ForceHasHeroesAlive = false

            call ForForce(BRPlayerForce[brPlayerForceIndex], function IsPlayerHeroAlive)

            if (ForceHasHeroesAlive) then
                return BRPlayerForce[brPlayerForceIndex]
            endif

            set brPlayerForceIndex = brPlayerForceIndex + 1
        endloop

        // Shouldn't happen
        return null
    endfunction

    function IsBROver takes nothing returns boolean
        local integer brPlayerForceIndex = 0
        local integer aliveForces = 0

        loop
            exitwhen brPlayerForceIndex == BRTeamCount

            set ForceHasHeroesAlive = false

            call ForForce(BRPlayerForce[brPlayerForceIndex], function IsPlayerHeroAlive)

            if (ForceHasHeroesAlive) then
                set aliveForces = aliveForces + 1
            endif

            set brPlayerForceIndex = brPlayerForceIndex + 1
        endloop

        return aliveForces == 1
    endfunction

    function ResetBRPlayerSlots takes nothing returns nothing
        set BRTempForce = BRSolo
        call ForForce(BRTempForce, function MoveEnumPlayerToObservers)
        set BRTempForce = BRTeam1
        call ForForce(BRTempForce, function MoveEnumPlayerToObservers)
        set BRTempForce = BRTeam2
        call ForForce(BRTempForce, function MoveEnumPlayerToObservers)
        set BRTempForce = BRTeam3
        call ForForce(BRTempForce, function MoveEnumPlayerToObservers)
        set BRTempForce = BRTeam4
        call ForForce(BRTempForce, function MoveEnumPlayerToObservers)
        set BRTempForce = null

        call ForceClear(BRSolo)
        call ForceClear(BRTeam1)
        call ForceClear(BRTeam2)
        call ForceClear(BRTeam3)
        call ForceClear(BRTeam4)

        set BRRoundPlayerCount = CountPlayersInForceBJ(BRObservers) + CountPlayersInForceBJ(BRRandomTeam)

        call UpdateBRPlayerSlots()
        call UpdateRandomTeamVoteText()
    endfunction

    function ResetBRPlayerForce takes nothing returns nothing
        call ForceClear(BRPlayerForce[0])
        call ForceClear(BRPlayerForce[1])
        call ForceClear(BRPlayerForce[2])
        call ForceClear(BRPlayerForce[3])
        call ForceClear(BRPlayerForce[4])
        call ForceClear(BRPlayerForce[5])
        call ForceClear(BRPlayerForce[6])
        call ForceClear(BRPlayerForce[7])

        call ForceClear(BRPlayers)

        set UsedPlayerForce[0] = false
        set UsedPlayerForce[1] = false
        set UsedPlayerForce[2] = false
        set UsedPlayerForce[3] = false
        set UsedPlayerForce[4] = false
        set UsedPlayerForce[5] = false
        set UsedPlayerForce[6] = false
        set UsedPlayerForce[7] = false

        set BRUsedTeams[0] = BRTeam1
        set BRUsedTeams[1] = BRTeam2
        set BRUsedTeams[2] = BRTeam3
        set BRUsedTeams[3] = BRTeam4

        set UsedTeamCount = 0
        set BRTeamCount = 0
    endfunction

    private function AddPlayerToNextAvailableForce takes nothing returns nothing
        call ForceAddPlayer(BRPlayerForce[TempPlayerForceIndex], GetEnumPlayer())
        call ForceAddPlayer(BRPlayers, GetEnumPlayer())
        
        set TempPlayerForceIndex = TempPlayerForceIndex + 1
        set AddedPlayerToForce = true
    endfunction
    
    private function AddPlayerToCurrentAvailableForce takes nothing returns nothing
        call ForceAddPlayer(BRPlayerForce[TempPlayerForceIndex], GetEnumPlayer())
        call ForceAddPlayer(BRPlayers, GetEnumPlayer())

        set AddedPlayerToForce = true
    endfunction

    private function AddToBRTempForce takes nothing returns nothing
        call ForceAddPlayer(BRTempForce, GetEnumPlayer())
    endfunction

    function CalculateFreeForAllPlayerForces takes force validPlayers returns nothing
        // Set the players for the rest of the game. All players will be managed from here for the fun BR rounds
        set BRTempForce = BRObservers
        call ForForce(validPlayers, function AddToBRTempForce)

        call ResetBRPlayerSlots()
        call ResetBRPlayerForce()

        set TempPlayerForceIndex = 0
        call ForForce(validPlayers, function AddPlayerToNextAvailableForce)
        set BRTeamCount = TempPlayerForceIndex

        call SetBRLockStatus(false)
    endfunction

    private function CopyForceToNextAvailableForce takes force sourceForce returns nothing
        set AddedPlayerToForce = false

        call ForForce(sourceForce, function AddPlayerToCurrentAvailableForce)

        if (AddedPlayerToForce) then
            set TempPlayerForceIndex = TempPlayerForceIndex + 1

            set BRUsedTeams[UsedTeamCount] = sourceForce
            set UsedTeamCount = UsedTeamCount + 1
        endif
    endfunction

    function CalculatePlayerForces takes nothing returns nothing
        local integer nonObserverCount = BRRoundPlayerCount - CountPlayersInForceBJ(BRObservers)
        local integer remainingPlayerCount
        local integer teamCount
        local integer currentTeamCount
        local integer teamSize
        local integer currentTeamSize
        local player randomPlayer
        local force availableRandomForce
        local integer randomTeamIndex
        local integer randomTeam

        set AddedPlayerToForce = false
        set TempPlayerForceIndex = 0

        call ResetBRPlayerForce()

        // Make random teams if majority voted
        if (CountPlayersInForceBJ(BRRandomTeam) > 1 and CountPlayersInForceBJ(BRRandomTeam) > (nonObserverCount / 2)) then
            // Use the amount of players, excluding those in the solo queue
            set remainingPlayerCount = nonObserverCount - CountPlayersInForceBJ(BRSolo)

            // Determine random team count
            if (remainingPlayerCount == 8) then
                set teamCount = GetRandomInt(2, 4)
            elseif (remainingPlayerCount == 7) then
                set teamCount = GetRandomInt(2, 4)
            elseif (remainingPlayerCount == 6) then
                set teamCount = GetRandomInt(2, 4)
            elseif (remainingPlayerCount == 5) then
                set teamCount = GetRandomInt(2, 3)
            elseif (remainingPlayerCount == 4) then
                set teamCount = GetRandomInt(2, 3)
            elseif (remainingPlayerCount == 3) then
                set teamCount = GetRandomInt(2, 3)
            elseif (remainingPlayerCount == 2) then
                set teamCount = GetRandomInt(2, 2)
            endif

            call BlzFrameSetText(BRMessageTextFrameHandle, BR_MESSAGE_COLOR + "Majority vote for random teams. Randomizing " + I2S(teamCount) + " teams." + BR_COLOR_END_TAG)
            call BlzFrameSetVisible(BRMessageTextFrameHandle, true)

            // Create a pool of possible people to select from
            set availableRandomForce = CreateForce()
            set BRTempForce = availableRandomForce
            call ForForce(BRTeam1, function AddToBRTempForce)
            call ForForce(BRTeam2, function AddToBRTempForce)
            call ForForce(BRTeam3, function AddToBRTempForce)
            call ForForce(BRTeam4, function AddToBRTempForce)
            call ForForce(BRRandomTeam, function AddToBRTempForce)

            set teamSize = remainingPlayerCount / teamCount
            set currentTeamCount = 0

            // Create each team
            loop
                exitwhen currentTeamCount == teamCount

                set randomPlayer = ForcePickRandomPlayer(availableRandomForce)

                set currentTeamSize = 0

                // Add the specified amount of random players to the current team
                loop
                    exitwhen currentTeamSize == teamSize or randomPlayer == null
    
                    call ForceRemovePlayer(availableRandomForce, randomPlayer)
                    call ForceAddPlayer(BRPlayers, randomPlayer)
                    call ForceAddPlayer(BRUsedTeams[currentTeamCount], randomPlayer)
                    call ForceAddPlayer(BRPlayerForce[currentTeamCount], randomPlayer)
    
                    set currentTeamSize = currentTeamSize + 1

                    set randomPlayer = ForcePickRandomPlayer(availableRandomForce)
                endloop

                // Create the next team
                set currentTeamCount = currentTeamCount + 1
            endloop

            // Ensure everyone is in a team, usually due to rounding errors
            set randomPlayer = ForcePickRandomPlayer(availableRandomForce)

            loop
                exitwhen randomPlayer == null

                // Put the player in one of the random teams generated above
                set randomTeam = GetRandomInt(0, teamCount - 1)

                call ForceRemovePlayer(availableRandomForce, randomPlayer)
                call ForceAddPlayer(BRPlayers, randomPlayer)
                call ForceAddPlayer(BRUsedTeams[randomTeam], randomPlayer)
                call ForceAddPlayer(BRPlayerForce[randomTeam], randomPlayer)

                set randomPlayer = ForcePickRandomPlayer(availableRandomForce)
            endloop

            // Manually set the temp player force index for the solo players to be added to
            set TempPlayerForceIndex = teamCount
        else
            // Each specified team gets assigned to their own team
            call CopyForceToNextAvailableForce(BRTeam1)
            call CopyForceToNextAvailableForce(BRTeam2)
            call CopyForceToNextAvailableForce(BRTeam3)
            call CopyForceToNextAvailableForce(BRTeam4)

            // Create a pool of possible people to select from
            set availableRandomForce = CreateForce()
            set BRTempForce = availableRandomForce
            call ForForce(BRRandomTeam, function AddToBRTempForce)

            // Add anyone in the BRRandomTeam to the created teams
            set randomPlayer = ForcePickRandomPlayer(availableRandomForce)
            call ForceRemovePlayer(availableRandomForce, randomPlayer)

            loop
                exitwhen randomPlayer == null

                set randomTeamIndex = GetRandomInt(0, TempPlayerForceIndex)

                call ForceRemovePlayer(availableRandomForce, randomPlayer)
                call ForceAddPlayer(BRPlayers, randomPlayer)
                call ForceAddPlayer(BRUsedTeams[randomTeamIndex], randomPlayer)
                call ForceAddPlayer(BRPlayerForce[randomTeamIndex], randomPlayer)

                set randomPlayer = ForcePickRandomPlayer(availableRandomForce)
            endloop

            // Hack? If there was only one person in the random vote. Can probably remove?
            if (TempPlayerForceIndex == 0 and CountPlayersInForceBJ(BRRandomTeam) > 0) then
                set TempPlayerForceIndex = 1
            endif
        endif

        call ForForce(BRSolo, function AddPlayerToNextAvailableForce)

        // Set the team count
        set BRTeamCount = TempPlayerForceIndex

        // Update the UI so everyone sees what happened
        call UpdateBRPlayerSlots()

        call SetBRLockStatus(false)

        // Cleanup
        call ForceClear(availableRandomForce)
        call DestroyForce(availableRandomForce)
        set availableRandomForce = null
        set randomPlayer = null
    endfunction

    private function RandomizeComputers takes nothing returns nothing
        if (GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
            call TryMovePlayerToForce(GetEnumPlayer(), BRUsedTeams[GetRandomInt(0, 3)])
        endif
    endfunction

    private function MoveToSolo takes nothing returns nothing
        if (GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
            call TryMovePlayerToForce(GetEnumPlayer(), BRSolo)
        endif
    endfunction

    private function MoveToRandomVote takes nothing returns nothing
        if (GetPlayerController(GetEnumPlayer()) == MAP_CONTROL_COMPUTER) then
            call TryMovePlayerToForce(GetEnumPlayer(), BRRandomTeam)
        endif
    endfunction

    private function Random takes Args args returns nothing
        call ForForce(BRObservers, function RandomizeComputers)

        call UpdateBRPlayerSlots()
	endfunction
	
    private function Solo takes Args args returns nothing
        call ForForce(BRObservers, function MoveToSolo)

        call UpdateBRPlayerSlots()
	endfunction

    private function RandomVote takes Args args returns nothing
        call ForForce(BRObservers, function MoveToRandomVote)

        call UpdateBRPlayerSlots()
        call UpdateRandomTeamVoteText()
	endfunction

    private function init takes nothing returns nothing
        set BRHandleTitles = Table.create()
        set BRHandleDescriptions = Table.create()

        set BRObservers = CreateForce()
        set BRSolo = CreateForce()
        set BRRandomTeam = CreateForce()
        set BRTeam1 = CreateForce()
        set BRTeam2 = CreateForce()
        set BRTeam3 = CreateForce()
        set BRTeam4 = CreateForce()
        set BRPlayers = CreateForce()

        set BRPlayerForce[0] = CreateForce()
        set BRPlayerForce[1] = CreateForce()
        set BRPlayerForce[2] = CreateForce()
        set BRPlayerForce[3] = CreateForce()
        set BRPlayerForce[4] = CreateForce()
        set BRPlayerForce[5] = CreateForce()
        set BRPlayerForce[6] = CreateForce()
        set BRPlayerForce[7] = CreateForce()

		call Command.create(CommandHandler.Random).name("random").handles("random").help("random", "move all computer players to random teams")
        call Command.create(CommandHandler.Solo).name("solo").handles("solo").help("solo", "move all computer players to the solo team")
        call Command.create(CommandHandler.RandomVote).name("randomvote").handles("randomvote").help("randomvote", "move all computer players to the solo team")
    endfunction

endlibrary
