library DarkRune requires RandomShit
    function CastDarkRune takes nothing returns boolean
        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and IsUnitTarget(GetFilterUnit()) then
            call UsOrderU2(GLOB_RUNE_U, GetFilterUnit(), GetUnitX(GLOB_RUNE_U), GetUnitY(GLOB_RUNE_U), 'A0A7', "soulburn", (0.01*GLOB_RUNE_POWER), (0.01*GLOB_RUNE_POWER),ABILITY_RLF_DURATION_NORMAL,ABILITY_RLF_DURATION_HERO)
        endif
        return false
    endfunction

    function DarkRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),400+100*power, Condition(function CastDarkRune) )

        set u = null
        return false
    endfunction
endlibrary