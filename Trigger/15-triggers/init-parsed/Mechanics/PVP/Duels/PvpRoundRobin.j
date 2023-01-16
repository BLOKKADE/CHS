library PvpRoundRobin requires ListT, ForceHelper, VotingResults
    /*
        Round robin style tournament for more info see: https://en.wikipedia.org/wiki/Round-robin_tournament#Circle_method
        PlayerList = list of player ids that is moved around round robin style
        DuelGameList = each duel that will be held for the next round
        TemPlayerLimit = the amount of players per team for duels
        OddPlayer = set to a player number if there's an odd amount of player


        Run UpdatePlayerCount() before duels to update the PlayerList and make sure only surviving player ids are in it
        Run MoveRoundRobin() before duels after ^ (except first duels round) to move the ids in PlayerList around
        refer to GetNextDuel to get the DuelGame struct for the next duel
    */

    globals
        private boolean initialised = false
        private IntegerList PlayerList // Contains all active players
        private boolean array UsedArenas // Contains the arenas that are used for current duels
        private DuelGame TempDuelGame // Temporary global variable for DisplayNemesisNames

        private integer DuelPrepareDuration = 10
        private integer NextPvpBattleDuration = 15

        DuelGame CurrentDuelGame // Used to reference the current duel for betting purposes. Doesn't work properly for simultaneous duels.
        IntegerList DuelGameList // The list of duels that doesn't get emptied as we get duels
        IntegerList DuelGameListRemaining // The list of duels that gets emptied as we get duels
        integer OddPlayer = -1 // The player id of the odd player
    endglobals

    function DisplayNemesisNames takes nothing returns nothing
        local IntegerListItem node = DuelGameListRemaining.first
        local DuelGame currentDuelGame
        local string team1ForceString
        local string team2ForceString

        loop
            exitwhen node == 0
            
            set currentDuelGame = node.data

            set team1ForceString = ConvertForceToUnitString(currentDuelGame.team1)
            set team2ForceString = ConvertForceToUnitString(currentDuelGame.team2)

            // Display team2 opponents to team1
            if (CountPlayersInForceBJ(currentDuelGame.team2) > 1) then // This is assuming equal team sizes
                call DisplayTimedTextToForce(currentDuelGame.team1, pvpWaitDuration, team1ForceString + "|cffff0000 PVP opponents are|r " + team2ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team1, pvpWaitDuration, "|cffff0000Your PVP opponent is|r " + team2ForceString)
            endif

            // Display team1 opponents to team2
            if (CountPlayersInForceBJ(currentDuelGame.team1) > 1) then // This is assuming equal team sizes
                call DisplayTimedTextToForce(currentDuelGame.team2, pvpWaitDuration, team2ForceString + "|cffff0000 PVP opponents are|r " + team1ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team2, pvpWaitDuration, "|cffff0000Your PVP opponent is|r " + team1ForceString)
            endif

            set node = node.next
        endloop

        if (OddPlayer != -1) then
            call DisplayTimedTextToPlayer(Player(OddPlayer), 0, 0, pvpWaitDuration, "|cffff0000You are the odd player out. You will duel the loser of the first finished duel.|r")
        endif
    endfunction

    function GetNextDuel takes nothing returns DuelGame
        local DuelGame duelGame = DuelGameListRemaining.back()
        set CurrentDuelGame = duelGame
        call DuelGameListRemaining.pop()
        return duelGame
    endfunction

    struct DuelGame extends array
        force team1
        force team2
        boolean isDuelOver
        boolean isInitialized
        boolean team1Won
        boolean fightStarted
        SuddenDeath suddenDeath

        // Duel prepare timer dialog properties
        private timer DuelPrepareTimer
        private timerdialog DuelPrepareDialog

        // Next PVP battle timer dialog properties
        private timer NextPvpBattleTimer
        private timerdialog NextPvpBattleDialog

        private integer arenaIndex
        private integer currentCountdown
        private integer startTick
        private integer nextTick

        static method startCountdowns takes nothing returns nothing
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                set currentDuelGame = node.data

                if (currentDuelGame.isInitialized and (not currentDuelGame.fightStarted)) then
                    call currentDuelGame.startCountdown()
                endif

                set node = node.next
            endloop
        endmethod

        static method showPrepareTimerDialogs takes nothing returns nothing
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                set currentDuelGame = node.data

                if (currentDuelGame.isInitialized and (not currentDuelGame.fightStarted)) then
                    call currentDuelGame.setupPrepareTimer()
                endif

                set node = node.next
            endloop
        endmethod

        static method startDuels takes nothing returns nothing
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                set currentDuelGame = node.data

                if (currentDuelGame.isInitialized and (not currentDuelGame.fightStarted)) then
                    set currentDuelGame.fightStarted = true

                    call currentDuelGame.suddenDeath.start()
                    call currentDuelGame.cleanupPrepareDialog()
                endif

                set node = node.next
            endloop
        endmethod

        static method cleanupDuels takes nothing returns nothing
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                set currentDuelGame = node.data

                call currentDuelGame.destroy()

                set node = node.next
            endloop
        endmethod

        static method areAllDuelsOver takes nothing returns boolean
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                
                set currentDuelGame = node.data

                if (not currentDuelGame.isDuelOver) then
                    return false
                endif

                set node = node.next
            endloop

            return true
        endmethod

        static method getPlayerDuelGame takes player p returns thistype
            local IntegerListItem node = DuelGameList.first
            local DuelGame currentDuelGame

            loop
                exitwhen node == 0
                
                set currentDuelGame = node.data

                if (IsPlayerInForce(p, currentDuelGame.team1) or IsPlayerInForce(p, currentDuelGame.team2)) then
                    return currentDuelGame
                endif

                set node = node.next
            endloop

            return 0
        endmethod
        
        method getEnemyPlayerTeam takes player p returns force
            if (IsPlayerInForce(p, this.team1)) then
                return this.team2
            elseif (IsPlayerInForce(p, this.team2)) then
                return this.team1
            else
                return null
            endif
        endmethod

        method getPlayerTeam takes player p returns force
            if (IsPlayerInForce(p, this.team1)) then
                return this.team1
            elseif (IsPlayerInForce(p, this.team2)) then
                return this.team2
            else
                return null
            endif
        endmethod

        method getDuelArena takes nothing returns rect
            return PlayerArenaRects[this.arenaIndex]
        endmethod
        
        method removeUsedArena takes nothing returns nothing
            // Remove the arena that was used for this duel so it can be used in another duel
            set UsedArenas[this.arenaIndex] = false
        endmethod

        method cleanupPrepareDialog takes nothing returns nothing
            if (this.DuelPrepareDialog != null) then
                call ReleaseTimer(this.DuelPrepareTimer)
                call TimerDialogDisplay(this.DuelPrepareDialog, false)
                call DestroyTimerDialog(this.DuelPrepareDialog)

                set this.DuelPrepareTimer = null
                set this.DuelPrepareDialog = null
            endif
        endmethod
        
        method cleanupNextPvpBattleDialog takes nothing returns nothing
            if (this.NextPvpBattleDialog != null) then
                call ReleaseTimer(this.NextPvpBattleTimer)
                call TimerDialogDisplay(this.NextPvpBattleDialog, false)
                call DestroyTimerDialog(this.NextPvpBattleDialog)
    
                set this.NextPvpBattleTimer = null
                set this.NextPvpBattleDialog = null
            endif
        endmethod

        method setupNextPvpBattleTimer takes nothing returns nothing
            set NextPvpBattleTimer = NewTimer()
            call TimerStart(this.NextPvpBattleTimer, NextPvpBattleDuration, false, null)
            set this.NextPvpBattleDialog = CreateTimerDialog(this.NextPvpBattleTimer)
            call TimerDialogDisplay(this.NextPvpBattleDialog, false)
            call TimerDialogSetTitle(this.NextPvpBattleDialog, "Next PvP Battle ...")
            
            if SimultaneousDuelMode == 1 or BlzForceHasPlayer(this.team1, GetLocalPlayer()) or BlzForceHasPlayer(this.team2, GetLocalPlayer()) then
                call TimerDialogDisplay(this.NextPvpBattleDialog, true)
            endif
        endmethod

        method setupPrepareTimer takes nothing returns nothing
            call this.cleanupNextPvpBattleDialog()

            set DuelPrepareTimer = NewTimer()
            call TimerStart(this.DuelPrepareTimer, DuelPrepareDuration, false, null)
            set this.DuelPrepareDialog = CreateTimerDialog(this.DuelPrepareTimer)
            call TimerDialogDisplay(this.DuelPrepareDialog, false)
            call TimerDialogSetTitle(this.DuelPrepareDialog, "Prepare ...")

            // Show the dialog for everyone if this is not simulataneous duels
            if SimultaneousDuelMode == 1 then
                call TimerDialogDisplay(this.DuelPrepareDialog, true)
            // Only show the dialog and play the noise for the team2 if simultaneous duels
            elseif BlzForceHasPlayer(this.team1, GetLocalPlayer()) or BlzForceHasPlayer(this.team2, GetLocalPlayer()) then
                call TimerDialogDisplay(this.DuelPrepareDialog, true)
            endif
        endmethod

        private method periodic takes nothing returns nothing
            local location arenaCenter

            if this.currentCountdown > 0 then
                if T32_Tick > this.nextTick then
                    set this.nextTick = T32_Tick + 32

                    set arenaCenter = GetRectCenter(this.getDuelArena())

                    // Display the number
                    call CreateTextTagLocBJ(I2S(this.currentCountdown) + " ...", arenaCenter, 0.00, 40.00, 100, I2R(this.currentCountdown * 20), I2R(this.currentCountdown * 20), 0)
                    call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                    call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.80)
                    call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)

                    // Cleanup
                    call RemoveLocation(arenaCenter)
                    set arenaCenter = null

                    set this.currentCountdown = this.currentCountdown - 1

                    if SimultaneousDuelMode == 1 or BlzForceHasPlayer(this.team1, GetLocalPlayer()) or BlzForceHasPlayer(this.team2, GetLocalPlayer()) then
                        call PlaySoundBJ(udg_sound09) // Ticking noise
                    endif
                endif
            else
                call this.stopPeriodic()
            endif
        endmethod 

        method startCountdown takes nothing returns nothing
            set this.startTick = T32_Tick
            set this.nextTick = T32_Tick + 32
            call this.startPeriodic()
        endmethod

        static method create takes force team1, force team2, integer arenaIndex returns thistype
            local thistype this = thistype.setup()

            set this.team1 = team1
            set this.team2 = team2
            set this.arenaIndex = arenaIndex
            set this.suddenDeath = SuddenDeath.create(this)
            set this.isDuelOver = false
            set this.team1Won = false
            set this.fightStarted = false
            set this.isInitialized = false
            set this.currentCountdown = 5

            return this
        endmethod

        method destroy takes nothing returns nothing
            call DestroyForce(team1)
            call DestroyForce(team2)
            set this.team1 = null
            set this.team2 = null

            call this.cleanupPrepareDialog()
            call this.cleanupNextPvpBattleDialog()

            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    private function ResetUsedArenas takes nothing returns nothing
        local integer playerArenaRectIndex = 0

        loop
            exitwhen playerArenaRectIndex == 20

            set UsedArenas[playerArenaRectIndex] = false

            set playerArenaRectIndex = playerArenaRectIndex + 1
        endloop
    endfunction

    private function GetOpenArenaIndex takes nothing returns integer
        local integer playerArenaRectIndex

        // Find an open arena
        loop
            set playerArenaRectIndex = GetRandomInt(0, 7) // Represents all arenas

            if (not UsedArenas[playerArenaRectIndex]) then
                set UsedArenas[playerArenaRectIndex] = true
                exitwhen true
            endif
        endloop

        return playerArenaRectIndex
    endfunction

    function AddOddPlayerDuel takes player duelPlayer returns DuelGame
        local force team1 = CreateForce()
        local force team2 = CreateForce()
        local DuelGame currentDuelGame

        // Create the odd 1v1 duel
        call ForceAddPlayer(team1, duelPlayer)
        call ForceAddPlayer(team2, Player(OddPlayer))

        set currentDuelGame = DuelGame.create(team1, team2, GetOpenArenaIndex())

        call DuelGameList.unshift(currentDuelGame)
        call DuelGameListRemaining.unshift(currentDuelGame)

        set team1 = null
        set team2 = null

        return currentDuelGame
    endfunction

    function MoveRoundRobin takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local integer limit
        local integer tempBack
        local integer tempFront
        local IntegerList tempPlayerList = IntegerList[PlayerList]
        local force team1
        local force team2
        local DuelGame currentDuelGame
        local integer teamPlayerLimit

        // If team duel is enabled, and the 12.5% chance passes, and there are either 4 or 8 people, do a 2v2 fight
        if (TeamDuelMode == 2 and (GetRandomInt(1, 8) == 1) and ModuloInteger(PlayerList.size(), 4) == 0) then
            set teamPlayerLimit = 2
            set limit = PlayerList.size() / (2 * teamPlayerLimit)
        else
            set teamPlayerLimit = 1
            set limit = PlayerList.size() / (2 * teamPlayerLimit)
        endif

        call DuelGameList.clear()
        call DuelGameListRemaining.clear()
        call ResetUsedArenas()

        loop
            set team1 = CreateForce()
            set team2 = CreateForce()

            set j = teamPlayerLimit
            loop
                call ForceAddPlayer(team1, Player(tempPlayerList.front()))
                call ForceAddPlayer(team2, Player(tempPlayerList.back()))

                call tempPlayerList.pop()
                call tempPlayerList.shift()
                set j = j - 1
                exitwhen j <= 0
            endloop

            set currentDuelGame = DuelGame.create(team1, team2, GetOpenArenaIndex())
            call DuelGameList.push(currentDuelGame)
            call DuelGameListRemaining.push(currentDuelGame)

            set i = i + 1
            exitwhen i >= limit
        endloop

        set tempFront = PlayerList.front()
        set tempBack = PlayerList.back()

        call PlayerList.shift()
        call PlayerList.pop()

        call PlayerList.unshift(tempBack)
        call PlayerList.unshift(tempFront)

        set team1 = null
        set team2 = null
    endfunction


    function UpdatePlayers takes nothing returns nothing
        local integer i = 0

         // Move the odd player to the beginning of the player list. UpdatePlayers we get a new OddPlayer
         if OddPlayer != -1 then
            call PlayerList.unshift(OddPlayer)
            set OddPlayer = -1
        endif

        loop
            if not UnitAlive(PlayerHeroes[i]) then
                call PlayerList.erase(PlayerList.find(i))
            endif
            set i = i + 1
            exitwhen i == 20
        endloop

        if ModuloInteger(PlayerList.size(), 2) != 0 then
            set OddPlayer = PlayerList.back()
            call PlayerList.pop()
        else
            set OddPlayer = -1
        endif
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local integer tempPlayerId = 0
        local integer array tempPlayerIds
        local integer playerCount = 0

        set PlayerList = PlayerList.create()
        set DuelGameList = DuelGameList.create()
        set DuelGameListRemaining = DuelGameListRemaining.create()
        call ResetUsedArenas()
        
        // Add players that are in the game
        loop
            if (UnitAlive(PlayerHeroes[i])) then
                set tempPlayerIds[playerCount] = i
                set playerCount = playerCount + 1
            endif
            set i = i + 1
            exitwhen i == 20
        endloop

        set i = playerCount - 1

        // Shuffle the array https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle#The_modern_algorithm
        loop
            exitwhen i == 0

            set j = MathRound_floor(GetRandomReal(0, 1) * (i + 1))
            set tempPlayerId = tempPlayerIds[i]
            set tempPlayerIds[i] = tempPlayerIds[j]
            set tempPlayerIds[j] = tempPlayerId

            set i = i - 1
        endloop

        set i = 0

        // Add shuffled players into the player list used by the round robin algorithm
        loop
            exitwhen i == playerCount
            call PlayerList.push(tempPlayerIds[i])
            set i = i + 1
        endloop
    endfunction

    function UpdatePlayerCount takes nothing returns nothing
        if not initialised then
            set initialised = true
            call init()
        endif

        call UpdatePlayers()
    endfunction

endlibrary