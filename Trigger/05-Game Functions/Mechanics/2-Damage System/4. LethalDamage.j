scope LethalDamage initializer init

    globals
        trigger TrgLethalDamage
    endglobals

    private function LethalDamage takes nothing returns nothing
        local integer i = 0
        local boolean negated = false

        //Skeleton Battlemaster (Black Arrow)
        set i = GetUnitAbilityLevel(DamageTargetHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
        if i > 0 and GetUnitAbilityLevel(DamageTarget, 'A0AX') > 0 and GetRandomInt(1,100) < (i + 10) * GetUnitCustomState(DamageTargetHero, BONUS_LUCK) then
            set udg_LethalDamageHP = GetUnitState(DamageTarget, UNIT_STATE_MAX_LIFE)
            return
        endif

        if GetUnitAbilityLevel(DamageTarget, 'A08B') > 0 then
            set udg_LethalDamageHP = 1
            return
        endif

        //Ankh of Reincarnation
        if UnitHasItemType(DamageTarget, 'ankh') and GetUnitAbilityLevel(DamageTarget, 'A0EP') == 0 then
            call BJDebugMsg("Ankh")
            set udg_LethalDamageHP = 1
            call RemoveItem(GetUnitItem(DamageTarget, 'ankh'))
            call Reincarnate.start(DamageTarget, 1, 500)
            return
        endif

        //Reincarnation
        if GetUnitAbilityLevel(DamageTarget, REINCARNATION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget, REINCARNATION_ABILITY_ID) == 0 and GetUnitAbilityLevel(DamageTarget, 'A0EP') == 0 then
            call BJDebugMsg("Reincarnation") 
            set udg_LethalDamageHP = 1
            call BlzStartUnitAbilityCooldown(DamageTarget, REINCARNATION_ABILITY_ID, 244 - (4 * GetUnitAbilityLevel(DamageTarget, REINCARNATION_ABILITY_ID)))
            call Reincarnate.start(DamageTarget, 2, BlzGetUnitMaxHP(DamageTarget))
            return
        endif

        //Magic Necklace
        if UnitHasItemType(DamageSourceHero, 'I05G') and IsMagicDamage() then
            set MagicNecklaceBonus.boolean[GetHandleId(DamageTarget)] = true
        endif

        //Chest of Greed
        if UnitHasItemType(DamageSourceHero, 'I05A') and IsPhysDamage() then
            set ChestOfGreedBonus.boolean[GetHandleId(DamageTarget)] = true
        endif

        //Battle Runestone
        if UnitHasItemType(DamageSourceHero, 'I0BX') then
            call CheckBattleRunestoneCount(DamageSourceHero, GetHandleId(DamageSourceHero))
        endif

        //Last Breath
        set i = GetUnitAbilityLevel(DamageTarget, LAST_BREATHS_ABILITY_ID)
        if Damage.index.damageType != DAMAGE_TYPE_ENHANCED and i > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,LAST_BREATHS_ABILITY_ID) == 0 then
            set negated = true
            call ActivateLastBreath(DamageTarget, DamageSource, i)
        endif

        if DamageTargetPid != 11 and DamageTarget == DamageTargetHero and negated == false then
            call ShowDamageText(true)
        endif

        //call BJDebugMsg("lethal source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgLethalDamage = CreateTrigger()
        call TriggerAddAction(TrgLethalDamage, function LethalDamage)
        call DamageTrigger.registerTrigger(TrgLethalDamage, "Lethal", 1.0)
    endfunction

endscope