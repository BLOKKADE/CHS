scope ModifyDamageBeforeArmor initializer init

    globals
        trigger TrgModifyDamageBefore
    endglobals

    private function ModifyDamageBeforeArmor takes nothing returns nothing
        local real blockDamage = 0
        local real r1 = 0
        local integer i1 = 0
        local integer i2 = 0
        local integer i = 0

         //Extradimensional Cooperation
         if GetUnitAbilityLevel(DamageSource, EXTRADIMENSIONAL_COOPERATION_BUFF_ID) > 0 and (not IsOnHitDamage()) and DamageSourceAbility != EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID then
            call CastExtradimensionalCoop(DamageSource, DamageTarget, Damage.index.damage, Damage.index.isAttack, IsMagicDamage())
        endif

        //Contract of the Living no damage
        if GetUnitAbilityLevel(DamageSource, CONTRACT_LIVING_BUFF_ID) > 0 or GetUnitAbilityLevel(DamageTarget, CONTRACT_LIVING_BUFF_ID) > 0 then
            set Damage.index.damage = 0
            return
        endif

        //Reincarnation
        if GetUnitAbilityLevel(DamageTarget, 'A0EP') > 0 then
            set Damage.index.damage = 0
            return
        endif

        //enhanced damage ignores everything but mana shield
        if Damage.index.damageType == DAMAGE_TYPE_ENHANCED then
            set Damage.index.armorPierced = BlzGetUnitArmor(DamageTarget)
            return
        endif

        //Faerie Dragon
        if GetUnitTypeId(Damage.target) == FAERIE_DRAGON_UNIT_ID then
            set Damage.index.damage = 0
            return
        endif

        //Conquerors Bamboo Stick
        if GetUnitAbilityLevel(DamageTarget, CONQ_BAMBOO_STICK_BUFF_ID) > 0 and DamageSourcePid != 11 and IsUnitType(DamageSource, UNIT_TYPE_HERO) == false and IsUnitType(DamageTarget, UNIT_TYPE_HERO) and BambooImmuneActive(DamageTargetId, GetHandleId(DamageSourceHero)) then
            //call BJDebugMsg("conq bamboo stick immune")
            set Damage.index.damage = 0
            return
        endif

        //Storm Horn
        if GetUnitAbilityLevel(DamageTarget ,'B00B') >= 1 then
            if GetRandomReal(1,100) <= 14 * DamageTargetLuck then
                set Damage.index.damage = 0
                if not IsFxOnCooldownSet(DamageTargetId, 'B00B', 1) then
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", DamageTarget, "chest"))
                endif
                return
            endif		
        endif

        //Aura of Immortality
        if GetUnitAbilityLevel(DamageTarget ,'B00D') >= 1 then
            if GetRandomInt(1,100) <= GetUnitAbilityLevel(DamageTargetHero  ,AURA_OF_IMMORTALITY_ABILITY_ID) then
                set Damage.index.damage = 0
                if not IsFxOnCooldownSet(DamageTargetId, 'B00D', 1) then
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                endif
                return			
            endif		
        endif	

        //Null Void Orb
        if UnitHasItemType(DamageTarget, NULL_VOID_ORB_ITEM_ID) then
            if GetRandomInt(1,100) <= 10 * DamageTargetLuck then
                set Damage.index.damage = 0
                if not IsFxOnCooldownSet(DamageTargetId, NULL_VOID_ORB_ITEM_ID, 1) then
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIlm\\AIlmTarget.mdl", DamageTarget, "chest"))
                endif
                return			
            endif		
        endif

        //Runic Bracer
        if UnitHasItemType(DamageTarget, 'I04C') then
            if IsMagicDamage() and BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0CP') == 0 then
                call RemoveUnitBuffs(DamageTarget, BUFFTYPE_NEGATIVE, false)
                call AbilStartCD(DamageTarget, 'A0CP', 10)
                set Damage.index.damage = 0
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                return
            endif

        //Dark Shield
        elseif UnitHasItemType( DamageTarget,'I060' )  then
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08S') <= 0 then
                call AbilStartCD(DamageTarget, 'A08S', 10)
                call RemoveUnitBuffs(DamageTarget, BUFFTYPE_NEGATIVE, false)  
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIta\\CrystalBallCaster.mdl", DamageTarget, "chest")) 
            endif 
            if IsPhysDamage() then
                if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08R') <= 0 then
                    call AbilStartCD(DamageTarget, 'A08R', 1)
                    set Damage.index.damage = 0
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                    return
                endif 
            else 
                if BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A08Q') <= 0 then
                    call AbilStartCD(DamageTarget, 'A08Q', 3)
                    set Damage.index.damage = 0
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                    return
                endif 
            endif      
        endif 

        // Light Magic Shield activate
        if UnitHasItemType(DamageTarget, LIGHT_MAGIC_SHIELD_ITEM_ID) then
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget, LIGHT_MAGIC_SHIELD_ABILITY_ID) == 0 and DistanceBetweenUnits(DamageTarget, DamageSource) > 300 + BlzGetUnitWeaponRealField(DamageTarget, UNIT_WEAPON_RF_ATTACK_RANGE, 0) then
                call AbilStartCD(DamageTarget, LIGHT_MAGIC_SHIELD_ABILITY_ID, 18)
                set Damage.index.damage = 0
                call TempAbil.create(DamageTarget, LIGHT_MAGIC_SHIELD_BUFF_ABILITY_ID, 3)
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\SpellShieldAmulet\\SpellShieldCaster.mdl", DamageTarget, "chest")) 
                return
            endif
        endif

        // Light Magic Shield damage immunity
        if GetUnitAbilityLevel(DamageTarget, LIGHT_MAGIC_SHIELD_BUFF_ABILITY_ID) > 0 then
            set Damage.index.damage = 0
            return
        endif

        //Strong Chestmail
        if UnitHasItemType(DamageTarget, 'I07P') and (not IsUnitType(DamageSource, UNIT_TYPE_HERO)) then
            set Damage.index.damage = StrongChestMailDamage(DamageTargetId, Damage.index.damage)
        endif

        //Divine Bubble
        set i1 = GetUnitAbilityLevel(DamageTarget,DIVINE_BUBBLE_ABILITY_ID)
        if i1 > 0 or UnitHasItemType(DamageTarget, LIGHT_RUNESTONE_ITEM_ID) then
            if IsUnitDivineBubbled(DamageTarget) then
                call RemoveUnitBuffs(DamageTarget, BUFFTYPE_NEGATIVE, false)

                if IsOnHitDamage() then
                    set Damage.index.damage = 0
                endif

                set DamageIsOnHit = 2
            endif

            if (i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,DIVINE_BUBBLE_ABILITY_ID) <= 0.001) or (i1 == 0 and UnitHasItemType(DamageTarget, LIGHT_RUNESTONE_ITEM_ID) and BlzGetUnitAbilityCooldownRemaining(DamageTarget,'A0AP') == 0) then
                set DamageIsOnHit = 2
                call RemoveUnitBuffs(DamageTarget, BUFFTYPE_NEGATIVE, false) 
                if UnitHasItemType(DamageTarget, LIGHT_RUNESTONE_ITEM_ID) then
                    set i1 = 1
                else
                    set i1 = 0
                endif
                if UnitHasItemType(DamageTarget, LIGHT_RUNESTONE_ITEM_ID) and GetUnitAbilityLevel(DamageTarget, DIVINE_BUBBLE_ABILITY_ID) == 0 then
                    if IsUnitDivineBubbled(DamageTarget) then
                        set GetDivineBubbleStruct(DamageTargetId).endTick = T32_Tick + (32 * i1)
                    else
                        call DivineBubbleStruct.create(DamageTarget, i1, 'A0AP')
                    endif
                else
                    if IsUnitDivineBubbled(DamageTarget) then
                        set GetDivineBubbleStruct(DamageTargetId).endTick = T32_Tick + (32 * (6 + i1))
                    else
                        //call BJDebugMsg("db: " + I2S(3 + i1))
                        call DivineBubbleStruct.create(DamageTarget, 6 + i1, DIVINE_BUBBLE_ABILITY_ID)
                    endif
                endif
            endif
        endif

        if Damage.index.damage <= 0 then
            set Damage.index.damage = 0
            return
        endif

        //Energy Bombardment
        if DamageSourceAbility == ENERGY_BOMBARDMENT_DUMMY_ABILITY_ID then
            set udg_NextDamageAbilitySource = ENERGY_BOMBARDMENT_ABILITY_ID
            call Damage.applyPhys(DamageSourceHero, DamageTarget, Damage.index.damage, true, true, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            set Damage.index.damage = 0
            return
        endif

        //Shadow dance - start shadow form
        set i1 = GetUnitAbilityLevel(DamageSource, SHADOW_DANCE_ABILITY_ID)
        if i1 > 0 and  BlzGetUnitAbilityCooldownRemaining(DamageSource,SHADOW_DANCE_ABILITY_ID) <= 0 and Damage.index.isAttack and not IsOnHitDamage() then
            if CalculateDistance(GetUnitX(DamageTarget), GetUnitX(DamageSource), GetUnitY(DamageTarget), GetUnitY(DamageSource)) < 230  then
                call UnitAddForm(DamageSource, FORM_SHADOW, 2.9 + I2R(i1)/ 10)
                call AbilStartCD(DamageSource,SHADOW_DANCE_ABILITY_ID, 13) 
            endif
        endif

        //Evasion & miss TODO: clean this up
        if (Damage.index.isAttack or GetUnitAbilityLevel(DamageTarget, 'B01T') > 0 or (UnitHasItemType(DamageTarget, SHADOW_BLADE_ITEM_ID) and UnitHasForm(DamageTarget, FORM_SHADOW))) and (GetUnitCustomState(DamageTarget, BONUS_EVASION) > 0 or GetUnitAbilityLevel(DamageSource, 'B027') > 0 or GetUnitCustomState(DamageSource, BONUS_MISSCHANCE) > 0) then
            call Evade()
            
            if Damage.index.damage == 0 then
                return
            endif
        endif

        if Damage.index.isAttack then

            //Arcane Assault
            set i1 = GetUnitAbilityLevel(DamageSource, ARCANE_ASSAUL_ABILITY_ID)
            if i1 > 0 and DamageSourceAbility != ARCANE_ASSAUL_ABILITY_ID then
                call ArcaneAssault(DamageSource, DamageTarget, DamageSourceAbility, Damage.index.damage, i1)
            //arcane infused sword
            elseif i1 == 0 and DamageSourceAbility != ARCANE_ASSAUL_ABILITY_ID and UnitHasItemType(DamageSource, ARCANE_INFUSED_SWORD_ITEM_ID) then
                call ArcaneAssault(DamageSource, DamageTarget, DamageSourceAbility, Damage.index.damage, 8)
            endif

            //Cloak of Sorrow
            if GetUnitAbilityLevel(DamageSource, 'B007') > 0 then
                set Damage.index.damage = RMaxBJ(300,  Damage.index.damage - 4000)
            endif

            //Cloak of Sorrow
            if GetUnitAbilityLevel(DamageSource, 'B00W') > 0 then
                set Damage.index.damage = Damage.index.damage - 100
            endif
        endif

        //Banish and Scroll of Transformation phys immunity and negative dmg ignore
        if Damage.index.damage <= 0 or (IsPhysDamage() and (GetUnitAbilityLevel(DamageTarget, 'B028') > 0 or (GetUnitAbilityLevel(DamageTarget, BANISH_BUFF_ID) > 0 and not (DamageSourceTypeId == PHOENIX_1_UNIT_ID or DamageSourceTypeId == HAWK_1_UNIT_ID)))) then
            set Damage.index.damage = 0
            return
        endif

        //Energy Shield
        set i1 = GetUnitAbilityLevel(DamageTargetHero, ENERGY_SHIELD_ABILITY_ID)
        set r1 = CalculateDistance(GetUnitX(DamageTargetHero), GetWidgetX(DamageSource), GetUnitY(DamageTargetHero), GetWidgetY(DamageSource))
        if i1 > 0 and GetUnitAbilityLevel(DamageTarget, ENERGY_SHIELD_BUFF_ID) > 0 and r1 >= 300 then
            set Damage.index.damage = Damage.index.damage * Pow((1 - (0.05 + (i1 * 0.01))),  r1 / 300)
        endif

        //Sword of Bloodthirst
        set i1 = GetUnitItemTypeCount(DamageSource, SWORD_OF_BLOODTHRIST_ITEM_ID)
        if i1 > 0 and IsPhysDamage() then
            set Damage.index.damage = Damage.index.damage + 900 * i1
        endif

        //Finger of Death
        if DamageSourceAbility == FINGER_OF_DEATH_ABILITY_ID then
            set r1 = GetHeroInt(DamageSource, true) * (0.5 * DamageSourceAbilityLevel)
            if Damage.index.damage < r1 then
                set Damage.index.damage = r1
            endif

            set FingerOfDeathTable.real[DamageTargetId] = Damage.index.damage * 0.25
        endif

        //Starfall
        if DamageSourceAbility == STARFALL_ABILITY_ID then
            if GetUnitAbilityLevel(DamageTarget, STARFALL_BUFF_ABILITY_ID) == 1 then
                set StarfallTable.real[DamageTargetId] = StarfallTable.real[DamageTargetId] + 0.05
                set Damage.index.damage = Damage.index.damage * (1 + StarfallTable.real[DamageTargetId])
            else
                set StarfallTable.real[DamageTargetId] = 0
            endif
            call TempAbil.create(DamageTarget, STARFALL_BUFF_ABILITY_ID, 3)
        endif

        //Crits
        call SetCritDamage()

        //Yeti cold based crit negation
        if DamageTargetTypeId == YETI_UNIT_ID and DamageIsCrit and GetRandomReal(0, 1) < 0.08 * GetUnitElementCount(DamageTarget, Element_Cold) then
            set Damage.index.damage = 0
            return
        endif

        //Shadow Dance
        set i1 = GetUnitAbilityLevel(DamageSource, SHADOW_DANCE_ABILITY_ID)
        if UnitHasForm(DamageSource, FORM_SHADOW) and i1 > 0 and Damage.index.isAttack then
            set Damage.index.damage = Damage.index.damage + 50 * i1
            if IsTerrainWalkable(GetWidgetX(DamageTarget) - 65 * CosBJ(GetUnitFacing(DamageTarget)), GetWidgetY(DamageTarget) - 65 * SinBJ(GetUnitFacing(DamageTarget))) then
                call SetUnitX(DamageSource, GetWidgetX(DamageTarget) - 65 * CosBJ(GetUnitFacing(DamageTarget)))
                call SetUnitY(DamageSource, GetWidgetY(DamageTarget) - 65 * SinBJ(GetUnitFacing(DamageTarget))) 
                call BlzSetUnitFacingEx( DamageSource, GetUnitFacing(DamageTarget))
            endif
        endif
    
        //Backstab
        set i1 = GetUnitAbilityLevel(DamageSource, BACKSTAB_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and not IsOnHitDamage() then
            if CalculateDistance(GetUnitX(DamageTarget), GetUnitX(DamageSource), GetUnitY(DamageTarget), GetUnitY(DamageSource)) < 220 and  RAbsBJ(GetUnitFacing(DamageTarget) - GetUnitFacing(DamageSource)) < 85 then
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl", DamageTarget, "chest"))
                set Damage.index.damage = Damage.index.damage * (1 +  0.05 * I2R(i2)) + 20 * i1
            endif
        endif

        //Crushing Wave
        if DamageSourceAbility == CRUSHING_WAVE_ABILITY_ID then
            call SetUnitState(DamageTarget, UNIT_STATE_MANA, GetUnitState(DamageTarget, UNIT_STATE_MANA) - (GetUnitState(DamageTarget, UNIT_STATE_MAX_MANA) * (0.05 + (0.005 * DamageSourceAbilityLevel))))
        endif

        //Demon Hunter
        if GetUnitTypeId(DamageSource) == DEMON_HUNTER_UNIT_ID and (IsMagicDamage() and CheckUnitHitCooldown(DamageTargetId, DEMON_HUNTER_UNIT_ID, 0.7) or IsPhysDamage()) then
            set r1 = RMinBJ(GetHeroLevel(DamageSource) * 20, GetUnitState(DamageTarget, UNIT_STATE_MANA))
            call SetUnitState(DamageTarget, UNIT_STATE_MANA, GetUnitState(DamageTarget, UNIT_STATE_MANA) - r1)
            call SetUnitState(DamageSource, UNIT_STATE_MANA, GetUnitState(DamageSource, UNIT_STATE_MANA) + r1)

            if not IsFxOnCooldownSet(DamageTargetId, DEMON_HUNTER_UNIT_ID, 1) then
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", DamageTarget, "head"))
            endif
        endif

        //Blizzard
        if DamageSourceAbility == BLIZZARD_ABILITY_ID then
            call UnitRemoveAbility(DamageTarget, 'BHbz')
        endif

        //Flame Strike
        if DamageSourceAbility == FLAME_STRIKE_ABILITY_ID then
            call UnitRemoveAbility(DamageTarget, FLAME_STRIKE_BUFF_ID)
        endif

        //Rain of Fire
        if DamageSourceAbility == RAIN_OF_FIRE_ABILITY_ID then
            call UnitRemoveAbility(DamageTarget, 'BNrf')
        endif

        //Monsoon
        set i1 = GetUnitAbilityLevel(DamageSource, MONSOON_ABILITY_ID)
        if i1 > 0 and DamageSourceAbility == MONSOON_ABILITY_ID then
            call SetUnitState(DamageTarget, UNIT_STATE_MANA, GetUnitState(DamageTarget, UNIT_STATE_MANA) - (GetUnitState(DamageTarget, UNIT_STATE_MAX_MANA) * (0.03)))
        endif

        //Acid Spray
        if DamageSourceAbility == ACID_SPRAY_ABILITY_ID then
            set r1 = GetHeroInt(DamageSourceHero, true) * (1.5 + (0.15 * DamageSourceAbilityLevel))
            if Damage.index.damage < r1 then
                set Damage.index.damage = r1
            endif
        endif

        //Pyromancer fire attack
        if DamageSourceTypeId == PYROMANCER_UNIT_ID and Damage.index.isAttack and DamageSourceAbility != PYROMANCER_UNIT_ID then
            set DamageSourceAbility = PYROMANCER_UNIT_ID 
        endif

        //Searing Arrows
        set i1 = GetUnitAbilityLevel(DamageSource, SEARING_ARROWS_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack and IsAbilityEnabled(DamageSource, SEARING_ARROWS_ABILITY_ID) then
            set r1 = GetUnitState(DamageSource, UNIT_STATE_MAX_MANA) * 0.08
            if GetUnitState(DamageSource, UNIT_STATE_MANA) > r1 then
                set DamageSourceAbility = SEARING_ARROWS_ABILITY_ID
                //call BJDebugMsg("sa: " + I2S(GetSpellValue(60, 30, i1)))
                call SetUnitState(DamageSource, UNIT_STATE_MANA, GetUnitState(DamageSource, UNIT_STATE_MANA) - r1)
                set Damage.index.damage = Damage.index.damage + GetSpellValue(60, 30, i1)
            else
                call ToggleSearingArrows(DamageSource)
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
            else
                call ToggleColdArrows(DamageSource)
            endif
        endif

        //Cutting
        set i1 = GetUnitAbilityLevel(DamageSource,CUTTING_ABILITY_ID)
        if i1 > 0 and Damage.index.isAttack then
            if GetRandomReal(1,100) < 20 * DamageSourceLuck then
            set Damage.index.damage = Damage.index.damage+ (i1 * 100) * (1 + 0.02 * GetHeroLevel(DamageSource))
            set DamageIsCutting = true
            endif

            if BlzGetUnitArmor(DamageTarget) >= 0 then
                call TempAbil.create(DamageTarget, CUTTING_BUFF_ABILITY_ID, 8.25 + (i1 * 1.75))
            call TempBonus.create(DamageTarget, BONUS_ARMOR, 0 - 3, 8.25 + (i1 * 1.75), CUTTING_BUFF_ABILITY_ID).addBuffLink(CUTTING_BUFF_ABILITY_ID).activate()
            endif
        endif

        //Ancient Blood
        set i1 = GetUnitAbilityLevel(DamageTarget, ANCIENT_BLOOD_ABILITY_ID)
        if i1 > 0 then
            call ActivateAncientBlood(DamageTarget, i1)
        endif

        if DamageSourceAbility == SHOCKWAVE_ABILITY_ID then
            call UpdateShockwaveDamageBonus(DamageSourceId, DamageTargetId)
            set Damage.index.damage = Damage.index.damage * GetShockwaveDamageBonus(DamageSourceId, DamageTargetId)
        endif

        // Carrion Swarm
        if DamageSourceAbility == CARRION_SWARM_ABILITY_ID then
            set Damage.index.damage = GetUnitState(DamageTarget, UNIT_STATE_MAX_LIFE) * (0.0462 + (0.0038 * DamageSourceAbilityLevel))
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
        set i1 = GetUnitItemTypeCount( DamageSource,'I064' )
        if i1 > 0 and IsPhysDamage() then 
            set Damage.index.damage = Damage.index.damage + (i1 * (3 * GetHeroStatBJ(GetHeroPrimaryStat(DamageSource), DamageSource, true)))
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\BallistaMissile\\BallistaMissileTarget.mdl", DamageTarget, "chest"))  
        endif

        //Hammer of Chaos
        if UnitHasItemType( DamageSource,'I06H' ) and Damage.index.isAttack then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource,'A04Y') <= 0 then
                call AbilStartCD(DamageSource,'A04Y', 3 )
                call DummyInstantCast4(DamageSource,GetUnitX(DamageTarget),GetUnitY(DamageTarget),'A04R',"stomp",Damage.index.damage,ABILITY_RLF_DAMAGE_INCREASE,500,ABILITY_RLF_CAST_RANGE ,1,ABILITY_RLF_DURATION_HERO,0.05,ABILITY_RLF_DURATION_NORMAL)
            endif       
        endif   

        //Tauren
        if DamageSourceTypeId == TAUREN_UNIT_ID then
            
            set r1 = 0
            set i = 1
            set i1 = GetHeroLevel(DamageSource)
            loop
                if IsSpellElement(DamageSource, DamageSourceAbility, i) then
                    //call BJDebugMsg("element: " + GetFullElementText(i))
                    //call BJDebugMsg("bonus: " + R2S((0.05 + (0.0005 * i1))) + " count: " + I2S(GetSpellElementCount(DamageSource, DamageSourceAbility, i))) 
                    set r1 = r1 + ((0.05 + (0.0005 * i1)) * GetUnitElementCount(DamageSource, i))
                endif
                set i = i + 1
                exitwhen i > Element_Maximum
            endloop
            //call BJDebugMsg("st bonus: " + R2S(1 + r1))
            set Damage.index.damage = Damage.index.damage * (1 + r1)
        endif

        //Absolute Poison
        set i = GetUnitAbilityLevel(DamageSource, ABSOLUTE_POISON_ABILITY_ID)
        if i > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Poison) then
            set Damage.index.damage = Damage.index.damage * (1.0138 + ((i * 0.0062) * GetUnitElementCount(DamageSource, Element_Poison)))
        endif

        if UnitColdRuneDmgBonus.real[DamageTargetId] != 0. then
            set Damage.index.damage = Damage.index.damage * (1 + UnitColdRuneDmgBonus.real[DamageTargetId])
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

        if DamageSourceAbility == 'A0CR' then
            set Damage.index.damage = GetHeroLevel(DamageSource) * 25
            call DoomGuardHellfireApply(DamageSource, DamageTarget)
        endif

        //Ursa Warrior
        if DamageSourceTypeId == URSA_WARRIOR_UNIT_ID and Damage.index.isAttack then
            //call CastUrsaBleed(DamageSource, DamageTarget, Damage.index.damage, Damage.index.damageType !=  DAMAGE_TYPE_NORMAL)
            call TempAbil.create(DamageTarget, 'A08O', 2)
            call PeriodicDamage.create(DamageSource, DamageTarget, Damage.index.damage/ 3, Damage.index.damageType ==  DAMAGE_TYPE_MAGIC, 1., 2, 0, true, BLEED_BUFF_ID, URSA_WARRIOR_UNIT_ID).addFx(FX_Bleed, "head").addLimit('A0A4', 40, 1).start()
        endif

        //Pvp Bonus
        if DamageTargetPid != 11 and DamageSourcePid != 11 then
            set Damage.index.damage = RMaxBJ(Damage.index.damage+  (Damage.index.damage*(GetUnitCustomState(DamageSource, BONUS_PVP)- GetUnitCustomState(DamageTarget, BONUS_PVP)  )/ 100), 0)
        endif 

        if Damage.index.damage <= 0 then
            set Damage.index.damage = 0
            return
        endif

        //Banish magic damage bonus
        if GetUnitAbilityLevel(DamageTarget, BANISH_BUFF_ID) > 0 and IsMagicDamage() then
            set Damage.index.damage = Damage.index.damage * 1.5
        endif

        //Ice Armor
        set i1 = GetUnitAbilityLevel(DamageTarget,ICE_ARMOR_SUMMON_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,ICE_ARMOR_SUMMON_ABILITY_ID) <= 0 then
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl", DamageTarget, "chest"))
            set Damage.index.damage = Damage.index.damage * 0.2
            call AbilStartCD(DamageTarget, ICE_ARMOR_SUMMON_ABILITY_ID, 2.05 - (0.05 * i1))
        endif

        //Ice Force
        set i1 = GetUnitAbilityLevel(DamageTarget,ICE_FORCE_ABILITY_ID)
        if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,ICE_FORCE_ABILITY_ID) <= 0 then
            set r1 = 500. / (500. + GetHeroInt(DamageTarget, true))
            call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\FrostBolt\\FrostBoltMissile.mdl", DamageTarget, "chest"))
            set Damage.index.damage = Damage.index.damage * r1
            call AbilStartCD(DamageTarget, ICE_FORCE_ABILITY_ID, 2.05 - (0.05 * i1))
            call UpdateAbilityDescriptionString(GetAbilityDescription(ICE_FORCE_ABILITY_ID, i1 - 1), Player(DamageTargetPid), GetDummySpell(DamageTarget, ICE_FORCE_ABILITY_ID), ",s01,", R2S((1 - r1) * 100.), i1)
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
        if GetUnitTypeId(DamageSource) == PIT_LORD_UNIT_ID then
            call CastPitlordRainOfFire(DamageSource, DamageTarget)
        endif

        //Ogre Warrior Stomp block ignore
        if DamageSourceAbility == 'A047' and GetUnitCustomState(DamageTarget, BONUS_BLOCK) > 0 then
            call TempBonus.create(DamageTarget, BONUS_BLOCK, 0 - GetUnitCustomState(DamageTarget, BONUS_BLOCK) * 0.2, 1, 'A047').activate()
        endif

        //Fan of Knives
        if DamageSourceAbility == FAN_OF_KNIVES_ABILITY_ID then
            set Damage.index.damage = FanOfKnivesDamageBonus(DamageSource, DamageTarget, Damage.index.damage, GetUnitAbilityLevel(DamageSource, FAN_OF_KNIVES_ABILITY_ID))
        endif

        if GetUnitAbilityLevel(DamageSource, 'A09T') != 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A09T') == 0 then
            call CastStaffOfLightning(DamageSource, DamageTarget)
        endif

        //Lich
        /*if GetUnitTypeId(DamageSource) == LICH_UNIT_ID and IsMagicDamage() then
            if BlzGetUnitAbilityCooldownRemaining(DamageSource, 'A08W') <= 0 then
                call AbilStartCD(DamageSource, 'A08W', 6)
                call ElemFuncStart(DamageSource,LICH_UNIT_ID)
                call DummyTargetCast2 (DamageSource,DamageTarget,GetUnitX(DamageSource),GetUnitY(DamageSource),'A03J',"frostnova", GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), GetHeroInt(DamageSource, true) + (GetHeroLevel(DamageSource)* 60), ABILITY_RLF_AREA_OF_EFFECT_DAMAGE,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_UFN2)
            endif
        endif*/

        //Hero Force
        set i1 = GetUnitAbilityLevel(DamageSourceHero, HERO_FORCE_ABILITY_ID)
        if i1 > 0 and CheckUnitHitCooldown(DamageTargetId, HERO_FORCE_ABILITY_ID, 0.3) then
            set i2 = GetHeroStatBJ(GetHeroPrimaryStat(DamageSourceHero), DamageSourceHero                                                                                                                                                                                                                       , true)
            if GetUnitAbilityLevel(DamageTarget, 'Bams') > 0 or GetUnitAbilityLevel(DamageTarget, ANTI_MAGIC_SHELL_BUFF_ID) > 0  then

                set Damage.index.damage = Damage.index.damage  + (i1 * i2)/ 40
            else
                set Damage.index.damage = Damage.index.damage  + (i1 * i2)/ 20
            endif

            if not IsFxOnCooldownSet(DamageTargetId, HERO_FORCE_ABILITY_ID, 1) then
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIlb\\AIlbSpecialArt.mdl", DamageTarget, "chest"))		
            endif
        endif

        //Naga Siren passive
        if DamageSourceTypeId == NAGA_SIREN_UNIT_ID and Damage.index.isSpell and (not IsOnHitDamage()) then
            set Damage.index.damage = Damage.index.damage + (GetAttackDamage(DamageSource) * (0.1 + (0.001 * GetHeroLevel(DamageSource))))
        endif

        //Grom Hellscream
        if GetUnitTypeId(DamageSourceHero) == ORC_CHAMPION_UNIT_ID and (not IsOnHitDamage()) then
            set Damage.index.damage = Damage.index.damage + (GetHeroStatBJ(GetHeroPrimaryStat(DamageSourceHero), DamageSourceHero, true) * (0.1 + (0.005 * GetHeroLevel(DamageSourceHero))))
            if not IsFxOnCooldownSet(DamageTargetId, ORC_CHAMPION_UNIT_ID, 1) then
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", DamageTarget, "chest"))		
            endif
        endif

        //Robes of the Archmage
        if GetUnitAbilityLevel(DamageSource  ,'B00L') >= 1 and IsMagicDamage() then
            set DamageSourceMagicPower = DamageSourceMagicPower + (BlzGetUnitMaxMana(DamageTarget) - GetUnitState(DamageTarget, UNIT_STATE_MANA)) / 90000
        endif

        /*//Pit Lord Magic power for phys
        if GetUnitTypeId(DamageSource) == PIT_LORD_UNIT_ID and IsPhysDamage() and (DamageSourceMagicPower != 1 or GetUnitCustomState(DamageSource, BONUS_MAGICPOW) > 0) then
            set r1 = 1 - RMaxBJ(0.25 * GetUnitElementCount(DamageSource, Element_Water), 0)
            set Damage.index.damage = Damage.index.damage* ((DamageSourceMagicPower + GetUnitCustomState(DamageSource, BONUS_MAGICPOW)/ 100) * r1))
        endif   */

        //Cold Arrow
        set i1 = GetUnitAbilityLevel(DamageTarget, COLD_ARROWS_STACKING_BUFF_ID)
        if i1 > 0 and GetRandomInt(1, 100) < 20 * DamageSourceLuck then
            set Damage.index.damage = Damage.index.damage * 2
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\FrostArmor\\FrostArmorDamage.mdl", DamageTarget, "chest"))
        endif

        //Vigour Token
        set i1 = GetUnitItemTypeCount(DamageSource, VIGOUR_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitMaxHP(DamageSource) < BlzGetUnitMaxHP(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * (1 + (0.5 * i1))
        endif

        //Flimsy Token
        set i1 = GetUnitItemTypeCount(DamageSource, FLIMSY_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitArmor(DamageSource) < BlzGetUnitArmor(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * (1 + (0.5 * i1))
        endif

        //Spellbane Token
        set i1 = GetUnitItemTypeCount(DamageSource, SPELL_BANE_TOKEN_ITEM_ID)
        if i1 > 0 and BlzGetUnitMaxMana(DamageSource) < BlzGetUnitMaxMana(DamageTarget) then
            set Damage.index.damage = Damage.index.damage * (1 + (0.5 * i1))
        endif

        //Conquerors Bamboo Stick
        if GetUnitAbilityLevel(DamageSource, CONQ_BAMBOO_STICK_BUFF_ID) > 0 and DamageTargetPid != 11 and BambooImmuneActive(DamageSourceId, GetHandleId(DamageTargetHero)) and IsUnitType(DamageTarget, UNIT_TYPE_HERO) == false then
            //call BJDebugMsg("conq bamboo stick dmg bonus")
            set Damage.index.damage = Damage.index.damage * 2
            return
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

        //Absolute Cold
        set i1 = GetUnitAbilityLevel(DamageSource, ABSOLUTE_COLD_ABILITY_ID)
        if i1 > 0 and GetUnitMoveSpeed(DamageTarget) == 150 then
            set AbsColdCdBonus.boolean[DamageTargetId] = true
            set Damage.index.damage = Damage.index.damage * 1 + ((0.05 + (0.005 * i1)) * GetUnitElementCount(DamageSource, Element_Cold))
            if not IsFxOnCooldownSet(DamageTargetId, ABSOLUTE_COLD_ABILITY_ID, 1) then
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIob\\AIobSpecialArt.mdl", DamageTarget, "chest"))
            endif	
        endif

        if IsPhysDamage() or IsSeerPassiveActivated(DamageSourceTypeId, DamageSource) and (not IsOnHitDamage()) and DamageSourceAbility != INCINERATE_ABILITY_ID then
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
                call TempAbil.create(DamageTarget, 'A06L', 8)

                if Damage.index.damage > 0 then
                    set Damage.index.damage = Damage.index.damage+ r1
                endif
            endif
        endif

        //Rock Golem
        if DamageTargetTypeId == ROCK_GOLEM_UNIT_ID and BlzGetUnitAbilityCooldownRemaining(DamageTarget, 'A0AH') == 0 then
            call AbilStartCD(DamageTarget, 'A0AH', 1)
            call ElementStartAbility(DamageTarget, ROCK_GOLEM_UNIT_ID)
            call DestroyEffect(AddLocalizedSpecialEffect("Abilities\\Spells\\Orc\\WarStomp\\WarStompCaster.mdl", GetUnitX(DamageTarget), GetUnitY(DamageTarget)))
            call AreaDamage(DamageTarget, GetUnitX(DamageTarget), GetUnitY(DamageTarget), GetUnitCustomState(DamageTarget, BONUS_BLOCK) * (0.49 + (0.01 * GetHeroLevel(DamageTarget))), 400, false, ROCK_GOLEM_UNIT_ID, false, false)
        endif

        //Spirit Link
        if GetUnitAbilityLevel(DamageTarget, SPIRIT_LINK_BUFF_ID) > 0 then
            set Damage.index.damage = DistributeSpiritLink(DamageTargetHero, Damage.index.damage)
        endif

        //Physical Power
        if IsPhysDamage() then
            set DamageSourcePhysPower = DamageSourcePhysPower + GetUnitCustomState(DamageSource, BONUS_PHYSPOW)
            if DamageSourcePhysPower != 0 then
                set Damage.index.damage = Damage.index.damage * (1 + (DamageSourcePhysPower * 0.01))
            endif
        endif

        // Arcane Strike. Snowww made this the new Absolute Arcane. Reverted it back and changed it a bit without many problems hopefully.
        set i1 = GetUnitAbilityLevel(DamageSource, ARCANE_STRIKE_ABILITY_ID)
        if i1 > 0 and not IsOnHitDamage() then
            set r1 = GetHeroTotalAbilitiesCooldown(DamageSource)

            set r1 = r1 * (i1 * 2)
            if r1 > Damage.index.damage * 3 then
                set r1 = Damage.index.damage * 3
            endif
            if r1 > 0 then
                set Damage.index.damage = Damage.index.damage + r1
                if not IsFxOnCooldownSet(DamageTargetId, ARCANE_STRIKE_ABILITY_ID, 1) then
                    call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Feedback\\ArcaneTowerAttack.mdl", DamageTarget, "chest"))
                endif		
            endif
        endif

        if IsMagicDamage() then 
            //Magic Power
            if DamageSourceMagicPower != 1 or GetUnitCustomState(DamageSource, BONUS_MAGICPOW) > 0 then
                set Damage.index.damage =   Damage.index.damage*(DamageSourceMagicPower + GetUnitCustomState(DamageSource, BONUS_MAGICPOW)/ 100 )
                //call BJDebugMsg("src: " + GetUnitName(DamageSource) + "dmg: " + R2S(Damage.index.damage) + "magic pow: " + R2S((DamageSourceMagicPower + GetUnitCustomState(DamageSource, BONUS_MAGICPOW)/ 100 )))
            endif   
        endif

        //Block
        if GetUnitCustomState(DamageTarget, BONUS_BLOCK) != 0 and (not DamageIsTrue) then	
            set blockDamage = GetUnitCustomState(DamageTarget, BONUS_BLOCK)

            
            if DamageIsSuddenDeath then
                set blockDamage = blockDamage / 2
            endif

            //Sword of Bloodthirst
            if UnitHasItemType(DamageSource, SWORD_OF_BLOODTHRIST_ITEM_ID) then
                set blockDamage = blockDamage * 0.7
            endif

            //call BJDebugMsg(GetUnitName(DamageTarget) + ", block:  " + R2S(GetUnitCustomState(DamageTarget, BONUS_BLOCK)) + ", calc: " + R2S(blockDamage))
            //Absolute Dark
            //set i1 = GetUnitAbilityLevel(DamageSourceHero, ABSOLUTE_DARK_ABILITY_ID)
            //if i1 > 0 and GetUnitAbilityLevel(DamageSourceHero, NULL_VOID_ORB_BUFF_ID) == 0 then
            //    set blockDamage = blockDamage * (1 - ((0.009 + (0.001 * i1)) * GetUnitElementCount(DamageSourceHero, Element_Dark)))
            //endif

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
        if IsMagicDamage() and UnitHasItemType(DamageTarget, WISDOM_CHESTPLATE_ITEM_ID) then 
            call ActivateWisdomChestplate(DamageTarget, Damage.index.damage)
        endif

        //Martial retribution
        if GetUnitAbilityLevel(DamageTarget, MARTIAL_RETRIBUTION_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(DamageTarget,MARTIAL_RETRIBUTION_ABILITY_ID) <= 0 then
            call MartialRetributionStore(DamageTarget, Damage.index.damage * 0.5)
        endif

        if (not IsOnHitDamage()) and IsUnitEnemy(DamageTarget, Player(DamageSourcePid)) and IsUnitSpellTargetCheck(DamageTarget, Player(DamageSourcePid)) then   

            //Liquid Fire
            set i1 = GetUnitAbilityLevel(DamageSource,LIQUID_FIRE_ABILITY_ID)
            if IsPhysDamage() or IsSeerPassiveActivated(DamageSourceTypeId, DamageSource) and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, LIQUID_FIRE_ABILITY_ID) == 0 then

                call TempAbil.create(DamageTarget, 'A06R', 3)
                //call PerodicDmg(DamageSource,DamageTarget,40*i1 +  GetUnitCustomState(DamageSource, BONUS_MAGICPOW)*5,0,1,3.01,LIQUID_FIRE_CUSTOM_BUFF_ID,Bfirst)
                call PeriodicDamage.create(DamageSource, DamageTarget, 80 * i1 + GetUnitCustomState(DamageSource, BONUS_MAGICPOW)* 10 + GetUnitCustomState(DamageSource, BONUS_PHYSPOW) * 10, true, 1., 3, 0, false, LIQUID_FIRE_CUSTOM_BUFF_ID, LIQUID_FIRE_ABILITY_ID).addLimit(LIQUID_FIRE_ABILITY_ID, 40, 1).start()
            endif

            //Envenomed Weapons heroes
            set i1 = GetUnitAbilityLevel(DamageSource,ENVENOMED_WEAPONS_ABILITY_ID) + PoisonRuneBonus[DamageSourcePid]
            if IsPhysDamage() or IsSeerPassiveActivated(DamageSourceTypeId, DamageSource) or (PoisonRuneBonus[DamageSourcePid] > 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Poison)) and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, ENVENOMED_WEAPONS_ABILITY_ID) == 0 then

                call TempAbil.create(DamageTarget, 'A06P', 8)
                //call PerodicDmg(DamageSource,DamageTarget,10*i1,0.5,1,8.01,POISON_NON_STACKING_CUSTOM_BUFF_ID,Bfirst)
                call PeriodicDamage.create(DamageSource, DamageTarget, 30 * i1, true, 1., 8, 1, false, POISON_NON_STACKING_CUSTOM_BUFF_ID, ENVENOMED_WEAPONS_ABILITY_ID).addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 40, 1).start()
            endif

            //Quillbeasts
            if DamageSourceTypeId == QUILBEAST_1_UNIT_ID then
                set i1 = GetUnitAbilityLevel(DamageSource, 'A0BF') + PoisonRuneBonus[DamageSourcePid]
                if (IsPhysDamage() or PoisonRuneBonus[DamageSourcePid] > 0) and i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, ENVENOMED_WEAPONS_ABILITY_ID) == 0 then
                    call TempAbil.create(DamageTarget, 'A06P', 8)
                    call PeriodicDamage.create(DamageSource, DamageTarget, 20 * i1, true, 1., 8, 1, false, POISON_NON_STACKING_CUSTOM_BUFF_ID, ENVENOMED_WEAPONS_ABILITY_ID).addLimit(ENVENOMED_WEAPONS_ABILITY_ID, 40, 1).start()
                endif
            endif
        endif

        if GetUnitAbilityLevel(DamageTarget, DRUNKEN_HAZE_BUFF_ID) != 0 and GetUnitAbilityLevel(DamageTarget, DRUNKEN_HAZE_IGNITE_BUFF_ID) == 0 and IsSpellElement(DamageSource, DamageSourceAbility, Element_Fire) then
            call StartDrunkenHazeIgnition(DamageSource, DamageTarget, DamageSourceAbility, Damage.index.damage)
        endif

        //Frostbite of the Soul
        set i1 = GetUnitAbilityLevel(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID)
        if i1 > 0 and IsHeroUnitId(DamageSourceTypeId) then
            if BlzGetUnitAbilityCooldownRemaining(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID) <= 0 then
                call AbilStartCD(DamageTarget,FROSTBITE_OF_THE_SOUL_ABILITY_ID, 9)
                call AddCooldowns(DamageSource,0.95 + I2R(i1)* 0.05)
                set udg_NextDamageType = DamageType_Onhit
                set udg_NextDamageAbilitySource = FROSTBITE_OF_THE_SOUL_ABILITY_ID
                call Damage.applyMagic(DamageTarget, DamageSource, 200 * i1, false, DAMAGE_TYPE_MAGIC)
                call DestroyEffect( AddLocalizedSpecialEffectTarget("Abilities\\Weapons\\FrostWyrmMissile\\FrostWyrmMissile.mdl", DamageSource, "chest"))
            endif
        endif 

        if Damage.index.isAttack and GetUnitAbilityLevel(DamageSource, TERRESTRIAL_GLAIVE_ABILITY_ID) != 0 and FilterListNotEmpty(DamageSource, TERRESTRIAL_GLAIVE_ABILITY_ID) and BlzGetUnitAbilityCooldownRemaining(DamageSource, TERRESTRIAL_GLAIVE_ABILITY_ID) == 0 then
            call CastTerrestrialGlaive(DamageSource, DamageTarget)
        endif

        //Mystical armor
        set i1 = GetUnitItemTypeCount( DamageTarget,'I06E' )
        if i1 > 0  then
            if GetRandomReal(1,100)  <= i1 * 8 * DamageSourceLuck then
                if GetUnitState(DamageTarget,UNIT_STATE_MANA) >= 750 then
                    set RandomSpellLoc = Location(GetUnitX(DamageSource), GetUnitY(DamageSource))
                    call CastRandomSpell(DamageTarget, 0, DamageSource, RandomSpellLoc, true, GetRandomInt(1, 20))
                    call RemoveLocation(RandomSpellLoc)
                    set RandomSpellLoc = null
                    call SetUnitState(DamageTarget,UNIT_STATE_MANA,GetUnitState(DamageTarget,UNIT_STATE_MANA)- 750 )
                endif
            endif
        endif

        //Magic Resistance
        if IsMagicDamage() and GetUnitCustomState(DamageTarget, BONUS_MAGICRES) > 0 then 

            //Fatal Flaw
            set i1 = GetUnitAbilityLevel(DamageSource,FATAL_FLA_ABILITY_ID)
            if i1 > 0 and BlzGetUnitAbilityCooldownRemaining(DamageSource, FATAL_FLA_ABILITY_ID) == 0 then
                set DamageTargetMagicRes = DamageTargetMagicRes * (1 - (0.025 * i1))
                call AbilStartCD(DamageSource, FATAL_FLA_ABILITY_ID, 3)
            endif

            //call BJDebugMsg("magic dmg pre prot: " + R2S(Damage.index.damage))
            set Damage.index.damage =   Damage.index.damage*( 50 /(50 + (GetUnitCustomState(DamageTarget, BONUS_MAGICRES) * DamageTargetMagicRes)) )
            //call BJDebugMsg("magic dmg post prot: " + R2S(Damage.index.damage))
        endif
        //call BJDebugMsg("MOD1.1 source: " + GetUnitName(DamageSource) + " target: " + GetUnitName(DamageTarget) + " dmg: " + R2S(Damage.index.damage))
    endfunction

    private function init takes nothing returns nothing
        set TrgModifyDamageBefore = CreateTrigger()
        call TriggerAddAction(TrgModifyDamageBefore, function ModifyDamageBeforeArmor)
        call DamageTrigger.registerTrigger(TrgModifyDamageBefore, "Mod", 1.1)
    endfunction

endscope