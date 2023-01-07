library PackingTape initializer init requires PlayerSummonGroups, SummonInfo

    public function CheckSummonCount takes unit hero, unit summon returns boolean
        call GroupClear(ENUM_GROUP)
        call GetPlayerSummonGroup(hero, GetUnitTypeId(summon), ENUM_GROUP)
        if BlzGroupGetSize(ENUM_GROUP) >= 4 then
            call KillUnit(summon)
            return false
        endif

        return true
    endfunction

    function CastPackingTape takes unit caster, unit target returns nothing
        local integer i = 0
        local unit temp = null
        local integer totalLevel = SummonLevel.integer[GetHandleId(target)]

        call GroupClear(ENUM_GROUP)
        set ENUM_GROUP = GetPlayerSummonGroup(caster, GetUnitTypeId(target), ENUM_GROUP)
        call GroupRemoveUnit(ENUM_GROUP, target)

        set i = IMinBJ(BlzGroupGetSize(ENUM_GROUP), 3)

        if i > 0 then
            loop
                set temp = BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP) - 1))
                if temp != null then
                    set totalLevel = totalLevel + SummonLevel.integer[GetHandleId(temp)]
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
        
    endfunction
endlibrary