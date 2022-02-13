scope ModifyDamageAfterArmor initializer init

    globals
        trigger TrgModifyDamageAfter
    endglobals

    private function ModifyDamageAfterArmor takes nothing returns nothing
        local real r1 = 0
        local real r2 = 0
        local real r3 = 0
        
        local integer i = 0
        local integer i1 = 0
        local integer i2 = 0

        local integer vampCount = 0
        local real vampAmount = 0

        //call BJDebugMsg("MOD1.2 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))

        //Titanium Armor
        if UnitHasItemS(DamageTarget,'I07M') then
            set r1 = I2R(GetHeroStr(DamageTarget,true))* 0.08
            
            if r1 >= Damage.index.amount then
                set Damage.index.amount = 0
                return
            else
                set Damage.index.amount =  Damage.index.amount - r1
            endif
        endif

        //Strong Chest Mail
        if UnitHasItemS(DamageTarget,'I07P') and IsHeroUnitId(GetUnitTypeId(DamageSource)) == false and (not Damage.index.isSpell) then   
            set Damage.index.amount = Damage.index.amount / 2
        endif

        //Fishing Rod
        if (not DamageIsOnHit) and UnitHasItemS(DamageSource,'I07T') and (not Damage.index.isSpell) and DistanceBetweenUnits(DamageSource, DamageTarget) < 1200 then
            call SetUnitX(DamageSource,GetUnitX(DamageTarget) )
            call SetUnitY(DamageSource,GetUnitY(DamageTarget) )
        endif

        /*//Aura of Vulnerability
        if GetUnitAbilityLevel(DamageTarget ,'B00E') >= 1 then
            if GetRandomReal(0,100) <= 5 * luck then
                set Damage.index.amount = Damage.index.amount * (1 + (0.5 * GetUnitAbilityLevel(DamageSourceHero  ,AURA_OF_VULNERABILITY_ABILITY_ID))))
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", DamageTarget, "chest"))
            endif
        endif*/

        //Mask of Death lifesteal
        if LoadInteger(HTi,GetHandleId(DamageSourceHero),1) == 1 then
            set r2 = (Damage.index.amount/ 4)
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1	
        endif

        //Medal of Honor
        if LoadInteger(HTi,GetHandleId(DamageTargetHero),2) == 1 then 
            set Damage.index.amount = Damage.index.amount * 0.66
        endif 

        //Mask of Death damage reduction
        if LoadInteger(HTi,GetHandleId(DamageSourceHero),1) == 1 then
            set Damage.index.amount = Damage.index.amount * 0.75
        endif

        //Medal of Honor
        if LoadInteger(HTi,GetHandleId(DamageSourceHero),2) == 1 then 
            set Damage.index.amount = Damage.index.amount * 0.66
        endif 

        //Blokkades Shield damage reduction
        if GetUnitAbilityLevel(DamageTarget, 'A01X') > 0 then

            //attack ignore
            if Damage.index.isAttack then
                set BlokShieldAttackCount[DamageTargetId] = BlokShieldAttackCount[DamageTargetId] + 1
                call BJDebugMsg("bs ac: " + I2S(BlokShieldAttackCount[DamageTargetId]))
                if BlokShieldAttackCount[DamageTargetId] >= 3 then
                    set BlokShieldAttackCount[DamageTargetId] = 0
                    set Damage.index.damage = 0
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                    return
                endif
            endif
            
            //damage reduction
            if T32_Tick - BlokShieldDmgReductionTick[DamageTargetId] < 32 then
                call BJDebugMsg("bs dmg red")
                set Damage.index.amount = Damage.index.amount * 0.2
            endif
        endif

        //Vampirism
        set r1 = GetUnitAbilityLevel(DamageSource,VAMPIRISM_ABILITY_ID)
        if r1 > 0 then
            set r2 = Damage.index.amount * (0.005 + 0.005 * r1 + GetClassUnitSpell(DamageSource,11)* 0.02 )
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Soul Reaper
        if UnitHasItemS(DamageSource, 'I01C') and Damage.index.isAttack then
            set r2 = Damage.index.amount * 0.5
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Dreadlord Passive
        if GetUnitTypeId(DamageSourceHero) == DEADLORD_UNIT_ID then
            set r2 = Damage.index.amount * (0.02 * I2R(GetHeroLevel(DamageSourceHero)) )
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif	

        //Ghoul Passive
        if GetUnitTypeId(DamageSource) == GHOUL_UNIT_ID and Damage.index.isAttack then
            //call BJDebugMsg(GetUnitName(DamageSource) + " Damage.index.isAttack " + GetUnitName(DamageTarget) + ": " + I2S(DamageTargetId))
            set i = GetHeroLevel(DamageSource)
            set r2 = BlzGetUnitMaxHP(DamageTarget) * (0.025 + (0.00025 * i))
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
            set Damage.index.amount = Damage.index.amount + r2 
        endif

        //Bone Armor Skeleton Defender
        if UnitHasItemS(DamageTarget, 'I07O') then
            set i = GetBoneArmorStruct(GetHandleId(DamageTargetHero)).groupSize
            if i > 0 and IsHeroUnitId(GetUnitTypeId(DamageTarget)) then
                if i > 12 then
                    set i = 12
                endif
                set Damage.index.amount = Damage.index.amount * (1 - (i * 0.08))
            endif
        endif

        //Wild Runestone
        if UnitHasItemS(DamageTargetHero, 'I0B6') and IsUnitType(DamageTarget, UNIT_TYPE_HERO) == false then
            set Damage.index.amount = Damage.index.amount * 0.7
        endif
        
        //Magic Necklace of Absorption
        if GetUnitAbilityLevel(DamageTarget  ,'B00R') >= 1 and Damage.index.isSpell then
            call SetUnitState(DamageTarget,UNIT_STATE_MANA,   GetUnitState( DamageTarget  , UNIT_STATE_MANA  )  + Damage.index.amount * 0.75 )
        endif

        //Bloody Axe
        if (not Damage.index.isSpell) and IsHeroUnitId(GetUnitTypeId(DamageTarget)) == false then
            set i = UnitHasItemI( DamageSource,'I078') 
            if i > 0 then
                set r2 = Damage.index.amount * (0.25 * I2R(i))
                set vampAmount = vampAmount + r2
                set vampCount = vampCount + 1  
            endif
        endif

        //Staff of Absolute Magic
        if GetUnitAbilityLevel(DamageSourceHero  ,'B00O') >= 1 and Damage.index.isSpell then
            set r2 = Damage.index.amount * 0.33 
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Heavy Blow
        if GetUnitAbilityLevel(DamageSource  ,HEAVY_BLOW_ABILITY_ID) > 0 and (not Damage.index.isSpell) and (BlzGetUnitAbilityCooldownRemaining(DamageSourceHero,HEAVY_BLOW_ABILITY_ID) <= 0 or CheckTimerZero(DamageSourceHero,HEAVY_BLOW_ABILITY_ID)) then
            if ZetoTimerStart(DamageSourceHero,HEAVY_BLOW_ABILITY_ID) then
                call AbilStartCD(DamageSource,HEAVY_BLOW_ABILITY_ID,0.3)
            endif
            set Damage.index.amount = Damage.index.amount + 30 * GetUnitAbilityLevel(DamageSource  ,HEAVY_BLOW_ABILITY_ID)
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", DamageTarget, "chest"))
        endif
        
        //Combustion
        if GetUnitAbilityLevel(DamageSourceHero   ,COMBUSTION_ABILITY_ID) > 0 and Damage.index.isSpell and (BlzGetUnitAbilityCooldownRemaining(DamageSourceHero,COMBUSTION_ABILITY_ID) <= 0 or CheckTimerZero(DamageSourceHero,COMBUSTION_ABILITY_ID)) then
            if ZetoTimerStart(DamageSourceHero,COMBUSTION_ABILITY_ID) then
                call AbilStartCD(DamageSourceHero,COMBUSTION_ABILITY_ID,0.3)
            endif
            set Damage.index.amount = Damage.index.amount + 30 * GetUnitAbilityLevel(DamageSourceHero   ,COMBUSTION_ABILITY_ID)
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", DamageTarget, "chest"))
        endif

        //Frostmourne
        if GetUnitAbilityLevel(DamageSourceHero ,'B008') >= 1 then
            set r2 = (Damage.index.amount / 4)	
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1 
        endif
        
        //Heavy Mace
        set i = UnitHasItemI( DamageSource,'I07I') 
        if i > 0 and IsUnitType(DamageSource,UNIT_TYPE_MELEE_ATTACKER) then
            set r1 =  (GetWidgetLife(DamageTarget)/ 100)* 1.5 * I2R(i)  
            set vampAmount = vampAmount + r1
            set Damage.index.amount = Damage.index.amount + r1
            set vampCount = vampCount + 1
        endif
        
        //Cutting
        if DamageIsCutting then
            set r2 = Damage.index.amount / 2
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1 
            call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Other\\PandarenBrewmasterBlood\\PandarenBrewmasterBlood.mdl", DamageTarget, "chest"))
        endif 

        if vampCount > 0 and IsFxOnCooldown(DamageSource, 0) == false then
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", DamageSource, "chest"))
            call Vamp(DamageSource, DamageTarget, vampAmount)
            call SetFxCooldown(DamageSource, 0, 1)
        endif

        //Ancient Blood
        if GetUnitAbilityLevel(DamageTarget,ANCIENT_BLOOD_ABILITY_ID) > 0 then
            set r1 = LoadReal(HT,DamageTargetId,82340)
            set r2 = LoadReal(HT,DamageTargetId,82341)
            set r3 = 1 - 0.01 * I2R(GetUnitAbilityLevel(DamageTarget,ANCIENT_BLOOD_ABILITY_ID) ) 
            
            if r1 == 0 then
                set r2 = 20000
            endif
            
            set r1 = r1 + Damage.index.amount
            loop
                exitwhen r3 * r2 > r1 
                set r1 = r1 - r2 * r3 
                set r2 = r2 + 250
                call SetHeroStr(DamageTarget,GetHeroStr(DamageTarget,false)+ 2,false)
                //remove bufs
                
                if BlzGetUnitAbilityCooldownRemaining(DamageTarget, ANCIENT_BLOOD_ABILITY_ID) == 0 then
                    call AbilStartCD(DamageTarget, ANCIENT_BLOOD_ABILITY_ID, 1)
                    set i1 = 0
                    loop
                        exitwhen i1 > 10
                        set i2 = GetInfoHeroSpell(DamageTarget ,i1)
                        if i2 != 0 and IsSpellResettable(i2) then
                            call ResetSpell(DamageTarget, i2, 1 + 0.25 * I2R(GetUnitAbilityLevel(DamageTarget,ANCIENT_BLOOD_ABILITY_ID)), false)
                        endif
                        set i1 = i1 + 1
                    endloop
                endif
                
                call RemoveDebuff(DamageTarget, 1)
            endloop
            call SaveReal(HT,DamageTargetId,82340,r1)
            call SaveReal(HT,DamageTargetId,82341,r2)
        endif

        //Blademaster
        if GetUnitTypeId(DamageSource) == BLADE_MASTER_UNIT_ID and BladestormReady(DamageSource) and Damage.index.isAttack then
            call BladestormDamage(DamageSource, Damage.index.amount , Damage.index.isSpell)
        endif

        //Magnetic Oscillation
        set i = GetUnitAbilityLevel(DamageTarget, MAGNET_OSC_ABILITY_ID)
        if i > 0 then
            //call BJDebugMsg("dmg sourceid: " + I2S(DamageSourceId) + " time: " + I2S(T32_Tick - MagnetOscHitTick[DamageSourceId]))
            if T32_Tick - MagnetOscHitTick[DamageSourceId] > ((8 - (0.2 * i)) * 32) then
                //call SetUnitVertexColor(DamageSource, 0, 255, 0, 255)
                set r1 = CalculateDistance(GetUnitX(DamageTarget), GetUnitX(DamageSource), GetUnitY(DamageTarget), GetUnitY(DamageSource))
                if r1 < 600 then
                    //call BJDebugMsg("mosc")
                    set MagnetOscHitTick[DamageSourceId] = T32_Tick
                    set udg_NextDamageAbilitySource = MAGNET_OSC_ABILITY_ID
                    call Damage.apply(DamageTarget, DamageSource, GetSpellValue(30, 15, i), false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                    if IsAbilityEnabled(DamageTarget, MAGNET_OSC_ABILITY_ID) then
                        call KnockbackTarget(DamageTarget, DamageSource, GetAngleToTarget(DamageTarget, DamageSource) * bj_RADTODEG, RAbsBJ(700 - r1), 600, false, false, false, false)
                    else
                        if r1 > 150 then
                            call MoveToPoint(DamageTarget, DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget))
                        endif
                    endif
                endif
            endif
        endif

        if not DamageIsOnHit and Damage.index.amount > 0 then
            if (not Damage.index.isSpell) then

                 //Pulverize
                set i = GetUnitAbilityLevel(DamageSource, PULVERIZE_ABILITY_ID)
                if i > 0 and GetRandomReal(0, 100) <= 20 * DamageSourceLuck then
                    call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(DamageTarget),GetUnitY(DamageTarget) ))
                    call AreaDamage(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 100 * i, BlzGetAbilityRealLevelField(BlzGetUnitAbility(DamageSource,PULVERIZE_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT,i - 1), true, PULVERIZE_ABILITY_ID)
                endif

                //Destruction
                set i = GetUnitAbilityLevel(DamageSource, DESTRUCTION_ABILITY_ID) 
                if i > 0 and GetRandomReal(0, 100) <= 15 * DamageSourceLuck then
                    call DestroyEffect(AddSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(DamageTarget),GetUnitY(DamageTarget) ))
                    call AreaDamage(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 400 * i, BlzGetAbilityRealLevelField(BlzGetUnitAbility(DamageSource,DESTRUCTION_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT, i - 1), true, DESTRUCTION_ABILITY_ID)
                endif
                
                //Bash
                set i = GetUnitAbilityLevel(DamageSource, BASH_ABILITY_ID)  
                if i > 0 and GetRandomReal(0, 100) <= I2R(i) * DamageSourceLuck and GetUnitAbilityLevel(DamageTarget, STUNNED_BUFF_ID) == 0 then
                    call UsOrderU(DamageSource, DamageTarget, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 'A06T', "thunderbolt", i * 100 + GetHeroStr(DamageSourceHero,true) / 2, ABILITY_RLF_DAMAGE_HTB1 )
                endif

                if UnitHasItemS(DamageSource, 'I03T') and GetUnitAbilityLevel(DamageTarget, STUNNED_BUFF_ID) == 0 and GetRandomInt(1,100) <= 15 *  DamageTargetLuck then
                    call ActivateVolcanicArmor(DamageSource, DamageTarget)
                endif

                //Thorns
                if (GetUnitAbilityLevel(DamageTarget, 'B01C') > 0 and IsUnitType(DamageSource, UNIT_TYPE_MELEE_ATTACKER)) then

                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID + GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID)))
                    //call BJDebugMsg("thorns: r1:" + R2S(r1) + " ttl: " + R2S((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) * 0.01)) * r1))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = THORNS_AURA_ABILITY_ID
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        call Damage.applySpell(DamageTarget, DamageSource, (Damage.index.amount * ( 0.12 + (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) * 0.03))) * r1, DAMAGE_TYPE_MAGIC)
                        //call MagicDamage(DamageTarget,DamageSource, , true)
                    else
                        call Damage.applySpell(DamageTarget,DamageSource, (Damage.index.amount * ( 0.18 + (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) * 0.045))) * r1, DAMAGE_TYPE_MAGIC)
                    endif
                endif

                //Reflection
                if (GetUnitAbilityLevel(DamageTarget, 'B01O') > 0 and IsUnitType(DamageSource, UNIT_TYPE_RANGED_ATTACKER)) then
                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID + GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID)))
                    //call BJDebugMsg("ref: r1:" + R2S(r1) + " ttl: " + R2S((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.01)) * r1))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = REFLECTION_AUR_ABILITY_ID
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        call Damage.applySpell(DamageTarget,DamageSource, (Damage.index.amount * (0.12 + (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.03))) * r1, DAMAGE_TYPE_MAGIC)
                    else
                        call Damage.applySpell(DamageTarget,DamageSource, (Damage.index.amount * (0.12 + (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.045))) * r1, DAMAGE_TYPE_MAGIC)
                    endif
                endif

                //Spiked Carapaces
                if GetUnitAbilityLevel(DamageTarget, SPIKED_CARAPACE_ABILITY_ID) > 0 and Damage.index.isAttack then
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = SPIKED_CARAPACE_ABILITY_ID
                    call Damage.applySpell(DamageTarget,DamageSource, Damage.index.amount * (0.03 + (GetUnitAbilityLevel(DamageTargetHero, SPIKED_CARAPACE_ABILITY_ID) * 0.009)), DAMAGE_TYPE_MAGIC)
                endif
            endif

            if Damage.index.isSpell then

                //Wizardbane
                if GetUnitAbilityLevel(DamageTarget, 'B01B') > 0 then
                    set r1 = 1 - (0.01 * GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID + GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID)))
                    //call BJDebugMsg("wb: r1:" + R2S(r1) + " ttl: " + R2S((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.01)) * r1))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = WIZARDBANE_AURA_ABILITY_ID
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        call Damage.applySpell(DamageTarget,DamageSource, (Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.03)) * r1, DAMAGE_TYPE_MAGIC)
                    else
                        call Damage.applySpell(DamageTarget,DamageSource, (Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.05)) * r1, DAMAGE_TYPE_MAGIC)
                    endif
                    call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", DamageSource, "chest"))
                endif
            endif

            //Dark Hunter Bash
            if GetUnitTypeId(DamageSource) == DARK_HUNTER_UNIT_ID and GetRandomInt(0, 100) <= 20 * DamageSourceLuck and GetUnitAbilityLevel(DamageTarget, STUNNED_BUFF_ID) == 0 then
                call UsOrderU(DamageSource, DamageTarget, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 'A06T', "thunderbolt", 50 * GetHeroLevel(DamageSource), ABILITY_RLF_DAMAGE_HTB1 )
            endif
        endif
        
        //Banshee passive
        if GetUnitTypeId(DamageTarget) == BANSHEE_UNIT_ID then
            if Damage.index.amount >= GetUnitState(DamageTarget,UNIT_STATE_MANA) then
                call SetUnitState(DamageTarget,UNIT_STATE_MANA,0)
                set Damage.index.amount = GetUnitState(DamageTarget,UNIT_STATE_MAX_LIFE) + 1
            else
                call SetUnitState(DamageTarget,UNIT_STATE_MANA,GetUnitState(DamageTarget,UNIT_STATE_MANA) - Damage.index.amount)     
                set Damage.index.amount = 0
            endif 
        endif
            
        //Holy Chain Mail
        if UnitHasItemS(DamageTarget,'I07U') then   
            if BlzGetUnitMaxHP(DamageTarget) > BlzGetUnitMaxMana(DamageTarget) then
                if Damage.index.amount > BlzGetUnitMaxHP(DamageTarget)/ 5 then
                    set Damage.index.amount = BlzGetUnitMaxHP(DamageTarget) / 5
                endif
            else
                if Damage.index.amount > BlzGetUnitMaxMana(DamageTarget)/ 5 then
                    set Damage.index.amount = BlzGetUnitMaxMana(DamageTarget) / 5
                endif
            endif
        endif

        //Skeleton Brute
        if GetUnitTypeId(DamageTarget) == SKELETON_BRUTE_UNIT_ID then
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0BA') == 0 and Damage.index.amount > BlzGetUnitMaxHP(DamageTarget) * 0.3 and GetUnitAbilityLevel(DamageTarget, 'A0BB') == 0 then
                call SkeletonBrute(DamageTarget)
            endif

            //Invul
            if GetUnitAbilityLevel(DamageTarget, 'A0BB') > 0 then
                set Damage.index.amount = 0
            endif
        endif

        //Murloc Warrior
        if GetUnitTypeId(DamageTarget) == 'H01F' and GetHeroStr(DamageTarget, true) < 2147483647 then
            set i1 = 1 + GetHeroLevel(DamageTarget)/ 10 
            call SaveInteger(HT,DamageTargetId,54021,i1 + LoadInteger(HT,DamageTargetId,54021))
            call SetHeroStr(DamageTarget,GetHeroStr(DamageTarget,false)+ i1,false)
            call SetHeroAgi(DamageTarget,GetHeroAgi(DamageTarget,false)+ i1,false)
            call SetHeroInt(DamageTarget,GetHeroInt(DamageTarget,false)+ i1,false)
        endif

        //Flimsy Token
        if UnitHasItemS(DamageTarget, FLIMSY_TOKEN_ITEM_ID) and GetUnitAbilityLevel(DamageSource, FLIMSY_TOKEN_BUFF_ID) == 0 then
            call FlimsyToken(DamageTarget, DamageSource)
        endif

        //Stone Protection
        if GetUnitAbilityLevel(DamageTarget,STONE_PROTECTION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,STONE_PROTECTION_ABILITY_ID)<= 0.001 then
            call CastStoneProtect(DamageTarget, DamageSource)
        endif
        
        //Thunder Force
        if GetUnitAbilityLevel(DamageSource,THUNDER_FORCE_ABILITY_ID ) >= 1 and Damage.index.isAttack then
            call UsOrderU(DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A02R',"chainlightning",  GetHeroInt(DamageSource,true)*(20 + 8 * I2R(GetUnitAbilityLevel(DamageSource,THUNDER_FORCE_ABILITY_ID )))/ 100, ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 )
        endif

        //Finishing Blow
        if Damage.index.amount > 0 and GetUnitAbilityLevel(DamageSourceHero , FINISHING_BLOW_ABILITY_ID) >= 1 then
            if 100 *(GetWidgetLife(DamageTarget)- Damage.index.amount)/ GetUnitState(DamageTarget,UNIT_STATE_MAX_LIFE)     <= R2I(GetUnitAbilityLevel(DamageSourceHero , FINISHING_BLOW_ABILITY_ID))  then
                set Damage.index.amount = 9999999
                call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", DamageTarget, "chest"))
            endif
        endif

        //Contract of the Living
        if IsContractLivingAvailable(DamageTarget) then
            call ActivateContractLiving(DamageTarget)
            set Damage.index.amount = 0
        endif

        //Last Breath
        set i = GetUnitAbilityLevel(DamageTarget, LAST_BREATHS_ABILITY_ID)
        if i > 0 then
            call LastBreath(DamageTarget, i)
        endif

        //call BJDebugMsg("MOD4.0 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction
    
    private function init takes nothing returns nothing
        set TrgModifyDamageAfter = CreateTrigger()
        call TriggerAddAction(TrgModifyDamageAfter, function ModifyDamageAfterArmor)
        call DamageTrigger.registerTrigger(TrgModifyDamageAfter, "Mod", 4.0)
    endfunction

endscope