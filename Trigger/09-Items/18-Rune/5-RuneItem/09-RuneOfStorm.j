library StormRune requires RandomShit

    function ShouldSkipDisplacement takes unit target returns boolean
        // Check for Hardened Skin ability
        if GetUnitAbilityLevel(target, HARDENED_SKIN_ABILITY_ID) > 0 then
            return true
        endif

        // Check for specific items
        if UnitHasItemType(target, 'I0CV') or UnitHasItemType(target, 'I090') then
            return true
        endif

        return false
    endfunction


    function CastRuneOfStorm takes nothing returns boolean
        local unit target = GetFilterUnit()

        if IsUnitEnemy(GLOB_RUNE_U, GetOwningPlayer(target)) then

            // Apply displacement only if unit is not immune
            if not ShouldSkipDisplacement(target) then
                call SetUnitX(target, GetUnitX(GLOB_RUNE_U) + GetRandomReal(-50, 50))
                call SetUnitY(target, GetUnitY(GLOB_RUNE_U) + GetRandomReal(-50, 50))
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\CrushingWave\\CrushingWaveMissile.mdl", target, "chest"))
            endif

            // Damage is always applied
            set udg_NextDamageAbilitySource = 'I08I'
            call Damage.applyMagic(GLOB_RUNE_U, target, 1000 * GLOB_RUNE_POWER, false, DAMAGE_TYPE_MAGIC)
        endif

        set target = null
        return false
    endfunction

    function RuneOfStorm takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 300 + 100 * power, Condition(function CastRuneOfStorm))

        set u = null
        return false
    endfunction

endlibrary
