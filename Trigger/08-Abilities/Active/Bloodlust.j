library Bloodlust requires RuneInit, AbilityCooldown, DummyOrder, GetRandomUnit, CastSpellOnTarget

    globals
        private unit bloodlustCaster = null
        private integer bloodlustLevel = 0
    endglobals

    function CastBloodlust takes unit caster, unit target, integer lvl returns nothing
        local real duration = 17.0 + 1.0 * lvl
        if IsUnitSpellTargetCheck(caster, GetOwningPlayer(caster)) then
            call UniqueTempBonus(target, BONUS_ATTACK_SPEED, 0.133 * lvl, duration, BLOODLUST_ABILITY_ID, 'Bblo')
            call UniqueTempBonus(target, BONUS_MOVEMENT_SPEED, 0.02 * lvl, duration, BLOODLUST_ABILITY_ID, 'Bblo')
        endif
    endfunction

    private function BloodlustDelayedCast takes nothing returns nothing
        local unit target
        local integer i = 0

        call RUH.reset().doHeroPriority().checkMagicImmune()
        call RUH.EnumUnits(GetUnitX(bloodlustCaster), GetUnitY(bloodlustCaster), 500, Target_Ally, GetOwningPlayer(bloodlustCaster))

        loop
            set target = RUH.GetRandomUnit(true)
            exitwhen target == null

            call CastSpell(bloodlustCaster, target, BLOODLUST_ABILITY_ID, bloodlustLevel, Order_Target, 0, 0).activate()

            set i = i + 1
            exitwhen i > 4
        endloop

        call AbilStartCD(bloodlustCaster, BLOODLUST_ABILITY_ID, 10)

        // Cleanup
        set bloodlustCaster = null
        set bloodlustLevel = 0
    endfunction

    function CastBloodlustOnSpellCast takes unit caster, integer lvl returns nothing
        set bloodlustCaster = caster
        set bloodlustLevel = lvl
        call TimerStart(CreateTimer(), 0.50, false, function BloodlustDelayedCast)
    endfunction

endlibrary

