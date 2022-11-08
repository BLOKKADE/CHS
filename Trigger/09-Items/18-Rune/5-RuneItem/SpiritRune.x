library SpiritRune initializer init requires RandomShit
    function SpiritRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 3)
        call dummy.addActiveAbility('A014', 1, 852274)
        call dummy.setAbilityRealField('A014', ABILITY_RLF_DAMAGE_DEALT_PERCENT_OF_NORMAL, 0.001*power)
        call dummy.setAbilityRealField('A014', ABILITY_RLF_DAMAGE_RECEIVED_MULTIPLIER, 2.0)
        call dummy.setAbilityRealField('A014', ABILITY_RLF_DURATION_HERO, 0.03*power)
        call dummy.setAbilityRealField('A014', ABILITY_RLF_DURATION_NORMAL, 0.03*power)
        call dummy.target(u)
        call dummy.activate()

        set u = null
        return false
    endfunction
endlibrary