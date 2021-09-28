library WildRune requires RandomShit
    function WildRune takes nothing returns boolean
        local player p = GetOwningPlayer(GLOB_RUNE_U)
        local real power = GLOB_RUNE_POWER
        local integer levels = R2I(power/ 150) + 1
        local integer r = GetRandomInt(0,2)
        call SetPlayerTechResearched(p, 'R000' + r, GetPlayerTechCount(p, 'R000' + r, true) + 1) 

        set p = null
        return false
    endfunction
endlibrary