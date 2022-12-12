library ElementalAbility requires RandomShit, AbilityData, CustomState, RuneInit, DrainAura
    globals
        unit GLOB_ELEM_U = null
        integer GLOB_ELEM_I = 0
    endglobals

    function ElementStartAbility takes unit u, integer id returns nothing
        local unit U = null
        local real calc = 0
        local real luck = GetUnitCustomState(u, BONUS_LUCK)

        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return
        endif

        //Decaying Scythe
        if GetUnitAbilityLevel(u, DECAYING_SCYTHE_ABILITY_ID) > 0 and IsSpellElement(u, id, Element_Poison) then
            call DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 2).addActiveAbility(DECAYING_SCYTHE_DUMMY2_ABILITY_ID, 1, 852588).instant().activate()
        endif
        
        //Fire Runestone
        if UnitHasItemType(u,FIRE_RUNESTONE_ITEM_ID) and IsSpellElement(u,id, Element_Fire) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A076') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,Element_Fire)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 1000)
                call AbilStartCD(u,'A076',3 ) 
            endif
        endif
        
        //Water Runestone
        if UnitHasItemType(u,WATER_RUNESTONE_ITEM_ID) and IsSpellElement(u,id,Element_Water) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A077') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,Element_Water)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 1000)
                call AbilStartCD(u,'A077',3 ) 
            endif
        endif
        
        //Earth Runestone
        if UnitHasItemType(u,EARTH_RUNESTONE_ITEM_ID) and IsSpellElement(u,id,Element_Earth) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A078') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,Element_Earth)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 1000)
                call AbilStartCD(u,'A078',8 ) 
            endif
        endif
        
        //Wind Runestone
        if UnitHasItemType(u,WIND_RUNESTONE_ITEM_ID) and IsSpellElement(u,id,Element_Wind) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A079') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 500 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,Element_Wind)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 500)
                call AbilStartCD(u,'A079',12 ) 
            endif
        endif

        //Wild Runestone
        if UnitHasItemType(u, WILD_RUNESTONE_ITEM_ID) and IsSpellElement(u, id, Element_Wild) then
            if BlzGetUnitAbilityCooldownRemaining(u, 'A0AN') == 0 and GetUnitState(u, UNIT_STATE_MANA) >= 500 then
                call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Element_Wild)  )
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - 500)
                call AbilStartCD(u, 'A0AN', 10) 
            endif
        endif

        //Light Runestone
        if UnitHasItemType(u, LIGHT_RUNESTONE_ITEM_ID) and IsSpellElement(u, id, Element_Light) then
            if BlzGetUnitAbilityCooldownRemaining(u, 'A0AK') == 0 and GetUnitState(u, UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Element_Light)  )
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - 1000)
                call AbilStartCD(u, 'A0AK', 15) 
            endif
        endif

        //Dark Runestone
        if UnitHasItemType(u, DARK_RUNESTONE_ITEM_ID) and IsSpellElement(u, id, Element_Dark) then
            if BlzGetUnitAbilityCooldownRemaining(u, 'A0AL') == 0 and GetUnitState(u, UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Element_Dark)  )
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - 1000)
                call AbilStartCD(u, 'A0AL', 12) 
            endif
        endif

        //Poison Runestone
        if UnitHasItemType(u, POISON_RUNESTONE_ITEM_ID) and IsSpellElement(u, id, Element_Poison) then
            if BlzGetUnitAbilityCooldownRemaining(u, 'A0AO') == 0 and GetUnitState(u, UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Element_Poison)  )
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - 1000)
                call AbilStartCD(u, 'A0AO', 15) 
            endif
        endif

        //Arcane Runestone
        if UnitHasItemType(u, ARCANE_RUNESTONE_ITEM_ID) and IsSpellElement(u, id, Element_Arcane) then
            if BlzGetUnitAbilityCooldownRemaining(u, 'A0AM') == 0 and GetUnitState(u, UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u, CreateRune(null, 0, 0, 0, u, Element_Arcane)  )
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - 1000)
                call AbilStartCD(u, 'A0AM', 30) 
            endif
        endif
        
        //Absolute Fire
        if GetUnitAbilityLevel(u,ABSOLUTE_FIRE_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Fire) then
            if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
                set calc = 1 - RMaxBJ(0.25 * GetUnitElementCount(u, Element_Water), 0)
                call TempBonus.create(u, BONUS_MAGICPOW, (2 * (1 + /*GetUnitAbsoluteEffective(u,Element_Fire) + */(0.005 * GetHeroLevel(u)))) * calc, 10, ABSOLUTE_FIRE_ABILITY_ID).activate()
            else
                call TempBonus.create(u, BONUS_MAGICPOW, 2 /* (1 + GetUnitAbsoluteEffective(u,Element_Fire))*/, 10, ABSOLUTE_FIRE_ABILITY_ID).activate()
            endif
        endif
        
        //Absolute Water
        if GetUnitAbilityLevel(u,ABSOLUTE_WATER_ABILITY_ID) > 0 and IsSpellElement(u,id, Element_Water) then
            call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA) + (GetUnitState(u,UNIT_STATE_MAX_MANA))* .02)
            call TempBonus.create(u, BONUS_INTELLIGENCE,20 /* (1 + GetUnitAbsoluteEffective(u,Element_Water))*/,9, ABSOLUTE_WATER_ABILITY_ID).activate()
        endif      
        
        //Absolute Wind
        if GetUnitAbilityLevel(u,ABSOLUTE_WIND_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Wind) then
            call TempBonus.create(u, BONUS_AGILITY,25 /** (1 + GetUnitAbsoluteEffective(u,Element_Wind))*/,9, ABSOLUTE_WIND_ABILITY_ID).activate()
            call TempBonus.create(u, BONUS_EVASION,5 /** (1 + GetUnitAbsoluteEffective(u,Element_Wind))*/,9, ABSOLUTE_WIND_ABILITY_ID).activate()
        endif   
        
        //Absolute Earth
        if GetUnitAbilityLevel(u,ABSOLUTE_EARTH_ABILITY_ID) > 0 and IsSpellElement(u,id, Element_Earth) then
            call TempBonus.create(u,BONUS_BLOCK, 50 /** (1 + GetUnitAbsoluteEffective(u,Element_Earth))*/,15, ABSOLUTE_EARTH_ABILITY_ID).activate()
        endif     
        
        //Absolute Dark
        if GetUnitAbilityLevel(u,ABSOLUTE_DARK_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Dark) then
            call ActivateDrainAura(u, GetUnitX(u), GetUnitY(u), 8, 500, false)
        endif           
        
        //Absolute Cold
        if GetUnitAbilityLevel(u,ABSOLUTE_COLD_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Cold) then
            call AbsoluteColdCooldown(u)
        endif           
        
        //Absolute Light
        if GetUnitAbilityLevel(u,ABSOLUTE_LIGHT_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Light) then
            call SetUnitState(u,UNIT_STATE_LIFE,GetUnitState(u,UNIT_STATE_LIFE) + (GetUnitState(u,UNIT_STATE_LIFE))* .04 /** (1 + GetUnitAbsoluteEffective(u,Element_Light))*/)
        endif 

        //Absolute Wild
        if GetUnitAbilityLevel(u,ABSOLUTE_WILD_ABILITY_ID) > 0 and IsSpellElement(u,id,Element_Wild) then
            set U = CreateUnit( GetOwningPlayer(u),'h01N',GetUnitX(u)+ 40 * CosBJ(- 30 + GetUnitFacing(u)),GetUnitY(u)+ 40 * SinBJ(- 30 + GetUnitFacing(u)),GetUnitFacing(u) )
            call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)- 1000 + R2I(GetHeroLevel(u)*(1000)/* * (1 + GetUnitAbsoluteEffective(u,Element_Wild))*/))
            call BlzSetUnitBaseDamage(U,BlzGetUnitBaseDamage(U,0) + 150 + R2I((50)* GetHeroLevel(u) /** (1 + GetUnitAbsoluteEffective(u,Element_Wild))*/) ,0)
            call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,15)
        endif   
        
        //Stone Helmet
        if UnitHasItemType(u,'I090') and IsSpellElement(u,id,Element_Earth) then   
            if GetRandomReal(0,100) <= 30 * luck then 
                set U = CreateUnit( GetOwningPlayer(u),'h01M',GetUnitX(u)+ 40 * CosBJ(- 30 + GetUnitFacing(u)),GetUnitY(u)+ 40 * SinBJ(- 30 + GetUnitFacing(u)),GetUnitFacing(u) )
                call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)- 3000 + GetHeroLevel(u)*(2500 + 50 * GetHeroLevel(u)))
                call AddUnitCustomState(U, BONUS_BLOCK,100 + 50 * GetHeroLevel(u) )
                call BlzSetUnitBaseDamage(U,BlzGetUnitBaseDamage(U,0) + 200 + (50 + GetHeroLevel(u))* GetHeroLevel(u) ,0)
                call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
                call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,30)
        
            endif
        endif

        set u = null
        set U = null
    endfunction


    function ElemStartTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        call ElementStartAbility(LoadUnitHandle(HT,GetHandleId(t),1),LoadInteger(HT,GetHandleId(t),2))
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
    endfunction


    function ElementStartAbilityS takes nothing returns nothing
        local timer t = NewTimer()
        call SaveUnitHandle(HT,GetHandleId(t),1,GLOB_ELEM_U)
        call SaveInteger(HT,GetHandleId(t),2,GLOB_ELEM_I)
        call TimerStart(t,0,false,function ElemStartTimer)
    
        set t = null
    endfunction
endlibrary