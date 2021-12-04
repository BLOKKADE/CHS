library WildRune requires RandomShit
    function WildRune takes nothing returns boolean
        local player p = GetOwningPlayer(GLOB_RUNE_U)
        local real power = GLOB_RUNE_POWER * 100
        local integer levels = R2I(power / 75) + 1
        local integer r
        
        loop
            set r = GetRandomInt(0,2)
            
            if r == 0 then
                call SetPlayerTechResearched(p, 'R000', GetPlayerTechCount(p, 'R000', true) + 1) 
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon Attack Bonus - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R000', true)) + "|r]")
            elseif r == 1 then
                call SetPlayerTechResearched(p, 'R001', GetPlayerTechCount(p, 'R001', true) + 1) 
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon Armor Bonus - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R001', true)) + "|r]")
            else
                call SetPlayerTechResearched(p, 'R002', GetPlayerTechCount(p, 'R002', true) + 1) 
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Summon HP Bonus - [|cffffcc00Level " + I2S(GetPlayerTechCount(p, 'R002', true)) + "|r]")
            endif
            set levels = levels - 1
            exitwhen levels <= 0
        endloop
        set p = null
        return false
    endfunction
endlibrary