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

        if Damage.index.amount == 0 then
            return
        endif

        //enhanced damage ignores everything
        if Damage.index.damageType == DAMAGE_TYPE_ENHANCED then
            return
        endif

        //call BJDebugMsg("MOD1.2 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))

        //Fishing Rod
        if UnitHasItemType(DamageSource,'I07T') and IsPhysDamage() and GetUnitAbilityLevel(DamageSource, ENTANGLING_ROOTS_BUFF_ID) == 0 then
            call FishingRod(DamageSource, DamageTarget)
        endif

        /*//Aura of Vulnerability
        if GetUnitAbilityLevel(DamageTarget ,'B00E') >= 1 then
            if GetRandomReal(0,100) <= 5 * luck then
                set Damage.index.amount = Damage.index.amount * (1 + (0.5 * GetUnitAbilityLevel(DamageSourceHero  ,AURA_OF_VULNERABILITY_ABILITY_ID))))
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\Darksummoning\\DarkSummonTarget.mdl", DamageTarget, "chest"))
            endif
        endif*/

        //Mask of Death
        if UnitHasItemType(DamageSourceHero, 'I04T') then
            set r2 = (Damage.index.amount * 0.25)
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Light Magic Shield
        if UnitHasItemType(DamageTarget,LIGHT_MAGIC_SHIELD_ITEM_ID) and BlzGetUnitArmor(DamageTarget)<= (50 + GetHeroLevel(DamageTarget))  then
            set Damage.index.amount = Damage.index.amount * 0.5
        endif

        //Medal of Honor
        if UnitHasItemType(DamageTargetHero, 'I04U') or UnitHasItemType(DamageSourceHero, 'I04U') then
            set Damage.index.amount = Damage.index.amount * 0.66
        endif

        //Decaying Scythe
        if GetUnitAbilityLevel(DamageTarget, DECAYING_SCYTHE_BUFF2_ID) > 0 then
            set Damage.index.damage = Damage.index.damage * 0.5
        endif

        //Conq Bamboo passive
        if GetUnitAbilityLevel(DamageTarget, CONQ_BAMBOO_STICK_ABILITY_ID) > 0 and DamageSourcePid != 8 then
            set Damage.index.damage = Damage.index.damage * 0.7
        endif

        //Blokkades Shield damage reduction
        if GetUnitAbilityLevel(DamageTarget, BLOKKADE_SHIELD_ABIL_ID) > 0 then

            //attack ignore
            if Damage.index.isAttack then
                set BlokShieldAttackCount[DamageTargetId] = BlokShieldAttackCount[DamageTargetId] + 1
                //call BJDebugMsg("bs ac: " + I2S(BlokShieldAttackCount[DamageTargetId]))
                if BlokShieldAttackCount[DamageTargetId] >= 3 then
                    set BlokShieldAttackCount[DamageTargetId] = 0
                    set Damage.index.damage = 0
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                    return
                endif
            endif
            
            //damage reduction
            if T32_Tick - BlokShieldDmgReductionTick[DamageTargetId] < 64 then
                //call BJDebugMsg("bs dmg red")
                set Damage.index.amount = Damage.index.amount * 0.2
            endif
        endif

        //Vampirism
        set r1 = GetUnitAbilityLevel(DamageSource,VAMPIRISM_ABILITY_ID)
        if r1 > 0 then
            set r2 = Damage.index.amount * (0.005 + 0.005 * r1 + GetUnitElementCount(DamageSource, Element_Blood)* 0.05 )
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

         //Bloodlust
         
         if GetUnitAbilityLevel(DamageSource, 'Bblo') != 0 then
            //does not work in team duels if you cast bloodlust on an other players units
             set r2 = Damage.index.amount * (0.0069 + (0.0031 * GetUnitAbilityLevel(PlayerHeroes[DamageSourcePid], BLOODLUST_ABILITY_ID)))
             set vampAmount = vampAmount + r2
             set vampCount = vampCount + 1
         endif

        //Soul Reaper
        if UnitHasItemType(DamageSource, 'I01C') and Damage.index.isAttack then
            set r2 = Damage.index.amount * 0.5
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Crypt lord Locust
        if DamageSourceTypeId == CRYPT_LORD_LOCUST_UNIT_ID then
            set vampAmount = vampAmount + Damage.index.amount
            set vampCount = vampCount + 1
        endif

        //Dreadlord Passive
        if GetUnitTypeId(DamageSourceHero) == DEADLORD_UNIT_ID then
            set r2 = Damage.index.amount * (0.02 * I2R(GetHeroLevel(DamageSourceHero)) )
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif	

        //Ghoul Passive
        if DamageSourceTypeId == GHOUL_UNIT_ID and Damage.index.isAttack and CheckUnitHitCooldown(DamageTargetId, GHOUL_UNIT_ID, 0.35) then
            //call BJDebugMsg(GetUnitName(DamageSource) + " Damage.index.isAttack " + GetUnitName(DamageTarget) + ": " + I2S(DamageTargetId))
            set i = GetHeroLevel(DamageSource)
            //set r2 = BlzGetUnitMaxHP(DamageTarget) * (0.025 + (0.00025 * i))
            set r2 = (GetWidgetLife(DamageTarget)/ 100) * (2.5 + (0.025 * i))
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
            set Damage.index.amount = Damage.index.amount + r2 
        endif

        //Bone Armor Skeleton Defender
        if UnitHasItemType(DamageTarget, 'I07O') then
            set i = GetBoneArmorStruct(GetHandleId(DamageTargetHero)).groupSize
            if i > 0 and IsHeroUnitId(DamageTargetTypeId) then
                if i > 12 then
                    set i = 12
                endif
                set Damage.index.amount = Damage.index.amount * (1 - (i * 0.08))
            endif
        endif

        //Wild Runestone
        if UnitHasItemType(DamageTargetHero, WILD_RUNESTONE_ITEM_ID) and IsUnitType(DamageTarget, UNIT_TYPE_HERO) == false then
            set Damage.index.amount = Damage.index.amount * 0.7
        endif
        
        //Magic Necklace of Absorption
        if GetUnitAbilityLevel(DamageTarget  ,'B00R') >= 1 and IsMagicDamage() then
            call SetUnitState(DamageTarget,UNIT_STATE_MANA,   GetUnitState( DamageTarget  , UNIT_STATE_MANA  )  + Damage.index.amount * 0.50 )
        endif

        //Bloody Axe
        if IsPhysDamage() and IsHeroUnitId(DamageTargetTypeId) == false then
            set i = GetUnitItemTypeCount( DamageSource,'I078') 
            if i > 0 then
            set r2 = Damage.index.amount * (0.25 * I2R(i))
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1  
            endif
        endif

        //Staff of Absolute Magic
        if GetUnitAbilityLevel(DamageSourceHero  ,'B00O') >= 1 and IsMagicDamage() then
            set r2 = Damage.index.amount * 0.33 
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1
        endif

        //Heavy Blow
        if GetUnitAbilityLevel(DamageSourceHero, HEAVY_BLOW_ABILITY_ID) > 0 and IsPhysDamage() and BlzGetUnitAbilityCooldownRemaining(DamageSourceHero,HEAVY_BLOW_ABILITY_ID) <= 0 then
            call AbilStartCD(DamageSourceHero,HEAVY_BLOW_ABILITY_ID,0.3)
            set Damage.index.amount = Damage.index.amount + 30 * GetUnitAbilityLevel(DamageSourceHero, HEAVY_BLOW_ABILITY_ID)
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Orc\\Devour\\DevourEffectArt.mdl", DamageTarget, "chest"))
        endif
        
        //Combustion
        if GetUnitAbilityLevel(DamageSourceHero, COMBUSTION_ABILITY_ID) > 0 and IsMagicDamage() and BlzGetUnitAbilityCooldownRemaining(DamageSourceHero,COMBUSTION_ABILITY_ID) <= 0 then
            call AbilStartCD(DamageSourceHero,COMBUSTION_ABILITY_ID,0.3)
            set Damage.index.amount = Damage.index.amount + 30 * GetUnitAbilityLevel(DamageSourceHero   ,COMBUSTION_ABILITY_ID)
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\RedDragonBreath\\RedDragonMissile.mdl", DamageTarget, "chest"))
        endif

        //Devastating Blow
        if GetUnitAbilityLevel(DamageSourceHero, DEVASTATING_BLOW_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSourceHero, DEVASTATING_BLOW_ABILITY_ID) <= 0 then
            call AbilStartCD(DamageSourceHero,DEVASTATING_BLOW_ABILITY_ID,5)
            set r1 = BlzGetUnitMaxHP(DamageTarget)
            set r2 = 50 * GetUnitAbilityLevel(DamageSourceHero, DEVASTATING_BLOW_ABILITY_ID) +  (r1 * 0.08)
            set udg_NextDamageAbilitySource = DEVASTATING_BLOW_ABILITY_ID
            call Damage.applyMagic(DamageSource, DamageTarget, r2, false, DAMAGE_TYPE_MAGIC)
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\Incinerate\\FireLordDeathExplode.mdl", DamageTarget, "chest"))
        endif
        
        //Frostmourne
        if GetUnitAbilityLevel(DamageSourceHero ,'A02C') >= 1 then
            set r2 = (Damage.index.amount / 4)	
            set vampAmount = vampAmount + r2
            set vampCount = vampCount + 1 
        endif
        
        //Heavy Mace
        set i = GetUnitItemTypeCount( DamageSource,'I07I') 
        if i > 0 then
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
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Objects\\Spawnmodels\\Other\\PandarenBrewmasterBlood\\PandarenBrewmasterBlood.mdl", DamageTarget, "chest"))
        endif 

        //Blademaster
        if DamageSourceTypeId == BLADE_MASTER_UNIT_ID and DamageSourceAbility != BLADE_STORM_DUMMY_ABILITY_ID and BladestormReady(DamageSource) and Damage.index.isAttack then
            call BladestormDamage(DamageSource, Damage.index.amount , IsMagicDamage())
        endif

        //call BJDebugMsg("src: " + GetObjectName(DamageSourceAbility))
        //Pyromancer
        if DamageSourceTypeId == PYROMANCER_UNIT_ID  and IsSpellElement(DamageSource, DamageSourceAbility, Element_Fire) then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A0B6') == 0 then
                call CreateScorches(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 149 + (1 * GetHeroLevel(DamageSource)))
            endif
        endif
        
        //Ogre Warrior
        if DamageSourceTypeId == OGRE_WARRIOR_UNIT_ID and DamageSourceAbility != 'A047' and (IsPhysDamage() or IsSpellElement(DamageSource, DamageSourceAbility, Element_Earth)) then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08U') <= 0 then
                call ElemFuncStart(DamageSource,OGRE_WARRIOR_UNIT_ID)
                call CheckProc(DamageSource, 400)
                set r1 = 6 - (0.5 * GetProcCheckCount())
                call AbilStartCD(DamageSource, 'A08U', RMaxBJ(r1, 0))
                //call BJDebugMsg("ow cd" + R2S(r1))
                call DummyInstantCast4(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 'A047', "stomp", GetHeroStr(DamageSource,true) + (60 * GetHeroLevel(DamageSource)), ABILITY_RLF_DAMAGE_INCREASE, 400, ABILITY_RLF_CAST_RANGE, 1, ABILITY_RLF_DURATION_HERO, 1, ABILITY_RLF_DURATION_NORMAL)
            endif
        endif

        //Lich
        //call BJDebugMsg("dmg source ability:" + GetObjectName(DamageSourceAbility))
        if DamageSourceTypeId == LICH_UNIT_ID and DamageSourceAbility != 'A03J' and (IsSpellElement(DamageSource, DamageSourceAbility, Element_Cold) or IsSpellElement(DamageSource, DamageSourceAbility, Element_Dark) or IsSpellElement(DamageSource, DamageSourceAbility, Element_Water)) and GetRandomInt(1, 100) < 25 * DamageSourceLuck then
            call ElemFuncStart(DamageSource,LICH_UNIT_ID)
            call DummyTargetCast2 (DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A03J',"frostnova", GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), GetHeroInt(DamageSource, true) * (1 + (0.01 * GetHeroLevel(DamageSource))), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
        endif

        //Magnetic Oscillation
        set i = GetUnitAbilityLevel(DamageTarget, MAGNET_OSC_ABILITY_ID)
        if i > 0 then
            //call BJDebugMsg("dmg sourceid: " + I2S(DamageSourceId) + " time: " + I2S(T32_Tick - MagnetOscHitTick[DamageSourceId]))
            if T32_Tick >= MagnetOscHitTick[DamageSourceId] then
                //call SetUnitVertexColor(DamageSource, 0, 255, 0, 255)
                set r1 = CalculateDistance(GetUnitX(DamageTarget), GetUnitX(DamageSource), GetUnitY(DamageTarget), GetUnitY(DamageSource))
                if r1 < 600 then
                    //call BJDebugMsg("mosc")
                    
                    set udg_NextDamageAbilitySource = MAGNET_OSC_ABILITY_ID
                    call Damage.apply(DamageTarget, DamageSource, GetSpellValue(30, 15, i), false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                    if IsAbilityEnabled(DamageTarget, MAGNET_OSC_ABILITY_ID) then
                        set MagnetOscHitTick[DamageSourceId] = T32_Tick + R2I((12.21 - (0.21 * i)) * 32)
                        call KnockbackTarget(DamageTarget, DamageSource, GetAngleToTarget(DamageTarget, DamageSource) * bj_RADTODEG, RAbsBJ(700 - r1), 600, false, false, false, false)
                    else
                        if r1 > 150 then
                            set MagnetOscHitTick[DamageSourceId] = T32_Tick + R2I((8.12 - (0.12 * i)) * 32)
                            call MoveToPoint(DamageTarget, DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget))
                        endif
                    endif
                endif
            endif
        endif

        //Spiked Shield bonus dmg
        set i1 = GetUnitAbilityLevel(DamageTarget, SPIKED_SHIELD_ABILITY_ID)
        if i1 > 0 then
            set r3 = 0
            if IsPhysDamage() then
                set r2 = 1 + (BlzGetUnitArmor(DamageTarget) * 0.01)
            endif

            if IsMagicDamage() then
                set r2 = 1 + (GetUnitCustomState(DamageTarget, BONUS_MAGICRES) * 0.01)
            endif
        else
            set r2 = 1
        endif

        if IsNotOnHitOrIsDivineBubbleOnHit() and Damage.index.amount > 0 then
            if IsPhysDamage() or IsSeerPassiveActivated(DamageSourceTypeId, DamageSource) then

                if not IsOnHitDamage() then
                    //Pulverize
                    set i = GetUnitAbilityLevel(DamageSource, PULVERIZE_ABILITY_ID)
                    if i > 0 and GetRandomReal(0, 100) <= 20 * DamageSourceLuck then
                        call DestroyEffect(AddLocalizedSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(DamageTarget),GetUnitY(DamageTarget) ))
                        call AreaDamage(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 100 * i + GetUnitCustomState(DamageSource, BONUS_BLOCK)/2, BlzGetAbilityRealLevelField(BlzGetUnitAbility(DamageSource,PULVERIZE_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT,i - 1), true, PULVERIZE_ABILITY_ID, true, false)
                    endif

                    //Destruction
                    set i = GetUnitAbilityLevel(DamageSource, DESTRUCTION_ABILITY_ID) 
                    if i > 0 and GetRandomReal(0, 100) <= 15 * DamageSourceLuck then
                        call DestroyEffect(AddLocalizedSpecialEffect(  "Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl" , GetUnitX(DamageTarget),GetUnitY(DamageTarget) ))
                        call AreaDamage(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 400 * i + GetHeroStatBJ(GetHeroPrimaryStat(DamageSource), DamageSource, true)/2, BlzGetAbilityRealLevelField(BlzGetUnitAbility(DamageSource,DESTRUCTION_ABILITY_ID), ABILITY_RLF_AREA_OF_EFFECT, i - 1), true, DESTRUCTION_ABILITY_ID, true, false)
                    endif
                    
                    //Bash
                    set i = GetUnitAbilityLevel(DamageSource, BASH_ABILITY_ID)  
                    if i > 0 and GetRandomReal(0, 100) <= I2R(i) * DamageSourceLuck and GetUnitAbilityLevel(DamageTarget, STUNNED_BUFF_ID) == 0 then
                        call DummyTargetCast1(DamageSource, DamageTarget, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 'A06T', "thunderbolt", i * 100 + GetHeroStr(DamageSourceHero,true) * 1.25, ABILITY_RLF_DAMAGE_HTB1 )
                    endif
                endif

                //Thorns
                if (GetUnitAbilityLevel(DamageTarget, 'B01C') > 0 and IsUnitType(DamageSource, UNIT_TYPE_MELEE_ATTACKER)) then
                    
                    set r1 = 1 - (0.01 * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) + GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID)))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = THORNS_AURA_ABILITY_ID
                    
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        set r3 = ((Damage.index.amount * ( 0.12 + (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) * 0.03))) * r1) * r2
                        //call BJDebugMsg("thorns: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                        //call MagicDamage(DamageTarget,DamageSource, , true)
                    else
                        set r3 = ((Damage.index.amount * ( 0.18 + (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) * 0.03))) * r1) * r2
                        //call BJDebugMsg("thorns: r1:" + R2S(1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                endif

                //Reflection
                if (GetUnitAbilityLevel(DamageTarget, 'B01O') > 0 and IsUnitType(DamageSource, UNIT_TYPE_RANGED_ATTACKER)) then
                    set r1 = 1 - (0.01 * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) + GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID)))
                    //call BJDebugMsg("ref: r1:" + R2S(r1) + " ttl: " + R2S((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.01)) * r1))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = REFLECTION_AUR_ABILITY_ID
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        set r3 = ((Damage.index.amount * (0.12 + (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.03))) * r1) * r2
                        //call BJDebugMsg("ref: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    else
                        set r3 = ((Damage.index.amount * (0.12 + (GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID) * 0.045))) * r1) * r2
                        //call BJDebugMsg("ref: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                endif
            endif

            if IsMagicDamage() then

                //call BJDebugMsg("trgt: " + GetUnitName(DamageTarget) + " attack: " + B2S(Damage.index.isAttack))

                //Wizardbane
                if GetUnitAbilityLevel(DamageTarget, 'B01B') > 0 then
                    set r1 = 1 - (0.01 * (GetUnitAbilityLevel(DamageTargetHero, THORNS_AURA_ABILITY_ID) + GetUnitAbilityLevel(DamageTargetHero, REFLECTION_AUR_ABILITY_ID)))
                    //call BJDebugMsg("wb: r1:" + R2S(r1) + " ttl: " + R2S((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.01)) * r1))
                    set udg_NextDamageType = DamageType_Onhit
                    set udg_NextDamageAbilitySource = WIZARDBANE_AURA_ABILITY_ID
                    if IsUnitType(DamageSource, UNIT_TYPE_HERO) then
                        set r3 = ((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.03)) * r1) * r2
                        //call BJDebugMsg("wb: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    else
                        set r3 = ((Damage.index.amount * (GetUnitAbilityLevel(DamageTargetHero, WIZARDBANE_AURA_ABILITY_ID) * 0.05)) * r1) * r2
                        //call BJDebugMsg("wb: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                        call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                    endif
                    //call BJDebugMsg("wb damage: " + R2S(r3) + " mult: " + R2S(r2) + " reduce: " + R2S(r1))
                    call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\Bolt\\BoltImpact.mdl", DamageSource, "chest"))
                endif
            endif

            //Spiked Carapaces
            set i = GetUnitAbilityLevel(DamageTarget, SPIKED_CARAPACE_ABILITY_ID)
            if i > 0 and Damage.index.isAttack then
                set udg_NextDamageType = DamageType_Onhit
                set udg_NextDamageAbilitySource = SPIKED_CARAPACE_ABILITY_ID
                //set r3 = (Damage.index.amount * (0.03 + (GetUnitAbilityLevel(DamageTargetHero, SPIKED_CARAPACE_ABILITY_ID) * 0.009))) * r2
                set r3 = ((BlzGetUnitArmor(DamageTarget) * 0.10) * i)
                //call BJDebugMsg("sc: r1:" + R2S(r1) + "ss bonus: " + R2S(r2) + " total: " + R2S(r3))
                call Damage.apply(DamageTarget, DamageSource, r3, false, true, null, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
            endif  

            //Volcanic Armor
            if UnitHasItemType(DamageTarget, 'I03T') and GetUnitAbilityLevel(DamageSource, STUNNED_BUFF_ID) == 0 and GetRandomInt(1,100) <= 15 *  DamageTargetLuck then
                call ActivateVolcanicArmor(DamageSource, DamageTarget)
            endif

            //Spiked Shield heal
            if i1 > 0 and r3 != 0 then
                //call BJDebugMsg("ss heal: " + R2S(r3 * 0.1))
                call SetUnitState(DamageSource, UNIT_STATE_LIFE, GetUnitState(DamageSource, UNIT_STATE_LIFE) + (r3 * 0.1))
            endif

            //Dark Hunter Bash
            if DamageSourceTypeId == DARK_HUNTER_UNIT_ID and GetRandomInt(0, 100) <= 20 * DamageSourceLuck and GetUnitAbilityLevel(DamageTarget, STUNNED_BUFF_ID) == 0 then
                set r1 = GetHeroLevel(DamageSource) * 50
                set r2 = DarkHunterStun.real[DamageSourceId]
                if CheckUnitHitCooldown(DamageTargetId, DARK_HUNTER_UNIT_ID, r2 + 0.4) then
                    call ApplyDarkHunterStun(DamageSource, DamageTarget, r1, r2)
                endif
            endif
        endif

        if vampCount > 0 and Damage.index.amount > 0 then
            if not IsFxOnCooldownSet(DamageSourceId, 0, 1) then
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", DamageSource, "chest"))
            endif
            call Vamp(DamageSource, DamageTarget, vampAmount)
        endif
        
        //Banshee passive
        if DamageTargetTypeId == BANSHEE_UNIT_ID then
            if Damage.index.amount >= GetUnitState(DamageTarget,UNIT_STATE_MANA) then
                call SetUnitState(DamageTarget,UNIT_STATE_MANA,0)
                set Damage.index.amount = GetUnitState(DamageTarget,UNIT_STATE_MAX_LIFE) + 1
            else
                call SetUnitState(DamageTarget,UNIT_STATE_MANA,GetUnitState(DamageTarget,UNIT_STATE_MANA) - Damage.index.amount)     
                set Damage.index.amount = 0
            endif 
        endif

        //War Golem
        if DamageTargetTypeId == WAR_GOLEM_UNIT_ID then
            set r1 = BlzGetUnitMaxHP(DamageTarget)
            if r1 > 100000 and Damage.index.amount > r1 * 0.1 then
                set Damage.index.amount = r1 * 0.1
            endif
        endif

        //Holy Chain Mail
        if UnitHasItemType(DamageTarget,'I07U') then   
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
        if DamageTargetTypeId == SKELETON_BRUTE_UNIT_ID then
            //Invul dmg negation
            if GetUnitAbilityLevel(DamageTarget, 'A0BB') > 0 then
                set Damage.index.amount = 0
            endif

            //make invul
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0BA') == 0 and Damage.index.amount > BlzGetUnitMaxHP(DamageTarget) * 0.2 and GetUnitAbilityLevel(DamageTarget, 'A0BB') == 0 then
                call SkeletonBrute(DamageTarget)
            endif
        endif

        //Murloc Warrior
        if DamageTargetTypeId == MURLOC_WARRIOR_UNIT_ID and GetHeroStr(DamageTarget, true) < 2147483647 then
            set i1 = 1 + GetHeroLevel(DamageTarget)/ 10 
            call SaveInteger(HT,DamageTargetId,54021,i1 + LoadInteger(HT,DamageTargetId,54021))
            call SetHeroStr(DamageTarget,GetHeroStr(DamageTarget,false)+ i1,false)
            call SetHeroAgi(DamageTarget,GetHeroAgi(DamageTarget,false)+ i1,false)
            call SetHeroInt(DamageTarget,GetHeroInt(DamageTarget,false)+ i1,false)
        endif

        //Decaying Scythe
        if GetUnitAbilityLevel(DamageSource, DECAYING_SCYTHE_ABILITY_ID) > 0 and T32_Tick - DecayingScytheTick[DamageTargetId] > 192 then
            
            call DummyOrder.create(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), GetUnitFacing(DamageSource), 2).addActiveAbility(DECAYING_SCYTHE_DUMMY_ABILITY_ID, 1, 852189).target(DamageTarget).activate()
            set DecayingScytheTick[DamageTargetId] = T32_Tick
            if GetUnitAbilityLevel(DamageSource, ABSOLUTE_POISON_ABILITY_ID) == 0 then
                set r2 = GetUnitPositiveHpRegen(DamageTarget)
                set r3 = r2 * 0.6

                if r2 - r3 < 0 then
                    set r3 = RMaxBJ(r3 + (r2 - r3), 0)
                endif
                if r3 > 0 then
                    call TempBonus.create(DamageTarget, BONUS_NEGATIVEHPREGEN, r3, 7, DECAYING_SCYTHE_ABILITY_ID).addBuffLink(DECAYING_SCYTHE_BUFF_ID).activate()
                endif
                //call BJDebugMsg("regen red: " + R2S(r3))
            endif
        endif

        //Flimsy Token
        if UnitHasItemType(DamageTarget, FLIMSY_TOKEN_ITEM_ID) and GetUnitAbilityLevel(DamageSource, FLIMSY_TOKEN_BUFF_ID) == 0 then
            call FlimsyToken(DamageTarget, DamageSource)
        endif

        //Stone Protection
        set i1 = GetUnitAbilityLevel(DamageTarget, STONE_PROTECTION_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,STONE_PROTECTION_ABILITY_ID) == 0 then
            call CastStoneProtect(DamageTarget, DamageSource)
        endif
        
        //Thunder Force
        set i1 = GetUnitAbilityLevel(DamageSource, THUNDER_FORCE_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and BlzGetUnitAbilityCooldownRemaining(DamageSource,THUNDER_FORCE_ABILITY_ID) == 0 then
            call AbilStartCD(DamageSource, THUNDER_FORCE_ABILITY_ID, 0.5)
            call DummyTargetCast1(DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A02R',"chainlightning",  GetHeroAgi(DamageSource,true) * (0.2 + (0.08 * i1)), ABILITY_RLF_DAMAGE_PER_TARGET_OCL1 )
        endif

        //Finishing Blow
        set i1 = GetUnitAbilityLevel(DamageSourceHero, FINISHING_BLOW_ABILITY_ID)
        if Damage.index.amount > 0 and i1 > 0 then
            if 100 *(GetWidgetLife(DamageTarget)- Damage.index.amount)/ GetUnitState(DamageTarget,UNIT_STATE_MAX_LIFE) <= (i1 * 0.7) then
                set Damage.index.amount = 9999999
                if not IsFxOnCooldownSet(DamageTargetId, FINISHING_BLOW_ABILITY_ID, 1) then
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl", DamageTarget, "chest"))
                endif
            endif
        endif

        //Contract of the Living
        if IsContractLivingAvailable(DamageTarget, Damage.index.amount) then
            call ActivateContractLiving(DamageTarget)
            set Damage.index.amount = 0
        endif

        //call BJDebugMsg("MOD4.0 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction
    
    private function init takes nothing returns nothing
        set TrgModifyDamageAfter = CreateTrigger()
        call TriggerAddAction(TrgModifyDamageAfter, function ModifyDamageAfterArmor)
        call DamageTrigger.registerTrigger(TrgModifyDamageAfter, "Mod", 4.0)
    endfunction

endscope