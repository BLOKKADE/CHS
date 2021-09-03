

function Trig_Damage_Controller_After_Actions takes nothing returns nothing
    local unit TrigU = GetTriggerUnit()
    local unit TrigA = GetEventDamageSource()
    local integer CuId = GetUnitTypeId(TrigA)
	local unit GUS = udg_units01[GetConvertedPlayerId(GetOwningPlayer( TrigA) ) ]
	local unit GUT = udg_units01[GetConvertedPlayerId(GetOwningPlayer( TrigU) ) ]
    local integer i = 0
    local real r3 = 0
    local real r2 = 0
    local real r1 = 0
    local integer i1 = 0
    local integer i2 = 0
    local timer tim
    local real luck = 1
    local boolean attack =  BlzGetEventIsAttack()
    local unit CrUnitS  = TrigA


    if CuId == 'h015' or CuId == 'h014' or CuId == 'h00T' or CuId == 'n00V' then
        set TrigA = GUS
        set CrUnitS = GUS
    endif
    


	if GetEventDamage() == 0 then
		set GUS = null
		set GUT = null
        set CrUnitS = null
		return
	endif
    
    
    set luck = GetUnitLuck(TrigA)
    
    if TrigA == null then
        set GUS = null
    endif

    //Titanium Armor
    if UnitHasItemS(TrigU,'I07M') then
        set r1 = I2R(GetHeroStr(TrigU,true))*0.08
        
        if r1 >= GetEventDamage() then
            call BlzSetEventDamage( 0 )
            set GUS = null
            set GUT = null
            return
        else
            call BlzSetEventDamage( GetEventDamage()-r1 )
        endif
    endif

    //Strong Chest Mail
    if UnitHasItemS(TrigU,'I07P') and IsHeroUnitId(GetUnitTypeId(TrigA)) == false and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL then   
       			call BlzSetEventDamage(  GetEventDamage()/2 ) 
    endif

    //Fishing Rod
    if UnitHasItemS(TrigA,'I07T') and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL then
        call SetUnitX(TrigA,GetUnitX(TrigU) )
        call SetUnitY(TrigA,GetUnitY(TrigU) )
    endif

    //Aura of Vulnerability
	if GetUnitAbilityLevel(TrigU ,'B00E') >= 1 then
		if GetRandomReal(0,100) <= 5*luck then
			call BlzSetEventDamage(  GetEventDamage()  +   (GetEventDamage()*(GetUnitAbilityLevel(GUS  ,'A02M')/2))  )
			call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", TrigU, "chest"))
		endif
	endif

    //Medal of Honor
	if LoadInteger(HTi,GetHandleId(GUT),2) == 1 then 
		call BlzSetEventDamage(   GetEventDamage()*0.66 )
	endif 

    //Medal of Honor
	if LoadInteger(HTi,GetHandleId(GUS),2) == 1 then 
		call BlzSetEventDamage(   GetEventDamage()*0.66 )
	endif 

    //Mask of Death
	if LoadInteger(HTi,GetHandleId(GUS),1) == 1 then
        set r2 = (GetEventDamage()/4)
        call Vamp(TrigA,TrigU,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GUS, "chest"))		
		call BlzSetEventDamage(   GetEventDamage()*0.75 )
	endif

    //Vampirism
    set r1 = GetUnitAbilityLevel(TrigA,'AUav')
    if r1 > 0 then
        set r2 = GetEventDamage()*(0.005 + 0.005*r1 +  GetClassUnitSpell(TrigA,11)*0.02 )
        call Vamp(TrigA,TrigU,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", TrigA, "chest"))   
    endif

    //Dreadlord Passive
	if GetUnitTypeId(GUS) == 'O002' then
        set r2 = GetEventDamage()*(0.02*I2R(GetHeroLevel(GUS)) )
        call Vamp(TrigA,TrigU,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GUS, "chest"))
	endif	
    
    //Ghoul Passive
	if GetUnitTypeId(TrigA) == 'H01H' and  attack   then
        set i = GetHeroLevel(TrigA)
        set r2 = (GetEventDamage() * (i * 0.01))
        call Vamp(TrigA,TrigU,r2)
        
        call BlzSetEventDamage(   GetEventDamage()+ r2 ) 
        call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", TrigA, "chest")) 
    endif

    //Mortar Aura
    if GetUnitAbilityLevel(TrigA, 'B00G') > 0 and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL   then
        set i = GetHeroLevel(GUS)
        call BlzSetEventDamage(   GetEventDamage() + (GetEventDamage() * (i * 0.02)) ) 
    endif

    //Bone Armor Skeleton Defender
    set i = SkeletonDefender[GetPlayerId(GetOwningPlayer(GUT))]
    if i > 0 and  IsHeroUnitId(GetUnitTypeId(TrigU )) then
        call BlzSetEventDamage(   GetEventDamage() -     GetEventDamage()*I2R(i)*0.08 )
    endif
    
    //Magic Necklace of Absorption
    if GetUnitAbilityLevel(TrigU  ,'B00R') >= 1 and  BlzGetEventDamageType() !=  DAMAGE_TYPE_NORMAL  then
        if GetUnitAbilityLevel(TrigA, 'A087') == 0 then
            if TrigU == TrigA then
                call AddHeroXP(TrigU, R2I(GetEventDamage()*0.015),true)
            else
                call AddHeroXP(TrigU, R2I(GetEventDamage()*0.15),true)
            endif
        endif
     	 call SetUnitState(TrigU,UNIT_STATE_MANA,   GetUnitState( TrigU  , UNIT_STATE_MANA  )  +     GetEventDamage()*0.75 )
    endif

    //Bloody Axe
   if BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL  and IsHeroUnitId(GetUnitTypeId(TrigU)) == false then
        set i =  UnitHasItemI( TrigA,'I078') 
        if i > 0 then
            set r2 = GetEventDamage()*(  0.25* I2R(i))
            call Vamp(TrigA,TrigU,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", TrigA, "chest"))      
        endif
   endif

   //Staff of Absolute Magic
	if GetUnitAbilityLevel(GUS  ,'B00O') >= 1 and  BlzGetEventDamageType() !=  DAMAGE_TYPE_NORMAL  then
        set r2 = GetEventDamage()*0.33 
        call Vamp(TrigA,TrigU,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GUS, "chest"))
	endif

    //Heavy Blow
    if GetUnitAbilityLevel(TrigA  ,'A04G') > 0 and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(GUS,'A04G') <= 0 or CheckTimerZero(GUS,'A04G')) then
          if ZetoTimerStart(GUS,'A04G') then
            call  AbilStartCD(TrigA,'A04G',0.3)
          endif
          call BlzSetEventDamage(  GetEventDamage() + 30*GetUnitAbilityLevel(TrigA  ,'A04G')  )
          call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", TrigU, "chest"))
    endif
    
    //Combustion
    if GetUnitAbilityLevel(GUS   ,'A04H') > 0 and  BlzGetEventDamageType() !=  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(GUS,'A04H') <= 0 or CheckTimerZero(GUS,'A04H')) then
          if ZetoTimerStart(GUS,'A04H') then
            call  AbilStartCD(GUS,'A04H',0.3)
          endif
          call BlzSetEventDamage(  GetEventDamage() + 30*GetUnitAbilityLevel(GUS   ,'A04H')  )
          call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", TrigU, "chest"))
    endif

    //Frostmourne
	if GetUnitAbilityLevel(GUS ,'B008') >= 1 then
       call Vamp(GUS,TrigU, (GetEventDamage()/4))
	   call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Undead\\UndeadBlood\\UndeadBloodCryptFiend.mdl", TrigA, "chest"))		
	endif
	
	//Heavy Mace
	set i =  UnitHasItemI( TrigA,'I07I') 
	if i > 0 and    IsUnitType(TrigA,UNIT_TYPE_MELEE_ATTACKER) then
	    set r1 =  (GetWidgetLife(TrigU)/100)*1.5*I2R(i)  
        call Vamp(TrigA,TrigU,r1)
	    call BlzSetEventDamage( GetEventDamage()+r1)
	    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", TrigU, "chest"))
	endif
    
    //Cutting
    if GLOB_cuttting then
        call Vamp(TrigA,TrigU,GetEventDamage()/2 )
        call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", TrigA, "chest"))
        call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Other\\PandarenBrewmasterBlood\\PandarenBrewmasterBlood.mdl", TrigU, "chest"))
    endif 
    
    //Finishing Blow
	if GetUnitAbilityLevel(GUS ,'A02N') >= 1 then
		if 100*(GetWidgetLife(TrigU)-GetEventDamage())/GetUnitState(TrigU,UNIT_STATE_MAX_LIFE)     <= R2I(GetUnitAbilityLevel(GUS ,'A02N'))  then
			call BlzSetEventDamage(   GetUnitState(TrigU,UNIT_STATE_MAX_LIFE)  )
			call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", TrigU, "chest"))
		endif
	endif
    
    //Ancient Blood
    if GetUnitAbilityLevel(TrigU,'A07T') > 0 then
        set r1 = LoadReal(HT,GetHandleId(TrigU),82340)
        set r2 = LoadReal(HT,GetHandleId(TrigU),82341)
        set r3 = 1 - 0.01*I2R(GetUnitAbilityLevel(TrigU,'A07T') ) 
        
        if r1 == 0 then
            set r2 = 20000
        endif
        
        set r1 = r1 + GetEventDamage()
            loop
            exitwhen r3*r2 > r1 
            set r1 = r1 - r2*r3 
            set r2 = r2 + 250
            call SetHeroStr(TrigU,GetHeroStr(TrigU,false)+2,false)
            //remove bufs
            
            set i1 = 0
            loop
                exitwhen i1 > 10
                set i2 = GetInfoHeroSpell(TrigU ,i1)
                if i2 != 'A07S' and i2 != 'A05R' and i2 != 'A05U' then
                    call ResetSpell(TrigU, i2, 1 + 0.25*I2R(GetUnitAbilityLevel(TrigU,'A07T')), false)
                endif
                set i1 = i1 + 1
            endloop
            
            
            
            
            call RemoveDebuff(TrigU)
        endloop
        call SaveReal(HT,GetHandleId(TrigU),82340,r1)
        call SaveReal(HT,GetHandleId(TrigU),82341,r2)
    endif
    
    //Banshee passive
    if GetUnitTypeId(TrigU) == 'H01I' then
        if GetEventDamage() >= GetUnitState(TrigU,UNIT_STATE_MANA) then
            call SetUnitState(TrigU,UNIT_STATE_MANA,0)
            call BlzSetEventDamage(GetUnitState(TrigU,UNIT_STATE_MAX_LIFE)+1)
        else
           call SetUnitState(TrigU,UNIT_STATE_MANA,GetUnitState(TrigU,UNIT_STATE_MANA) - GetEventDamage()    )            
           call BlzSetEventDamage(0)
           return
        endif 
    endif

    //Holy Chain Mail
    if UnitHasItemS(TrigU,'I07U') then   
        if BlzGetUnitMaxHP(TrigU) > BlzGetUnitMaxMana(TrigU) then
            if GetEventDamage() > BlzGetUnitMaxHP(TrigU)/5 then
                call BlzSetEventDamage(  BlzGetUnitMaxHP(TrigU)/5 ) 
            endif
        else
            if GetEventDamage() > BlzGetUnitMaxMana(TrigU)/5 then
                call BlzSetEventDamage(  BlzGetUnitMaxMana(TrigU)/5 ) 
            endif
        endif
    endif

    //Blademaster
    if GetUnitTypeId(TrigA) == 'N00K' and BladestormReady(TrigA) and attack then
        call BladestormDamage(TrigA, GetEventDamage(), BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL)
    endif

    //Stone Protection
    if GetUnitAbilityLevel(TrigU,'A060') > 0 and BlzGetUnitAbilityCooldownRemaining(TrigU,'A060')<= 0.001 then
        call stoneProtect(TrigU,CrUnitS)
    endif
    
    //Thunder Force
	if GetUnitAbilityLevel(TrigA,'A02S' ) >= 1 and attack  then
    	call UsOrderU(TrigA,TrigU,GetUnitX(TrigA),GetUnitY(TrigA),'A02R',"chainlightning",  GetHeroInt(TrigA,true)*(20+8*I2R(GetUnitAbilityLevel(TrigA,'A02S' )))/100, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 )
    endif
    
	set GUS = null
	set GUT = null
    set TrigU = null
    set TrigA = null
	set tim = null
endfunction




//===========================================================================
function InitTrig_Damage_Controller_After takes nothing returns nothing
    set gg_trg_Damage_Controller_After = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Damage_Controller_After, EVENT_PLAYER_UNIT_DAMAGED )
    call TriggerAddAction( gg_trg_Damage_Controller_After, function Trig_Damage_Controller_After_Actions )
    call TriggerAddAction( gg_trg_Damage_Controller_After, function LastBreath )
endfunction

