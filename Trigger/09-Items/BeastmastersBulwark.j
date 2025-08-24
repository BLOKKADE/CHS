library BeastmastersBulwark

function BulwarkBumRush takes unit target returns nothing
    local unit caster = GetTriggerUnit() // Assumes this is called within a trigger context
    local group g = CreateGroup()
    local unit sum
    local integer count = 0
    local integer limit = 100 // Adjustable limit for number of summons

    if target != null and IsUnitEnemy(target, GetOwningPlayer(caster)) then
        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 1000.0, null)
        loop
            set sum = FirstOfGroup(g)
            exitwhen sum == null or count >= limit
            call GroupRemoveUnit(g, sum)
            if IsUnitType(sum, UNIT_TYPE_SUMMONED) and IsUnitOwnedByPlayer(sum, GetOwningPlayer(caster)) and UnitAlive(sum) then
                call IssueTargetOrder(sum, "attack", target)
                set count = count + 1
            endif
        endloop
    endif

    call DestroyGroup(g)
    set g = null
    set sum = null
    set caster = null
endfunction

endlibrary