scope LethalDamage initializer init

    globals
        trigger TrgLethalDamage
    endglobals

    private function LethalDamage takes nothing returns nothing
        local integer i = 0

        //Skeleton Battlemaster (Black Arrow)
        set i = GetUnitAbilityLevel(DamageTargetHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
        if i > 0 and GetUnitAbilityLevel(DamageTarget, 'A0AX') > 0 /*and GetRandomInt(1,100) < (i + 10) * GetUnitLuck(DamageTargetHero)*/ then
            set udg_LethalDamageHP = GetUnitState(DamageTarget, UNIT_STATE_MAX_LIFE)
            return
        endif

        //Magic Necklace
        if UnitHasItemS(DamageSourceHero, 'I05G') and Damage.index.isSpell then
            set MacigNecklaceBonus.boolean[GetHandleId(DamageTarget)] = true
        endif

        //Chest of Greed
        if UnitHasItemS(DamageSourceHero, 'I05A') and (not Damage.index.isSpell) then
            set ChestOfGreedBonus.boolean[GetHandleId(DamageTarget)] = true
        endif

        //call BJDebugMsg("lethal source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgLethalDamage = CreateTrigger()
        call TriggerAddAction(TrgLethalDamage, function LethalDamage)
        call DamageTrigger.registerTrigger(TrgLethalDamage, "Lethal", 1.0)
    endfunction

endscope