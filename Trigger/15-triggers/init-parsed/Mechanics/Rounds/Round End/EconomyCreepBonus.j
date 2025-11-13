library EconomyCreepBonus 

    globals
        integer array Income
        integer BonusNeutral = 0
        integer array BonusNeutralPlayer
    endglobals

    function SetEconomyCreepBonus takes nothing returns nothing
        local integer i = 0
        local integer i1 = 0
        if ((RoundNumber > 14 and RoundNumber < 36) or (GameModeShort and RoundNumber < 26)) then
            loop
                if GameModeShort == true then
                    set Income[i] = RoundNumber * 1000
                    
                else
                    set Income[i] = (RoundNumber - 14) * 70
                endif

                if GameModeShort == true then
                    set BonusNeutralPlayer[i] = Income[i] / 250 
                else
                    set BonusNeutralPlayer[i] = BonusNeutralPlayer[i] + (i1 * 4)
                endif

                call DisplayTextToPlayer(Player(i),0,0, "+" + I2S(BonusNeutralPlayer[i]) + " |cffffb23dCreep levels|r (" + I2S(BonusNeutralPlayer[i]) + " total) and + " + I2S(Income[i]) + " |cffffee00income|r")       

                set i = i + 1
                exitwhen i == 8
            endloop
        endif
    endfunction
endlibrary