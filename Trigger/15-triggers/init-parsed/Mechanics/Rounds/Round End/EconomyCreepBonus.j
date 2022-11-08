library EconomyCreepBonus 

    globals
        integer array Income
        integer BonusNeutral = 0
        integer array BonusNeutralPlayer
    endglobals

    function SetEconomyCreepBonus takes nothing returns nothing
        local integer i = 0
        local integer i1 = 0
        if RoundNumber > 14 and RoundNumber < 36 then
            loop
                set i1 = RoundNumber - 14
                set Income[i] = Income[i] + (i1 * 70)
                set BonusNeutralPlayer[i] = BonusNeutralPlayer[i] + (i1 * 4)
                call DisplayTextToPlayer(Player(i),0,0, "+" + I2S(i1 * 4) + " |cffffb23dCreep levels|r (" + I2S(BonusNeutralPlayer[i]) + " total) and + " + I2S(i1 * 70) + " |cffffee00income|r")       
                set i = i + 1
                exitwhen i > 7
            endloop
        endif
    endfunction
endlibrary