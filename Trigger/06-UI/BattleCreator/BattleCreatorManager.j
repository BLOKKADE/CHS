library BattleCreatorManager initializer init

    globals
        // Player force array representing all teams. Can be up to 8 teams.
        force array BRPlayerForce
        force array BRRandomPlayerForce
        force BRPlayers
        boolean array UsedPlayerForce

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

        // Temp variables
        private integer TempPlayerForceIndex
        private boolean ForceHasHeroesAlive
        private boolean AddedPlayerToForce
    endglobals
    
    private function IsPlayerHeroAlive takes nothing returns nothing
        // Don't check if we already know there is a hero alive for this force
        if (ForceHasHeroesAlive) then
            return
        endif

        set ForceHasHeroesAlive = UnitAlive(PlayerHeroes[GetPlayerId(GetEnumPlayer())])
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

    private function ResetBRPlayerForce takes nothing returns nothing
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

    function CalculateFreeForAllPlayerForces takes force validPlayers returns nothing
        call ResetBRPlayerForce()

        set TempPlayerForceIndex = 0
        call ForForce(validPlayers, function AddPlayerToNextAvailableForce)
        set BRTeamCount = TempPlayerForceIndex
    endfunction

    private function CopyForceToNextAvailableForce takes force sourceForce returns nothing
        set AddedPlayerToForce = false

        call ForForce(sourceForce, function AddPlayerToCurrentAvailableForce)

        if (AddedPlayerToForce) then
            set TempPlayerForceIndex = TempPlayerForceIndex + 1
        endif
    endfunction

    function CalculatePlayerForces takes nothing returns nothing
        set AddedPlayerToForce = false

        call ResetBRPlayerForce()

        call ForForce(BRSolo, function AddPlayerToNextAvailableForce)

        call CopyForceToNextAvailableForce(BRTeam1)
        call CopyForceToNextAvailableForce(BRTeam2)
        call CopyForceToNextAvailableForce(BRTeam3)
        call CopyForceToNextAvailableForce(BRTeam4)
    endfunction

    private function init takes nothing returns nothing
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
    endfunction

endlibrary
