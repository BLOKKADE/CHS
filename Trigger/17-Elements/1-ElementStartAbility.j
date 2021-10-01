library ElementalAbility requires RandomShit, AbilityData, CustomState, RuneInit
    globals
        unit GLOB_ELEM_U = null
        integer GLOB_ELEM_I = 0
    endglobals

    function ElementStartAbility takes unit u, integer id returns nothing
        local unit U = null
        local real luck = GetUnitLuck(u)

        if GetUnitAbilityLevel(u, 'B01W') > 0 then
            return
        endif
        
        //Fire Runestone
        if  UnitHasItemS(u,'I08P') and IsSpellElement(u,id,1) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A076') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,3)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)-1000)
                call AbilStartCD(u,'A076',3 ) 
            endif
        endif
        
        //Water Runestone
        if  UnitHasItemS(u,'I08Q') and IsSpellElement(u,id,2) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A077') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,9)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)-1000)
                call AbilStartCD(u,'A077',3 ) 
            endif
        endif
        
        //Earth Runestone
        if  UnitHasItemS(u,'I08R') and IsSpellElement(u,id,4) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A078') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 1000 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,8)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)-1000)
                call AbilStartCD(u,'A078',8 ) 
            endif
        endif
        
        //Wind Runestone
        if  UnitHasItemS(u,'I08S') and IsSpellElement(u,id,3) then            
            if BlzGetUnitAbilityCooldownRemaining(u,'A079') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 500 then
                call UnitAddItem(u,CreateRune(null, 0,0,0,u,10)  )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)-500)
                call AbilStartCD(u,'A079',12 ) 
            endif
        endif
        
        //Absolute Fire
        if GetUnitAbilityLevel(u,'A07B') > 0 and IsSpellElement(u,id,1) then
            call AddStateTemp(u,1,4,10)
        endif
        
        //Absolute Water
        if GetUnitAbilityLevel(u,'A07C') > 0 and IsSpellElement(u,id,2) then
            call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA) + (GetUnitState(u,UNIT_STATE_MAX_MANA))*.02    )
        endif      
        
        //Absolute Wind
        if GetUnitAbilityLevel(u,'A07E') > 0 and IsSpellElement(u,id,3) then
            call AddHeroTempAgi(u,25,9)
            call AddStateTemp(u,3,5,9)
        endif   
        
        //Absolute Earth
        if GetUnitAbilityLevel(u,'A07D') > 0 and IsSpellElement(u,id,4) then
            call AddStateTemp(u,4, 50,15)
        endif     
        
        //Absolute Dark
        if GetUnitAbilityLevel(u,'A07Q') > 0 and IsSpellElement(u,id,7) then
            call AoeDrainAura2(u,8,500,false)
        endif           
        
        //Absolute Cold
        if GetUnitAbilityLevel(u,'A07V') > 0 and IsSpellElement(u,id,9) then
            call AbsoluteColdCooldown(u)
        endif           
        
        //Absolute Light
        if GetUnitAbilityLevel(u,'A07P') > 0 and IsSpellElement(u,id,8) then
            call SetUnitState(u,UNIT_STATE_LIFE,GetUnitState(u,UNIT_STATE_LIFE) + (GetUnitState(u,UNIT_STATE_LIFE))*.04)
        endif 

        //Absolute Wild
        if GetUnitAbilityLevel(u,'A07K') > 0 and IsSpellElement(u,id,5) then
                set U = CreateUnit( GetOwningPlayer(u),'h01N',GetUnitX(u)+40*CosBJ(-30+GetUnitFacing(u)),GetUnitY(u)+40*SinBJ(-30+GetUnitFacing(u)),GetUnitFacing(u) )
                call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)-1000 +   GetHeroLevel(u)*(1000))
                call BlzSetUnitBaseDamage(U,BlzGetUnitBaseDamage(U,0) + 150 + (50)*GetHeroLevel(u) ,0)
                call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
                call UnitApplyTimedLife(U,'A041',15)
        endif   
        
        //Stone Helmet
        if  UnitHasItemS(u,'I090') and IsSpellElement(u,id,4) then   
            if GetRandomReal(0,100) <= 30*luck then 
                set U = CreateUnit( GetOwningPlayer(u),'h01M',GetUnitX(u)+40*CosBJ(-30+GetUnitFacing(u)),GetUnitY(u)+40*SinBJ(-30+GetUnitFacing(u)),GetUnitFacing(u) )
                call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)-3000 +   GetHeroLevel(u)*(2500+50*GetHeroLevel(u)))
                call AddUnitBlock(U,100 + 50*GetHeroLevel(u) )
                call BlzSetUnitBaseDamage(U,BlzGetUnitBaseDamage(U,0) + 200 + (50+GetHeroLevel(u))*GetHeroLevel(u) ,0)
                call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
                call UnitApplyTimedLife(U,'A041',30)
        
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