library DousingHex initializer init requires DummyOrder, RandomShit

    globals
        Table DousingHexReduction
        Table DousingHexCooldown
    endglobals

    function CastDousingHex takes unit caster, unit target, integer level returns nothing
        local integer i = 1
        local integer abilId = 0 

        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility('A09K', 1, 852189)
        call dummy.target(target)
        call dummy.activate()
        set DousingHexReduction.real[GetHandleId(target)] = 0.1250 + (0.0125 * level)
        set DousingHexCooldown.real[GetHandleId(target)] = 1.17 + (0.03 * level)
        
        loop
            exitwhen i > 10
            set abilId = GetInfoHeroSpell(target ,i)
            if BlzGetUnitAbilityCooldownRemaining(target, abilId) > 0 then
                call BlzStartUnitAbilityCooldown(target,abilId, BlzGetUnitAbilityCooldownRemaining(target,abilId) * DousingHexCooldown.real[GetHandleId(target)])
            endif

            set i = i + 1
        endloop
        //call BJDebugMsg("dh: " + I2S(DousingHexChance.integer[GetHandleId(target)]))
    endfunction

    private function init takes nothing returns nothing
        set DousingHexCooldown = Table.create()
        set DousingHexReduction = Table.create()
    endfunction
endlibrary