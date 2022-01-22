library ToggleAbility initializer init requires AbilityDescription

    globals
        HashTable AbilityStorage
        HashTable CurrentAbilitySetting
    endglobals

    function IsAbilityEnabled takes unit u, integer abilId returns boolean
        return CurrentAbilitySetting[GetHandleId(u)].boolean[abilId]
    endfunction

    function SetAbilityIcon takes player p, integer abilId, boolean enabled returns nothing
        if GetLocalPlayer() == p then
            if enabled then
                call BlzSetAbilityIcon(abilId, AbilityStorage[abilId].string[2])
            else
                call BlzSetAbilityIcon(abilId, AbilityStorage[abilId].string[1])
            endif
        endif
    endfunction

    function ToggleUpdateDescription takes player p, integer abilId, integer lvl returns nothing
        call UpdateAbilityDescriptionString(GetAbilityDescription(abilId, lvl - 1), p, abilId, "Disabled", "Enabled", lvl)
    endfunction

    function FirstTimeSetup takes integer abilId returns nothing
        set AbilityStorage[abilId].boolean[0] = true
        set AbilityStorage[abilId].string[2] = BlzGetAbilityIcon(abilId)
    endfunction

    function ToggleAbility takes unit u, integer abilId, integer lvl returns nothing
        local integer hid = GetHandleId(u)
        local player p = GetOwningPlayer(u)
        call SaveAbilityDescription(abilId, lvl)

        if AbilityStorage[abilId].boolean[0] == false then
            call FirstTimeSetup(abilId)
        endif

        if CurrentAbilitySetting[hid].boolean[abilId] then
            set CurrentAbilitySetting[hid].boolean[abilId] = false
            call ResetAbilityDescription(p, abilId, lvl - 1)
            call SetAbilityIcon(p, abilId, true)
        else
            set CurrentAbilitySetting[hid].boolean[abilId] = true
            call ToggleUpdateDescription(p, abilId, lvl)
            call SetAbilityIcon(p, abilId, false)
        endif

        set p = null
    endfunction

    function SetupToggleAbility takes integer abilId, string enabledIcon returns nothing
        set AbilityStorage[abilId].string[1] = enabledIcon
    endfunction

    private function init takes nothing returns nothing
        set AbilityStorage = HashTable.create()
        set CurrentAbilitySetting = HashTable.create()
    endfunction
endlibrary