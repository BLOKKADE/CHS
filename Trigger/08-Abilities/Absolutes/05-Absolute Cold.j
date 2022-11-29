library AbsoluteCold initializer init requires RandomShit, DivineBubble
    globals
        unit GLOB_ABSOLUTE_COLD_U = null
        real GLOB_ABSOLUTE_COLD_DMG = 0
        real GLOB_ABSOLUTE_COLD_DUR = 0

        Table AbsoluteColdLastTick
    endglobals

    function AbsoluteIceFunc takes nothing returns boolean
        local DummyOrder dummy
        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U,GetOwningPlayer(GetFilterUnit())) and IsUnitSpellTargetCheck(GetFilterUnit(), GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and IsUnitDivineBubbled(GetFilterUnit()) == false then
            set dummy = DummyOrder.create(GLOB_ABSOLUTE_COLD_U, GetUnitX(GLOB_ABSOLUTE_COLD_U),GetUnitY(GLOB_ABSOLUTE_COLD_U), GetUnitFacing(GLOB_ABSOLUTE_COLD_U), 3)
            call dummy.addActiveAbility('A07W', 1, 852171)
            call dummy.setAbilityRealField('A07W', ABILITY_RLF_DAMAGE_PER_SECOND_EER1, GLOB_ABSOLUTE_COLD_DMG)
            call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_NORMAL, GLOB_ABSOLUTE_COLD_DUR)
            call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_HERO, GLOB_ABSOLUTE_COLD_DUR)
            call dummy.target(GetFilterUnit()).activate()   
        endif
        return false
    endfunction

    function AbsoluteCold takes unit u, integer elementCount, integer level returns boolean
        set GLOB_ABSOLUTE_COLD_U = u 
        set GLOB_ABSOLUTE_COLD_DMG = elementCount * (30 * level)
        set GLOB_ABSOLUTE_COLD_DUR = elementCount * 0.15
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 500, Condition(function AbsoluteIceFunc))
        return false
    endfunction

    function AbsoluteColdFunc takes nothing returns boolean
        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U,GetOwningPlayer(GetFilterUnit())) and IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) and IsUnitSpellTargetCheck(GetFilterUnit(), GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and IsUnitDivineBubbled(GetFilterUnit()) == false then
            call AddCooldowns(GetFilterUnit(),0.2)
        endif
        return false
    endfunction

    function AbsoluteColdCooldown takes unit u returns boolean
        set GLOB_ABSOLUTE_COLD_U = u 
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),500,Condition(function AbsoluteColdFunc) )
        return false
    endfunction

    private function init takes nothing returns nothing
        set AbsoluteColdLastTick = Table.create()
    endfunction
endlibrary