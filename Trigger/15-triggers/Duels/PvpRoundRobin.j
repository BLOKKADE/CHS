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
        private IntegerList UsedArenas // Contains the arenas that are used for current duels
        private DuelGame TempDuelGame // Temporary global variable for DisplayNemesisNames

        DuelGame CurrentDuelGame // Used to reference the current duel for betting pruposes. Doesn't work properly for simultaneous duels.
        IntegerList DuelGameList // The list of duels that doesn't get emptied as we get duels
        IntegerList DuelGameListRemaining // The list of duels that gets emptied as we get duels
        integer OddPlayer = -1 // The player id of the odd player
    endglobals

    function DisplayNemesisNames takes nothing returns nothing
        local IntegerListItem node = DuelGameList.first
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
                call DisplayTimedTextToForce(currentDuelGame.team1, 25, team1ForceString + "|cffff0000 PVP opponents are|r " + team2ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team1, 25, "|cffff0000Your PVP opponent is|r " + team2ForceString)
            endif

            // Display team1 opponents to team2
            if (CountPlayersInForceBJ(currentDuelGame.team1) > 1) then // This is assuming equal team sizes
                call DisplayTimedTextToForce(currentDuelGame.team2, 25, team2ForceString + "|cffff0000 PVP opponents are|r " + team1ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team2, 25, "|cffff0000Your PVP opponent is|r " + team1ForceString)
            endif

            set node = node.next
        endloop
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
        rect arena
        boolean team1Won
        
        private static thistype recycle = 0
        private static integer instanceCount = 0
        private thistype next

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

        static method create takes force team1, force team2, rect arena returns thistype
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.next
            endif

            set this.team1 = team1
            set this.team2 = team2
            set this.arena = arena

            return this
        endmethod

        method destroy takes nothing returns nothing
            //call BJDebugMsg("destroy duelgame")
            call DestroyForce(team1)
            call DestroyForce(team2)
            set this.team1 = null
            set this.team2 = null
            set this.arena = null
            set next = recycle
            set recycle = this
        endmethod
    endstruct

    function AddOddPlayerDuel takes player duelPlayer returns nothing
        local force team1 = CreateForce()
        local force team2 = CreateForce()
        local integer playerArenaRectIndex = GetRandomInt(1, 8) // Represents all arenas
        local DuelGame currentDuelGame

        // Reset everything. All of these duels should be over by now
        call DuelGameList.clear()
        call DuelGameListRemaining.clear()
        call UsedArenas.clear()

        // Create the odd 1v1 duel
        call ForceAddPlayer(team1, duelPlayer)
        call ForceAddPlayer(team2, Player(OddPlayer))

        set currentDuelGame = DuelGame.create(team1, team2, PlayerArenaRects[playerArenaRectIndex])

        call DuelGameList.push(currentDuelGame)
        call DuelGameListRemaining.push(currentDuelGame)

        set team1 = null
        set team2 = null
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
        local integer playerArenaRectIndex
        local DuelGame currentDuelGame
        local integer teamPlayerLimit

        // If team duel is enabled, and the 12.5% chance passes, and there are either 4 or 8 people, do a 2v2 fight
        if (TeamDuelMode == 2 and /*(GetRandomInt(1, 8) == 1) and*/ ModuloInteger(PlayerList.size(), 4) == 0) then
            set teamPlayerLimit = 2
            set limit = PlayerList.size() / (2 * teamPlayerLimit)
        else
            set teamPlayerLimit = 1
            set limit = PlayerList.size() / (2 * teamPlayerLimit)
        endif

        call DuelGameList.clear()
        call DuelGameListRemaining.clear()
        call UsedArenas.clear()

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

            // Find an open arena
            loop
                set playerArenaRectIndex = GetRandomInt(1, 8) // Represents all arenas

                if (UsedArenas.find(playerArenaRectIndex) == 0) then
                    call UsedArenas.push(playerArenaRectIndex)
                    exitwhen true
                endif
            endloop

            set currentDuelGame = DuelGame.create(team1, team2, PlayerArenaRects[playerArenaRectIndex])
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

        if OddPlayer != -1 then
            call PlayerList.unshift(OddPlayer)
            set OddPlayer = -1
        endif

        set team1 = null
        set team2 = null
    endfunction


    function UpdatePlayers takes nothing returns nothing
        local integer i = 0

        loop
            if not UnitAlive(PlayerHeroes[i + 1]) then
                call PlayerList.erase(PlayerList.find(i))
            endif
            set i = i + 1
            exitwhen i > 7
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
        set PlayerList = PlayerList.create()
        set DuelGameList = DuelGameList.create()
        set DuelGameListRemaining = DuelGameListRemaining.create()
        set UsedArenas = UsedArenas.create()
        
        loop
            if /*UnitAlive(PlayerHeroes[i + 1])*/ true then
                call PlayerList.push(i)
            endif
            set i = i + 1
            exitwhen i > 7
        endloop
        set i = 0
    endfunction

    function UpdatePlayerCount takes nothing returns nothing
        if not initialised then
            set initialised = true
            call init()
        endif

        call UpdatePlayers()
    endfunction

endlibrary