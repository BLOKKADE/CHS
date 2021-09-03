globals
    hashtable HT_SPELC = InitHashtable()
endglobals

function RefreshSpellO takes nothing returns nothing
     local timer TimerT = GetExpiredTimer()
     local unit u = LoadUnitHandle(HT_SPELC,GetHandleId(TimerT),2)
     local integer id = LoadInteger(HT_SPELC,GetHandleId(TimerT),1)
     local real time = LoadReal(HT_SPELC,GetHandleId(TimerT),3) 

	//call BlzSetAbilityRealLevelField(BlzGetUnitAbility(LoadUnitHandle(HT_SPELC,GetHandleId(TimerT),2), ),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1,timeT*ResCD)

     call BlzSetUnitAbilityCooldown(u,id, GetUnitAbilityLevel(u,id)-1,  time  ) 



     call FlushChildHashtable(HT_SPELC,GetHandleId(TimerT))
     call ReleaseTimer(TimerT)
     set TimerT = null
endfunction

function Trig_Cooldown_Actions takes nothing returns nothing 
    local timer TimerT = null
    local real timeT = 0
    local integer Aid = GetSpellAbilityId()
    local real ResCD = 1 
    local unit u = GetTriggerUnit()
    local real luck = GetUnitLuck(u)
    local real ress = 0
    local integer lvl = GetUnitAbilityLevel(u,Aid) - 1
    local real xesilChance = 0
    set timeT = BlzGetAbilityCooldown (Aid,lvl)

    //Fast Magic
    if GetUnitAbilityLevel(u,'A03P') >= 1 then
        set   ResCD =  ResCD*(1-0.01*GetUnitAbilityLevel(u,'A03P')) 
    endif

    if Aid == 'A07X' then
        set ress = GetClassUnitSpell(u,2)
    endif
	
    if (GetUnitTypeId(u ) == 'H01D') then
        set xesilChance = 15 + (0.1*GetHeroLevel(u) )
    endif

    if (xesilChance <= 25*luck and UnitHasItemS(u,'I03P') and GetRandomReal(0,100) <= 25*luck) or (GetUnitTypeId(u ) == 'H01D' and UnitHasItemS(u,'I03P') == false and GetRandomReal(0,100) <= xesilChance*luck) then
        set ResCD = 0.001
        call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl",u,"origin" )  )     
    endif 
    
    //Fishing Rod and Blink Strike
    if UnitHasItemS(u, 'I07T') and Aid == 'A08J' then
        set ResCD = ResCD * 0.5
    endif

    //staff of water
    if  UnitHasItemS(u,'I08Y') and LoadBoolean(Elem,Aid,2) then
        if GetRandomReal(0,100) <= 40*luck then
            set ResCD = 0.001
        endif
    endif
    
    //Fan
    if  UnitHasItemS(u,'I08Z') and LoadBoolean(Elem,Aid,3) then
            set ResCD =ResCD*0.65
    endif   


    if  LoadTimerHandle(HT_timerSpell,GetHandleId(u),2) != null and GetUnitAbilityLevel(u, 'A08G') > 0 then
        if Aid == 'A049' or Aid == 'A024' then
            set  ResCD = ResCD*0.1
        else
            
               set  ResCD = ResCD*0.05
        endif
    endif


 

    if ResCD != 1 or ress != 0  then
	//call BlzSetAbilityRealLevelField(GetSpellAbility(),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1,timeT*ResCD)
        call BlzSetUnitAbilityCooldown(u,Aid, lvl,(timeT-ress)*ResCD) 
        set TimerT = NewTimer()
        call SaveInteger(HT_SPELC,GetHandleId(TimerT),1,Aid  )
        call SaveUnitHandle(HT_SPELC,GetHandleId(TimerT),2, u )
        call SaveReal(HT_SPELC,GetHandleId(TimerT),3,  timeT)

        call TimerStart(TimerT,0.01,false,function RefreshSpellO)
        set TimerT = null
     endif

    set u = null
endfunction

//===========================================================================
function InitTrig_Cooldown takes nothing returns nothing
    set gg_trg_Cooldown = CreateTrigger(  )
    //call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    //call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown, EVENT_PLAYER_UNIT_SPELL_FINISH )
                //call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddAction( gg_trg_Cooldown, function Trig_Cooldown_Actions )
endfunction

