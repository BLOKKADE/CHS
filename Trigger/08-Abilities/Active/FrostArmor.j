library FrostArmor requires RuneInit, AbilityCooldown, DummyOrder, GetRandomUnit, CastSpellOnTarget
    function CastFrostArmorOnSpellCast takes unit caster, integer lvl returns nothing
        local integer i = 0
        local DummyOrder dummy
        local unit target = null

        call RUH.reset().doHeroPriority().checkMagicImmune()
        call RUH.EnumUnits(GetUnitX(caster), GetUnitY(caster), 500, Target_Ally, GetOwningPlayer(caster))

        loop
            set target = RUH.GetRandomUnit(true)

            if target == null then
                exitwhen true
            endif

            call CastSpell(caster, target, FROST_ARMOR_ABILITY_ID, lvl, Order_Target, 0, 0).activate()

            set i = i + 1
            exitwhen i > 5
        endloop

        call AbilStartCD(caster, FROST_ARMOR_ABILITY_ID, 8)
    endfunction
endlibrary