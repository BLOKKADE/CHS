library WindRune requires RandomShit
    function CastRuneOfWinds takes nothing returns boolean

        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and IsUnitSpellTargetCheck(GetFilterUnit(), GetOwningPlayer(GLOB_RUNE_U)) then
            call DummyTargetCast2(GLOB_RUNE_U,GetFilterUnit(),GetUnitX(GLOB_RUNE_U),GetUnitY(GLOB_RUNE_U),'A075',"entanglingroots",500 * GLOB_RUNE_POWER,4,ABILITY_RLF_DAMAGE_PER_SECOND_EER1,ABILITY_RLF_DURATION_NORMAL)
            
        endif
        return false
    endfunction

    function RuneOfWinds takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),400 + 100 * power, Condition(function CastRuneOfWinds) )

        set u = null
        return false
    endfunction
endlibrary