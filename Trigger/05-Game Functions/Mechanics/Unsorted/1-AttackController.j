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

        //Murloc
        if GetUnitTypeId(attacker) == MURLOC_WARRIOR_UNIT_ID then
            set i1 = 1 + GetHeroLevel(attacker)/ 10 
            call SaveInteger(HT, GetHandleId(attacker),54021, i1 + LoadInteger(HT, GetHandleId(attacker),54021))
            call SetHeroStr(attacker, GetHeroStr(attacker, false) + i1, false)
            call SetHeroAgi(attacker, GetHeroAgi(attacker, false) + i1, false)
            call SetHeroInt(attacker, GetHeroInt(attacker, false) + i1, false)
        endif

        //Huntress
        if GetUnitTypeId(attacker) == HUNTRESS_UNIT_ID then
            if BlzGetUnitAbilityCooldownRemaining(attacker, 'A0DW') == 0 then
                call ElemFuncStart(attacker, HUNTRESS_UNIT_ID)
                call DummyInstantCast1(attacker, GetUnitX(attacker), GetUnitY(attacker), 'A035', "fanofknives",  RMaxBJ(7, GetAttackDamage(attackerHero)* (0.245 + (0.005 * GetHeroLevel(attackerHero)))) , ConvertAbilityRealLevelField('Ocl1'))
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
        set i1 = GetUnitAbilityLevel(target,FIRE_FORCE_ABILITY_ID)
        if i1 > 0 and (GetRandomReal(1, 100)<= 25 * targetLuck) then
            call DummyInstantCast1(target, GetUnitX(target), GetUnitY(target), 'A0C0', "fanofknives", GetHeroStr(target,true) * (0.62 + (0.08 * i1)), ConvertAbilityRealLevelField('Ocl1'))
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