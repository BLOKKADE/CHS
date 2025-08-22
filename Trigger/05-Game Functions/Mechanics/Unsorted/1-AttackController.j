scope AttackController initializer init
    private function Stop takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT, GetHandleId(t), 1)

        call IssueImmediateOrderById(u,851972)
        // call IssueTargetOrder(u, "smart",u)
        
        call FlushChildHashtable(HT, GetHandleId(t))
        call ReleaseTimer(t)
        set u = null
        set t = null
    endfunction

    private function AttackControllerActions takes nothing returns nothing
        local integer i1 = 0
        local timer t
        local unit target = GetTriggerUnit()
        local unit attacker = GetAttacker()
        local unit attackerHero = PlayerHeroes[GetPlayerId(GetOwningPlayer(attacker))]
        local real targetLuck = GetUnitCustomState(target, BONUS_LUCK)
        local integer i3 = 1 + GetHeroLevel(attacker) / 10
        local integer attackerId = GetHandleId(attacker)
        local integer baseStr = GetHeroStatBJ(bj_HEROSTAT_STR, attacker, true)
        local integer baseAgi = GetHeroStatBJ(bj_HEROSTAT_AGI, attacker, true)
        local integer baseInt = GetHeroStatBJ(bj_HEROSTAT_INT, attacker, true)
        local integer currentStr = GetHeroStr(attacker, true)
        local real scaleFactor = 1.0 + (currentStr / 30000.0) * 3.0
        local integer bonus = R2I(i3 * 1.5)
        
        if IsUnitEnemy(target, GetOwningPlayer(attacker)) == false then

            set t = NewTimer()
            call SaveUnitHandle(HT, GetHandleId(t), 1, attacker)
            call TimerStart(t, 0.0, false, function Stop)

            set t = null
            set target = null
            set attacker = null
            set attackerHero = null
            return
        endif

        // Murloc Warrior bonus logic
        if GetUnitTypeId(attacker) == MURLOC_WARRIOR_UNIT_ID then

            // Track bonuses separately
            if baseStr > baseAgi and baseStr > baseInt then
                call AddUnitBonus(attacker, BONUS_STRENGTH, i3 * 3)
                call SaveInteger(HT, attackerId, 54021, LoadInteger(HT, attackerId, 54021) + i3 * 3)
            elseif baseAgi > baseStr and baseAgi > baseInt then
                call AddUnitBonus(attacker, BONUS_AGILITY, i3 * 3)
                call SaveInteger(HT, attackerId, 54022, LoadInteger(HT, attackerId, 54022) + i3 * 3)
            elseif baseInt > baseStr and baseInt > baseAgi then
                call AddUnitBonus(attacker, BONUS_INTELLIGENCE, i3 * 3)
                call SaveInteger(HT, attackerId, 54023, LoadInteger(HT, attackerId, 54023) + i3 * 3)
            elseif baseStr == baseAgi and baseStr > baseInt then
                call AddUnitBonus(attacker, BONUS_STRENGTH, bonus)
                call AddUnitBonus(attacker, BONUS_AGILITY, bonus)
                call SaveInteger(HT, attackerId, 54021, LoadInteger(HT, attackerId, 54021) + bonus)
                call SaveInteger(HT, attackerId, 54022, LoadInteger(HT, attackerId, 54022) + bonus)
            elseif baseStr == baseInt and baseStr > baseAgi then
                call AddUnitBonus(attacker, BONUS_STRENGTH, bonus)
                call AddUnitBonus(attacker, BONUS_INTELLIGENCE, bonus)
                call SaveInteger(HT, attackerId, 54021, LoadInteger(HT, attackerId, 54021) + bonus)
                call SaveInteger(HT, attackerId, 54023, LoadInteger(HT, attackerId, 54023) + bonus)
            elseif baseAgi == baseInt and baseAgi > baseStr then
                call AddUnitBonus(attacker, BONUS_AGILITY, bonus)
                call AddUnitBonus(attacker, BONUS_INTELLIGENCE, bonus)
                call SaveInteger(HT, attackerId, 54022, LoadInteger(HT, attackerId, 54022) + bonus)
                call SaveInteger(HT, attackerId, 54023, LoadInteger(HT, attackerId, 54023) + bonus)
            elseif baseStr == baseAgi and baseStr == baseInt then
                call AddUnitBonus(attacker, BONUS_STRENGTH, i3)
                call AddUnitBonus(attacker, BONUS_AGILITY, i3)
                call AddUnitBonus(attacker, BONUS_INTELLIGENCE, i3)
                call SaveInteger(HT, attackerId, 54021, LoadInteger(HT, attackerId, 54021) + i3)
                call SaveInteger(HT, attackerId, 54022, LoadInteger(HT, attackerId, 54022) + i3)
                call SaveInteger(HT, attackerId, 54023, LoadInteger(HT, attackerId, 54023) + i3)
            endif

            // Dynamic scaling based on bonus Strength
            if scaleFactor > 4.0 then
                set scaleFactor = 4.0
            endif

            call SetUnitScale(attacker, scaleFactor, scaleFactor, scaleFactor)
        endif




        //Huntress
        if GetUnitTypeId(attacker) == HUNTRESS_UNIT_ID then
            if BlzGetUnitAbilityCooldownRemaining(attacker, 'A0DW') == 0 then
                call ElemFuncStart(attacker, HUNTRESS_UNIT_ID)
                call DummyInstantCast1(attacker, GetUnitX(attacker), GetUnitY(attacker), 'A035', "fanofknives",  RMaxBJ(7, GetAttackDamage(attackerHero)* (0.245 + (0.005 * GetHeroLevel(attackerHero)))) , ConvertAbilityRealLevelField('Ocl1'), 4)
                call AbilStartCD(attacker, 'A0DW', 1)
            endif
        endif
        
        //Pyromancer
        if GetUnitTypeId(attacker) == PYROMANCER_UNIT_ID then
            call PyromancerScorch(attacker, target)
        endif

        //Mega Speed
        if GetUnitAbilityLevel(attacker, MEGA_SPEED_ABILITY_ID) > 0 then
            if T32_Tick - MegaSpeedLastAttack[GetHandleId(attacker)] > 6 * 32 then
                set MegaSpeedStartTimer[GetHandleId(attacker)] = T32_Tick
            endif

            set MegaSpeedLastAttack[GetHandleId(attacker)] = T32_Tick
        endif

        //Locust
        if GetUnitTypeId(attacker) == CRYPT_LORD_LOCUST_UNIT_ID then
            set attacker = attackerHero
        endif

        //Corrosive Skin
        set i1 = GetUnitAbilityLevel(target, CORROSIVE_SKIN_ABILITY_ID)
        if i1 > 0 and GetRandomReal(0, 100) <= 35 * targetLuck then
            call DummyOrder.create(target, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 4).addActiveAbility('A00R', 1, 852231).setAbilityRealField('A00R', ABILITY_RLF_DAMAGE_HTB1, (80 * i1)).target(attacker).activate()
            if GetUnitAbilityLevel(target, ABSOLUTE_POISON_ABILITY_ID) > 0 and GetUnitAbilityLevel(target, NULL_VOID_ORB_BUFF_ID) == 0 then
                call PoisonSpellCast(target, attacker)
            endif
        endif

        //Reaction
        set i1 = GetUnitAbilityLevel(target, REACTION_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(target, REACTION_ABILITY_ID) == 0 then
            call TempBonus.create(target, BONUS_EVASION, 10 * i1, 2.5, REACTION_ABILITY_ID).addBuffLink('A08D').activate()
            call TempAbil.create(target, 'A08D', 2.5)
            call AbilStartCD(target, REACTION_ABILITY_ID, 8)
        endif
        
        //Cold Wind
        set i1 = GetUnitAbilityLevel(attacker, COLD_WIND_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(attacker, COLD_WIND_ABILITY_ID) == 0 then
            call CastColdWind(attacker, i1)
        endif

        //Fire Force
        set i1 = GetUnitAbilityLevel(target, FIRE_FORCE_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(target, FIRE_FORCE_ABILITY_ID) == 0 and (GetRandomReal(1, 100) <= 25 * targetLuck) then
            call BlzStartUnitAbilityCooldown(target, FIRE_FORCE_ABILITY_ID, 0.3)
            call BlzStartUnitAbilityCooldown(target, GetDummySpell(target, FIRE_FORCE_ABILITY_ID), 0.3)
            call DummyInstantCast1(target, GetUnitX(target), GetUnitY(target), 'A0C0', "fanofknives", GetHeroStr(target,true) * (0.62 + (0.08 * i1)), ConvertAbilityRealLevelField('Ocl1'), 4)
        endif

        // Cleanup
        set target = null
        set attacker = null
        set attackerHero = null
    endfunction

    private function init takes nothing returns nothing
        local trigger attackControllerTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(attackControllerTrigger, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddAction(attackControllerTrigger, function AttackControllerActions)
        set attackControllerTrigger = null
    endfunction

endscope