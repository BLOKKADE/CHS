library WildRune requires RandomShit
    function WildRune takes nothing returns boolean
        local player p = GetOwningPlayer(GLOB_RUNE_U)
        local real power = GLOB_RUNE_POWER * 100
        local integer levels = R2I(power / 75) + 1
        local integer r
        local integer pid = GetPlayerId(p)
        
        loop
            set r = GetRandomInt(0,2)
            
            if r == 0 then
                set SummonDamage[pid] = SummonDamage[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon Attack Bonus - [|cffffcc00Level " + I2S(SummonDamage[pid]) + "|r] - (|cff89ff52+" + I2S(SummonDamage[pid] * 3) + ")|r")
            elseif r == 1 then
                set SummonArmor[pid] = SummonArmor[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon Armor Bonus - [|cffffcc00Level " + I2S(SummonArmor[pid]) + "|r] - (|cff89ff52+" + I2S(SummonArmor[pid]) + ")|r")
            else
                set SummonHitPoints[pid] = SummonHitPoints[pid] + 1
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon HP Bonus - [|cffffcc00Level " + I2S(SummonHitPoints[pid]) + "|r] - (|cff89ff52+" + I2S(SummonHitPoints[pid] * 50) + ")|r")
            endif
            set levels = levels - 1
            exitwhen levels <= 0
        endloop
        set p = null
        return false
    endfunction
endlibrary