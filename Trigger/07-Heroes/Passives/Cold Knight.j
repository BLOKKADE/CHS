library ColdKnight requires DummyOrder, AbilityCooldown, UnitHelpers, DivineBubble
    globals
        unit GLOB_ABSOLUTE_COLD_U = null
        real GLOB_ABSOLUTE_COLD_DMG = 0
        real GLOB_ABSOLUTE_COLD_DUR = 0
    endglobals

    private function ApplyColdKnightEffect takes unit target returns nothing
        local DummyOrder dummy = DummyOrder.create(GLOB_ABSOLUTE_COLD_U, GetUnitX(GLOB_ABSOLUTE_COLD_U), GetUnitY(GLOB_ABSOLUTE_COLD_U), GetUnitFacing(GLOB_ABSOLUTE_COLD_U), 3)
        
        call dummy.addActiveAbility('A07W', 1, 852171)
        call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_NORMAL, GLOB_ABSOLUTE_COLD_DUR)
        call dummy.setAbilityRealField('A07W', ABILITY_RLF_DURATION_HERO, GLOB_ABSOLUTE_COLD_DUR)
        call dummy.target(target).activate()

        set udg_NextDamageAbilitySource = 'A07W'
        call Damage.applyMagic(GLOB_ABSOLUTE_COLD_U, target, GLOB_ABSOLUTE_COLD_DMG, false, DAMAGE_TYPE_MAGIC)
    endfunction

    private function ColdKnightEffect takes nothing returns boolean
        local unit target = GetFilterUnit()

        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U, GetOwningPlayer(target)) and IsUnitSpellTargetCheck(target, GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and not IsUnitDivineBubbled(target) then
            call ApplyColdKnightEffect(target)
        endif

        set target = null
        return false
    endfunction

    function ColdKnight takes unit u, integer elementCount, integer heroLevel returns boolean
        set GLOB_ABSOLUTE_COLD_U = u
        set GLOB_ABSOLUTE_COLD_DMG = elementCount * (30 * heroLevel)
        set GLOB_ABSOLUTE_COLD_DUR = 0.15 + (0.01 * heroLevel)

        call AbilStartCD(u, COLD_KNIGHT_PASSIVE_ABILITY_ID, 10)
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, Condition(function ColdKnightEffect))
        return false
    endfunction

    private function ColdKnightCdEffect takes nothing returns boolean
        local unit target = GetFilterUnit()

        if IsUnitEnemy(GLOB_ABSOLUTE_COLD_U, GetOwningPlayer(target)) and IsHeroUnitId(GetUnitTypeId(target)) and IsUnitSpellTargetCheck(target, GetOwningPlayer(GLOB_ABSOLUTE_COLD_U)) and not IsUnitDivineBubbled(target) and CheckUnitHitCooldown(GetHandleId(target), GHOUL_UNIT_ID, 0.7) then
            call AddCooldowns(target, 0.2)
        endif

        set target = null
        return false
    endfunction

    function ColdKnightCooldown takes unit u returns boolean
        set GLOB_ABSOLUTE_COLD_U = u
        
        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 500, Condition(function ColdKnightCdEffect))

        return false
    endfunction
endlibrary