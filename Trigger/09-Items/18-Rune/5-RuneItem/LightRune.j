library LightRune requires RandomShit, UnitHelpers

    function CastLightRune takes nothing returns boolean
        local unit target = GetFilterUnit()
        local real dx = GetUnitX(target) - GetUnitX(GLOB_RUNE_U)
        local real dy = GetUnitY(target) - GetUnitY(GLOB_RUNE_U)
        local real distance = SquareRoot(dx * dx + dy * dy)
        local real baseDamage = (0.03 * GLOB_RUNE_POWER) * BlzGetUnitMaxHP(GLOB_RUNE_U)
        local real multiplier = 0.0

        if IsUnitEnemy(GLOB_RUNE_U, GetOwningPlayer(target)) and IsUnitTarget(target) then
            // Calculate damage multiplier based on distance
            if distance <= 100.0 then
                set multiplier = 1.0
            elseif distance <= 200.0 then
                set multiplier = 0.5
            elseif distance <= 300.0 then
                set multiplier = 0.25
            elseif distance <= 400.0 then
                set multiplier = 0.125
            elseif distance <= 500.0 then
                set multiplier = 0.0625
            elseif distance <= 600.0 then
                set multiplier = 0.03125
            endif

            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl", target, "origin"))
            set udg_NextDamageAbilitySource = 'I0AW'
            call Damage.applyMagic(GLOB_RUNE_U, target, baseDamage * multiplier, false, DAMAGE_TYPE_MAGIC)
        endif

        set target = null
        return false
    endfunction

    function LightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600 * power, Condition(function CastLightRune))

        set u = null
        return false
    endfunction
endlibrary
