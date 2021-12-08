scope DamageControllerBefore initializer init
    globals
        boolean GLOB_cuttting = false 
        boolean GLOB_SpiritLink = false
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
            if GetUnitTypeId(u) == SEER_UNIT_ID then
                if BlzGetEventDamageType() == DAMAGE_TYPE_NORMAL then
                    call BlzSetEventDamageType(DAMAGE_TYPE_MAGIC)
                else
                    call BlzSetEventDamageType(DAMAGE_TYPE_NORMAL)
                endif
            else
                //Staff of Power
                if UnitHasItemS( GetEventDamageSource() ,'I080') or GetUnitTypeId(u) == 'n00W' or GetUnitTypeId(u) == 'n01H'  or GetUnitTypeId(u) == SKELETON_WARMAGE_1_UNIT_ID then
                    call BlzSetEventDamageType(DAMAGE_TYPE_MAGIC)
                endif
            endif
        endif

    endfunction


    function Trig_Damage_Controller_Before_Actions takes nothing returns nothing
        local unit damageTarget = GetTriggerUnit()
        local unit damageSource = GetEventDamageSource()

        local integer PidT = GetPlayerId(GetOwningPlayer(damageTarget ))
        local integer PidA = GetPlayerId(GetOwningPlayer(damageSource))

        local integer sourceId = GetHandleId(damageSource) 	
        local integer targetId = GetHandleId(damageTarget) 	
        local unit damageSourceHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageSource) ) ]
        local unit damageTargetHero = udg_units01[GetConvertedPlayerId(GetOwningPlayer( damageTarget) ) ]
        local damagetype DmgType
        local real blockDamage = 0
        local timer tim = null
        local real magicResDamage = 0
        local boolean attack = BlzGetEventIsAttack()
        local real Admg
        local real magicPowerDamage = 1
        local integer II = 0
        local integer CuId = GetUnitTypeId(damageSource)
        local real luckSource = 1
        local real luckTarget = 1
        local boolean notOnHit = true
        local boolean Bfirst = false
        local boolean trueAttack = false
        local boolean unlimitedAgony = false
        local boolean spiritLink = false

        //some abilities like faerie fire start a 0 damage event this negates that
        if GetEventDamage() == 0 or DeathReviveInvul.boolean[PidT] then
            call BlzSetEventDamage(0)
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
            return
        endif

        //Some abilities are counted as attacks by setting DamageIsAttack before they use UnitDamageTarget
        if DamageIsAttack then
            set attack = true
            set DamageIsAttack = false
        endif

        //Modify player hero when creep because they dont have a hero
        if GetOwningPlayer(damageTarget) == Player(11) then
            set damageTargetHero = damageTarget
        endif

        if GetOwningPlayer(damageSource) == Player(11) then
            set damageSourceHero = damageSource
        endif

        //not sure when this is applicable
        if damageSource == null then
            set damageSourceHero = null
        endif

        //check if onhit is set
        if TypeDmg_b == 2 then
            set notOnHit = false
            set TypeDmg_b = 0
        endif 

        //check if damage is from spiritlink (dummy)
        if GLOB_SpiritLink then
            set spiritLink = true
            set GLOB_SpiritLink = false
        endif

        set ChestOfGreedBonus.boolean[targetId] = false
        set MacigNecklaceBonus.boolean[targetId] = false

        //call BJDebugMsg("hid: " + I2S(sourceId) + " retdmg: " + R2S(RetaliationDamage.real[sourceId]))
        //Retaliation Aura damage calculation
        if RetaliationDamage.real[sourceId] > 0 then
            //call BJDebugMsg("ra dmg: " + R2S(RetaliationDamage.real[sourceId]) + " new: " + R2S(GetEventDamage() * RetaliationDamage.real[sourceId]))
            call BlzSetEventDamage(GetEventDamage() * RetaliationDamage.real[sourceId])
            set RetaliationDamage.real[sourceId] = 0
            set magicPowerDamage = magicPowerDamage + (GetUnitMagicDmg(damageSource) / 100)
        endif

        //Scorched Earth
        if ScorchedEarthDummy.boolean[sourceId] then
            set ScorchedEarthSource[targetId] = PidA
            call BlzSetEventDamage(0)
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
            return
        endif

        //Thunderwitch passive
        if ThunderBoltSource.boolean[sourceId] then
            set magicPowerDamage = magicPowerDamage + (GetUnitMagicDmg(damageSourceHero) / 100)
        endif

        //modified damage source after this, so can't detect dummy units, those need to go ^^^
        if CuId == PRIEST_1_UNIT_ID or CuId == 'h014' or CuId == 'h00T' or CuId == 'n00V' then
            set damageSource = damageSourceHero
        endif

        //--------------------------------------------------------------------------------------------------        
        set luckSource = GetUnitLuck(damageSource)
        set luckTarget = GetUnitLuck(damageTarget)

        call SetTypeDamage(damageSource)
        set DmgType = BlzGetEventDamageType()

        //Evasion & miss TODO: clean this up
        if (attack or GetUnitAbilityLevel(damageTarget, 'B01T') > 0) and (GetUnitEvasion(damageTarget) > 0 or GetUnitAbilityLevel(damageSource, 'B027') > 0 or GetUnitMissChance(damageSource) > 0) then
            set Admg = Evade(damageSource, damageTarget, GetEventDamage())
            if Admg == 0 then
                call BlzSetEventDamage(0)
                set damageSourceHero = null
                set damageTargetHero = null
                set damageTarget = null
                set damageSource = null
                return
            endif
            call BlzSetEventDamage(Admg)
            if TrueDamage then
                set trueAttack = true
                set TrueDamage = false
            endif
        endif

        if IsUnitType(damageSource, UNIT_TYPE_HERO) and attack and IsDamageWhirlwind(damageSource) == false then

            //set attack damage for skills based on it
            set SpellData[sourceId].real[7] = GetEventDamage()

            //Whirlwind update description
            if GetUnitAbilityLevel(damageSource, WHIRLWIND_ABILITY_ID) > 0 then
                call Whirlwind_Description(damageSource, GetEventDamage())
            endif

            //Arcane Assault
            if GetUnitAbilityLevel(damageSource, ARCANE_ASSAUL_ABILITY_ID) > 0 and IsDamageArcaneAssault(damageSource) == false then
                call ArcaneAssault(damageSource, damageTarget, GetEventDamage())
            endif
        endif

        //Extradimensional Cooperation
        if GetUnitAbilityLevel(damageSource, 'B01H') > 0 and notOnHit and IsDamageExtradimensional(damageSource) == false then
            call CastExtradimensionalCoop(damageSource, damageTarget, GetEventDamage(), DmgType == DAMAGE_TYPE_MAGIC)
        endif

        if (GetUnitAbilityLevel(damageTarget, 'B028') > 0 or GetUnitAbilityLevel(damageTarget, 'BHbn') > 0) and DmgType == DAMAGE_TYPE_NORMAL then
            call BlzSetEventDamage(0)
            set damageSourceHero = null
            set damageTargetHero = null
            set damageTarget = null
            set damageSource = null
            return
        endif

        //Divine Bubble
        set II = GetUnitAbilityLevel(damageTarget,DIVINE_BUBBLE_ABILITY_ID)
        if II > 0 or UnitHasItemS(damageTarget, 'I095') then
            if IsUnitDivineBubbled(damageTarget) then
                call RemoveDebuff(damageTarget, 1) 
                set notOnHit = false
            endif

            if (II > 0 and BlzGetUnitAbilityCooldownRemaining(damageTarget,DIVINE_BUBBLE_ABILITY_ID) <= 0.001) or (II == 0 and UnitHasItemS(damageTarget, 'I095') and BlzGetUnitAbilityCooldownRemaining(damageTarget,'A0AP') == 0) then
                set notOnHit = false
                call RemoveDebuff(damageTarget, 1) 
                if UnitHasItemS(damageTarget, 'I095') then
                    set II = 1
                else
                    set II = 0
                endif
                if UnitHasItemS(damageTarget, 'I095') and GetUnitAbilityLevel(damageTarget, DIVINE_BUBBLE_ABILITY_ID) == 0 then
                    if IsUnitDivineBubbled(damageTarget) then
                        set GetDivineBubbleStruct(GetHandleId(damageTarget)).endTick = T32_Tick + (32 * II)
                    else
                        call DivineBubbleStruct.create(damageTarget, II, 'A0AP')
                    endif
                else
                    if IsUnitDivineBubbled(damageTarget) then
                        set GetDivineBubbleStruct(GetHandleId(damageTarget)).endTick = T32_Tick + (32 * (3 + II))
                    else
                        //call BJDebugMsg("db: " + I2S(3 + II))
                        call DivineBubbleStruct.create(damageTarget, 3 + II, DIVINE_BUBBLE_ABILITY_ID)
                    endif
                endif
            endif
        endif


        //Sword of Bloodthirst
        set II = UnitHasItemI(damageSource, 'I0AI')
        if II > 0 and DmgType == DAMAGE_TYPE_NORMAL then
            call BlzSetEventDamage(GetEventDamage() + 900 * II)
        endif

        //Crits
        if DmgType ==  DAMAGE_TYPE_NORMAL then
            call TakePhysDmg(damageSource,damageTarget, notOnHit)
        elseif DmgType == DAMAGE_TYPE_MAGIC then
            call TakeMagickDmg(damageSource,damageTarget, notOnHit)
        endif

        //Cutting
        set GLOB_cuttting = false
        set II = GetUnitAbilityLevel(damageSource,CUTTING_ABILITY_ID)
        if II > 0 and attack and GetRandomReal(1,100) < 20 * luckSource then
            call BlzSetEventDamage(GetEventDamage()+ II * 100)
            set GLOB_cuttting = true
        endif

        //Unlimited Agony
        set II = GetUnitAbilityLevel(damageSource, UNLIMITED_AGON_ABILITY_ID)
        if II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, UNLIMITED_AGON_ABILITY_ID) == 0 and (not (IsUnitMagicImmune(damageTarget) or IsUnitDivineBubbled(damageTarget))) then
            call AbilStartCD(damageSource, UNLIMITED_AGON_ABILITY_ID, 20.5 - (0.5 * II))
            set unlimitedAgony = true
            set UnlimitedAgonyActivated.boolean[sourceId] = true
            //call BJDebugMsg("unlimited agony activated")
        endif

        if not unlimitedAgony then
            //Storm Horn
            if GetUnitAbilityLevel(damageTarget ,'B00B') >= 1 then
                if GetRandomReal(1,100) <= 14 * luckTarget then
                    call BlzSetEventDamage(   0 )
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", damageTarget, "chest"))
                    set damageSourceHero = null
                    set damageTargetHero = null
                    set damageTarget = null
                    set damageSource = null
                    return
                endif		
            endif

            //Aura of Immortality
            if GetUnitAbilityLevel(damageTarget ,'B00D') >= 1 then
                if GetRandomInt(1,100) <= GetUnitAbilityLevel(damageTargetHero  ,AURA_OF_IMMORTALITY_ABILITY_ID) then
                    call BlzSetEventDamage(   0 )
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", damageTarget, "chest"))
                    set damageSourceHero = null
                    set damageTargetHero = null
                    set damageTarget = null
                    set damageSource = null
                    return			
                endif		
            endif	

            //Null Void Orb
            if UnitHasItemS(damageTarget, 'I0AL') then
                if GetRandomInt(1,100) <= 10 * luckTarget then
                    call BlzSetEventDamage(0)
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", damageTarget, "chest"))
                    set damageSourceHero = null
                    set damageTargetHero = null
                    set damageTarget = null
                    set damageSource = null
                    return			
                endif		
            endif


            //Dark Shield
            if UnitHasItemS( damageTarget,'I060' )  then
                if DmgType ==  DAMAGE_TYPE_NORMAL then
                    if BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08R') <= 0 then
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
                    if BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08Q') <= 0 then
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
                if BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A08S') <= 0 then
                    call AbilStartCD(damageTarget, 'A08S', 6)
                    call RemoveDebuff(damageTarget, 1)  
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl", damageTarget, "chest")) 
                    set tim = null
                    set damageSourceHero = null
                    set damageTargetHero = null
                    set damageTarget = null
                    set damageSource = null
                    return
                endif 
            endif 
        endif

         //Light Magic Shield
        if UnitHasItemS(damageTarget,'I06K') and BlzGetUnitArmor(damageTarget)<= 50  then
            call BlzSetEventDamage(  GetEventDamage()* 0.7  )
        endif

        //Centuar Archer passive
        if GetUnitTypeId(damageSource) == CENTAUR_ARCHER_UNIT_ID and attack then
            if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08T') <= 0 then
                call AbilStartCD(damageSource, 'A08T', 2)
                call ElemFuncStart(damageSource,CENTAUR_ARCHER_UNIT_ID)
                call BlzSetEventDamage(GetEventDamage() + (BlzGetUnitMaxHP(damageTarget) * 0.06) + (GetEventDamage() * (1 + (0.05 * GetHeroLevel(damageSource)))) )
                call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl", damageTarget, "chest"))
            endif
        endif  

        //Hero's Hammer
        set II = UnitHasItemI( damageSource,'I064' )
        if II > 0 and DmgType ==  DAMAGE_TYPE_NORMAL then 
            if BlzGetUnitAbilityCooldownRemaining(damageSource,'A051') <= 0 then
                call AbilStartCD(damageSource,'A051',15 /(  BlzGetUnitAttackCooldown(damageSource,0) ))
                call BlzSetEventDamage(GetEventDamage() + II *(2.2 * GetHeroStr(damageSource ,true)- GetHeroAgi(damageSource ,true))  )  
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\BallistaMissile\\BallistaMissileTarget.mdl", damageTarget, "chest"))  
            endif
        endif

        //Hammer of Chaos
        if UnitHasItemS( damageSource,'I06H' ) and attack then
            if BlzGetUnitAbilityCooldownRemaining(damageSource,'A04Y') <= 0 then
                call AbilStartCD(damageSource,'A04Y', 8 )
                call USOrder4field(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),'A04R',"stomp",GetEventDamage(),ABILITY_RLF_DAMAGE_INCREASE,500,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,0.05,ABILITY_RLF_DURATION_NORMAL)
            endif       
        endif   

        //Cruelty
        set II = GetUnitAbilityLevel(damageSource,CRUELTY_ABILITY_ID)
        if II > 0 and DmgType ==  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(damageSource,CRUELTY_ABILITY_ID) <= 0.001 or CheckTimerZero(damageSourceHero,CRUELTY_ABILITY_ID) ) then
            call BlzSetEventDamage(GetEventDamage() + GetEventDamage()*(2.5 + I2R(II)/ 2) ) 
            call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", damageTarget, "chest"))
            if ZetoTimerStart(damageSource,CRUELTY_ABILITY_ID) then
                call AbilStartCD(damageSource,CRUELTY_ABILITY_ID, 6 )
            endif
        endif

        //Trident of Pain
        if UnitHasItemS( damageSource,'I061' )  then
            if DmgType ==  DAMAGE_TYPE_NORMAL then
                if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08X') <= 0 then
                    call AbilStartCD(damageSource, 'A08X', 12)
                    call ElemFuncStart(damageSource,'I061')
                    call BlzSetEventDamage(GetEventDamage()* 2.6)
                    call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
                elseif BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08Y') <= 0 then
                    call AbilStartCD(damageSource, 'A08Y', 12)
                    call ElemFuncStart(damageSource,'I061')
                    call BlzSetEventDamage(GetEventDamage()* 2.6)
                    call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
                elseif BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08Z') <= 0 then
                    call AbilStartCD(damageSource, 'A08Z', 12)
                    call ElemFuncStart(damageSource,'I061')
                    call BlzSetEventDamage(GetEventDamage()* 2.6)
                    call CreateTextTagTimer( R2S(GetEventDamage()) + "!",1,GetUnitX(damageTarget),GetUnitY(damageTarget),50,1)
                endif
            endif
        endif

        //Ursa Warrior
        if GetUnitTypeId(damageSource) == URSA_WARRIOR_UNIT_ID and attack then
            //call CastUrsaBleed(damageSource, damageTarget, GetEventDamage(), DmgType !=  DAMAGE_TYPE_NORMAL)
            call SetBuff(damageTarget,4,3)
            call PeriodicDamage.create(damageSource, damageTarget, GetEventDamage()/ 3, DmgType ==  DAMAGE_TYPE_MAGIC, 1., 3, 0, true, 'B01I').addFx(FX_Bleed, "head").addLimit('A0A4', 150, 1)
        endif

        //Pvp Bonus
        if GetOwningPlayer(damageTarget) != Player(11) and GetOwningPlayer(damageSource) != Player(11) then
            call BlzSetEventDamage(GetEventDamage()+  (GetEventDamage()*(GetUnitPvpBonus(damageSource)- GetUnitPvpBonus(damageTarget)  )/ 100)   )
        endif 

        //Ogre Warrior
        if GetUnitTypeId(damageSource) == OGRE_WARRIOR_UNIT_ID and DmgType ==  DAMAGE_TYPE_NORMAL then
            if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08U') <= 0 then
                call AbilStartCD(damageSource, 'A08U', 6)
                call ElemFuncStart(damageSource,OGRE_WARRIOR_UNIT_ID)
                call USOrder4field(damageSource,GetUnitX(damageTarget),GetUnitY(damageTarget),'A047',"stomp",GetHeroStr(damageSource,true) + 60 * GetHeroLevel(damageSource) ,ABILITY_RLF_DAMAGE_INCREASE,300,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,1,ABILITY_RLF_DURATION_NORMAL)
            endif
        endif  

        if GetUnitAbilityLevel(damageTarget, 'BHbn') > 0 and DmgType == DAMAGE_TYPE_MAGIC then
            call BlzSetEventDamage( GetEventDamage() * 1.5)
        endif

        if not unlimitedAgony then
            //Ice Armor
            if GetUnitAbilityLevel(damageTarget,ICE_ARMOR_ABILITY_ID)> 0 and BlzGetUnitAbilityCooldownRemaining(damageTarget,ICE_ARMOR_ABILITY_ID) <= 0    then
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl", damageTarget, "chest"))
                call BlzSetEventDamage( GetEventDamage()/ 5) 
                call AbilStartCD(damageTarget,ICE_ARMOR_ABILITY_ID, 2.05 - 0.05 * I2R(GetUnitAbilityLevel(damageTarget,ICE_ARMOR_ABILITY_ID)) )
            endif  

            //Blessed Protection
            set II = GetBuffLevel(damageTarget, 'A0AF')
            if II > 0 then
                loop
                    call BlzSetEventDamage(  GetEventDamage()/ 10) 
                    set II = II - 1
                    exitwhen II <= 0
                endloop
            endif
        endif
        
        //Pit Lord
        /*if GetUnitTypeId(damageSource) == PIT_LORD_UNIT_ID then
            if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08V') <= 0 then
                call AbilStartCD(damageSource, 'A08V', 2)
                call ElemFuncStart(damageSource,PIT_LORD_UNIT_ID)
                call UsOrderU2 (damageSource,damageTarget,GetUnitX(damageSource),GetUnitY(damageSource),'A08N',"rainoffire", GetHeroLevel(damageSource)* 40, GetHeroLevel(damageSource)* 20, ABILITY_RLF_DAMAGE_HBZ2, ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5)
            endif
        endif*/

        //Lich
        if GetUnitTypeId(damageSource) == LICH_UNIT_ID and DmgType == DAMAGE_TYPE_MAGIC then
            if BlzGetUnitAbilityCooldownRemaining(damageSource, 'A08W') <= 0 then
                call AbilStartCD(damageSource, 'A08W', 6)
                call ElemFuncStart(damageSource,LICH_UNIT_ID)
                call UsOrderU2 (damageSource,damageTarget,GetUnitX(damageSource),GetUnitY(damageSource),'A03J',"frostnova", GetHeroInt(damageSource, true) + (GetHeroLevel(damageSource)* 60), GetHeroInt(damageSource, true) + (GetHeroLevel(damageSource)* 60), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
            endif
        endif

        //Air Force
        if GetUnitAbilityLevel(damageSourceHero  ,AIR_FORCE_ABILITY_ID) >= 1 then
            if GetUnitAbilityLevel(damageTarget,'Bams') > 0 or GetUnitAbilityLevel(damageTarget,'Bam2') > 0  then

                call BlzSetEventDamage(  GetEventDamage()  + (I2R(GetUnitAbilityLevel(damageSourceHero  ,AIR_FORCE_ABILITY_ID))* GetHeroAgi(damageSourceHero,true))/ 40  )
            else
                call BlzSetEventDamage(  GetEventDamage()  + (I2R(GetUnitAbilityLevel(damageSourceHero  ,AIR_FORCE_ABILITY_ID))* GetHeroAgi(damageSourceHero,true))/ 20  )
            endif
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl", damageTarget, "chest"))		
        endif

        //Grom Hellscream
        if GetUnitTypeId(damageSourceHero) == ORC_CHAMPION_UNIT_ID then
            call BlzSetEventDamage(GetEventDamage() + GetHeroStr(damageSourceHero, true) * 0.1 + (0.01 * GetHeroLevel(damageSourceHero)))
            call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", damageTarget, "chest"))		
        endif

        //Robes of the Archmage
        if GetUnitAbilityLevel(damageSource  ,'B00L') >= 1 and DmgType == DAMAGE_TYPE_MAGIC then
            set magicPowerDamage = magicPowerDamage + (BlzGetUnitMaxMana(damageTarget) - GetUnitState(damageTarget, UNIT_STATE_MANA)) / 90000
        endif

        /*//Pit Lord Magic power for phys
        if GetUnitTypeId(damageSource) == PIT_LORD_UNIT_ID and DmgType == DAMAGE_TYPE_NORMAL and (magicPowerDamage != 1 or GetUnitMagicDmg(damageSource) > 0) then
            set Admg = 1 - RMaxBJ(0.25 * GetClassUnitSpell(damageSource, Element_Water), 0)
            call BlzSetEventDamage(GetEventDamage()* ((magicPowerDamage + GetUnitMagicDmg(damageSource)/ 100) * Admg))
        endif   */

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

        //Absolute Poison
        if GetUnitAbilityLevel(damageSource, ABSOLUTE_POISON_ABILITY_ID) > 0 and GetUnitAbilityLevel(damageSource, 'B01W') == 0  then
            call PoisonSpellCast(damageSource, damageTarget)
        endif

        if DmgType == DAMAGE_TYPE_NORMAL and notOnHit then
            //Incinerate
            set II = GetUnitAbilityLevel(damageSource,INCINERATE_ABILITY_ID)
            if II > 0 then
                if GetUnitAbilityLevel(damageTarget,'B014') > 0 then
                    set Admg = II * 5 + LoadInteger(HT,GetHandleId(damageTarget),- 300001)
                else
                    set Admg = II * 5
                endif
                call SaveInteger(HT,GetHandleId(damageTarget),- 300001, R2I(Admg))
                call SaveInteger(HT,GetHandleId(damageTarget),- 300002,II * 100)
                call SaveUnitHandle(HT,GetHandleId(damageTarget),- 300003,damageSource)
                call SaveInteger(HT,GetHandleId(damageTarget),- 300004,T32_Tick)
                call SetBuff(damageTarget,1,5)

                if GetEventDamage() > 0 then
                    call BlzSetEventDamage(GetEventDamage()+ Admg)
                endif
            endif
        endif

        //Rock Golem
        if GetUnitTypeId(damageTarget) == ROCK_GOLEM_UNIT_ID and BlzGetUnitAbilityCooldownRemaining(damageTarget, 'A0AH') == 0 then
            call AbilStartCD(damageTarget, 'A0AH', 1)
            call ElementStartAbility(damageTarget, ROCK_GOLEM_UNIT_ID)
            call DestroyEffect(AddSpecialEffectFix("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(damageTarget), GetUnitY(damageTarget)))
            call AreaDamagePhys(damageTarget, GetUnitX(damageTarget), GetUnitY(damageTarget), GetUnitBlock(damageTarget) * (0.49 + (0.01 * GetHeroLevel(damageTarget))), 400, 'A0AH')
        endif

        //Spirit Link
        if GetUnitAbilityLevel(damageTarget, 'Bspl') > 0 and spiritLink == false then
            call BlzSetEventDamage(DistributeSpiritLink(damageTargetHero, GetEventDamage()))
        endif

        //Physical Power
        if DmgType == DAMAGE_TYPE_NORMAL then
            set Admg = GetUnitPhysPow(damageSource)
            if Admg != 0 then
                call BlzSetEventDamage(GetEventDamage() * (1 + (Admg * 0.01)))
            endif
        endif

        if DmgType == DAMAGE_TYPE_MAGIC then 
            //Magic Power
            if magicPowerDamage != 1 or GetUnitMagicDmg(damageSource) > 0 then
                call BlzSetEventDamage(  GetEventDamage()*(magicPowerDamage + GetUnitMagicDmg(damageSource)/ 100 )   )
            endif   

            //Magic Resistance
            set magicResDamage = GetUnitMagicDef(damageTarget)   
            if magicResDamage > 0 then

                //Fatal Flaw
                set II = GetUnitAbilityLevel(damageSource,FATAL_FLA_ABILITY_ID)
                if II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, FATAL_FLA_ABILITY_ID) == 0 then
                    set magicResDamage = magicResDamage * (1 - (0.025 * II))
                    call AbilStartCD(damageSource, FATAL_FLA_ABILITY_ID, 3)
                endif
                call BlzSetEventDamage(  GetEventDamage()*( 50 /(50 + magicResDamage) )   )        
            endif
        endif

        //Block
        if GetUnitBlock(damageTarget) != 0 and trueAttack == false then	
            set blockDamage = GetUnitBlock(damageTarget)

            //Sword of Bloodthirst
            if UnitHasItemS(damageSource, 'I0AI') and attack then
                set blockDamage = blockDamage * 0.7
            endif

            //call BJDebugMsg(GetUnitName(damageTarget) + ", block:  " + R2S(GetUnitBlock(damageTarget)) + ", calc: " + R2S(blockDamage))
            //Absolute Dark
            set II = GetUnitAbilityLevel(damageSourceHero, ABSOLUTE_DARK_ABILITY_ID)
            if II > 0 and GetUnitAbilityLevel(damageSourceHero, 'B01W') == 0 then
                set blockDamage = blockDamage * (1 - ((0.009 + (0.001 * II)) * GetClassUnitSpell(damageSourceHero, Element_Dark)))
            endif

            //Skeleton Warmage
            set II = GetUnitAbilityLevel(damageSourceHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
            if II > 0 and GetUnitAbilityLevel(damageSource, 'A0AY') > 0 and GetRandomInt(1,100) < ((II + 10) * 0.5) * luckSource then
                set blockDamage = 0
            endif

            //call BJDebugMsg("dmg: " + R2S(GetEventDamage()) + ", block after ad: " + R2S(blockDamage) + " new dmg: " + R2S(GetEventDamage() - blockDamage))
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

        //Martial retribution
        if GetUnitAbilityLevel(damageTarget, MARTIAL_RETRIBUTION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(damageTarget,MARTIAL_RETRIBUTION_ABILITY_ID) <= 0 then
            call MartialRetributionStore(damageTarget, GetEventDamage() * 0.5)
        endif

        if notOnHit and IsUnitEnemy(damageTarget, GetOwningPlayer(damageSource)) then   

            //Liquid Fire
            set II = GetUnitAbilityLevel(damageSource,LIQUID_FIRE_ABILITY_ID)
            if DmgType == DAMAGE_TYPE_NORMAL and II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, LIQUID_FIRE_ABILITY_ID) == 0 then

                call SetBuff(damageTarget,3,3)
                //call PerodicDmg(damageSource,damageTarget,40*II +  GetUnitMagicDmg(damageSource)*5,0,1,3.01,'B016',Bfirst)
                call PeriodicDamage.create(damageSource, damageTarget, 40 * II + GetUnitMagicDmg(damageSource)* 5, true, 1., 3, 0, false, 'B016').addLimit(LIQUID_FIRE_ABILITY_ID, 150, 1)
            endif

            //Envenomed Weapons
            set II = GetUnitAbilityLevel(damageSource,ENVENOMED_WEAPONS_ABILITY_ID) + PoisonRuneBonus[PidA]
            if (DmgType == DAMAGE_TYPE_NORMAL or PoisonRuneBonus[PidA] > 0) and II > 0 and BlzGetUnitAbilityCooldownRemaining(damageSource, ENVENOMED_WEAPONS_ABILITY_ID) == 0 then

                //Absolute Poison
                set Admg = PoisonBonus.real[sourceId]
                if Admg == 0 or GetUnitAbilityLevel(damageSourceHero, 'B01W') == 0 then
                    set Admg = 1
                endif
                call SetBuff(damageTarget,2,8)
                //call PerodicDmg(damageSource,damageTarget,10*II,0.5,1,8.01,'B015',Bfirst)
                call PeriodicDamage.create(damageSource, damageTarget, 30 * II * Admg, true, 1., 8, 1, false, 'B015').addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 150, 1)
            endif
        endif

        //Frostbite of the Soul
        set II = GetUnitAbilityLevel(damageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID)
        if II > 0 and IsHeroUnitId(GetUnitTypeId(damageSource)) then
            if BlzGetUnitAbilityCooldownRemaining(damageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID) <= 0 then
                call AbilStartCD(damageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID, 9)
                call AddCooldowns(damageSource,0.95 + I2R(II)* 0.05)
                call MagicDamage(damageTarget,damageSource,200 * II, false)
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", damageSource, "chest"))
            endif
        endif 

        //Mystical armor
        set II = UnitHasItemI( damageTarget,'I06E' )
        if II > 0  then
            if GetRandomReal(1,100)  <= II * 8 * luckSource then
                if GetUnitState(damageTarget,UNIT_STATE_MANA) >= 750 then
                    set RandomSpellLoc = Location(GetUnitX(damageSource), GetUnitY(damageSource))
                    call CastRandomSpell(damageTarget, 0, damageSource, RandomSpellLoc, true, 15)
                    call RemoveLocation(RandomSpellLoc)
                    set RandomSpellLoc = null
                    call SetUnitState(damageTarget,UNIT_STATE_MANA,GetUnitState(damageTarget,UNIT_STATE_MANA)- 750 )
                endif
            endif
        endif

        if notOnHit == false then
            set OnHitDamage = true
        endif

        set damageSourceHero = null
        set damageTargetHero = null
        set damageTarget = null
        set damageSource = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DAMAGING)
        call TriggerAddAction( trg, function Trig_Damage_Controller_Before_Actions )
        set trg = null
    endfunction
endscope