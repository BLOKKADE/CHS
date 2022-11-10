library BloodRune requires RandomShit, UnitHelpers
    function CastBloodRune takes nothing returns boolean
        if IsUnitEnemy(GLOB_RUNE_U,GetOwningPlayer(GetFilterUnit())) and IsUnitTarget(GetFilterUnit()) then
            call DummyTargetCast2(GLOB_RUNE_U, GetFilterUnit(), GetUnitX(GLOB_RUNE_U), GetUnitY(GLOB_RUNE_U), 'A0A6', "cripple", 1 + (1 * GLOB_RUNE_POWER), 1 + (1 * GLOB_RUNE_POWER),ABILITY_RLF_DURATION_NORMAL,ABILITY_RLF_DURATION_HERO)
        endif
        return false
    endfunction

    function BloodRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),400 + 100 * power, Condition(function CastBloodRune) )

        set u = null
        return false
    endfunction
endlibrary