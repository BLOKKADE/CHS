


 function LastBreathEnd takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT,GetHandleId(tim),1)
    local effect eff = LoadEffectHandle(HT,GetHandleId(tim),2)
    call SaveInteger(HT,GetHandleId(u),'A05R',0) 
    call DestroyEffect(eff)
    call FlushChildHashtable(HT,GetHandleId(tim))
    call DestroyTimer(tim)
    set tim = null
    set eff = null
    set u = null
 endfunction
 
 
 function LastBreath takes nothing returns nothing 
    local timer tim
    local unit u = GetTriggerUnit()
    local real lvlAbility = GetUnitAbilityLevel(u ,'A05R')
    local real Hp
    
	if lvlAbility > 0 then
        if LoadInteger(HT,GetHandleId(u),'A05R') == 1 then
            set Hp = GetWidgetLife(u)
            set Hp = Hp - GetEventDamage()
            if Hp < 1 then
                set Hp = 1
            endif
            call SetWidgetLife(u,Hp)
            call BlzSetEventDamage(0)
        elseif GetWidgetLife(u) <= GetEventDamage()+0.405 and BlzGetUnitAbilityCooldownRemaining(u,'A05R') <= 0.501 then
            set tim = CreateTimer()
            call BlzSetEventDamage(0)
            call SetWidgetLife(u,1.405)
            call  AbilStartCD(u,'A05R', 60+ BlzGetUnitAbilityCooldownRemaining(u,'A05R') )  
            call SaveInteger(HT,GetHandleId(u),'A05R',1)	             
            call SaveUnitHandle(HT,GetHandleId(tim),1,GetTriggerUnit())
            call SaveEffectHandle(HT,GetHandleId(tim),2,AddSpecialEffectTarget( LastBreathAnim , u , "origin" ) ) 
            
            
            if GetOwningPlayer(GetEventDamageSource()) == Player(11) then
                call TimerStart(tim,0.4 + 0.1*lvlAbility,false, function LastBreathEnd)            
            else
                call TimerStart(tim,0.8 + 0.2*lvlAbility,false, function LastBreathEnd)
            endif
	    endif
        
        
	endif
    set tim = null
 endfunction


function GetTimerCD takes unit U1, integer id, real timeT returns boolean
    local timer tim 
    if  LoadTimerHandle( DataUnitHT,GetHandleId(U1),id ) == null then
        set tim = CreateTimer()
        call TimerStart(tim,timeT,false,null)
        call SaveTimerHandle( DataUnitHT,GetHandleId(U1),id,tim) 
        set tim = null
        return true
    else
        set tim = LoadTimerHandle( DataUnitHT,GetHandleId(U1),id )
        if TimerGetRemaining(tim) <= 0.0001 then
            call TimerStart(tim,timeT,false,null)     
            set tim = null
            return true
        else
            set tim = null
            return false
        endif
    endif
    return false
    
endfunction
 

function EndZeroTimer takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(DataUnitHT,GetHandleId(tim),1)
    local integer id = LoadInteger(DataUnitHT,GetHandleId(tim),2)

   call SaveTimerHandle( DataUnitHT,GetHandleId(u),id,null) 
   call FlushChildHashtable(DataUnitHT,GetHandleId(tim))
   call DestroyTimer(tim)
   set tim = null
   set u = null
endfunction
 
 
function ZetoTimerStart takes unit u,integer id returns boolean
    local timer tim 
    
    if  LoadTimerHandle( DataUnitHT,GetHandleId(u),id ) == null then
        set tim = CreateTimer()
        call SaveUnitHandle(DataUnitHT,GetHandleId(tim),1,u)
        call SaveInteger(DataUnitHT,GetHandleId(tim),2,id)
        call SaveTimerHandle( DataUnitHT,GetHandleId(u),id,tim) 
        call TimerStart(tim,0,false,function EndZeroTimer)
        set tim = null
        return true
    endif

 
    return false
endfunction

function CheckTimerZero takes unit u,integer id returns boolean
    if LoadTimerHandle( DataUnitHT,GetHandleId(u),id ) == null then
        return false
    endif
    return true
endfunction

