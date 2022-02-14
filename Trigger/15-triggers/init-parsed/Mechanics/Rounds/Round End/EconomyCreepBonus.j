library EconomyCreepBonus 

    function SetEconomyCreepBonus takes nothing returns nothing
        local integer i = 0
        local integer i1 = 0
        if udg_integer02 > 14 and udg_integer02 < 36 then
            loop
                set i1 = udg_integer02 - 14
                set Income[i] = Income[i] + (i1 * 90)
                set BonusNeutralPlayer[i] = BonusNeutralPlayer[i] + i1
                call DisplayTextToPlayer(Player(i),0,0, "+" + I2S(i1) + " |cffffb23dCreep levels|r (" + I2S(BonusNeutralPlayer[i]) + " total) and + " + I2S(i1 * 90) + " |cffffee00income|r")       
                set i = i + 1
                exitwhen i > 7
            endloop
        endif
    endfunction
endlibrary