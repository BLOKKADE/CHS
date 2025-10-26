library DuelReward initializer init
    globals
        integer array DuelGoldReward
        force DuelLosers = CreateForce()
    endglobals
    
    private function init takes nothing returns nothing
        set DuelGoldReward[5] = 750
        set DuelGoldReward[10] = 1500
        set DuelGoldReward[15] = 3000
        set DuelGoldReward[20] = 5000
        set DuelGoldReward[25] = 7750
        set DuelGoldReward[30] = 12500
        set DuelGoldReward[35] = 17500
        set DuelGoldReward[40] = 22500
        set DuelGoldReward[45] = 27500
    endfunction
endlibrary