function Trig_Damage_Controller_After_Copy_Actions takes nothing returns nothing
    local unit u_t = GetTriggerUnit()
    local unit u_a = GetEventDamageSource()
    local integer u_id = GetUnitTypeId(u_a)
	local unit GUS = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u_a) ) ]
	local unit GUT = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u_t) ) ]
    local damagetype  DmgType = BlzGetEventDamageType()
    local real Damage = GetEventDamage()
    local integer i = 0
    local real r3 = 0
    local real r2 = 0
    local real r1 = 0
    local integer i1 = 0
    local integer i2 = 0
    local integer i3 = 0
    local real luck_t = 1
    local real luck_a = 1
    local boolean is_attack =  BlzGetEventIsAttack()
    local unit CrUnitS  = u_a
    local AbilityData A = 0 

    if u_id == 'h015' or u_id == 'h014' or u_id == 'h00T' or u_id == 'n00V' then
        set u_a = GUS
        set CrUnitS = GUS
    endif
	if Damage == 0 then
		set GUS = null
		set GUT = null
        set CrUnitS = null
		return
	endif
    if u_a == null then
        set GUS = null
    endif
    set luck_t = GetUnitLuck(u_t)    
    set luck_a = GetUnitLuck(u_a)
    


    if UnitHasItemS(u_t,'I07M') then
        set r1 = I2R(GetHeroStr(u_t,true))*0.08
        
        if r1 >= GetEventDamage() then
            call BlzSetEventDamage( 0 )
            set GUS = null
            set GUT = null
            return
        else
            set Damage = Damage -r1
        endif
    endif
    if UnitHasItemS(u_t,'I07P') and IsHeroUnitId(GetUnitTypeId(u_a)) == false and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL then   
        set Damage = Damage/2
    endif
    if UnitHasItemS(u_a,'I07T') and  BlzGetEventDamageType() ==  DAMAGE_TYPE_NORMAL then
        call SetUnitX(u_a,GetUnitX(u_t) )
        call SetUnitY(u_a,GetUnitY(u_t) )
    endif
	if GetUnitAbilityLevel(GUS ,'B00E') >= 1 then
		if GetRandomReal(0,100) <= 5*luck_a then
            set Damage = Damage + Damage*(GetUnitAbilityLevel(u_a  ,'A02M')/2)
			call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", u_t, "chest"))
		endif
	endif

	if LoadInteger(HTi,GetHandleId(GUT),2) == 1 then 
        set Damage = Damage*0.66
	endif 

	if LoadInteger(HTi,GetHandleId(u_a),2) == 1 then 
        set Damage = Damage*0.66
	endif 

	if LoadInteger(HTi,GetHandleId(u_a),1) == 1 then
        set r2 = (Damage/4)
        call Vamp(u_a,u_t,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest"))	
        set Damage = Damage * 0.75
	endif


    //! runtextmacro AUav_Vampirism()
    //! runtextmacro O002_DreadLord()
    //! runtextmacro H01H_Ghoul()
    //! runtextmacro I07O_BoneArmor()
    //! runtextmacro I05G_MagicNecklaceOfAbsorption()

    //! runtextmacro AEah_Thorns()
    //! runtextmacro AUts_Spiked_Carapace()


if DmgType == DAMAGE_TYPE_NORMAL then //////////////
    
    
    if IsHeroUnitId(GetUnitTypeId(u_t)) == false then
        set i =  UnitHasItemI( u_a,'I078') 
        if i > 0 then
            set r2 = Damage*(  0.25* I2R(i))
            call Vamp(u_a,u_t,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest"))      
        endif
   endif
   
    if GetUnitAbilityLevel(u_a  ,'A04G') > 0 and (BlzGetUnitAbilityCooldownRemaining(GUS,'A04G') <= 0 or CheckTimerZero(GUS,'A04G')) then
          if ZetoTimerStart(GUS,'A04G') then
            call  AbilStartCD(u_a,'A04G',0.3)
          endif
          set Damage = Damage + 10*GetUnitAbilityLevel(u_a,'A04G')
          call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", u_t, "chest"))
    endif
    
    
    
    
    
    
else ///////////
    
    
    
    if GetUnitAbilityLevel(GUS  ,'B00O') >= 1  then
        set r2 = Damage*0.33 
        call Vamp(u_a,u_t,r2)
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GUS, "chest"))
	endif
    
    
    if GetUnitAbilityLevel(GUS   ,'A04H') > 0  and (BlzGetUnitAbilityCooldownRemaining(GUS,'A04H') <= 0 or CheckTimerZero(GUS,'A04H')) then
          if ZetoTimerStart(GUS,'A04H') then
            call  AbilStartCD(GUS,'A04H',0.3)
          endif
          set Damage = Damage + 10*GetUnitAbilityLevel(GUS,'A04H')
          call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", u_t, "chest"))
    endif
    
