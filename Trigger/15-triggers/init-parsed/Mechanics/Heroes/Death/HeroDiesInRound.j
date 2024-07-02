library HeroDiesInRound initializer init requires RandomShit, PetDeath

    private function HeroDiesInRoundConditions takes nothing returns boolean
        return IsPlayerHero(GetTriggerUnit())
    endfunction

    private function RemovePlayerUnit takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function ShowDefeatMessageToPlayer takes nothing returns nothing
        call CustomDefeatBJ(GetEnumPlayer(), "Defeat!")
    endfunction

    private function HeroDiesInRoundActions takes nothing returns nothing
        local player currentPlayer = GetOwningPlayer(GetTriggerUnit())
        local group playerUnits = GetUnitsOfPlayerAll(currentPlayer)

        call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(currentPlayer) + " |cffffcc00has fallen at level " + I2S(RoundNumber) + "!|r")
        call DisableTrigger(FaerieDragonDiesTrigger)
        call ForGroup(playerUnits, function RemovePlayerUnit)
        call EnableTrigger(FaerieDragonDiesTrigger)

        // Cleanup
        call DestroyGroup(playerUnits)
        set playerUnits = null
        set currentPlayer = null

        if (PlayerCount - 1 <= 0) then
            call DisableTrigger(PlayerAntiStuckTrigger)
            call DisableTrigger(GetTriggeringTrigger())
            call DisableTrigger(PlayerCompleteRoundTrigger)

            call TriggerSleepAction(2)

            if (InitialPlayerCount > 1) then
                call CustomVictoryBJ(SingleplayerPlayer, true, true)
            else
                call CustomDefeatBJ(SingleplayerPlayer, "Defeat!")
            endif

            call ForForce(DefeatedPlayers, function ShowDefeatMessageToPlayer)
        endif
    endfunction

    private function init takes nothing returns nothing
        set HeroDiesInRoundTrigger = CreateTrigger()
        call DisableTrigger(HeroDiesInRoundTrigger)
        call TriggerRegisterAnyUnitEventBJ(HeroDiesInRoundTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(HeroDiesInRoundTrigger, Condition(function HeroDiesInRoundConditions))
        call TriggerAddAction(HeroDiesInRoundTrigger, function HeroDiesInRoundActions)
    endfunction

endlibrary
