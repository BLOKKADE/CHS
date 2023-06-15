library BattleCreatorManager initializer init requires HeroPassiveDesc

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
        /*local integer observerCount = CountPlayersInForceBJ(BRObservers)
        local integer soloCount = CountPlayersInForceBJ(BRSolo)
        local integer team1Count = CountPlayersInForceBJ(BRTeam1)
        local integer team2Count = CountPlayersInForceBJ(BRTeam2)
        local integer team3Count = CountPlayersInForceBJ(BRTeam3)
        local integer team4Count = CountPlayersInForceBJ(BRTeam4)
        local integer nonObserverCount = BRRoundPlayerCount - observerCount

        if (soloCount > 1) then
            return true
        endif

        if (team1Count == nonObserverCount) then
            return false
        elseif (team2Count == nonObserverCount) then
            return false
        elseif (team3Count == nonObserverCount) then
            return false
        elseif (team4Count == nonObserverCount) then
            return false
        elseif (observerCount == BRRoundPlayerCount) then
            return false
        elseif (team1Count == 1 and team2Count == 0 and team3Count == 0 and team4Count == 0) then
            return false
        elseif (team1Count == 0 and team2Count == 1 and team3Count == 0 and team4Count == 0) then
            return false
        elseif (team1Count == 0 and team2Count == 0 and team3Count == 1 and team4Count == 0) then
            return false
        elseif (team1Count == 0 and team2Count == 0 and team3Count == 0 and team4Count == 1) then
            return false
        endif

        return true*/
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

    function TryMovePlayerToForce takes player p, force destinationForce returns boolean
        // Remove the player from everything if they left the game
        if (GetPlayerController(p) != MAP_CONTROL_COMPUTER and GetPlayerSlotState(p) != PLAYER_SLOT_STATE_PLAYING) then
            call ForceRemovePlayer(BRRandomTeam, p)
            call ForceRemovePlayer(BRObservers, p)
            call ForceRemovePlayer(BRSolo, p)
            call ForceRemovePlayer(BRTeam1, p)
            call ForceRemovePlayer(BRTeam2, p)
            call ForceRemovePlayer(BRTeam3, p)
            call ForceRemovePlayer(BRTeam4, p)

            return true
        endif

        // Don't do anything if the player is already in the destination force
        if (IsPlayerInForce(p, destinationForce) or IsPlayerInForce(p, BRRandomTeam)) then
            return false
        endif

        call ForceRemovePlayer(BRObservers, p)
        call ForceRemovePlayer(BRSolo, p)
        call ForceRemovePlayer(BRTeam1, p)
        call ForceRemovePlayer(BRTeam2, p)
        call ForceRemovePlayer(BRTeam3, p)
        call ForceRemovePlayer(BRTeam4, p)

        call ForceAddPlayer(destinationForce, p)

        return true
    endfunction

    function TryMovePlayerFromForceToForce takes player p, force sourceFource, force destinationForce returns boolean
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
        // Don't check if we already know there is a hero alive for this force
        if (ForceHasHeroesAlive) then
            return
        endif

        set ForceHasHeroesAlive = UnitAlive(PlayerHeroes[GetPlayerId(GetEnumPlayer())])
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

        set AddedPlayerToForce = false
        set TempPlayerForceIndex = 0

        call ResetBRPlayerForce()

        // Make random teams if majority voted
        if (CountPlayersInForceBJ(BRRandomTeam) > (nonObserverCount / 2)) then
            // Use the amount of players, excluding those in the solo queue
            set remainingPlayerCount = nonObserverCount - CountPlayersInForceBJ(BRSolo)

            // Determine random team count
            if (remainingPlayerCount == 8) then
                set teamCount = GetRandomInt(2, 4)
            elseif (remainingPlayerCount == 7) then
                set teamCount = GetRandomInt(2, 4)
            elseif (remainingPlayerCount == 6) then
                set teamCount = GetRandomInt(2, 3)
            elseif (remainingPlayerCount == 5) then
                set teamCount = GetRandomInt(2, 3)
            elseif (remainingPlayerCount == 4) then
                set teamCount = GetRandomInt(2, 2)
            elseif (remainingPlayerCount == 3) then
                set teamCount = GetRandomInt(2, 2)
            elseif (remainingPlayerCount == 2) then
                set teamCount = GetRandomInt(2, 2)
            endif

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
                call ForceRemovePlayer(availableRandomForce, randomPlayer)

                set currentTeamSize = 0

                // Add the specified amount of random players to the current team
                loop
                    exitwhen currentTeamSize == teamSize or randomPlayer == null
    
                    call ForceAddPlayer(BRUsedTeams[currentTeamCount], randomPlayer)
                    call ForceAddPlayer(BRPlayerForce[currentTeamCount], randomPlayer)
    
                    set currentTeamSize = currentTeamSize + 1
                endloop

                // Create the next team
                set currentTeamCount = currentTeamCount + 1
            endloop

            // Cleanup
            call ForceClear(availableRandomForce)
            call DestroyForce(availableRandomForce)
            set availableRandomForce = null
        else
            // Each specified team gets assigned to their own team
            call CopyForceToNextAvailableForce(BRTeam1)
            call CopyForceToNextAvailableForce(BRTeam2)
            call CopyForceToNextAvailableForce(BRTeam3)
            call CopyForceToNextAvailableForce(BRTeam4)

            // Add anyone in the BRRandomTeam to the created teams
            set randomPlayer = ForcePickRandomPlayer(BRRandomTeam)

            loop
                exitwhen randomPlayer == null

                set randomTeamIndex = GetRandomInt(0, TempPlayerForceIndex)

                call ForceRemovePlayer(BRRandomTeam, randomPlayer)
                call ForceAddPlayer(BRUsedTeams[randomTeamIndex], randomPlayer)
                call ForceAddPlayer(BRPlayerForce[randomTeamIndex], randomPlayer)
            endloop
        endif
        
        call ForForce(BRSolo, function AddPlayerToNextAvailableForce)

        // Set the team count
        set BRTeamCount = TempPlayerForceIndex

        // Update the UI so everyone sees what happened
        call UpdateBRPlayerSlots()

        call SetBRLockStatus(false)

        // Cleanup
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

    private function Random takes Args args returns nothing
        call ForForce(BRObservers, function RandomizeComputers)

        call UpdateBRPlayerSlots()
	endfunction
	
    private function Solo takes Args args returns nothing
        call ForForce(BRObservers, function MoveToSolo)

        call UpdateBRPlayerSlots()
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
        call Command.create(CommandHandler.Random).name("solo").handles("solo").help("solo", "move all computer players to the solo team")
    endfunction

endlibrary
