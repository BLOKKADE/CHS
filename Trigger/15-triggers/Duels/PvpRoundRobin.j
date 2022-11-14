library PvpRoundRobin requires ListT, ForceHelper
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
        DuelGame CurrentDuel

        private boolean initialised = false
        IntegerList PlayerList
        IntegerList DuelGameList
        integer OddPlayer = -1

        //has to be either 1 2 or 4 TODO: support 3
        private constant integer TeamPlayerLimit = 2
    endglobals

    function DisplayNemesisNames takes nothing returns nothing
        local integer duelGameIndex = 0
        local DuelGame currentDuelGame
        local string team1ForceString
        local string team2ForceString

        loop
            set currentDuelGame = DuelGameList[duelGameIndex]
            set team1ForceString = ConvertForceToString(currentDuelGame.team1)
            set team2ForceString = ConvertForceToString(currentDuelGame.team2)

            // Display team2 opponents to team1
            if (CountPlayersInForceBJ(currentDuelGame.team2) > 1) then
                call DisplayTimedTextToForce(currentDuelGame.team1, 25, "Your opponents are " + team2ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team1, 25, "Your opponent is " + team2ForceString)
            endif

            // Display team1 opponents to team2
            if (CountPlayersInForceBJ(currentDuelGame.team1) > 1) then
                call DisplayTimedTextToForce(currentDuelGame.team2, 25, "Your opponents are " + team1ForceString)
            else
                call DisplayTimedTextToForce(currentDuelGame.team2, 25, "Your opponent is " + team1ForceString)
            endif

            set duelGameIndex = duelGameIndex + 1

            exitwhen duelGameIndex == DuelGameList.size()
        endloop
    endfunction

    function GetNextDuel takes nothing returns DuelGame
        local DuelGame duelGame = DuelGameList.back()
        set CurrentDuel = duelGame
        call DuelGameList.pop()
        return duelGame
    endfunction

    struct DuelGame extends array
        force team1
        force team2
        boolean isDuelOver
        rect arena

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
            loop
                set currentDuelGame = DuelGameList[duelGameIndex]
    
                if (not currentDuelGame.isDuelOver) then
                    return false
                endif
    
                set duelGameIndex = duelGameIndex + 1
    
                exitwhen duelGameIndex == DuelGameList.size()
            endloop

            return true
        endmethod

        static method getPlayerDuelGame takes player p returns thistype
            local integer duelGameIndex = 0
            local DuelGame currentDuelGame
    
            loop
                set currentDuelGame = DuelGameList[duelGameIndex]
    
                if (IsPlayerInForce(p, currentDuelGame.team1) or IsPlayerInForce(p, currentDuelGame.team2)) then
                    return currentDuelGame
                endif
    
                set duelGameIndex = duelGameIndex + 1
    
                exitwhen duelGameIndex == DuelGameList.size()
            endloop
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
            set next = recycle
            set recycle = this
        endmethod
    endstruct

    function MoveRoundRobin takes nothing returns nothing
        local integer i = 0
        local integer j = 0
        local integer limit = PlayerList.size() / (2 * TeamPlayerLimit)
        local integer tempBack
        local integer tempFront
        local IntegerList tempPlayerList = IntegerList[PlayerList]
        local force team1
        local force team2
        local integer playerArenaRectIndex = GetRandomInt(1, 8) // Represents all arenas

        call DuelGameList.clear()

        loop
            set team1 = CreateForce()
            set team2 = CreateForce()

            set j = TeamPlayerLimit
            loop
                call ForceAddPlayer(team1, Player(tempPlayerList.front()))
                call ForceAddPlayer(team1, Player(tempPlayerList.back()))

                call tempPlayerList.pop()
                call tempPlayerList.shift()
                set j = j - 1
                exitwhen j <= 0
            endloop

            call DuelGameList.push(DuelGame.create(team1, team2, PlayerArenaRects[playerArenaRectIndex]))

            set playerArenaRectIndex = ModuloInteger(playerArenaRectIndex, 8)
            set playerArenaRectIndex = playerArenaRectIndex + 1
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


    function UpdatePlayers takes integer test returns nothing
        local integer i = 0

        loop
            if /*not UnitAlive(PlayerHeroes[i + 1]) */ i == test then
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

        loop
            if /*UnitAlive(PlayerHeroes[i + 1])*/ true then
                call PlayerList.push(i)
            endif
            set i = i + 1
            exitwhen i > 7
        endloop
        set i = 0
    endfunction

    function UpdatePlayerCount takes integer test returns nothing
        if not initialised then
            set initialised = true
            call init()
        endif

        call UpdatePlayers(test)
    endfunction

endlibrary