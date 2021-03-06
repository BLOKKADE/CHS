scope ModifyDamageBeforeArmor initializer init

    globals
        trigger TrgModifyDamageBefore
    endglobals

    private function ModifyDamageBeforeArmor takes nothing returns nothing
        local real blockDamage = 0
        local real r1 = 0
        local integer i1 = 0
        local integer i = 0

        //Contract of the Living no damage
        if GetUnitAbilityLevel(DamageSource, CONTRACT_LIVING_BUFF_ID) > 0 or GetUnitAbilityLevel(DamageTarget, CONTRACT_LIVING_BUFF_ID) > 0 then
            set Damage.index.damage = 0
            return
        endif

        //Evasion & miss TODO: clean this up
        if (Damage.index.isAttack or GetUnitAbilityLevel(DamageTarget, 'B01T') > 0) and (GetUnitEvasion(DamageTarget) > 0 or GetUnitAbilityLevel(DamageSource, 'B027') > 0 or GetUnitMissChance(DamageSource) > 0) then
            call Evade()
            
            if Damage.index.damage == 0 then
                return
            endif
        endif

        //Extradimensional Cooperation
        if GetUnitAbilityLevel(DamageSource, EXTRADIMENSIONAL_COOPERATION_BUFF_ID) > 0 and (not DamageIsOnHit) and DamageSourceAbility != EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID then
            call CastExtradimensionalCoop(DamageSource, DamageTarget, Damage.index.damage, IsMagicDamage())
        endif

        if Damage.index.isAttack then

            //Arcane Assault
            set i1 = GetUnitAbilityLevel(DamageSource, ARCANE_ASSAUL_ABILITY_ID)
            if i1 > 0 and DamageSourceAbility != ARCANE_ASSAUL_ABILITY_ID then
                call ArcaneAssault(DamageSource, DamageTarget, DamageSourceAbility, Damage.index.damage, i1)
            //arcane infused sword
            elseif i1 == 0 and DamageSourceAbility != ARCANE_ASSAUL_ABILITY_ID and UnitHasItemS(DamageSource, 'I0BN') then
                call ArcaneAssault(DamageSource, DamageTarget, DamageSourceAbility, Damage.index.damage, 8)
            endif

            //Cloak of Sorrow
            if GetUnitAbilityLevel(DamageSource, 'B007') > 0 then
                set Damage.index.damage = Damage.index.damage - RMinBJ(BlzGetUnitBaseDamage(DamageSource, 0), 4000)
            endif

            //Cloak of Sorrow
            if GetUnitAbilityLevel(DamageSource, 'B00W') > 0 then
                set Damage.index.damage = Damage.index.damage - 100
            endif
        endif

        if Damage.index.damage <= 0 or ((GetUnitAbilityLevel(DamageTarget, 'B028') > 0 or GetUnitAbilityLevel(DamageTarget, BANISH_BUFF_ID) > 0) and IsPhysDamage()) then
            set Damage.index.damage = 0
            return
        endif

        //Divine Bubble
        set i1 = GetUnitAbilityLevel(DamageTarget,DIVINE_BUBBLE_ABILITY_ID)
        if i1 > 0 or UnitHasItemS(DamageTarget, 'I095') then
            if IsUnitDivineBubbled(DamageTarget) then
                call RemoveDebuff(DamageTarget, 1) 
                set DamageIsOnHit = true
            endif

            if (i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,DIVINE_BUBBLE_ABILITY_ID) <= 0.001) or (i1 == 0 and UnitHasItemS(DamageTarget, 'I095') and BlzGetUnitAbilityCooldownRemaining(DamageTarget,'A0AP') == 0) then
                set DamageIsOnHit = true
                call RemoveDebuff(DamageTarget, 1) 
                if UnitHasItemS(DamageTarget, 'I095') then
                    set i1 = 1
                else
                    set i1 = 0
                endif
                if UnitHasItemS(DamageTarget, 'I095') and GetUnitAbilityLevel(DamageTarget, DIVINE_BUBBLE_ABILITY_ID) == 0 then
                    if IsUnitDivineBubbled(DamageTarget) then
                        set GetDivineBubbleStruct(DamageTargetId).endTick = T32_Tick + (32 * i1)
                    else
                        call DivineBubbleStruct.create(DamageTarget, i1, 'A0AP')
                    endif
                else
                    if IsUnitDivineBubbled(DamageTarget) then
                        set GetDivineBubbleStruct(DamageTargetId).endTick = T32_Tick + (32 * (3 + i1))
                    else
                        //call BJDebugMsg("db: " + I2S(3 + i1))
                        call DivineBubbleStruct.create(DamageTarget, 3 + i1, DIVINE_BUBBLE_ABILITY_ID)
                    endif
                endif
            endif
        endif
