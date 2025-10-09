library DeathPact requires UnitHelpers

    function CastDeathPact takes unit caster, unit target, integer level returns nothing
        local unit u = null
        local integer count = 0
        local real totalLife = 0.0
        local real damage = 0.0

        if UnitHasItemOfTypeBJ(caster, 'I0A0') then
            // Sacrifice up to 10 allied non-hero units within 500 range
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 500.0, GetOwningPlayer(caster), true, Target_Ally)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null or count >= 10

                if not IsHeroUnitId(GetUnitTypeId(u)) then
                    set totalLife = totalLife + GetUnitState(u, UNIT_STATE_LIFE)
                    call KillUnit(u)
                    set count = count + 1
                endif

                call GroupRemoveUnit(ENUM_GROUP, u)
            endloop

            // Heal caster based on total life sacrificed
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + (0.05 * level) * totalLife)

            // Damage nearby enemies based on totalLife
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 250.0, GetOwningPlayer(caster), false, Target_Enemy)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                set damage = totalLife * 0.1
                call UnitDamageTarget(caster, u, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                call GroupRemoveUnit(ENUM_GROUP, u)
            endloop

        elseif (not IsHeroUnitId(GetUnitTypeId(target))) and GetUnitState(caster, UNIT_STATE_LIFE) <= GetUnitState(caster, UNIT_STATE_MAX_LIFE) then
            // Original Death Pact logic
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(target), GetUnitY(target), 250.0, GetOwningPlayer(caster), false, Target_Enemy)

            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call UnitDamageTarget(caster, u, GetUnitState(target, UNIT_STATE_LIFE) * 0.1, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                call GroupRemoveUnit(ENUM_GROUP, u)
            endloop

            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + (0.05 * level) * GetUnitState(target, UNIT_STATE_LIFE))
            call KillUnit(target)
        endif
    endfunction

endlibrary

