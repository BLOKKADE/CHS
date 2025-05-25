library DeathPact
    function CastDeathPact takes unit caster, unit target, integer level returns nothing
        local real bonus = (0.05 * level) * GetUnitState(target, UNIT_STATE_LIFE)
        local real targetHP = GetUnitState(target, UNIT_STATE_LIFE)
        local group g = CreateGroup()
        local unit u = null 
        local player casterOwner = GetOwningPlayer(caster) 
        local real aoe = 250.0
            if (not IsHeroUnitId(GetUnitTypeId(target))) and GetUnitState(caster, UNIT_STATE_LIFE) <= GetUnitState(caster, UNIT_STATE_MAX_LIFE) then
        // Enumerate units within 350 radius of the target
                call GroupEnumUnitsInRange(g, GetUnitX(target), GetUnitY(target), aoe, null)
                loop
                    set u = FirstOfGroup(g)
                    exitwhen u == null
                    call GroupRemoveUnit(g, u)
        // Damage enemy units that are alive, not magic-immune, and not the caster or target
                    if IsUnitEnemy(u, casterOwner) and IsUnitAliveBJ(u) and not IsUnitType(u, UNIT_TYPE_MAGIC_IMMUNE) and GetHandleId(u) != GetHandleId(caster) and GetHandleId(u) != GetHandleId(target) then
                        call UnitDamageTarget(caster, u, targetHP * 0.1, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                    endif
                endloop
        // Apply the original Death Pact effect
                call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + bonus)
                call KillUnit(target)
            endif
    // Clean up
        call DestroyGroup(g)
        set g = null
        set u = null
        set casterOwner = null
    endfunction
endlibrary



