library DousingHex initializer init requires DummyOrder, RandomShit

    globals
        Table DousingHexChance
        Table DousingHexCooldown
    endglobals

    function DousingHexFailCheck takes unit u, integer abilId returns boolean
        if IsSpellElement(u, abilId, Element_Fire) and GetUnitAbilityLevel(u, 'B01Y') > 0 and GetRandomInt(0, 100) < DousingHexChance.integer[GetHandleId(u)] then
            //call BJDebugMsg("Dousing hex fail")
            call DestroyEffect(AddSpecialEffect("Objects\\Spawnmodels\\Naga\\NagaDeath\\NagaDeath.mdl", GetUnitX(u), GetUnitY(u)))
            call IssueImmediateOrderById(u, 851972)
            return true
        endif
        return false
    endfunction

    function CastDousingHex takes unit caster, unit target, integer level returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility('A09K', 1, 852189)
        call dummy.target(target)
        call dummy.activate()
        set DousingHexChance.integer[GetHandleId(target)] = level
        set DousingHexCooldown.real[GetHandleId(target)] = 1.17 + (0.03 * level)
        //call BJDebugMsg("dh: " + I2S(DousingHexChance.integer[GetHandleId(target)]))
    endfunction

    private function init takes nothing returns nothing
        set DousingHexCooldown = Table.create()
        set DousingHexChance = Table.create()
    endfunction
endlibrary