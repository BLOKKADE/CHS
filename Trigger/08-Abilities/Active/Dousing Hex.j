library DousingHex initializer init requires DummyOrder

    globals
        Table DousingHexReduction
    endglobals

    function DousingHexActivated takes unit target returns nothing
        local integer hid = GetHandleId(target)
        set DousingHexReduction.real[hid] = DousingHexReduction.real[hid] - 1
        if DousingHexReduction.real[hid] <= 0 then
            call UnitRemoveAbility(target, DOUSING_HEX_BUFF_ID)
        endif
    endfunction

    function CastDousingHex takes unit caster, unit target, integer level returns nothing
        local integer i = 1
        local integer abilId = 0 
        local integer dummyAbilId = 0
        local real cd = 0
        local integer targetHid = GetHandleId(target)
        local real cdBonus = 0

        if GetUnitAbilityLevel(target, DOUSING_HEX_BUFF_ID) > 0 then
            set DousingHexReduction.real[targetHid] = DousingHexReduction.real[targetHid] + 3
        else
            call UnitAddAbility(target, DOUSING_HEX_BUFF_ID)
            set DousingHexReduction.real[targetHid] = 3
        endif
    endfunction

    private function init takes nothing returns nothing
        set DousingHexReduction = Table.create()
    endfunction
endlibrary