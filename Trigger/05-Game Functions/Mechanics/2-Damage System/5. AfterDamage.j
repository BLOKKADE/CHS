scope AfterDamage initializer init

    globals
        trigger TrgAfterDamage
    endglobals

    private function AfterDamage takes nothing returns nothing

        // Cold Wind
        if DamageSourceAbility == COLD_WIND_ABILITY_ID and Damage.index.damage < 1 and (not ColdWindDamageIncreased.boolean[DamageSourceId]) then
            set ColdwindDamageBonus[DamageSourceId] = ColdwindDamageBonus[DamageSourceId] + 1
            set ColdWindDamageIncreased.boolean[DamageSourceId] = true
        endif

        //Finger of Death
        if DamageSourceAbility == FINGER_OF_DEATH_ABILITY_ID and Damage.index.damage <= FingerOfDeathTable.real[DamageTargetId] then
            call BlzStartUnitAbilityCooldown(DamageSource, GetDummySpell(DamageSource, FINGER_OF_DEATH_ABILITY_ID), BlzGetUnitAbilityCooldownRemaining(DamageSource, GetDummySpell(DamageSource, FINGER_OF_DEATH_ABILITY_ID)) * 0.5)
            call BlzStartUnitAbilityCooldown(DamageSource, FINGER_OF_DEATH_ABILITY_ID, BlzGetUnitAbilityCooldownRemaining(DamageSource, FINGER_OF_DEATH_ABILITY_ID) * 0.5)
        endif

        //Carrion Swarm heal
        if DamageSourceAbility == CARRION_SWARM_ABILITY_ID then
            call SetUnitState(DamageSource, UNIT_STATE_LIFE, GetUnitState(DamageSource, UNIT_STATE_LIFE) + Damage.index.damage)
        endif

        if DamageIsCrit and Damage.index.damage >= 1 then
            if IsPhysDamage() then
                call CreateTextTagTimerColor( I2S(R2I(Damage.index.damage)) + "!", 1, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 50, 1, 177, 0, 0)
            elseif IsMagicDamage() then
                call CreateTextTagTimerColor( I2S(R2I(Damage.index.damage)) + "!", 1, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 50, 1, 0, 0, 177)
            else
                call CreateTextTagTimerColor( I2S(R2I(Damage.index.damage)) + "!", 1, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 50, 1, 0, 177, 0)
            endif
        endif

        call ShowDamageText(false)
    endfunction

    private function init takes nothing returns nothing
        set TrgAfterDamage = CreateTrigger()
        call TriggerAddAction(TrgAfterDamage, function AfterDamage)
        call DamageTrigger.registerTrigger(TrgAfterDamage, "After", 1.0)
    endfunction

endscope