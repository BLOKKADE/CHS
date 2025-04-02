library NecromancerArmy initializer init requires CustomState

    globals
        Table NecroArmySummons
    endglobals

    function NecroSummonFilter takes nothing returns boolean
        if UnitAlive(GetFilterUnit()) and NecroArmySummons.boolean[GetHandleId(GetFilterUnit())] then
            return true
        endif
        return false
    endfunction

    function ActivateNecromancerArmy takes unit source, unit dyingUnit, integer level returns nothing
        local player p = GetOwningPlayer(source)
        local integer pid = GetPlayerId(p)
        local integer unitTypeId = GetUnitTypeId(dyingUnit)
        local unit summon

        call GroupClear(ENUM_GROUP)
        call GroupEnumUnitsOfPlayer(ENUM_GROUP, p, Filter(function NecroSummonFilter))

        if BlzGroupGetSize(ENUM_GROUP) < level then
            if unitTypeId == PHOENIX_1_UNIT_ID then
                set summon = CreateUnit(p, 'u006', GetUnitX(dyingUnit), GetUnitY(dyingUnit), GetUnitFacing(dyingUnit))
            elseif unitTypeId == HAWK_1_UNIT_ID then
                set summon = CreateUnit(p, 'u007', GetUnitX(dyingUnit), GetUnitY(dyingUnit), GetUnitFacing(dyingUnit))
            elseif unitTypeId == SERPENT_WARD_1_UNIT_ID then
                set summon = CreateUnit(p, 'o00D', GetUnitX(dyingUnit), GetUnitY(dyingUnit), GetUnitFacing(dyingUnit))
            else
                if IsUnitType(dyingUnit, UNIT_TYPE_RANGED_ATTACKER) then
                    set summon = CreateUnit(p, 'u005', GetUnitX(dyingUnit), GetUnitY(dyingUnit), GetUnitFacing(dyingUnit))
                else
                    set summon = CreateUnit(p, 'n039', GetUnitX(dyingUnit), GetUnitY(dyingUnit), GetUnitFacing(dyingUnit))
                endif
            endif
            call SetUnitAnimation(summon, "birth")
            call QueueUnitAnimation(summon, "stand")
            set NecroArmySummons.boolean[GetHandleId(summon)] = true

            call UnitApplyTimedLife(summon, 'BTLF', 60)
            call BlzSetUnitMaxHP(summon, BlzGetUnitMaxHP(dyingUnit))
            call SetUnitState(summon, UNIT_STATE_LIFE, GetUnitState(summon, UNIT_STATE_MAX_LIFE))
            call BlzSetUnitBaseDamage(summon, BlzGetUnitBaseDamage(dyingUnit, 0), 0)
            call BlzSetUnitArmor(summon, BlzGetUnitArmor(dyingUnit))
            call BlzSetUnitAttackCooldown(summon, BlzGetUnitAttackCooldown(dyingUnit, 0), 0)

            call AddUnitCustomState(summon, BONUS_MAGICPOW, GetUnitCustomState(dyingUnit, BONUS_MAGICPOW))
            call AddUnitCustomState(summon, BONUS_MAGICRES, GetUnitCustomState(dyingUnit, BONUS_MAGICRES) - (10 * SummonWildDefense[pid]))
            call AddUnitCustomState(summon, BONUS_EVASION, GetUnitCustomState(dyingUnit, BONUS_EVASION) - (1 * SummonWildDefense[pid]))
            call AddUnitCustomState(summon, BONUS_BLOCK, GetUnitCustomState(dyingUnit, BONUS_BLOCK) - (10 * SummonWildDefense[pid]))
        endif

        set summon = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        set NecroArmySummons = Table.create()
    endfunction
endlibrary