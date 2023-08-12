library CryptLord initializer init requires ElementalAbility, RandomShit, EditAbilityInfo
    globals
        Table CryptLordLocustCount
    endglobals

    function SpawnLocustSwarm takes unit caster returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 10)
        call dummy.addActiveAbility('A02S', 1, 852556)
        call dummy.setAbilityIntegerField('A02S', ABILITY_ILF_NUMBER_OF_SWARM_UNITS, (CryptLordLocustCount[GetHandleId(caster)]))
        call dummy.instant().activate()
    endfunction

    private function init takes nothing returns nothing
        set CryptLordLocustCount = Table.create()
    endfunction
endlibrary