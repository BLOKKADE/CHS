library PlayerTimerModification requires RandomShit

    globals
        real RoundTime = 20 // Can be modified by game modes
        real PvpWaitDuration = 35 // Can be modified by game modes

        private integer NewPlayerCount
        private integer IntermediatePlayerCount
        private integer VeteranPlayerCount
    endglobals

    private function GetPlayerKnowledgeStatus takes nothing returns nothing
        local player p = GetEnumPlayer()
        local integer allPvpWins

        // Don't count anything for the player if they don't have a hero
        if (PlayerHeroes[GetPlayerId(p)] == null) then
            // Cleanup
            set p = null

            return
        endif

        set allPvpWins = PlayerStats.forPlayer(p).getAllPVPWins() // This is already filtered down per game mode

        // Beginner
        if (allPvpWins < 30) then
            set NewPlayerCount = NewPlayerCount + 1
        // Intermediate
        elseif (allPvpWins < 80) then
            set IntermediatePlayerCount = IntermediatePlayerCount + 1
        else
            set VeteranPlayerCount = VeteranPlayerCount + 1
        endif

        // Cleanup
        set p = null
    endfunction

    private function GetCategoryTimeByPlayerCount takes integer playerCount, real threePlusPlayerTime, real twoPlayerTime, real onePlayerTime returns real
        if (playerCount >= 3) then
            return I2R(playerCount) * threePlusPlayerTime
        elseif (playerCount == 2) then
            return I2R(playerCount) * twoPlayerTime
        elseif (playerCount == 1) then
            return I2R(playerCount) * onePlayerTime
        endif

        return 0.0
    endfunction

    private function GetPlayerKnowledgeStatuses takes nothing returns nothing
        set NewPlayerCount = 0
        set IntermediatePlayerCount = 0
        set VeteranPlayerCount = 0

        call ForForce(GetPlayersAll(), function GetPlayerKnowledgeStatus)
    endfunction

    function GetRoundWaitTime takes nothing returns real
        local real bonusRoundWaitTime = 0

        call GetPlayerKnowledgeStatuses()

        set bonusRoundWaitTime = bonusRoundWaitTime + GetCategoryTimeByPlayerCount(NewPlayerCount, 2.0, 3.0, 4.0)
        set bonusRoundWaitTime = bonusRoundWaitTime + GetCategoryTimeByPlayerCount(IntermediatePlayerCount, 1.0, 1.5, 2.0)
        set bonusRoundWaitTime = bonusRoundWaitTime + IMaxBJ(VeteranPlayerCount - 2, 0) * -1.5

        return RoundTime + bonusRoundWaitTime
    endfunction

    function GetPvpRoundWaitTime takes nothing returns real
        local real bonusRoundWaitTime = 0

        call GetPlayerKnowledgeStatuses()

        set bonusRoundWaitTime = bonusRoundWaitTime + GetCategoryTimeByPlayerCount(NewPlayerCount, 2.0, 3.0, 4.0)
        set bonusRoundWaitTime = bonusRoundWaitTime + GetCategoryTimeByPlayerCount(IntermediatePlayerCount, 1.0, 1.5, 2.0)
        set bonusRoundWaitTime = bonusRoundWaitTime + IMaxBJ(VeteranPlayerCount - 2, 0) * -1.5

        return PvpWaitDuration + bonusRoundWaitTime
    endfunction

endlibrary