endif//////////////////

	



	if GetUnitAbilityLevel(GUS ,'B008') >= 1 then
	   call SetWidgetLife(GUS ,GetWidgetLife(GUS )+ (Damage/4) )
	   call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Undead\\UndeadBlood\\UndeadBloodCryptFiend.mdl", u_a, "chest"))		
	endif
	
	
	set i =  UnitHasItemI( u_a,'I07I') 
	if i > 0 and    IsUnitType(u_a,UNIT_TYPE_MELEE_ATTACKER) then
	    set r1 =  (GetWidgetLife(u_t)/100)*1.5*I2R(i)  
        call Vamp(u_a,u_t,r1)
        set Damage = Damage + r1
	    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_t, "chest"))
	endif
    
    if GLOB_cuttting then
        call Vamp(u_a,u_t,Damage/2 )
        call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", u_a, "chest"))
        call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Other\\PandarenBrewmasterBlood\\PandarenBrewmasterBlood.mdl", u_t, "chest"))
    endif 
    

	if GetUnitAbilityLevel(GUS ,'A02N') >= 1 then
		if 100*(GetWidgetLife(u_t)-Damage)/GetUnitState(u_t,UNIT_STATE_MAX_LIFE)     <= R2I(GetUnitAbilityLevel(u_a ,'A02N'))  then
            set Damage = Damage + GetUnitState(u_t,UNIT_STATE_LIFE)
			call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", u_t, "chest"))
		endif
	endif
    
    if GetUnitAbilityLevel(u_t,'A07T') > 0 then
        set r1 = LoadReal(HT,GetHandleId(u_t),82340)
        set r2 = LoadReal(HT,GetHandleId(u_t),82341)
        set r3 = 1 - 0.01*I2R(GetUnitAbilityLevel(u_t,'A07T') ) 
        
        if r1 == 0 then
            set r2 = 20000
        endif
        
        set r1 = r1 + Damage
            loop
            exitwhen r3*r2 > r1 
            set r1 = r1 - r2*r3 
            set r2 = r2 + 250
            call SetHeroStr(u_t,GetHeroStr(u_t,false)+2,false)

            set i1 = 0
            loop
                exitwhen i1 > 10
                set i2 = GetInfoHeroSpell(u_t ,i1)
                
                if BlzGetUnitAbilityCooldownRemaining(u_t,i2)>0 and i2 != 'A07S' and i2 != 'A05R' then
                    call BlzStartUnitAbilityCooldown(u_t,i2,BlzGetUnitAbilityCooldownRemaining(u_t,i2)-1 - 0.25*I2R(GetUnitAbilityLevel(u_t,'A07T')))
                    elseif  BlzGetUnitAbilityCooldownRemaining(u_t,i2) <  1 + 0.25*I2R(GetUnitAbilityLevel(u_t,'A07T'))  then
                      call BlzEndUnitAbilityCooldown(u_t,i2)
                endif
                set i1 = i1 + 1
            endloop
            
            call RemoveDebuff(u_t)
        endloop
        call SaveReal(HT,GetHandleId(u_t),82340,r1)
        call SaveReal(HT,GetHandleId(u_t),82341,r2)
    endif
    
    if GetUnitTypeId(u_t) == 'H01I' then
        if Damage >= GetUnitState(u_t,UNIT_STATE_MANA) then
            call SetUnitState(u_t,UNIT_STATE_MANA,0)
            set Damage = Damage + GetUnitState(u_t,UNIT_STATE_MAX_LIFE)
        else
           call SetUnitState(u_t,UNIT_STATE_MANA,GetUnitState(u_t,UNIT_STATE_MANA) - Damage    )   
           set Damage = 0
        endif 
    endif

    if UnitHasItemS(u_t,'I07U') then   
        if BlzGetUnitMaxHP(u_t) > BlzGetUnitMaxMana(u_t) then
            if Damage > BlzGetUnitMaxHP(u_t)/5 then
                set Damage =  BlzGetUnitMaxHP(u_t)/5
            endif
        elseif Damage > BlzGetUnitMaxMana(u_t)/5 then
            set Damage =  BlzGetUnitMaxMana(u_t)/5
        endif
    endif

    if GetUnitAbilityLevel(u_t,'A060') > 0 and BlzGetUnitAbilityCooldownRemaining(u_t,'A060')<= 0.001 then
        call stoneProtect(u_t,CrUnitS)
    endif
    
	if GetUnitAbilityLevel(u_a,'A02S' ) >= 1 and is_attack  then
    	call UsOrderU(u_a,u_t,GetUnitX(u_a),GetUnitY(u_a),'A02R',"chainlightning",  GetHeroInt(u_a,true)*(20+8*I2R(GetUnitAbilityLevel(u_a,'A02S' )))/100, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 )
    endif
    
    
    call BlzSetEventDamage(Damage)
    set GLOB_ABIL_ID = 0
    
	set GUS = null
	set GUT = null
    set u_t = null
    set u_a = null
endfunction




//===========================================================================
function InitTrig_Damage_Controller_After_Copy takes nothing returns nothing
    set gg_trg_Damage_Controller_After_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Damage_Controller_After_Copy, EVENT_PLAYER_UNIT_DAMAGED )
    call TriggerAddAction( gg_trg_Damage_Controller_After_Copy, function Trig_Damage_Controller_After_Copy_Actions )
    call TriggerAddAction( gg_trg_Damage_Controller_After_Copy, function LastBreath )
endfunction

