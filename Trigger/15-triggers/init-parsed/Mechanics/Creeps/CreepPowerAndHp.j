library CreepPowerAndHp initializer init requires RandomShit

    private function CreepPowerAndHpActions takes nothing returns nothing
        local unit u = GetLastCreatedUnit()
        local integer hpBuffIndex
        local integer hpBuffEndIndex

        // Short game settings
        if (GameModeShort == true) then
            // Creep power
            if (RoundNumber <= 5) then
                set RoundCreepPower = I2R(RoundNumber * 1) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 10) then
                set RoundCreepPower = (I2R(RoundNumber) * 1.25) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 15) then
                set RoundCreepPower = (I2R(RoundNumber) * 1.75) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 20) then
                set RoundCreepPower = (I2R(RoundNumber) * 2.50) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            elseif (RoundNumber <= 25) then
                set RoundCreepPower = I2R((RoundNumber * 4)) / (I2R(RoundCreepNumber) / 2.00)
                if (RoundCreepNumber == 1) then
                    set RoundCreepPower = RoundCreepPower / 1.50
                endif
            else
                set RoundCreepPower = I2R(((RoundNumber * RoundNumber) / 2)) / (I2R(RoundCreepNumber) / 2.00)
            endif

            // Buff creep HP
            if (RoundNumber > 1 and RoundNumber <= 10) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower)
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    if (RoundNumber >= 4) then
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    endif
                    if (RoundNumber >= 8) then
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                    endif
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 10 and RoundNumber <= 20) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 4
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 600)
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 20 and RoundNumber <= 25) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
                    set hpBuffIndex = hpBuffIndex + 1
                endloop
            elseif (RoundNumber > 25) then
                set hpBuffIndex = 1
                set hpBuffEndIndex = R2I(RoundCreepPower) / 8
                loop
                    exitwhen hpBuffIndex > hpBuffEndIndex
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 1200)
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
