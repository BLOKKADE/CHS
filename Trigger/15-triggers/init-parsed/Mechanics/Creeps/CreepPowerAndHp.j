library CreepPowerAndHp initializer init requires RandomShit

    private function CreepPowerAndHpActions takes nothing returns nothing
        local unit u = GetLastCreatedUnit()
        local integer hpBuffIndex
        local integer hpBuffEndIndex

        // Short game settings
        if (GameModeShort == true) then
                // Creep power
                if (RoundNumber == 1) then
                    set RoundCreepPower = (1.00) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 2) then
                    set RoundCreepPower = (2.0 * 0.65) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 3) then
                    set RoundCreepPower = (3.0 * 0.75) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 4) then
                    set RoundCreepPower = (4.0 * 0.9) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 5) then
                    set RoundCreepPower = (5.0 * 1.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 6) then
                    set RoundCreepPower = (6.0 * 1.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 7) then
                    set RoundCreepPower = (7.0 * 2.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 8) then
                    set RoundCreepPower = (8.0 * 3.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 9) then
                    set RoundCreepPower = (9.0 * 4.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 10) then
                    set RoundCreepPower = (10.0 * 5.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 11) then
                    set RoundCreepPower = (11.0 * 5.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 12) then
                    set RoundCreepPower = (12.0 * 6.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 13) then
                    set RoundCreepPower = (13.0 * 6.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 14) then
                    set RoundCreepPower = (14.0 * 7.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 15) then
                    set RoundCreepPower = (15.0 * 7.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 16) then
                    set RoundCreepPower = (16.0 * 8.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 17) then
                    set RoundCreepPower = (17.0 * 8.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 18) then
                    set RoundCreepPower = (18.0 * 9.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 19) then
                    set RoundCreepPower = (19.0 * 9.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 20) then
                    set RoundCreepPower = (20.0 * 10.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 21) then
                    set RoundCreepPower = (21.0 * 10.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 22) then
                    set RoundCreepPower = (22.0 * 11.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 23) then
                    set RoundCreepPower = (23.0 * 11.5) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 24) then
                    set RoundCreepPower = (24.0 * 12.0) / (I2R(RoundCreepNumber) / 2.00)
                elseif (RoundNumber == 25) then
                    set RoundCreepPower = (25.0 * 12.5) / (I2R(RoundCreepNumber) / 2.00)
                else
                    set RoundCreepPower = I2R((RoundNumber * RoundNumber) / 2) / (I2R(RoundCreepNumber) / 2.00)
                endif

                // Solo creep adjustment
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif

                // Buff creep HP
                if (RoundNumber == 2) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 30)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 3) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 4) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 65)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 5) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 90)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 6) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 130)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 7) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 200)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 8) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 300)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 9) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 450)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 10) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower)
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 700)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 11) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 12) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1400)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 13) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1600)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 14) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 2000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 15) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 3000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 16) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 4000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 17) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 4500)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 18) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 5000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 19) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 6000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 20) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 7000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 21) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 7500)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 22) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 8000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 23) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 10000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                elseif (RoundNumber == 24) then
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 15000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                else
                    set hpBuffIndex = 1
                    set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                    loop
                        exitwhen hpBuffIndex > hpBuffEndIndex
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 20000)
                        set hpBuffIndex = hpBuffIndex + 1
                    endloop
                endif
                
        // Long game settings
        else
            // Creep power
            if (RoundNumber <= 30) then
                set RoundCreepPower = (I2R(RoundNumber) * 1.75) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 40) then
                set RoundCreepPower = (I2R(RoundNumber) * 2.50) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 50) then
                set RoundCreepPower = (I2R(RoundNumber) * 4.00) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            else
                set RoundCreepPower = I2R(((RoundNumber * RoundNumber) / 10)) / (I2R(RoundCreepNumber) / 2.00)
            endif

            // Buff creep HP
            if (RoundNumber > 1 and RoundNumber <= 20) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower)
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    if (RoundNumber >= 8) then
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    endif
                    if (RoundNumber >= 16) then
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    endif
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 20 and RoundNumber <= 40) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 600)
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 40 and RoundNumber <= 50) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 50) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            endif
        endif

        // Reset the creeps current hp to its new max hp
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_MAX_LIFE))

        // Cleanup
        set u = null
    endfunction

    private function init takes nothing returns nothing
        set CreepPowerAndHpTrigger = CreateTrigger()
        call TriggerAddAction(CreepPowerAndHpTrigger, function CreepPowerAndHpActions)
    endfunction

endlibrary
