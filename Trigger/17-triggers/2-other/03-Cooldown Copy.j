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
     call DestroyTimer(TimerT)
     set TimerT = null
endfunction




function XesilChanceI takes nothing returns boolean 
	local integer Chance

	if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_CAST  then
	  set Chance = GetRandomInt(1,4)

	  call SaveInteger(HT_SPELC,GetHandleId(GetTriggerUnit()),GetSpellAbilityId(),Chance )
	endif
	if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_EFFECT then
	  set Chance = LoadInteger(HT_SPELC,GetHandleId(GetTriggerUnit()),GetSpellAbilityId())  
	endif
	if GetTriggerEventId() == EVENT_PLAYER_UNIT_SPELL_FINISH then
	  set Chance = LoadInteger(HT_SPELC,GetHandleId(GetTriggerUnit()),GetSpellAbilityId()) 
	endif

	if Chance == 3 then
		return true
	endif
	
	return false

endfunction






function Trig_Cooldown_Copy_Actions takes nothing returns nothing

    local unit t = GetTriggerUnit()   
    local timer TimerT = null
    local real timeT = 0
    local integer Aid = GetSpellAbilityId()
    local integer Lv 
    local real ResCD = 1 
    local unit u = GetTriggerUnit()
    local real TIM2 = BlzGetAbilityRealLevelField(GetSpellAbility(),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1)
    local real luck = GetUnitLuck(u)
    local real ress = 0
    set  Lv = GetUnitAbilityLevel(t,Aid)
    set timeT = BlzGetAbilityCooldown (Aid,Lv-1)


    if GetUnitAbilityLevel(t,'A03P') >= 1 then
        set   ResCD =  ResCD*(1-0.01*GetUnitAbilityLevel(t,'A03P')) 
    endif


    if Aid == 'A07X' then
        set ress = GetClassUnitSpell(t,2)
    
    endif


	
    if GetUnitTypeId(GetTriggerUnit() ) == 'H01D' then
        if XesilChanceI()  then
            set ResCD = 0.001

            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl",GetTriggerUnit(),"origin" )  ) 
        endif
    endif
    
    

    if  UnitHasItemS(u,'I08Y') and LoadBoolean(Elem,Aid,2) then
        if GetRandomReal(0,100) <= 40*luck then
            set ResCD = 0.001
        endif
    endif
    
    if  UnitHasItemS(u,'I08Z') and LoadBoolean(Elem,Aid,3) then
            set ResCD =ResCD*0.65
    endif   


    if  LoadTimerHandle(HT_timerSpell,GetHandleId(t),2) != null then
        if Aid == 'A049' or Aid == 'A024' then
            set  ResCD = ResCD*0.1
        else
            
               set  ResCD = ResCD*0.05
        endif
    endif


 

    if ResCD != 1 or ress != 0  then
    
    
        set  Lv = GetUnitAbilityLevel(t,Aid)
	//call BlzSetAbilityRealLevelField(GetSpellAbility(),ConvertAbilityRealLevelField('acdn'),GetUnitAbilityLevel(t,Aid)-1,timeT*ResCD)
        call BlzSetUnitAbilityCooldown(t,Aid, Lv-1,(timeT-ress)*ResCD) 
        set TimerT = CreateTimer()
        call SaveInteger(HT_SPELC,GetHandleId(TimerT),1,Aid  )
        call SaveUnitHandle(HT_SPELC,GetHandleId(TimerT),2, t )
        call SaveReal(HT_SPELC,GetHandleId(TimerT),3,  timeT)

        call TimerStart(TimerT,0.01,false,function RefreshSpellO)
        set TimerT = null
     endif

    set u = null
endfunction

//===========================================================================
function InitTrig_Cooldown_Copy takes nothing returns nothing
    set gg_trg_Cooldown_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown_Copy, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown_Copy, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown_Copy, EVENT_PLAYER_UNIT_SPELL_FINISH )
                //call TriggerRegisterAnyUnitEventBJ( gg_trg_Cooldown_Copy, EVENT_PLAYER_UNIT_SPELL_ENDCAST )
    call TriggerAddAction( gg_trg_Cooldown_Copy, function Trig_Cooldown_Copy_Actions )
endfunction

