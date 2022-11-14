library SinglePvpBetReward initializer init requires RandomShit

    private function SinglePvpBetRewardConditions takes nothing returns boolean
        return CountUnitsInGroup(DuelWinners) > 0
    endfunction

    private function RewardDuelWinner takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)

        if (BettingPlayerCount > 0 and IsUnitAliveBJ(currentUnit) == true) then
            call SetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(currentPlayer, PLAYER_STATE_RESOURCE_GOLD) + PvpGoldWinAmount)
            call GroupRemoveUnit(DuelWinners, currentUnit)
        endif

        // Cleanup
        set currentUnit = null
        set currentPlayer = null
    endfunction

    private function SinglePvpBetRewardActions takes nothing returns nothing
        call ForGroup(DuelWinners, function RewardDuelWinner)
        call TriggerSleepAction(0.50)
        call ConditionalTriggerExecute(GetTriggeringTrigger())
    endfunction

    private function init takes nothing returns nothing
        set SinglePvpBetRewardTrigger = CreateTrigger()
        call TriggerAddCondition(SinglePvpBetRewardTrigger, Condition(function SinglePvpBetRewardConditions))
        call TriggerAddAction(SinglePvpBetRewardTrigger, function SinglePvpBetRewardActions)
    endfunction

endlibrary
