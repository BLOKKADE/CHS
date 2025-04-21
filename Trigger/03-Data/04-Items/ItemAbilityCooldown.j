library ItemAbilityCooldown initializer init requires Table, T32
    globals
        Table ItemAbilCds
        Table ItemAbilId
    endglobals

    function GetItemTypeAbilityId takes integer itemTypeId returns integer
        return ItemAbilId.integer[itemTypeId]
    endfunction

    function SetItemAbility takes item it returns nothing
        local integer itemId = GetItemTypeId(it)
        if itemId != 0 and GetItemTypeAbilityId(itemId) == 0 then
            set ItemAbilId.integer[itemId] = BlzGetAbilityId(BlzGetItemAbilityByIndex(it, 0))
        endif
    endfunction

    function GetItemAbilCooldown takes item it returns real
        return ((ItemAbilCds.integer[GetHandleId(it)] - T32_Tick) / 32.)
    endfunction

    function IsItemAbilOnCooldown takes item it returns boolean
        return ItemAbilCds.integer[GetHandleId(it)] != 0 and T32_Tick < ItemAbilCds.integer[GetHandleId(it)]
    endfunction

    function StartItemAbilCooldown takes unit u, item it returns nothing
        call BlzStartUnitAbilityCooldown(u, GetItemTypeAbilityId(GetItemTypeId(it)), GetItemAbilCooldown(it))
    endfunction

    function SetItemAbilCooldown takes unit u, item it returns nothing
        local integer itemId = GetItemTypeId(it)

        if GetItemTypeAbilityId(itemId) == 0 then
            call SetItemAbility(it)
        endif

        set ItemAbilCds.integer[GetHandleId(it)] = T32_Tick + R2I(BlzGetUnitAbilityCooldownRemaining(u, GetItemTypeAbilityId(itemId)) * 32)
    endfunction

    private function init takes nothing returns nothing
        set ItemAbilCds = Table.create()
        set ItemAbilId = Table.create()
    endfunction
endlibrary
