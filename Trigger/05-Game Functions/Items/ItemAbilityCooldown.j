library ItemAbilityCooldown initializer init requires Table
    globals
        Table ItemAbilCds
        Table ItemAbilId
    endglobals

    function GetItemAbilCooldown takes item it returns real
        return ((ItemAbilCds.integer[GetHandleId(it)] - T32_Tick) / 32.)
    endfunction

    function IsItemAbilOnCooldown takes item it returns boolean
        return ItemAbilCds.integer[GetHandleId(it)] != 0 and T32_Tick < ItemAbilCds.integer[GetHandleId(it)]
    endfunction

    function StartItemAbilCooldown takes unit u, item it returns nothing
        call BlzStartUnitAbilityCooldown(u, ItemAbilId.integer[GetItemTypeId(it)], GetItemAbilCooldown(it))
    endfunction

    function SetItemAbilCooldown takes unit u, item it returns nothing
        local integer itemId = GetItemTypeId(it)

        if ItemAbilId.integer[itemId] == 0 then
            set ItemAbilId.integer[itemId] = BlzGetAbilityId(BlzGetItemAbilityByIndex(it, 0))
        endif

        set ItemAbilCds.integer[GetHandleId(it)] = T32_Tick + R2I(BlzGetUnitAbilityCooldownRemaining(u, ItemAbilId.integer[itemId]) * 32)
    endfunction

    private function init takes nothing returns nothing
        set ItemAbilCds = Table.create()
        set ItemAbilId = Table.create()
    endfunction
endlibrary
