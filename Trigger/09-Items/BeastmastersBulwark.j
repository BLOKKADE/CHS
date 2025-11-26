globals
    hashtable udg_Hash = InitHashtable()
endglobals

library BeastmastersBulwark requires GetObjectElement

    function GetUnitElementCountRaw takes unit u, integer elementId returns integer
        return LoadInteger(elementTable, GetHandleId(u), elementId)
    endfunction

    function SetUnitElementCountRaw takes unit u, integer elementId, integer value returns nothing
        call SaveInteger(elementTable, GetHandleId(u), elementId, value)
    endfunction

    function StoreBulwarkBonus takes unit u, integer elementId, integer bonus returns nothing
        call SaveInteger(bulwarkTable, GetHandleId(u), 0, elementId)
        call SaveInteger(bulwarkTable, GetHandleId(u), 1, bonus)
    endfunction

    function GetStoredBulwarkTarget takes unit u returns integer
        return LoadInteger(bulwarkTable, GetHandleId(u), 0)
    endfunction

    function GetStoredBulwarkBonus takes unit u returns integer
        return LoadInteger(bulwarkTable, GetHandleId(u), 1)
    endfunction

    function HandleBulwarkRetaliation takes unit target, unit source returns nothing
        local integer slot = 0
        local item it = null
        local group g
        local unit u
        local real x
        local real y
        local real range
        local integer wildCount
        local integer abilId = 'BBBG' // Cooldown ability rawcode
        local integer abilLevel

        // Only trigger if both units are heroes
        if IsUnitType(target, UNIT_TYPE_HERO) and IsUnitType(source, UNIT_TYPE_HERO) then
            set abilLevel = GetUnitAbilityLevel(target, abilId)

            // Only trigger if ability is present and off cooldown
            if abilLevel > 0 and BlzGetUnitAbilityCooldownRemaining(target, abilId) <= 0.0 then
                // Check for Bulwark item
                loop
                    exitwhen slot >= bj_MAX_INVENTORY
                    set it = UnitItemInSlot(target, slot)
                    if it != null and GetItemTypeId(it) == BULWARK_ITEM_ID then
                        // Calculate dynamic range
                        set wildCount = GetUnitElementCount(target, Element_Wild)
                        set range = 600.0 + (150.0 * wildCount)

                        // Retaliation: order nearby friendly non-hero units to attack the source
                        set x = GetUnitX(target)
                        set y = GetUnitY(target)
                        set g = CreateGroup()
                        call GroupEnumUnitsInRange(g, x, y, range, null)

                        loop
                            set u = FirstOfGroup(g)
                            exitwhen u == null
                            if IsUnitAlly(u, GetOwningPlayer(target)) and not IsUnitType(u, UNIT_TYPE_HERO) and UnitAlive(u) then
                                call IssueTargetOrder(u, "attack", source)
                                if GetUnitAbilityLevel(u, 'A06I') > 0 then
                                    call IssueImmediateOrderById(u, 852185)
                                endif
                            endif
                            call GroupRemoveUnit(g, u)
                        endloop

                        call DestroyGroup(g)

                        // Start cooldown
                        call BlzStartUnitAbilityCooldown(target, abilId, 7.0)
                        return
                    endif
                    set slot = slot + 1
                endloop
            endif
        endif
    endfunction

    function BulwarkBumRush takes unit target returns nothing
        local unit caster = GetTriggerUnit()
        local group g = CreateGroup()
        local unit sum
        local integer count = 0
        local integer limit = 100
        local real range
        local integer wildCount

        if target != null and IsUnitEnemy(target, GetOwningPlayer(caster)) then
            // Calculate dynamic range
            set wildCount = GetUnitElementCount(caster, Element_Wild)
            set range = 600.0 + (150.0 * wildCount)

            call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), range, null)
            loop
                set sum = FirstOfGroup(g)
                exitwhen sum == null or count >= limit
                call GroupRemoveUnit(g, sum)
                if IsUnitType(sum, UNIT_TYPE_SUMMONED) and IsUnitOwnedByPlayer(sum, GetOwningPlayer(caster)) and UnitAlive(sum) then
                    call IssueTargetOrder(sum, "attack", target)
                    if GetUnitAbilityLevel(sum, 'A06I') > 0 then
                        call IssueImmediateOrderById(sum, 852185)
                    endif
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