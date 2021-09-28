library DuelReward initializer init
    globals
        integer array DuelGoldReward
        force DuelWinners = CreateForce()
        force DuelLosers = CreateForce()
    endglobals

    function GiveGold takes nothing returns nothing
        call SetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetEnumPlayer(), PLAYER_STATE_RESOURCE_GOLD) + DuelGoldReward[udg_integer02])
    endfunction
    
    function GiveDuelReward takes nothing returns nothing
        call ForForce(DuelWinners, function GiveGold)
    endfunction
    
    private function init takes nothing returns nothing
        set DuelGoldReward[5] = 500
        set DuelGoldReward[10] = 1000
        set DuelGoldReward[15] = 2000
        set DuelGoldReward[20] = 3500
        set DuelGoldReward[25] = 10000
        set DuelGoldReward[30] = 15000
        set DuelGoldReward[35] = 20000
        set DuelGoldReward[40] = 25000
        set DuelGoldReward[45] = 30000
    endfunction
endlibrary