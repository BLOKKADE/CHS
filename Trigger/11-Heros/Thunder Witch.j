library ThunderWitch initializer init requires ElementalAbility, RandomShit
    globals
        Table ThunderBoltTargets
        Table ThunderBoltSource
    endglobals

    function ThunderWitchBolt takes unit u, integer level, integer hid returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 4)
        set ThunderBoltSource.boolean[GetDummyId(dummy.dummy)] = true
        call ElemFuncStart(u,THUNDER_WITCH_UNIT_ID)
        call dummy.addActiveAbility('A036', 1, OrderId("fanofknives"))
        call dummy.setAbilityRealField('A036', ABILITY_RLF_DAMAGE_PER_TARGET_OCL1, (30 + GetHeroLevel(u) * 30))
        //call BJDebugMsg("targets:" + I2S(ThunderBoltTargets[hid]))
        call dummy.setAbilityIntegerField('A036', ABILITY_ILF_MAXIMUM_NUMBER_OF_TARGETS_EFK3, ThunderBoltTargets[hid])
        call dummy.instant().activate()
        call AbilStartCD(u, 'A08P', 1)
    endfunction

    private function init takes nothing returns nothing
        set ThunderBoltTargets = Table.create()
        set ThunderBoltSource = Table.create()
    endfunction
endlibrary