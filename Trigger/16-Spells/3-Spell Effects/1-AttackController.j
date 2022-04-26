scope AttackController initializer init
    function EndEvasionTimer takes nothing returns nothing 
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u = LoadUnitHandle(HT,i,1)
        local integer bonus = LoadInteger(HT,i,2)
        
        call AddUnitEvasion(u,- bonus)
        call UnitRemoveAbility(u, 'A08D')
        call UnitRemoveAbility(u, 'B01F')
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t = null
        set u = null
    endfunction

    function Stop takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit u = LoadUnitHandle(HT,GetHandleId(t),1)

        call IssueImmediateOrderById(u,851972)
        // call IssueTargetOrder(u,"smart",u)

        
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set u = null
        set t = null
    endfunction



    function Trig_Spell12_Actions takes nothing returns nothing
        local real r1
        local real r2
        local real r3
        local integer i1 = 0
        local timer t = null
        local unit u = GetTriggerUnit()
        local unit u2 = GetAttacker()
        local unit attackerHero = PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer( u2  )  )]
        local real luck = GetUnitLuck(u)
        
        
        
        
        if IsUnitEnemy(u,GetOwningPlayer(u2)) == false then

            set t = NewTimer()
            call SaveUnitHandle(HT,GetHandleId(t),1,u2)
            call TimerStart(t,0.0,false,function Stop)
            set u = null
            set u2 = null
            return
        endif

        //Mega Speed
        if GetUnitAbilityLevel(u2, MEGA_SPEED_ABILITY_ID) > 0 then
            if T32_Tick - MegaSpeedLastAttack[GetHandleId(u2)] > 6 * 32 then
                set MegaSpeedStartTimer[GetHandleId(u2)] = T32_Tick
            endif

            set MegaSpeedLastAttack[GetHandleId(u2)] = T32_Tick
        endif

        //Corrosive Skin

        set i1 = GetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID)
        if i1 > 0 and GetRandomReal(0,100) <= 35 * luck then
            call DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 4).addActiveAbility('A00R', 1, 852231).setAbilityRealField('A00R', ABILITY_RLF_DAMAGE_HTB1, (80 * i1)).target(u2).activate()
            if GetUnitAbilityLevel(u, ABSOLUTE_POISON_ABILITY_ID) > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0 then
                call PoisonSpellCast(u, u2)
            endif
        endif
        
        //Demon Hunter
        if GetUnitTypeId(u2) == DEMON_HUNTER_UNIT_ID then
            set r1 = GetHeroLevel(   attackerHero   )* 20
            set r2 = GetUnitState(u, UNIT_STATE_MANA)
            set r3 = r2 - r1
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)- r1  )
            call SetUnitState(u2, UNIT_STATE_MANA, GetUnitState(u2, UNIT_STATE_MANA)+ r1  )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u, "head"))
            if r3 <= 0 then
                if GetWidgetLife(u) <= - r3 then
                    call SetWidgetLife(u,1)
                else
                endif 
            endif
        endif

        //Murloc
        if GetUnitTypeId(u2) == MURLOC_WARRIOR_UNIT_ID then
            set i1 = 1 + GetHeroLevel(u2)/ 10 
            call SaveInteger(HT,GetHandleId(u2),54021,i1 + LoadInteger(HT,GetHandleId(u2),54021))
            call SetHeroStr(u2,GetHeroStr(u2,false)+ i1,false)
            call SetHeroAgi(u2,GetHeroAgi(u2,false)+ i1,false)
            call SetHeroInt(u2,GetHeroInt(u2,false)+ i1,false)
        endif
        
        //Reaction
        set i1 = GetUnitAbilityLevel(u,REACTION_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(u,REACTION_ABILITY_ID) <= 0.001  then
            set t = NewTimer()
            
            call SaveUnitHandle(HT,GetHandleId(t),1,u)
            call SaveInteger(HT,GetHandleId(t),2,i1* 10)
            call AddUnitEvasion(u,10 * i1)
            call AbilStartCD(u,REACTION_ABILITY_ID,8)
            call UnitAddAbility(u, 'A08D')
            call TimerStart(t,2.5,false,function EndEvasionTimer )
            set t = null
        endif
        
        //Cold Wind
        set i1 = GetUnitAbilityLevel(u2,COLD_WIND_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(u2,COLD_WIND_ABILITY_ID) <= 0.001  then
            call AreaDamagePhys(u2,GetUnitX(u2),GetUnitY(u2), GetSpellValue(75, 10, i1),500,COLD_WIND_ABILITY_ID)
            call AbilStartCD(u2,COLD_WIND_ABILITY_ID,2 ) 
        endif
        
        //Magical Blade
        set i1 = UnitHasItemI( u2,'I06I' )
        if i1 > 0 then
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)- 50 * i1  )
            call SetUnitState(u2, UNIT_STATE_MANA, GetUnitState(u2, UNIT_STATE_MANA)+ 50 * i1  )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u, "head"))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u2, "head"))
        endif
        
        //Huntress
        if GetUnitTypeId(u2) == HUNTRESS_UNIT_ID then
            call USOrderA(u2,GetUnitX(u2),GetUnitY(u2),'A035',"fanofknives",  RMaxBJ(7, GetAttackDamage(attackerHero)* (0.495 + (0.005 * GetHeroLevel(attackerHero)))) , ConvertAbilityRealLevelField('Ocl1') )
        endif

        //Pyromancer
        if GetUnitTypeId(u2) == PYROMANCER_UNIT_ID then
            call PyromancerScorch(u2, u)
        endif

        //Fire Force
        set i1 = GetUnitAbilityLevel(u,FIRE_FORCE_ABILITY_ID )
        if i1 > 0 and (GetRandomReal(1,100)<= 12 * luck) then
            call USOrderA(u,GetUnitX(u),GetUnitY(u),'A0C0',"fanofknives",  GetHeroStr(u,true)*(60 + 20 * I2R(i1))/ 100, ConvertAbilityRealLevelField('Ocl1') )
        endif
        set u = null
        set u2 = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_ATTACKED )
        call TriggerAddAction( trg, function Trig_Spell12_Actions )
        set trg = null
    endfunction
endscope