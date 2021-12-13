library PvpRoundRobin requires ListT
/*
Round robin style tournament for more info see: https://en.wikipedia.org/wiki/Round-robin_tournament#Circle_method
PlayerList = list of player ids that is moved around round robin style
DuelGameList = each duel that will be held for the next round
TemPlayerLimit = the amount of players per team for duels
OddPlayer = set to a player number if there's an odd amount of player


Run UpdatePlayerCount() before duels to update the PlayerList and make sure only surviving player ids are in it
Run MoveRoundRobin() after duels to move the ids in PlayerList around
refer to GetNextDuel to get the DuelGame struct for the next duel
*/

    globals
        private boolean initialised = false
        IntegerList PlayerList
        public IntegerList DuelGameList
        integer OddPlayer = -1

        //has to be either 1 2 or 4 TODO: support 3
        private constant integer TeamPlayerLimit = 2
    endglobals

    function GetNextDuel takes nothing returns DuelGame
        local DuelGame duelGame = DuelGameList.back()
        call DuelGameList.pop()
        return duelGame
    endfunction

    struct DuelGame extends array
        IntegerList team1
        IntegerList team2

        private static thistype recycle = 0
        private static integer instanceCount = 0
        private thistype next

        static method GetDuelGame takes integer id returns thistype
            return thistype[id]
        endmethod

        static method create takes IntegerList team1, IntegerList team2 returns thistype
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

            return this
        endmethod

        method destroy takes nothing returns nothing
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
        local IntegerList team1
        local IntegerList team2

        call DuelGameList.clear()

        loop
            set team1 = IntegerList.create()
            set team2 = IntegerList.create()

            set j = TeamPlayerLimit
            loop
                call team1.push(tempPlayerList.front())
                call team2.push(tempPlayerList.back())

                call tempPlayerList.pop()
                call tempPlayerList.shift()
                set j = j - 1
                exitwhen j <= 0
            endloop
            call DuelGameList.push(DuelGame.create(team1, team2))
            
            call ListT_print(team1, "t1: ")
            call ListT_print(team2, "t2: ")
            set i = i + 1
            exitwhen i >= limit
        endloop

        set tempFront = PlayerList.front()
        set tempBack = PlayerList.back()

        call PlayerList.shift()
        call PlayerList.pop()

        call PlayerList.unshift(tempBack)
        call PlayerList.unshift(tempFront)
    endfunction


    function UpdatePlayers takes integer test returns nothing
        local integer i = 0

        loop
            if /*not UnitAlive(udg_units01[i + 1]) */ i == test then
                call PlayerList.erase(PlayerList.find(i))
            endif
            set i = i + 1
            exitwhen i > 7
        endloop

        if ModuloInteger(PlayerList.size(), 2) != 0 then
            set OddPlayer = PlayerList.back()
            call PlayerList.pop()
        endif
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0
        set PlayerList = PlayerList.create()
        set DuelGameList = DuelGameList.create()

        loop
            if /*UnitAlive(udg_units01[i + 1])*/ true then
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