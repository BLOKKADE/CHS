library DousingHex initializer init requires DummyOrder, RandomShit

    globals
        Table DousingHexReduction
        Table DousingHexCooldown
    endglobals

    function CastDousingHex takes unit caster, unit target, integer level returns nothing
        local integer i = 1
        local integer abilId = 0 
        local integer dummyAbilId = 0
        local real cd = 0
        local integer targetHid = GetHandleId(target)
        local real cdBonus = 0

        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility('A09K', 1, 852189)
        call dummy.target(target)
        call dummy.activate()
        set DousingHexReduction.real[targetHid] = 0.13 + (0.02 * level)
        set DousingHexCooldown.real[targetHid] = 1.17 + (0.03 * level)
        //call BJDebugMsg("dh: " + I2S(DousingHexChance.integer[GetHandleId(target)]))
    endfunction

    private function init takes nothing returns nothing
        set DousingHexCooldown = Table.create()
        set DousingHexReduction = Table.create()
    endfunction
endlibrary