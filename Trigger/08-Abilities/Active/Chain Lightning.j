library ChainLightning requires DummyOrder, GetRandomUnit
    function CastChainLightning takes unit caster returns nothing
        local integer i = 0
        local DummyOrder dummy
        local unit target = null

        call RUH.reset().doHeroPriority().checkMagicImmune()
        call RUH.EnumUnits(GetUnitX(caster), GetUnitY(caster), 600, Target_Enemy, GetOwningPlayer(caster))

        loop
            set target = RUH.GetRandomUnit(true)

            if target == null then
                exitwhen true
            endif

            set dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 5)
            call dummy.addActiveAbility(CHAIN_LIGHTNING_DUMMY_ABILITY_ID, 1, 852119)
            call dummy.setAbilityRealField(CHAIN_LIGHTNING_DUMMY_ABILITY_ID, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1, GetHeroInt(caster,true) * 1)
            call dummy.target(target)
            call dummy.activate()

            set i = i + 1
            exitwhen i >= 2
        endloop
    endfunction
endlibrary