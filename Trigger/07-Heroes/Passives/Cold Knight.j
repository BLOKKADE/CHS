library ColdKnight requires DummyOrder, AbilityCooldown, UnitHelpers, DivineBubble
    globals
        unit GLOB_ABSOLUTE_COLD_U = null
        real GLOB_ABSOLUTE_COLD_DMG = 0
        real GLOB_ABSOLUTE_COLD_DUR = 0
    endglobals

    function ColdKnightEffect takes nothing returns boolean
        local DummyOrder dummy
        local unit u = GetFilterUnit()
        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U,GetOwningPlayer(u)) and IsUnitSpellTargetCheck(u, GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and IsUnitDivineBubbled(u) == false then
            set dummy = DummyOrder.create(GLOB_ABSOLUTE_COLD_U, GetUnitX(GLOB_ABSOLUTE_COLD_U),GetUnitY(GLOB_ABSOLUTE_COLD_U), GetUnitFacing(GLOB_ABSOLUTE_COLD_U), 3)
            call dummy.addActiveAbility('A07W', 1, 852171)
            call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_NORMAL, GLOB_ABSOLUTE_COLD_DUR)
            call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_HERO, GLOB_ABSOLUTE_COLD_DUR)
            call dummy.target(u).activate()

            set udg_NextDamageAbilitySource = 'A07W'
            call Damage.applyMagic(GLOB_ABSOLUTE_COLD_U, u, GLOB_ABSOLUTE_COLD_DMG, DAMAGE_TYPE_MAGIC)
        endif

        set u = null
        return false
    endfunction

    function ColdKnight takes unit u, integer elementCount, integer heroLevel returns boolean
        set GLOB_ABSOLUTE_COLD_U = u 
        set GLOB_ABSOLUTE_COLD_DMG = elementCount * (30 * heroLevel)
        set GLOB_ABSOLUTE_COLD_DUR = 0.15 + (0.01 * heroLevel)

        //call BJDebugMsg(R2S(AbilStartCD(u, COLD_KNIGHT_PASSIVE_ABILITY_ID, 10)))
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, Condition(function ColdKnightEffect))
        return false
    endfunction

    function ColdKnightCdEffect takes nothing returns boolean
        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U,GetOwningPlayer(GetFilterUnit())) and IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) and IsUnitSpellTargetCheck(GetFilterUnit(), GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and IsUnitDivineBubbled(GetFilterUnit()) == false then
            call AddCooldowns(GetFilterUnit(),0.2)
        endif
        return false
    endfunction

    function ColdKnightCooldown takes unit u returns boolean
        set GLOB_ABSOLUTE_COLD_U = u 
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP,GetUnitX(u),GetUnitY(u),500,Condition(function ColdKnightCdEffect) )
        return false
    endfunction
endlibrary