globals
    boolean GLOB_cuttting = false 
    boolean DamageIsAttack = false
    boolean TrueDamage = false
endglobals
 
 
 function SetTypeDamage takes unit u returns nothing
   if BlzGetEventDamageType() != DAMAGE_TYPE_SPIRIT_LINK then
        if BlzGetEventIsAttack() or GLOB_typeDmg == 2  then
            set GLOB_typeDmg = 0
            call BlzSetEventDamageType(DAMAGE_TYPE_NORMAL)
        else 
        
            call BlzSetEventDamageType(DAMAGE_TYPE_MAGIC)
        endif

        //Seer
        if GetUnitTypeId(u) == 'H01L' then
            if BlzGetEventDamageType() == DAMAGE_TYPE_NORMAL then
                call BlzSetEventDamageType(DAMAGE_TYPE_MAGIC)
            else
                call BlzSetEventDamageType(DAMAGE_TYPE_NORMAL)
            endif
        else
            //Staff of Power
            if  UnitHasItemS( GetEventDamageSource() ,'I080') then
                call BlzSetEventDamageType(DAMAGE_TYPE_MAGIC)
            endif
        endif
  endif

 endfunction
 
 
  function DivineBubbleEnd takes nothing returns nothing
    local timer tim = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT,GetHandleId(tim),1)
    local effect eff = LoadEffectHandle(HT,GetHandleId(tim),2)
    call SaveBoolean(HT,GetHandleId(u),'A07S',false) 
    call DestroyEffect(eff)
    call UnitRemoveAbility(u, 'A08C')
    call UnitRemoveAbility(u, 'B01E')
    call FlushChildHashtable(HT,GetHandleId(tim))
    call ReleaseTimer(tim)
    set tim = null
    set eff = null
    set u = null
 endfunction
 
 
 
 function Trig_Damage_Controller_Before_Actions takes nothing returns nothing
 	local unit damageTarget = GetTriggerUnit()
	local unit damageSource= GetEventDamageSource()
	
	local integer PidT = GetPlayerId(GetOwningPlayer(damageTarget ))
	local integer PidA = GetPlayerId(GetOwningPlayer(damageSource))
	
    local integer HandleId1 = GetHandleId(damageSource) 	
	local integer HandleId2 = GetHandleId(damageTarget) 	
	local unit damageSourceHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageSource) ) ]
	local unit damageTargetHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageTarget) ) ]
	local damagetype  DmgType
	local real blockDamage = 0
	local timer tim = null
	local real magicResDamage = 0
    local boolean  attack = BlzGetEventIsAttack()
    local real Admg
	local real magicPowerDamage = 1
    local integer II = 0
    local integer CuId = GetUnitTypeId(damageSource)
    local real luckSource = 1
    local real luckTarget = 1
    local boolean AbilA = true
    local boolean Bfirst = false
    local boolean trueAttack = false

    if LoadBoolean(HT,GetHandleId(damageTarget),'A07S') and GetUnitAbilityLevel(damageTarget, 'A08C') > 0 then
        call RemoveDebuff(damageTarget) 
        set AbilA = false
    endif

    if GetEventDamage() == 0 then
        set damageSourceHero = null
        set damageTargetHero = null
        set damageTarget = null
        set damageSource = null
        return
    endif

    if DamageIsAttack then
        set attack = true
        set DamageIsAttack = false
    endif
    
    if GetOwningPlayer(damageTarget) == Player(11) then
        set damageTargetHero = damageTarget
    endif
    
    if GetOwningPlayer(damageSource) == Player(11) then
        set damageSourceHero = damageSource
    endif
    
    if damageSource == null then
        set damageSourceHero = null
    endif

    if CuId == 'h015' or CuId == 'h014' or CuId == 'h00T' or CuId == 'n00V' then
        set damageSource = damageSourceHero
    endif

    if CuId == 'e001' then
        set damageSource = damageSourceHero
    endif

    if CuId == 'n00V' then
        call BlzSetEventDamageType(DAMAGE_TYPE_UNIVERSAL)
    endif

    set luckSource = GetUnitLuck(damageSource)
    set luckTarget = GetUnitLuck(damageTarget)
    
    call SetTypeDamage(damageSource)
    set DmgType = BlzGetEventDamageType()

    if TypeDmg_b == 2 then
        set AbilA = false
    endif 
    set TypeDmg_b = 0

    //Evasion
    if (attack or GetUnitAbilityLevel(damageTarget, 'B01T') > 0) and GetUnitEvasion(damageTarget) > 0 then
        set Admg = Evade(damageSource, damageTarget, GetEventDamage())
        if Admg == 0 then
            call BlzSetEventDamage(0)
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
            return
        endif
        if TrueDamage then
            set trueAttack = true
            set TrueDamage = false
        endif
    endif

    //set attack damage
    if IsUnitType(damageSource, UNIT_TYPE_HERO) and attack and IsDamageWhirlwind(damageSource) == false then
        set SpellData[GetHandleId(damageSource)].real[7] = GetEventDamage()
        //Whirlwind
        if GetUnitAbilityLevel(damageSource, 'A025') > 0 then
            call Whirlwind_Description(damageSource, GetEventDamage())
        endif

        //Arcane Assault
        if GetUnitAbilityLevel(damageSource, 'A098') > 0 and IsDamageArcaneAssault(damageSource) == false then
            call ArcaneAssault(damageSource, damageTarget, GetEventDamage())
        endif
    endif

    //Extradimensional Cooperation
    if GetUnitAbilityLevel(damageSource, 'B01H') > 0 and AbilA and IsDamageExtradimensional(damageSource) == false then
        call CastExtradimensionalCoop(damageSource, damageTarget, GetEventDamage(), DmgType == DAMAGE_TYPE_MAGIC)
    endif

    //Divine Bubble
    set II = GetUnitAbilityLevel(damageTarget,'A07S')
    if II > 0 then
        if LoadBoolean(HT,GetHandleId(damageTarget),'A07S') and GetUnitAbilityLevel(damageTarget, 'A08C') > 0 then
            call RemoveDebuff(damageTarget) 
            set AbilA = false
        elseif BlzGetUnitAbilityCooldownRemaining(damageTarget,'A07S') <= 0.001 then
            //call BJDebugMsg("divine bubble")
            set tim = NewTimer()
            set AbilA = false
            call RemoveDebuff(damageTarget) 
            call UnitAddAbility(damageTarget, 'A08C')
            call AbilStartCD(damageTarget,'A07S', 30.69 - (0.69 * GetUnitAbilityLevel(damageTarget, 'A07S'))) 
            call SaveBoolean(HT,GetHandleId(damageTarget),'A07S',true)	    
            call SaveUnitHandle(HT,GetHandleId(tim),1,GetTriggerUnit())
            call SaveEffectHandle(HT,GetHandleId(tim),2,AddSpecialEffectTarget( "RighteousGuard.mdx" , damageTarget , "origin" ) ) 
            call TimerStart(tim, 3,false, function DivineBubbleEnd)
        endif
    endif

    
    //Sword of Bloodthirst
    set II = UnitHasItemI(damageSource, 'I0AI')
    if II > 0 and DmgType == DAMAGE_TYPE_NORMAL then
        call BlzSetEventDamage(GetEventDamage() + 900 * II)
    endif
    
    //Crits
    if DmgType ==  DAMAGE_TYPE_NORMAL then
        call TakePhysDmg(damageSource,damageTarget, AbilA)
    elseif DmgType == DAMAGE_TYPE_MAGIC then
        call TakeMagickDmg(damageSource,damageTarget, AbilA)
    endif

    //Cutting
    set GLOB_cuttting = false
    set II =  GetUnitAbilityLevel(damageSource,'A081')
    if II > 0 and attack and GetRandomReal(1,100) < 20*luckSource then
        call BlzSetEventDamage(GetEventDamage()+II*100)
        set GLOB_cuttting = true
    endif

    //Storm Horn
	if GetUnitAbilityLevel(GetTriggerUnit() ,'B00B') >= 1 then
		if GetRandomReal(1,100) <= 14*luckTarget then
			call BlzSetEventDamage(   0 )
			call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetTriggerUnit(), "chest"))
			set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
		    return
		endif		
	endif

    //Aura of Immortality
	if GetUnitAbilityLevel(GetTriggerUnit() ,'B00D') >= 1 then
		if GetRandomInt(1,100) <= GetUnitAbilityLevel(damageTargetHero  ,'A02L') then
			call BlzSetEventDamage(   0 )
			call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", GetTriggerUnit(), "chest"))
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
	    	return			
		endif		
	endif	
	
	
    //Dark Shield
    if  UnitHasItemS( damageTarget,'I060' )  then
        if   DmgType ==  DAMAGE_TYPE_NORMAL then
            if  BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08R') <= 0 then
                call AbilStartCD(damageTarget, 'A08R', 1)
                call BlzSetEventDamage(0) 
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", damageTarget, "chest")) 
                set tim = null
                set damageSourceHero = null
	            set damageTargetHero = null
	            set damageTarget = null
            	set damageSource = null
                return
            endif 
        else 
            if  BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08Q') <= 0 then
                call AbilStartCD(damageTarget, 'A08Q', 3)
                call BlzSetEventDamage(0) 
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", damageTarget, "chest")) 
                set tim = null
                set damageSourceHero = null
	            set damageTargetHero = null
	            set damageTarget = null
            	set damageSource = null
                return
            endif 
        endif      
        if  BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08S') <= 0 then
            call AbilStartCD(damageTarget, 'A08S', 6)
            call RemoveDebuff(damageTarget)  
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl", damageTarget, "chest")) 
            set tim = null
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
            return
        endif 
    endif 

    //Light Magic Shield
    if   UnitHasItemS( damageTarget,'I06K' ) and BlzGetUnitArmor(damageTarget)<=50  then
         call BlzSetEventDamage(  GetEventDamage()*0.7  )
    endif

    //Centuar Archer passive
    if GetUnitTypeId(damageSource) == 'H01B' and attack then
        if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08T') <= 0 then
            call AbilStartCD(damageSource, 'A08T', 2)
            call ElemFuncStart(damageSource,'H01B')
            call BlzSetEventDamage(GetEventDamage() + (BlzGetUnitMaxHP(damageTarget) * 0.06) + (GetEventDamage() * (1 + (0.05 * GetHeroLevel(damageSource)))) )
            call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl", damageTarget, "chest"))
         endif
     endif  
     
    //Hero's Hammer
    set II =  UnitHasItemI( damageSource,'I064' )
    if  II > 0 and DmgType ==  DAMAGE_TYPE_NORMAL then 
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'A051') <= 0 then
	     call  AbilStartCD(damageSource,'A051',15/(  BlzGetUnitAttackCooldown(damageSource,0) ))
         call BlzSetEventDamage(GetEventDamage() + II*(2.2*GetHeroStr(damageSource ,true)-GetHeroAgi(damageSource ,true))  )  
         call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\BallistaMissile\\BallistaMissileTarget.mdl", damageTarget, "chest"))  
        endif
    endif
        
    //Hammer of Chaos
    if  UnitHasItemS( damageSource,'I06H' ) and  attack then
        if BlzGetUnitAbilityCooldownRemaining(damageSource,'A04Y') <= 0 then
              call  AbilStartCD(damageSource,'A04Y', 8 )
              call USOrder4field(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),'A04R',"stomp",GetEventDamage(),ABILITY_RLF_DAMAGE_INCREASE,500,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,0.05,ABILITY_RLF_DURATION_NORMAL)
         endif       
    endif   
    
    //Cruelty
    set II =  GetUnitAbilityLevel(damageSource,'A067')
    if II > 0 and  DmgType ==  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(damageSource,'A067') <= 0.001 or CheckTimerZero(damageSourceHero,'A067') ) then
        call BlzSetEventDamage(GetEventDamage() +   GetEventDamage()*(2.5+I2R(II)/2) ) 
        call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", damageTarget, "chest"))
        if ZetoTimerStart(damageSource,'A067') then
            call  AbilStartCD(damageSource,'A067', 6 )
        endif
    endif

    //Trident of Pain
    if  UnitHasItemS( damageSource,'I061' )  then
        if   DmgType ==  DAMAGE_TYPE_NORMAL then
            if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08X') <= 0 then
                call AbilStartCD(damageSource, 'A08X', 12)
                call ElemFuncStart(damageSource,'I061')
               call BlzSetEventDamage(GetEventDamage()*2.6)
               call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
            elseif BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08Y') <= 0 then
                call AbilStartCD(damageSource, 'A08Y', 12)
                call ElemFuncStart(damageSource,'I061')
               call BlzSetEventDamage(GetEventDamage()*2.6)
               call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
            elseif BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08Z') <= 0 then
                call AbilStartCD(damageSource, 'A08Z', 12)
                call ElemFuncStart(damageSource,'I061')
               call BlzSetEventDamage(GetEventDamage()*2.6)
               call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
            endif
        endif
    endif

    //Ursa Warrior
    if GetUnitTypeId(damageSource) == 'N00Q' and attack then
        //call CastUrsaBleed(damageSource, damageTarget, GetEventDamage(), DmgType !=  DAMAGE_TYPE_NORMAL)
        call SetBuff(damageTarget,4,3)
        call PeriodicDamage.create(damageSource, damageTarget, GetEventDamage()/3, DmgType ==  DAMAGE_TYPE_MAGIC, 1., 3, 0, true, 'B01I').addFx(FX_Bleed, "head")
    endif
    
    //Pvp Bonus
   if IsHeroUnitId( GetUnitTypeId(damageTarget)) then
       call BlzSetEventDamage(GetEventDamage()+  (GetEventDamage()*(GetUnitPvpBonus(damageSource)-GetUnitPvpBonus(damageTarget)  )/100)   )
   endif 

   //Ogre Warrior
    if GetUnitTypeId(damageSource) == 'H01C' and  DmgType ==  DAMAGE_TYPE_NORMAL then
        if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08U') <= 0 then
            call AbilStartCD(damageSource, 'A08U', 6)
            call ElemFuncStart(damageSource,'H01C')
            call USOrder4field(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),'A047',"stomp",GetHeroStr(damageSource,true) + 60*GetHeroLevel(damageSource) ,ABILITY_RLF_DAMAGE_INCREASE,300,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,1,ABILITY_RLF_DURATION_NORMAL)
         endif
     endif  
      
     //Ice Armor
    if GetUnitAbilityLevel(damageTarget,'A053')>0 and  BlzGetUnitAbilityCooldownRemaining(damageTarget,'A053') <= 0    then
          call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl", damageTarget, "chest"))
          call BlzSetEventDamage( GetEventDamage()/5) 
          call  AbilStartCD(damageTarget,'A053', 2.05 -  0.05*I2R(GetUnitAbilityLevel(damageTarget,'A053')) )
    endif  

    //Blessed Protection
    if LoadTimerHandle(HT_timerSpell,HandleId2,3) != null then
		call BlzSetEventDamage(  GetEventDamage()/10) 
	endif

    //Pit Lord
    if GetUnitTypeId(damageSource) == 'O007' then
        if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08V') <= 0 then
            call AbilStartCD(damageSource, 'A08V', 2)
            call ElemFuncStart(damageSource,'O007')
            call UsOrderU2 (damageSource,damageTarget,GetUnitX(damageSource),GetUnitY(damageSource),'A08N',"rainoffire", GetHeroLevel(damageSource)*40, GetHeroLevel(damageSource)*20, ABILITY_RLF_DAMAGE_HBZ2, ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5)
        endif
    endif

    //Lich
	if GetUnitTypeId(damageSource) == 'H018' and  DmgType == DAMAGE_TYPE_MAGIC then
        if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08W') <= 0 then
            call AbilStartCD(damageSource, 'A08W', 6)
            call ElemFuncStart(damageSource,'H018')
            call UsOrderU2 (damageSource,damageTarget,GetUnitX(damageSource),GetUnitY(damageSource),'A03J',"frostnova", GetHeroInt(damageSource, true) + (GetHeroLevel(damageSource)*60), GetHeroInt(damageSource, true) + (GetHeroLevel(damageSource)*60), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
        endif
	endif
	
    //Air Force
	if GetUnitAbilityLevel(damageSourceHero  ,'A02T') >= 1 then
        if GetUnitAbilityLevel(damageTarget,'Bams') > 0 or GetUnitAbilityLevel(damageTarget,'Bam2') > 0  then
        
            call BlzSetEventDamage(  GetEventDamage()  + (I2R(GetUnitAbilityLevel(damageSourceHero  ,'A02T'))*GetHeroAgi(damageSourceHero,true))/40  )
        else
            call BlzSetEventDamage(  GetEventDamage()  + (I2R(GetUnitAbilityLevel(damageSourceHero  ,'A02T'))*GetHeroAgi(damageSourceHero,true))/20  )
        endif
		call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl", damageTarget, "chest"))		
	endif

    //Grom Hellscream
    if GetUnitTypeId(damageSourceHero) == 'N024' and DmgType == DAMAGE_TYPE_NORMAL then
        call BlzSetEventDamage(GetEventDamage() + GetHeroStr(damageSourceHero, true))
        call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", damageTarget, "chest"))		
    endif

    //Robes of the Archmage
	if GetUnitAbilityLevel(damageSource  ,'B00L') >= 1 and  DmgType == DAMAGE_TYPE_MAGIC then
     	set magicPowerDamage = magicPowerDamage + (BlzGetUnitMaxMana(damageTarget) - GetUnitState(damageTarget, UNIT_STATE_MANA)) / 90000
	endif

    //Vigour Token
    set II = UnitHasItemI(damageSource, 'I0A2')
    if II > 0 and BlzGetUnitMaxHP(damageSource) < BlzGetUnitMaxHP(damageTarget) then
        call BlzSetEventDamage(GetEventDamage() * 1 + (0.5 * II))
    endif

    //Flimsy Token
    set II = UnitHasItemI(damageSource, 'I0A3')
    if II > 0 and BlzGetUnitArmor(damageSource) < BlzGetUnitArmor(damageTarget) then
        call BlzSetEventDamage(GetEventDamage() * 1 + (0.5 * II))
    endif

    //Spellbane Token
    set II = UnitHasItemI(damageSource, 'I0A1')
    if II > 0 and BlzGetUnitMaxMana(damageSource) < BlzGetUnitMaxMana(damageTarget) then
        call BlzSetEventDamage(GetEventDamage() * 1 + (0.5 * II))
    endif

    if DmgType == DAMAGE_TYPE_NORMAL and AbilA then
        //Incinerate
        set II = GetUnitAbilityLevel(damageSource,'A06M')
        if II > 0 then
            if GetUnitAbilityLevel(damageTarget,'B014') > 0 then
                set Admg = II*5 + LoadInteger(HT,GetHandleId(damageTarget),-300001)
            else
                set Admg = II*5
            endif
            call SaveInteger(HT,GetHandleId(damageTarget),-300001, R2I(Admg))
            call SaveInteger(HT,GetHandleId(damageTarget),-300002,II*100)
            call SaveUnitHandle(HT,GetHandleId(damageTarget),-300003,damageSource)
            call SaveInteger(HT,GetHandleId(damageTarget),-300004,Glob_time)
            call SetBuff(damageTarget,1,5)
            
            if GetEventDamage() > 0 then
                call BlzSetEventDamage(GetEventDamage()+Admg)
            endif
        endif
    endif
	
	if DmgType == DAMAGE_TYPE_MAGIC then 
        //Magic Power
    	if magicPowerDamage != 1 or GetUnitMagicDmg(damageSource) > 0 then
    		call BlzSetEventDamage(  GetEventDamage()*(magicPowerDamage+GetUnitMagicDmg(damageSource)/100 )   )
    	endif   
        
        //Magic Resistance
        set magicResDamage =  GetUnitMagicDef(damageTarget)   
        if magicResDamage > 0 then
           call BlzSetEventDamage(  GetEventDamage()*( 50/(50+magicResDamage) )   )        
        endif
	endif

	//Block
	if GetUnitBlock(damageTarget) != 0 and trueAttack == false then	
        set blockDamage = GetUnitBlock(damageTarget)

        //Sword of Bloodthirst
        if UnitHasItemS(damageSource, 'I0AI') and attack then
            set blockDamage = blockDamage * 0.7
        endif

        //Absolute Dark
        set II = GetUnitAbilityLevel(damageSourceHero, 'A07Q')
        if II > 0 then
            set blockDamage = blockDamage * (1 - ((0.009 + (0.1 * II)) * GetClassUnitSpell(damageSourceHero, Element_Dark)))
        endif

		set blockDamage = GetEventDamage() - blockDamage
		if blockDamage < 0 then
			call BlzSetEventDamage(0)
		else
			call BlzSetEventDamage(blockDamage )
		endif
	endif

    //Wisdom Chestplate
    if DmgType == DAMAGE_TYPE_MAGIC and UnitHasItemS(damageTarget, 'I0AH') then 
        call ActivateWisdomChestplate(damageTarget, GetEventDamage())
    endif

    if AbilA then
        if DmgType == DAMAGE_TYPE_NORMAL then
            
            //Thorns
            if (GetUnitAbilityLevel(damageTarget, 'B01C') > 0 and IsUnitType(damageSource, UNIT_TYPE_MELEE_ATTACKER)) then
                
                set Admg = 1 - (0.01*GetUnitAbilityLevel(damageTargetHero, 'A088' + GetUnitAbilityLevel(damageTargetHero, 'A093')))
                //call BJDebugMsg("thorns: admg:" + R2S(Admg) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.01)) * Admg))
                if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.01)) * Admg, true)
                else
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A08F') * 0.02)) * Admg, true)
                endif
            endif

            //Reflection
            if (GetUnitAbilityLevel(damageTarget, 'B01O') > 0 and IsUnitType(damageSource, UNIT_TYPE_RANGED_ATTACKER)) then
                set Admg = 1 - (0.01*GetUnitAbilityLevel(damageTargetHero, 'A088' + GetUnitAbilityLevel(damageTargetHero, 'A08F')))
                //call BJDebugMsg("ref: admg:" + R2S(Admg) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.01)) * Admg))
                if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.01)) * Admg, true)
                else
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A093') * 0.02)) * Admg, true)
                endif
            endif
            
            //spiked carapaces
            if GetUnitAbilityLevel(damageTarget, 'AUts') > 0 and attack then
                call MagicDamage(damageTarget,damageSource, GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'AUts') * 0.003), true)
            endif
        endif
        
        if DmgType == DAMAGE_TYPE_MAGIC then
            
            //Wizardbane
            if GetUnitAbilityLevel(damageTarget, 'B01B') > 0 then
                set Admg = 1 - (0.01*GetUnitAbilityLevel(damageTargetHero, 'A08F' + GetUnitAbilityLevel(damageTargetHero, 'A093')))
                //call BJDebugMsg("wb: admg:" + R2S(Admg) + " ttl: " + R2S((GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.01)) * Admg))
                if IsUnitType(damageSource, UNIT_TYPE_HERO) then
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.01)) * Admg, true)
                else
                    call MagicDamage(damageTarget,damageSource, (GetEventDamage() * (GetUnitAbilityLevel(damageTargetHero, 'A088') * 0.02)) * Admg, true)
                endif
                call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", damageSource, "chest"))
            endif
        endif
    endif
    
    //Martial retribution
    if GetUnitAbilityLevel(damageTarget, 'A089') > 0 and BlzGetUnitAbilityCooldownRemaining(damageTarget,'A089') <= 0 then
        call MartialRetributionStore(damageTarget, GetEventDamage() * 0.5)
    endif

    if AbilA and DmgType == DAMAGE_TYPE_NORMAL then   
    
        //Liquid Fire
        set II = GetUnitAbilityLevel(damageSource,'A06Q')
        if II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, 'A06Q') == 0 then
        
            /*if GetUnitAbilityLevel(damageTarget,'B016') == 0 then
                set Bfirst = true
                else
                set Bfirst = false 
            endif*/
            call SetBuff(damageTarget,3,3)
            //call PerodicDmg(damageSource,damageTarget,40*II +  GetUnitMagicDmg(damageSource)*5,0,1,3.01,'B016',Bfirst)
            call PeriodicDamage.create(damageSource, damageTarget, 40*II + GetUnitMagicDmg(damageSource)*5, true, 1., 3, 0, false, 'B016').addLimit('A06Q', 150, 1)
        endif
        
        //Envenomed Weapons
        set II = GetUnitAbilityLevel(damageSource,'A06O')
        if II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, 'A06O') == 0 then
            /*if GetUnitAbilityLevel(damageTarget,'B015') == 0 then
                set Bfirst = true
            else
                set Bfirst = false 
            endif*/
            call SetBuff(damageTarget,2,8)
            //call PerodicDmg(damageSource,damageTarget,10*II,0.5,1,8.01,'B015',Bfirst)
            call PeriodicDamage.create(damageSource, damageTarget, 30*II, true, 1., 8, 1, false, 'B015').addLimit('A06O', 150, 1)
        endif
    endif
    
    //Frostbite of the Soul
    set II = GetUnitAbilityLevel(damageTarget,'A080')
    if II > 0 and IsHeroUnitId(GetUnitTypeId(damageSource)) then
        if BlzGetUnitAbilityCooldownRemaining(damageTarget,'A080') <= 0 then
            call  AbilStartCD(damageTarget,'A080', 9)
            call AddCooldowns(damageSource,0.95+I2R(II)*0.05)
            call MagicDamage(damageTarget,damageSource,200*II, false)
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", damageSource, "chest"))
        endif
    endif 
	
    //Mystical armor
	set II =  UnitHasItemI( damageTarget,'I06E' )
    if  II > 0  then
        if GetRandomReal(1,100)  <= II*8*luckSource then
         if GetUnitState(damageTarget,UNIT_STATE_MANA) >= 750 then
            set RandomSpellLoc = Location(GetUnitX(damageSource), GetUnitY(damageSource))
            call CastRandomSpell(damageTarget, damageSource, RandomSpellLoc, true, 15)
            call RemoveLocation(RandomSpellLoc)
            set RandomSpellLoc = null
            call SetUnitState(damageTarget,UNIT_STATE_MANA,GetUnitState(damageTarget,UNIT_STATE_MANA)-750 )
         endif
        endif
    endif

	set damageSourceHero = null
	set damageTargetHero = null
	set damageTarget = null
	set damageSource = null
endfunction

//===========================================================================
function InitTrig_Damage_Controller_Before takes nothing returns nothing
    set gg_trg_Damage_Controller_Before = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Damage_Controller_Before, EVENT_PLAYER_UNIT_DAMAGING)
    call TriggerAddAction( gg_trg_Damage_Controller_Before, function Trig_Damage_Controller_Before_Actions )
endfunction
