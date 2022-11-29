library DuelReward initializer init
    globals
        integer array DuelGoldReward
        force DuelLosers = CreateForce()
    endglobals
    
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