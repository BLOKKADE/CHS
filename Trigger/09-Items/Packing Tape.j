library PackingTape initializer init requires PlayerSummonGroups, SummonInfo

    globals
        Table RegisteredSummon
    endglobals

    public function CheckSummonCount takes unit hero, unit summon returns boolean
        call GroupClear(ENUM_GROUP)
        call GetPlayerSummonGroup(hero, GetUnitTypeId(summon), ENUM_GROUP)
        if BlzGroupGetSize(ENUM_GROUP) >= 4 then
            call KillUnit(summon)
            return false
        endif
        set RegisteredSummon.boolean[GetHandleId(summon)] = true

        return true
    endfunction

    function CastPackingTape takes unit caster, unit target returns nothing
        local integer i = 0
        local unit temp = null
        local integer totalLevel = SummonLevel.integer[GetHandleId(target)]

        if GetUnitTypeId(target) == FAERIE_DRAGON_UNIT_ID or GetSummonSpell(GetUnitTypeId(target)) == 0 then
            call DisplayTimedTextToPlayer(GetOwningPlayer(caster), 0, 0, 10, "Packing Tape cannot be cast on this unit.")
            return
        endif

        call GroupClear(ENUM_GROUP)
        set ENUM_GROUP = GetPlayerSummonGroup(caster, GetUnitTypeId(target), ENUM_GROUP)
        call GroupRemoveUnit(ENUM_GROUP, target)

        set i = IMinBJ(BlzGroupGetSize(ENUM_GROUP), 3)

        if i > 0 then
            loop
                set temp = BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP) - 1))
                if temp != null then
                    set totalLevel = totalLevel + SummonLevel.integer[GetHandleId(temp)]

                    // Packing tape doesn't make sense if the sacrificed unit revives itself
                    if (GetUnitTypeId(temp) == PHOENIX_1_UNIT_ID) then
                        call UnitRemoveAbility(temp, REINCARNATION_ABILITY_ID)
                    endif

                    call KillUnit(temp)
                    call GroupRemoveUnit(ENUM_GROUP, temp)
                endif

                set i = i - 1
                exitwhen i <= 0
            endloop
        endif

        call GetSummonStatFunction(GetUnitTypeId(target)).evaluate(target, totalLevel)

        call BlzSetUnitName(target,GetUnitName(target)+ ": |cff00d9fflevel " + I2S(totalLevel) + "|r")
        call SetWidgetLife(target, BlzGetUnitMaxHP(target))

        set temp = null
    endfunction

    private function init takes nothing returns nothing
        set RegisteredSummon = Table.create()
    endfunction
endlibrary
