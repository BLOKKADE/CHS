scope AttackController initializer init
    function EndEvasionTimer takes nothing returns nothing 
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u = LoadUnitHandle(HT,i,1)
        local integer bonus = LoadInteger(HT,i,2)
        
        call AddUnitEvasion(u,-bonus)
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
        set u =null
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
        local unit attackerHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u2  )  )]
        local real luck =  GetUnitLuck(u)
        
        
        
        
        if IsUnitEnemy(u,GetOwningPlayer(u2)) == false then

            set t = NewTimer()
            call SaveUnitHandle(HT,GetHandleId(t),1,u2)
            call TimerStart(t,0.0,false,function Stop)
            set u = null
            set u2 = null
            return
        endif
        
        //Demon Hunter
        if GetUnitTypeId(u2) == 'O004' then
            set r1 =  GetHeroLevel(   attackerHero   )*20
            set r2 = GetUnitState(u, UNIT_STATE_MANA)
            set r3 = r2 - r1
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)-r1  )
            call SetUnitState(u2, UNIT_STATE_MANA, GetUnitState(u2, UNIT_STATE_MANA)+r1  )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u, "head"))
            if r3 <= 0 then
                if GetWidgetLife(u) <= - r3 then
                    call SetWidgetLife(u,1)
                else
                endif 
            endif
        endif
        if GetUnitTypeId(u2) == 'H01F' then
            set i1 = 1 + GetHeroLevel(u2)/10 
            call SaveInteger(HT,GetHandleId(u2),54021,i1+LoadInteger(HT,GetHandleId(u2),54021))
            call SetHeroStr(u2,GetHeroStr(u2,false)+i1,false)
            call SetHeroAgi(u2,GetHeroAgi(u2,false)+i1,false)
            call SetHeroInt(u2,GetHeroInt(u2,false)+i1,false)
        endif
        
        if GetUnitAbilityLevel(u,'A06C') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A06C') <= 0.001  then
            set t = NewTimer()
            
            call SaveUnitHandle(HT,GetHandleId(t),1,u)
            call SaveInteger(HT,GetHandleId(t),2,GetUnitAbilityLevel(u,'A06C')*10)
            call AddUnitEvasion(u,10*GetUnitAbilityLevel(u,'A06C'))
            call AbilStartCD(u,'A06C',8)
            call UnitAddAbility(u, 'A08D')
            call TimerStart(t,2.5,false,function EndEvasionTimer )
            set t = null
        endif
        
        if GetUnitAbilityLevel(u2,'A07N') > 0 and BlzGetUnitAbilityCooldownRemaining(u2,'A07N') <= 0.001  then
            call AreaDamagePhys(u2,GetUnitX(u2),GetUnitY(u2),100*GetUnitAbilityLevel(u2,'A07N'),500,'A07N')
            call AbilStartCD(u2,'A07N',2 ) 
        endif
        
        
        set i1 = UnitHasItemI( u2,'I06I' )
        if  i1 > 0 then
            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA)-50*i1  )
            call SetUnitState(u2, UNIT_STATE_MANA, GetUnitState(u2, UNIT_STATE_MANA)+50*i1  )
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u, "head"))
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", u2, "head"))
        endif
        
        //Huntress
        if GetUnitTypeId(u2) == 'N00R' then
            call USOrderA(u2,GetUnitX(u2),GetUnitY(u2),'A035',"fanofknives",  RMaxBJ(7, GetAttackDamage(attackerHero)* (0.495 + (0.005 * GetHeroLevel(attackerHero)))) , ConvertAbilityRealLevelField('Ocl1') )
        endif


        if (GetUnitAbilityLevel(GetTriggerUnit(),'A02U' ) >= 1)  and (GetRandomReal(1,100)<= 12*luck) then
            call USOrderA(GetTriggerUnit(),GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),'A02V',"fanofknives",  GetHeroStr(GetTriggerUnit(),true)*(60+20*I2R(GetUnitAbilityLevel(u,'A02U' )))/100, ConvertAbilityRealLevelField('Ocl1') )
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