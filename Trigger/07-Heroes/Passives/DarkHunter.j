library DarkHunter initializer init requires DummyOrder, Table
    globals
        Table DarkHunterStun
    endglobals

    function ApplyDarkHunterStun takes unit source, unit target, real damage, real duration returns nothing
        local DummyOrder dummy = DummyOrder.create(source, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 5)
        call dummy.addActiveAbility('A06T', 1, 852095)
        call dummy.setAbilityRealField('A06T', ABILITY_RLF_DAMAGE_HTB1, damage)
        call dummy.setAbilityRealField('A06T', ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField('A06T', ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.target(target).activate()
    endfunction

    private function init takes nothing returns nothing
        set DarkHunterStun = Table.create()
    endfunction
endlibrary