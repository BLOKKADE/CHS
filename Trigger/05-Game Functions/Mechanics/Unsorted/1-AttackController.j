scope AttackController initializer init

    private function EndEvasionTimer takes nothing returns nothing 
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u = LoadUnitHandle(HT,i, 1)
        local integer bonus = LoadInteger(HT,i, 2)
        
        call AddUnitCustomState(u, BONUS_EVASION,- bonus)
        call RemoveUnitBuff(u, 'A08D')
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t = null
        set u = null
    endfunction

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
        local timer t = null
        local unit target = GetTriggerUnit()
        local unit attacker = GetAttacker()
        local unit attackerHero = PlayerHeroes[GetPlayerId(GetOwningPlayer(attacker))]
        local real luck = GetUnitCustomState(target, BONUS_LUCK)
        
        if IsUnitEnemy(target,GetOwningPlayer(attacker)) == false then

            set t = NewTimer()
            call SaveUnitHandle(HT, GetHandleId(t), 1, attacker)
            call TimerStart(t, 0.0, false, function Stop)
            set target = null
            set attacker = null
            return
        endif

        //Mega Speed
        if GetUnitAbilityLevel(attacker, MEGA_SPEED_ABILITY_ID) > 0 then
            if T32_Tick - MegaSpeedLastAttack[GetHandleId(attacker)] > 6 * 32 then
                set MegaSpeedStartTimer[GetHandleId(attacker)] = T32_Tick
            endif

            set MegaSpeedLastAttack[GetHandleId(attacker)] = T32_Tick
        endif

        //Corrosive Skin
        set i1 = GetUnitAbilityLevel(target, CORROSIVE_SKIN_ABILITY_ID)
        if i1 > 0 and GetRandomReal(0, 100) <= 35 * luck then
            call DummyOrder.create(target, GetUnitX(target), GetUnitY(target), GetUnitFacing(target), 4).addActiveAbility('A00R', 1, 852231).setAbilityRealField('A00R', ABILITY_RLF_DAMAGE_HTB1, (80 * i1)).target(attacker).activate()
            if GetUnitAbilityLevel(target, ABSOLUTE_POISON_ABILITY_ID) > 0 and GetUnitAbilityLevel(target, NULL_VOID_ORB_BUFF_ID) == 0 then
                call PoisonSpellCast(target, attacker)
            endif
        endif

        //Murloc
        if GetUnitTypeId(attacker) == MURLOC_WARRIOR_UNIT_ID then
            set i1 = 1 + GetHeroLevel(attacker)/ 10 
            call SaveInteger(HT, GetHandleId(attacker),54021, i1 + LoadInteger(HT, GetHandleId(attacker),54021))
            call SetHeroStr(attacker, GetHeroStr(attacker, false) + i1, false)
            call SetHeroAgi(attacker, GetHeroAgi(attacker, false) + i1, false)
            call SetHeroInt(attacker, GetHeroInt(attacker, false) + i1, false)
        endif
        
        //Reaction
        set i1 = GetUnitAbilityLevel(target, REACTION_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(target, REACTION_ABILITY_ID) <= 0.001  then
            set t = NewTimer()
            
            call SaveUnitHandle(HT, GetHandleId(t), 1,target)
            call SaveInteger(HT, GetHandleId(t), 2, i1 * 10)
            call AddUnitCustomState(target, BONUS_EVASION, 10 * i1)
            call AbilStartCD(target, REACTION_ABILITY_ID, 8)
            call UnitAddAbility(target, 'A08D')
            call TimerStart(t, 2.5, false, function EndEvasionTimer)
            set t = null
        endif
        
        //Cold Wind
        set i1 = GetUnitAbilityLevel(attacker, COLD_WIND_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(attacker, COLD_WIND_ABILITY_ID) <= 0.001  then
            call CastColdWind(attacker, i1)
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

        //Fire Force
        set i1 = GetUnitAbilityLevel(target,FIRE_FORCE_ABILITY_ID)
        if i1 > 0 and (GetRandomReal(1, 100)<= 25 * luck) then
            call DummyInstantCast1(target, GetUnitX(target), GetUnitY(target), 'A0C0', "fanofknives", GetHeroStr(target,true) * (0.62 + (0.08 * i1)), ConvertAbilityRealLevelField('Ocl1'))
        endif

        // Cleanup
        set target = null
        set attacker = null
    endfunction

    private function init takes nothing returns nothing
        local trigger attackControllerTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(attackControllerTrigger, EVENT_PLAYER_UNIT_ATTACKED)
        call TriggerAddAction(attackControllerTrigger, function AttackControllerActions)
        set attackControllerTrigger = null
    endfunction

endscope