/*
        //Damage Spread
        if 
            call PeriodicDamage.create(DamageSource, DamageTarget, 0.0333 * Damage.index.damage, true, 0.1, 8, 1, false, POISON_NON_STACKING_CUSTOM_BUFF_ID, ENVENOMED_WEAPONS_ABILITY_ID).addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 150, 1)
        endif
*/

        //Crushing Wave
        set i1 = GetUnitAbilityLevel(DamageSource, CRUSHING_WAVE_ABILITY_ID)
        if i1 > 0 and DamageSourceAbility == CRUSHING_WAVE_ABILITY_ID then
            call SetUnitState(DamageTarget, UNIT_STATE_MANA, GetUnitState(DamageTarget, UNIT_STATE_MANA) - (GetUnitState(DamageTarget, UNIT_STATE_MAX_MANA) * (0.05 + (0.005 * i1))))
        endif

        

        //Sword of Bloodthirst
        set i1 = UnitHasItemI(DamageSource, SWORD_OF_BLOODTHRIST_ITEM_ID)
        if i1 > 0 and IsPhysDamage() then
            set Damage.index.damage = Damage.index.damage + 900 * i1
        endif

        //Crits
        call SetCritDamage()

        //Searing Arrows
        set i1 = GetUnitAbilityLevel(DamageSource, SEARING_ARROWS_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and IsAbilityEnabled(DamageSource, SEARING_ARROWS_ABILITY_ID) then
            set r1 = GetUnitState(DamageSource, UNIT_STATE_MAX_MANA) * 0.08
            if GetUnitState(DamageSource, UNIT_STATE_MANA) > r1 then
                set DamageSourceAbility = SEARING_ARROWS_ABILITY_ID
                //call BJDebugMsg("sa: " + I2S(GetSpellValue(60, 30, i1)))
                call SetUnitState(DamageSource, UNIT_STATE_MANA, GetUnitState(DamageSource, UNIT_STATE_MANA) - r1)
                set Damage.index.damage = Damage.index.damage + GetSpellValue(60, 30, i1)
            endif
        endif

        //Cold Arrows
        set i1 = GetUnitAbilityLevel(DamageSource, COLD_ARROWS_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and IsAbilityEnabled(DamageSource, COLD_ARROWS_ABILITY_ID) then
            set r1 = GetUnitState(DamageSource, UNIT_STATE_MAX_MANA) * 0.04
            if GetUnitState(DamageSource, UNIT_STATE_MANA) > r1 then
                set DamageSourceAbility = COLD_ARROWS_ABILITY_ID
                call SetUnitState(DamageSource, UNIT_STATE_MANA, GetUnitState(DamageSource, UNIT_STATE_MANA) - r1)
                set Damage.index.damage = Damage.index.damage + GetSpellValue(20, 10, i1)
                call DummyOrder.create(DamageSource, GetUnitX(DamageSource), GetUnitY(DamageSource), GetUnitFacing(DamageSource), 4).addActiveAbility('A04X', 1, 852662).setAbilityRealField('A04X', ABILITY_RLF_DURATION_NORMAL, 2.8 + (0.2 * i1)).target(DamageTarget).activate()
            endif
        endif

        //Cutting
        set i1 = GetUnitAbilityLevel(DamageSource,CUTTING_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and GetRandomReal(1,100) < 20 * DamageSourceLuck then
            set Damage.index.damage = Damage.index.damage+ i1 * 100
            set DamageIsCutting = true
        endif

        //Storm Horn
        if GetUnitAbilityLevel(DamageTarget ,'B00B') >= 1 then
            if GetRandomReal(1,100) <= 14 * DamageTargetLuck then
                set Damage.index.damage = 0
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", DamageTarget, "chest"))
                return
            endif		
        endif

        //Aura of Immortality
        if GetUnitAbilityLevel(DamageTarget ,'B00D') >= 1 then
            if GetRandomInt(1,100) <= GetUnitAbilityLevel(DamageTargetHero  ,AURA_OF_IMMORTALITY_ABILITY_ID) then
                set Damage.index.damage = 0
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                return			
            endif		
        endif	

        //Null Void Orb
        if UnitHasItemS(DamageTarget, 'I0AL') then
            if GetRandomInt(1,100) <= 10 * DamageTargetLuck then
                set Damage.index.damage = 0
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                return			
            endif		
        endif


        //Dark Shield
        if UnitHasItemS( DamageTarget,'I060' )  then
            if Damage.index.damageType ==  DAMAGE_TYPE_NORMAL then
                if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08R') <= 0 then
                    call AbilStartCD(DamageTarget, 'A08R', 1)
                    set Damage.index.damage = 0
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                    return
                endif 
            else 
                if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08Q') <= 0 then
                    call AbilStartCD(DamageTarget, 'A08Q', 3)
                    set Damage.index.damage = 0
                    call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                    return
                endif 
            endif      
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08S') <= 0 then
                call AbilStartCD(DamageTarget, 'A08S', 6)
                call RemoveDebuff(DamageTarget, 1)  
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl", DamageTarget, "chest")) 
                return
            endif 
        endif 

         //Light Magic Shield
        if UnitHasItemS(DamageTarget,'I06K') and BlzGetUnitArmor(DamageTarget)<= 50  then
            set Damage.index.damage =   Damage.index.damage* 0.5
        endif

        //Centuar Archer passive
        if DamageSourceTypeId == CENTAUR_ARCHER_UNIT_ID and Damage.index.isAttack then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08T') <= 0 then
                call AbilStartCD(DamageSource, 'A08T', 2)
                call ElemFuncStart(DamageSource,CENTAUR_ARCHER_UNIT_ID)
                set Damage.index.damage = Damage.index.damage + (BlzGetUnitMaxHP(DamageTarget) * 0.06) + (Damage.index.damage * (1 + (0.05 * GetHeroLevel(DamageSource))))
                call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Human\\HCancelDeath\\HCancelDeath.mdl", DamageTarget, "chest"))
            endif
        endif  

        //Frost Circlet
        if GetUnitAbilityLevel(DamageSource, FROST_CIRCLET_ABILITY_ID) > 0 then

            if BlzGetUnitAbilityCooldownRemaining(DamageSource, FROST_CIRCLET_ABILITY_ID) == 0 and T32_Tick - ElementHitTick[DamageTargetId].integer[Element_Cold] < 64 then
                set Damage.index.damage = Damage.index.damage * 3
                call AbilStartCD(DamageSource, FROST_CIRCLET_ABILITY_ID, 2)
                call DummyOrder.create(DamageSource, GetUnitX(DamageTarget), GetUnitY(DamageTarget), GetUnitFacing(DamageSource), 2).addActiveAbility(STUN_ABILITY_ID, 1, 852095).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, 0.2).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_HERO, 0.2).target(DamageTarget).activate()
            endif

            if IsSpellElement(DamageSource, DamageSourceAbility, Element_Cold) then
                set ElementHitTick[DamageTargetId].integer[Element_Cold] = T32_Tick
            endif
        endif

        //Hero's Hammer
        set i1 = UnitHasItemI( DamageSource,'I064' )
        if i1 > 0 and Damage.index.damageType ==  DAMAGE_TYPE_NORMAL then 
            set Damage.index.damage = Damage.index.damage + (i1 * (3 * GetHeroStatBJ(GetHeroPrimaryStat(DamageSource), DamageSource, true)))
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\BallistaMissile\\BallistaMissileTarget.mdl", DamageTarget, "chest"))  
        endif

        //Hammer of Chaos
        if UnitHasItemS( DamageSource,'I06H' ) and Damage.index.isAttack then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource,'A04Y') <= 0 then
                call AbilStartCD(DamageSource,'A04Y', 8 )
                call USOrder4field(DamageSource,GetUnitX(DamageTarget),GetUnitY(DamageTarget),'A04R',"stomp",Damage.index.damage,ABILITY_RLF_DAMAGE_INCREASE,500,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,0.05,ABILITY_RLF_DURATION_NORMAL)
            endif       
        endif   

        //Tauren
        if DamageSourceTypeId == TAUREN_UNIT_ID then
            
            set r1 = 0
            set i1 = GetHeroLevel(DamageSource)
            loop
                if IsSpellElement(DamageSource, DamageSourceAbility, i) then
                    set r1 = r1 + ((0.05 + (0.0005 * i1)) * GetSpellElementCount(DamageSource, DamageSourceAbility, i))
                endif
                set i = i + 1
                exitwhen i > 12
            endloop
            set Damage.index.damage = Damage.index.damage * (1 + r1)
        endif

        //Cruelty
        set i1 = GetUnitAbilityLevel(DamageSource,CRUELTY_ABILITY_ID)
        if i1 > 0 and Damage.index.damageType ==  DAMAGE_TYPE_NORMAL and (BlzGetUnitAbilityCooldownRemaining(DamageSource,CRUELTY_ABILITY_ID) <= 0.001 or CheckTimerZero(DamageSourceHero,CRUELTY_ABILITY_ID) ) then
            set Damage.index.damage = Damage.index.damage + Damage.index.damage*(2.5 + I2R(i1)/ 2)
            call DestroyEffect( AddSpecialEffectTargetFix("Objects\\Spawnmodels\\Undead\\UndeadDissipate\\UndeadDissipate.mdl", DamageTarget, "chest"))
            if ZetoTimerStart(DamageSource,CRUELTY_ABILITY_ID) then
                call AbilStartCD(DamageSource,CRUELTY_ABILITY_ID, 6 )
            endif
        endif

        //Absolute Poison
        set i = GetUnitAbilityLevel(DamageSource, ABSOLUTE_POISON_ABILITY_ID)
        if i > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Poison) then
            set Damage.index.damage = Damage.index.damage * (1 + ((i * 0.01) * GetClassUnitSpell(DamageSource, Element_Poison)))
        endif

        //Trident of Pain
        if UnitHasItemS( DamageSource,'I061' )  then
            if Damage.index.damageType ==  DAMAGE_TYPE_NORMAL then
                if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08X') <= 0 then
                    call AbilStartCD(DamageSource, 'A08X', 12)
                    call ElemFuncStart(DamageSource,'I061')
                    set Damage.index.damage = Damage.index.damage * 2.6
                    call CreateTextTagTimer( R2S(Damage.index.damage) + "!",1,GetUnitX(DamageTarget),GetUnitY(DamageTarget),50,1)
                elseif BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08Y') <= 0 then
                    call AbilStartCD(DamageSource, 'A08Y', 12)
                    call ElemFuncStart(DamageSource,'I061')
                    set Damage.index.damage = Damage.index.damage * 2.6
                    call CreateTextTagTimer( R2S(Damage.index.damage) + "!",1,GetUnitX(DamageTarget),GetUnitY(DamageTarget),50,1)
                elseif BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08Z') <= 0 then
                    call AbilStartCD(DamageSource, 'A08Z', 12)
                    call ElemFuncStart(DamageSource,'I061')
                    set Damage.index.damage = Damage.index.damage * 2.6
                    call CreateTextTagTimer( R2S(Damage.index.damage) + "!",1,GetUnitX(DamageTarget),GetUnitY(DamageTarget),50,1)
                endif
            endif
        endif

        //Scorched Scimitar
        set i = GetUnitAbilityLevel(DamageSource, SCORCHED_SCIMITAR_ABILITY_ID)
        if i > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Fire) then
            set DamageTargetMagicRes = DamageTargetMagicRes * 0.7

            if IsPhysDamage() then
                set Damage.index.armorPierced = Damage.index.armorPierced + (GetUnitEffectiveArmor(DamageTarget) * 0.3)
                //call BJDebugMsg("ss armor pierce: " + R2S(Damage.index.armorPierced))
            endif
        endif

        //Ursa Warrior
        if DamageSourceTypeId == URSA_WARRIOR_UNIT_ID and Damage.index.isAttack then
            //call CastUrsaBleed(DamageSource, DamageTarget, Damage.index.damage, Damage.index.damageType !=  DAMAGE_TYPE_NORMAL)
            call SetBuff(DamageTarget,4,3)
            call PeriodicDamage.create(DamageSource, DamageTarget, Damage.index.damage/ 3, Damage.index.damageType ==  DAMAGE_TYPE_MAGIC, 1., 3, 0, true, BLEED_BUFF_ID, 0).addFx(FX_Bleed, "head").addLimit('A0A4', 150, 1)
        endif

        //Pvp Bonus
        if GetOwningPlayer(DamageTarget) != Player(11) and GetOwningPlayer(DamageSource) != Player(11) then
            set Damage.index.damage = Damage.index.damage+  (Damage.index.damage*(GetUnitPvpBonus(DamageSource)- GetUnitPvpBonus(DamageTarget)  )/ 100)
        endif 

        //Banish magic damage bonus
        if GetUnitAbilityLevel(DamageTarget, BANISH_BUFF_ID) > 0 and IsMagicDamage() then
            set Damage.index.damage =  Damage.index.damage * 1.5
        endif

        //Ice Armor
        if GetUnitAbilityLevel(DamageTarget,ICE_ARMOR_ABILITY_ID)> 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,ICE_ARMOR_ABILITY_ID) <= 0    then
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl", DamageTarget, "chest"))
            set Damage.index.damage =  Damage.index.damage / 5
            call AbilStartCD(DamageTarget,ICE_ARMOR_ABILITY_ID, 2.05 - 0.05 * I2R(GetUnitAbilityLevel(DamageTarget,ICE_ARMOR_ABILITY_ID)) )
        endif  

        //Blessed Protection
        set i1 = GetUnitAbilityLevel(DamageTarget, 'A0AF')
        if i1 > 0 then
            set Damage.index.damage =   Damage.index.damage / 10
        endif
        
        //Mega Speed
        if GetUnitAbilityLevel(DamageTarget, MEGA_SPEED_ABILITY_ID) > 0 then
            if T32_Tick - MegaSpeedLastAttack[DamageTargetId] > 6 * 32 then
                set MegaSpeedStartTimer[DamageTargetId] = T32_Tick
            endif

            set MegaSpeedLastAttack[DamageTargetId] = T32_Tick
        endif

        //Pit Lord
        /*if GetUnitTypeId(DamageSource) == PIT_LORD_UNIT_ID then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08V') <= 0 then
                call AbilStartCD(DamageSource, 'A08V', 2)
                call ElemFuncStart(DamageSource,PIT_LORD_UNIT_ID)
                call UsOrderU2 (DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A08N',"rainoffire", GetHeroLevel(DamageSource)* 40, GetHeroLevel(DamageSource)* 20, ABILITY_RLF_DAMAGE_HBZ2, ABILITY_RLF_DAMAGE_PER_SECOND_HBZ5)
            endif
        endif*/

        //Ogre Warrior Stomp block ignore
        if DamageSourceAbility == 'A047' and GetUnitBlock(DamageTarget) > 0 then
            call TempBonus.create(DamageTarget, BONUS_BLOCK,0 - GetUnitBlock(DamageTarget) * 0.2, 1)
        endif

        //Lich
        /*if GetUnitTypeId(DamageSource) == LICH_UNIT_ID and IsMagicDamage() then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08W') <= 0 then
                call AbilStartCD(DamageSource, 'A08W', 6)
                call ElemFuncStart(DamageSource,LICH_UNIT_ID)
                call UsOrderU2 (DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A03J',"frostnova", GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
            endif
        endif*/

        //Air Force
        if GetUnitAbilityLevel(DamageSourceHero  ,AIR_FORCE_ABILITY_ID) >= 1 then
            if GetUnitAbilityLevel(DamageTarget,'Bams') > 0 or GetUnitAbilityLevel(DamageTarget,ANTI_MAGIC_SHELL_BUFF_ID) > 0  then

                set Damage.index.damage =   Damage.index.damage  + (I2R(GetUnitAbilityLevel(DamageSourceHero  ,AIR_FORCE_ABILITY_ID))* GetHeroAgi(DamageSourceHero,true))/ 40
            else
                set Damage.index.damage =   Damage.index.damage  + (I2R(GetUnitAbilityLevel(DamageSourceHero  ,AIR_FORCE_ABILITY_ID))* GetHeroAgi(DamageSourceHero,true))/ 20
            endif
            call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl", DamageTarget, "chest"))		
        endif

        //Grom Hellscream
        if DamageSourceTypeId == ORC_CHAMPION_UNIT_ID then
            set Damage.index.damage = Damage.index.damage + GetHeroStr(DamageSourceHero, true) * 0.1 + (0.01 * GetHeroLevel(DamageSourceHero))
            call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", DamageTarget, "chest"))		
        endif

        //Robes of the Archmage
        if GetUnitAbilityLevel(DamageSource  ,'B00L') >= 1 and IsMagicDamage() then
            set DamageSourceMagicPower = DamageSourceMagicPower + (BlzGetUnitMaxMana(DamageTarget) - GetUnitState(DamageTarget, UNIT_STATE_MANA)) / 90000
        endif

        /*//Pit Lord Magic power for phys
        if GetUnitTypeId(DamageSource) == PIT_LORD_UNIT_ID and IsPhysDamage() and (DamageSourceMagicPower != 1 or GetUnitMagicDmg(DamageSource) > 0) then
            set r1 = 1 - RMaxBJ(0.25 * GetClassUnitSpell(DamageSource, Element_Water), 0)
            set Damage.index.damage = Damage.index.damage* ((DamageSourceMagicPower + GetUnitMagicDmg(DamageSource)/ 100) * r1))
        endif   */

        //Cold Arrow
        set i1 = GetUnitAbilityLevel(DamageTarget, COLD_ARROWS_STACKING_BUFF_ID)
        if i1 > 0 and GetRandomInt(1, 100) < 20 then
            set Damage.index.damage = Damage.index.damage * 2
            call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl", DamageTarget, "chest"))
        endif

        //Vigour Token
        set i1 = UnitHasItemI(DamageSource, VIGOUR_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitMaxHP(DamageSource) < BlzGetUnitMaxHP(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * 1 + (0.5 * i1)
        endif

        //Flimsy Token
        set i1 = UnitHasItemI(DamageSource, FLIMSY_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitArmor(DamageSource) < BlzGetUnitArmor(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * 1 + (0.5 * i1)
        endif

        //Spellbane Token
        set i1 = UnitHasItemI(DamageSource, SPELL_BANE_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitMaxMana(DamageSource) < BlzGetUnitMaxMana(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * 1 + (0.5 * i1)
        endif

        //Martial Theft
        set i1 = GetUnitAbilityLevel(DamageSource, MARTIAL_THEFT_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack then
            call CastMartialTheft(DamageSource, DamageTarget, i1)
        endif

        //Absolute Poison
        if GetUnitAbilityLevel(DamageSource, ABSOLUTE_POISON_ABILITY_ID) > 0 and GetUnitAbilityLevel(DamageSource, NULL_VOID_ORB_BUFF_ID) == 0  then
            call PoisonSpellCast(DamageSource, DamageTarget)
        endif

        if IsPhysDamage() and (not DamageIsOnHit) then
            //Incinerate
            set i1 = GetUnitAbilityLevel(DamageSource,INCINERATE_ABILITY_ID) + GetUnitAbilityLevel(DamageSource, 'A0C8')
            if i1 > 0 then
                if GetUnitAbilityLevel(DamageTarget,INCINERATE_CUSTOM_BUFF_ID) > 0 then
                    set r1 = i1 * 5 + LoadInteger(HT,DamageTargetId,- 300001)
                else
                    set r1 = i1 * 5
                endif
                call SaveInteger(HT,DamageTargetId,- 300001, R2I(r1))
                call SaveInteger(HT,DamageTargetId,- 300002,i1 * 100)
                call SaveUnitHandle(HT,DamageTargetId,- 300003, DamageSourceHero)
                call SaveInteger(HT,DamageTargetId,- 300004,T32_Tick)
                call SetBuff(DamageTarget,1,5)

                if Damage.index.damage > 0 then
                    set Damage.index.damage = Damage.index.damage+ r1
                endif
            endif
        endif

        //Rock Golem
        if DamageTargetTypeId == ROCK_GOLEM_UNIT_ID and BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0AH') == 0 then
            call AbilStartCD(DamageTarget, 'A0AH', 1)
            call ElementStartAbility(DamageTarget, ROCK_GOLEM_UNIT_ID)
            call DestroyEffect(AddSpecialEffectFix("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(DamageTarget), GetUnitY(DamageTarget)))
            call AreaDamagePhys(DamageTarget, GetUnitX(DamageTarget), GetUnitY(DamageTarget), GetUnitBlock(DamageTarget) * (0.49 + (0.01 * GetHeroLevel(DamageTarget))), 400, ROCK_GOLEM_UNIT_ID)
        endif

        //Spirit Link
        if GetUnitAbilityLevel(DamageTarget, SPIRIT_LINK_BUFF_ID) > 0 then
            set Damage.index.damage = DistributeSpiritLink(DamageTargetHero, Damage.index.damage)
        endif

        //Physical Power
        if IsPhysDamage() then
            set DamageSourcePhysPower = DamageSourcePhysPower + GetUnitPhysPow(DamageSource)
            if DamageSourcePhysPower != 0 then
                set Damage.index.damage = Damage.index.damage * (1 + (DamageSourcePhysPower * 0.01))
            endif
        endif

        if IsMagicDamage() then 
            //Magic Power
            if DamageSourceMagicPower != 1 or GetUnitMagicDmg(DamageSource) > 0 then
                set Damage.index.damage =   Damage.index.damage*(DamageSourceMagicPower + GetUnitMagicDmg(DamageSource)/ 100 )
                //call BJDebugMsg("src: " + GetUnitName(DamageSource) + "dmg: " + R2S(Damage.index.damage) + "magic pow: " + R2S((DamageSourceMagicPower + GetUnitMagicDmg(DamageSource)/ 100 )))
            endif   

            //Magic Resistance
            if GetUnitMagicDef(DamageTarget) > 0 then

                //Fatal Flaw
                set i1 = GetUnitAbilityLevel(DamageSource,FATAL_FLA_ABILITY_ID)
                if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, FATAL_FLA_ABILITY_ID) == 0 then
                    set DamageTargetMagicRes = DamageTargetMagicRes * (1 - (0.025 * i1))
                    call AbilStartCD(DamageSource, FATAL_FLA_ABILITY_ID, 3)
                endif

                //call BJDebugMsg("magic dmg pre prot: " + R2S(Damage.index.damage))
                set Damage.index.damage =   Damage.index.damage*( 50 /(50 + (GetUnitMagicDef(DamageTarget) * DamageTargetMagicRes)) )
                //call BJDebugMsg("magic dmg post prot: " + R2S(Damage.index.damage))
            endif
        endif

        //Block
        if GetUnitBlock(DamageTarget) != 0 and (not DamageIsTrue) then	
            set blockDamage = GetUnitBlock(DamageTarget)

            //Sword of Bloodthirst
            if UnitHasItemS(DamageSource, SWORD_OF_BLOODTHRIST_ITEM_ID) then
                set blockDamage = blockDamage * 0.7
            endif

            //call BJDebugMsg(GetUnitName(DamageTarget) + ", block:  " + R2S(GetUnitBlock(DamageTarget)) + ", calc: " + R2S(blockDamage))
            //Absolute Dark
            set i1 = GetUnitAbilityLevel(DamageSourceHero, ABSOLUTE_DARK_ABILITY_ID)
            if i1 > 0 and GetUnitAbilityLevel(DamageSourceHero, NULL_VOID_ORB_BUFF_ID) == 0 then
                set blockDamage = blockDamage * (1 - ((0.009 + (0.001 * i1)) * GetClassUnitSpell(DamageSourceHero, Element_Dark)))
            endif

            //Skeleton Warmage
            set i1 = GetUnitAbilityLevel(DamageSourceHero, BLACK_ARROW_PASSIVE_ABILITY_ID)
            if i1 > 0 and GetUnitAbilityLevel(DamageSource, 'A0AY') > 0 and GetRandomInt(1,100) < ((i1 + 10) * 0.5) * DamageSourceLuck then
                set blockDamage = 0
            endif

            //call BJDebugMsg("dmg: " + R2S(Damage.index.damage) + ", block after ad: " + R2S(blockDamage) + " new dmg: " + R2S(Damage.index.damage - blockDamage))
            set blockDamage = Damage.index.damage - blockDamage
            if blockDamage < 0 then
                set Damage.index.damage = 0
            else
                set Damage.index.damage = blockDamage
            endif
        endif

        //Demolish
        set i1 = GetUnitAbilityLevel(DamageSourceHero, DEMOLISH_ABILITY_ID)
        if i1 > 0 and IsPhysDamage() then
            set Damage.index.armorPierced = Damage.index.armorPierced + GetUnitEffectiveArmor(DamageTarget) * (0.05 + (0.005 * i1))
            //call BJDebugMsg("d armor pierce: " + R2S(Damage.index.armorPierced))
        endif

        //Titanium Spike
        if GetUnitAbilityLevel(DamageSource, TITANIUM_SPIKE_ABIL_ID) > 0 and GetUnitAbilityLevel(DamageTarget, TITANIUM_SPIKE_IMMUN_ABIL_ID) == 0 and IsPhysDamage() then
            set Damage.index.armorPierced = Damage.index.armorPierced + (GetUnitEffectiveArmor(DamageTarget) * 0.3)
            //call BJDebugMsg("ts armor pierce: " + R2S(Damage.index.armorPierced))
        endif

        //Wisdom Chestplate
        if IsMagicDamage() and UnitHasItemS(DamageTarget, WISDOM_CHESTPLATE_ITEM_ID) then 
            call ActivateWisdomChestplate(DamageTarget, Damage.index.damage)
        endif

        //Martial retribution
        if GetUnitAbilityLevel(DamageTarget, MARTIAL_RETRIBUTION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,MARTIAL_RETRIBUTION_ABILITY_ID) <= 0 then
            call MartialRetributionStore(DamageTarget, Damage.index.damage * 0.5)
        endif

        if (not DamageIsOnHit) and IsUnitEnemy(DamageTarget, GetOwningPlayer(DamageSource)) then   

            //Liquid Fire
            set i1 = GetUnitAbilityLevel(DamageSource,LIQUID_FIRE_ABILITY_ID)
            if IsPhysDamage() and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, LIQUID_FIRE_ABILITY_ID) == 0 then

                call SetBuff(DamageTarget,3,3)
                //call PerodicDmg(DamageSource,DamageTarget,40*i1 +  GetUnitMagicDmg(DamageSource)*5,0,1,3.01,LIQUID_FIRE_CUSTOM_BUFF_ID,Bfirst)
                call PeriodicDamage.create(DamageSource, DamageTarget, 40 * i1 + GetUnitMagicDmg(DamageSource)* 5, true, 1., 3, 0, false, LIQUID_FIRE_CUSTOM_BUFF_ID, LIQUID_FIRE_ABILITY_ID).addLimit(LIQUID_FIRE_ABILITY_ID, 150, 1)
            endif

            //Envenomed Weapons heroes
            set i1 = GetUnitAbilityLevel(DamageSource,ENVENOMED_WEAPONS_ABILITY_ID) + PoisonRuneBonus[DamageSourcePid]
            if (IsPhysDamage() or PoisonRuneBonus[DamageSourcePid] > 0) and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, ENVENOMED_WEAPONS_ABILITY_ID) == 0 then

                call SetBuff(DamageTarget,2,8)
                //call PerodicDmg(DamageSource,DamageTarget,10*i1,0.5,1,8.01,POISON_NON_STACKING_CUSTOM_BUFF_ID,Bfirst)
                call PeriodicDamage.create(DamageSource, DamageTarget, 30 * i1, true, 1., 8, 1, false, POISON_NON_STACKING_CUSTOM_BUFF_ID, ENVENOMED_WEAPONS_ABILITY_ID).addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 150, 1)
            endif

            //Qiulbeasts
            if DamageSourceTypeId == QUILBEAST_1_UNIT_ID then
                set i1 = GetUnitAbilityLevel(DamageSource, 'A0BF') + PoisonRuneBonus[DamageSourcePid]
                if (IsPhysDamage() or PoisonRuneBonus[DamageSourcePid] > 0) and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, ENVENOMED_WEAPONS_ABILITY_ID) == 0 then
                    call SetBuff(DamageTarget, 2, 8)
                    call PeriodicDamage.create(DamageSource, DamageTarget, 20 * i1, true, 1., 8, 1, false, POISON_NON_STACKING_CUSTOM_BUFF_ID, ENVENOMED_WEAPONS_ABILITY_ID).addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 150, 1)
                endif
            endif
        endif

        //Frostbite of the Soul
        set i1 = GetUnitAbilityLevel(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID)
        if i1 > 0 and IsHeroUnitId(DamageSourceTypeId) then
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID) <= 0 then
                call AbilStartCD(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID, 9)
                call AddCooldowns(DamageSource,0.95 + I2R(i1)* 0.05)
                set udg_NextDamageType = DamageType_Onhit
                set udg_NextDamageAbilitySource = FROSTBITE_OF_THE_SOUL_ABILITY_ID
                call Damage.applyMagic(DamageTarget, DamageSource, 200 * i1, DAMAGE_TYPE_MAGIC)
                call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", DamageSource, "chest"))
            endif
        endif 

        //Mystical armor
        set i1 = UnitHasItemI( DamageTarget,'I06E' )
        if i1 > 0  then
            if GetRandomReal(1,100)  <= i1 * 8 * DamageSourceLuck then
                if GetUnitState(DamageTarget,UNIT_STATE_MANA) >= 750 then
                    set RandomSpellLoc = Location(GetUnitX(DamageSource), GetUnitY(DamageSource))
                    call CastRandomSpell(DamageTarget, 0, DamageSource, RandomSpellLoc, true, 15)
                    call RemoveLocation(RandomSpellLoc)
                    set RandomSpellLoc = null
                    call SetUnitState(DamageTarget,UNIT_STATE_MANA,GetUnitState(DamageTarget,UNIT_STATE_MANA)- 750 )
                endif
            endif
        endif

        //call BJDebugMsg("MOD1.1 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgModifyDamageBefore = CreateTrigger()
        call TriggerAddAction(TrgModifyDamageBefore, function ModifyDamageBeforeArmor)
        call DamageTrigger.registerTrigger(TrgModifyDamageBefore, "Mod", 1.1)
    endfunction

endscope