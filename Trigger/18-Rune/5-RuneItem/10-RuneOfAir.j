library WindRune requires RandomShit
    globals
        boolexpr RuneOfWinds_b
    endglobals


    function CastRuneOfWinds takes nothing returns boolean

        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and GetUnitTypeId(GetFilterUnit()) != 'h015' then
            call UsOrderU2(GLOB_RUNE_U,GetFilterUnit(),GetUnitX(GLOB_RUNE_U),GetUnitY(GLOB_RUNE_U),'A075',"entanglingroots",500 * GLOB_RUNE_POWER,4,ABILITY_RLF_DAMAGE_PER_SECOND_EER1,ABILITY_RLF_DURATION_NORMAL)
            
        endif
        return false
    endfunction

    function RuneOfWinds takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupEnumUnitsInRange(GL_GR,GetUnitX(u),GetUnitY(u),400 + 100 * power,RuneOfWinds_b )

        set u = null
        return false
    endfunction
endlibrary