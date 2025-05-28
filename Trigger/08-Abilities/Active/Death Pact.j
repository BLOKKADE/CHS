library DeathPact requires UnitHelpers
    function CastDeathPact takes unit caster, unit target, integer level returns nothing
        local unit u = null 
        if (not IsHeroUnitId(GetUnitTypeId(target))) and GetUnitState(caster, UNIT_STATE_LIFE) <= GetUnitState(caster, UNIT_STATE_MAX_LIFE) then
            call GroupClear(ENUM_GROUP)
            // Enumerate units within 350 radius of the target
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(target), GetUnitY(target), 250, GetOwningPlayer(caster) , false, Target_Enemy)
            loop
                set u = FirstOfGroup(ENUM_GROUP)
                exitwhen u == null
                call UnitDamageTarget(caster, u, GetUnitState(target, UNIT_STATE_LIFE) * 0.1, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                call GroupRemoveUnit(ENUM_GROUP, u)
            endloop
            // Apply the original Death Pact effect
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + (0.05 * level) * GetUnitState(target, UNIT_STATE_LIFE))
            call KillUnit(target)
        endif
    endfunction
endlibrary