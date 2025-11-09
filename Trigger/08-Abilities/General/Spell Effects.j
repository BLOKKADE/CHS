library AbilityChannel requires RandomShit, ShadowBladeItem, BlessedStriders, AncientAxe, AncientDagger, AncientStaff, BlinkStrike, Cyclone, ChaosMagic, FrostBolt, SandOfTime, ResetTime, ExtradimensionalCooperation, Purge, AncientRunes, ShadowBootsHeroForm, HeroForm, Parasite, ContemporaryRunes, BloodstoneHeal

    function AbilityChannel takes unit caster, unit hero, unit target, real x, real y, integer abilId, integer lvl returns boolean
        
        //call BJDebugMsg("ac" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))

        //Mysterious Runestone
        if abilId == MYSTERIOUS_RUNESTONE_ABIL_ID then
            call CastMysteriousRunestone(hero)

        //Scroll of Transformation
        elseif abilId == SCROLL_OF_TRANSFORMATION_ABIL_ID then
            call CastScrollOfTransformation(hero)
            call CreateTextTagTimerColor("Scroll of Transformation!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)

        //Random Spell
        elseif abilId == RANDOM_SPELL_ABILITY_ID then
            //call BJDebugMsg("random spell: " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))
            if target != null then
                //call BJDebugMsg("target")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(caster, abilId, target, RandomSpellLoc, true, lvl)
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            elseif x != 0.00 and y != 0.00 then
                //call BJDebugMsg("point")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(caster, abilId, null, RandomSpellLoc, true, lvl)
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            endif

        //Contemporary Runes
        elseif abilId == CONTEMPORARY_RUNES_ABILITY_ID then
            call CastContemporaryRunes(hero, lvl)

        //Mana Starvation
        elseif abilId == MANA_STARVATIO_ABILITY_ID then
            call CreateTextTagTimerColor("Mana Starvation!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)
            call CastManaStarvation(hero, target, lvl)

        //Mountain Giant Taunt
        elseif abilId == MOUNTAIN_GIANT_TAUNT_ABILITY_ID then
            call OnTauntCast(caster)  
            call CreateTextTagTimerColor("Taunt!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)

        //Packing Tape
        elseif abilId == PACKING_TAPE_ABILITY_ID then
            call CastPackingTape(hero, target)
            call CreateTextTagTimerColor("Packing Tape!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)

        //Midas Touch
        elseif abilId == MIDAS_TOUCH_ABILITY_ID and SuddenDeathEnabled == false and (not IsUnitType(target, UNIT_TYPE_HERO)) then
            call CastMidasTouch(hero, target, lvl)
            call CreateTextTagTimerColor("Midas Touch!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        //Holy Light
        elseif abilId == HOLY_LIGHT_ABILITY_ID then
            call CastHolyLight(caster, target, lvl)

        //Parasite
        elseif abilId == PARASITE_ABILITY_ID then
            call CreateTextTagTimerColor("Parasite!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)
            call CastParasite(caster, target, lvl)

        //Lightning Shield
        elseif abilId == LIGHTNING_SHIELD_ABILITY_ID then
            call CastLightningShield(caster, target, lvl)

        //Plague
        elseif abilId == PLAGUE_ABILITY_ID then
            call CastPlague(caster, x, y, lvl)

        //Dousing Hex
        elseif abilId == DOUSING_HEX_ABILITY_ID then
            call CastDousingHex(hero, target, lvl)
            call CreateTextTagTimerColor("Dousing Hex!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        //Dark Seal
        elseif abilId == DARK_SEAL_ABILITY_ID then
            call CastDarkSeal(target, lvl)
            call CreateTextTagTimerColor("Dark Seal!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        //Destruction of Block
        elseif abilId == DESTRUCTION_BLOCK_ABILITY_ID then
            call CastDestrOfBlock(target, lvl)
            call CreateTextTagTimerColor("Destruction of Block!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        //Bloodlust
        elseif abilId == BLOODLUST_ABILITY_ID then
            call CastBloodlust(hero, target, lvl)

        //Inner Fire
        elseif abilId == INNER_FIRE_ABILITY_ID then
            call CastInnerFire(hero, target, lvl)

        //Battle Roar
        elseif abilId == BATTLE_ROAR_ABILITY_ID then
            call CastBattleRoar(hero, abilId, lvl)

        //Cyclone
        elseif abilId == CYCLONE_ABILITY_ID then
            call Cyclone(caster, x, y, lvl)

        //Ancient Axe
        elseif abilId == ANCIENT_AXE_ABIL_ID then
            call AncientAxe(hero)

        //Ancient Dagger
        elseif abilId == ANCIENT_DAGGER_ABIL_ID then
            call AncientDagger(hero)

        //Death Pact
        elseif abilId == DEATH_PACT_ABILITY_ID then
            call CastDeathPact(hero, target, lvl)

        //Ancient Staff
        elseif abilId == ANCIENT_STAFF_ABIL_ID then
            call AncientStaff(hero)

        //Full Restore 
        elseif abilId == FULL_RESTORE_ABIL_ID then
            call PotionHeal(GetUnitState(hero, UNIT_STATE_MAX_LIFE), GetUnitState(hero, UNIT_STATE_MAX_MANA))

        //Potion of Greater Healing
        elseif abilId == POTION_OF_GREATER_HEALING_ABIL_ID then
            call PotionHeal(500, 0)

        //Potion of Greater Mana
        elseif abilId == POTION_OF_GREATER_MANA_ABIL_ID then
            call PotionHeal(0, 200)

        //Super Potion of Healing
        elseif abilId == SUPER_POTION_OF_HEALING_ABIL_ID then
            call PotionHeal(1000, 0)

        //Super Potion of Mana
        elseif abilId == SUPER_POTION_OF_MANA_ABIL_ID then
            call PotionHeal(0, 600)

        //ShadowBlade
        elseif abilId == 'SBBB' then
            call ShadowBlade(hero)

        //Shadow Boots
        elseif abilId == 'BBGB' then
            call ShadowBoots(hero)   
            
        //Manifold staff cd
        elseif abilId == 'BBB9' then
            call AbilStartCD(caster, 'MSCD', 14)
            
        //Beastmaster's Bulwark
        elseif abilId == BULWARK_ABIL_ID then          
            call BulwarkBumRush(target)

        //Reset Time
        elseif abilId == RESET_TIME_ABILITY_ID then
            call ResetTime(hero)

        //Energy Trap
        elseif abilId == ENERGY_TRAP_ABILITY_ID then
            call CastEnergyTrap(caster, x, y, lvl)

        //Spirit Link
        elseif abilId == SPIRIT_LINK_ABILITY_ID then
            call CastSpiritLink(hero, lvl)

        //Blink Strike
        elseif abilId == BLINK_STRIKE_ABILITY_ID or abilId == 'A06I' then
            call BlinkStrike(caster, lvl)

        //Whirlwind
        elseif abilId == WHIRLWIND_ABILITY_ID then
            call CastWhirlwind(hero, x, y, lvl)

        //Extra dimensional cooperation
        elseif abilId == EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID then
            call ExtradimensionalCooperation(hero, abilId, lvl)

        //Frost Bolt
        elseif abilId == FROST_BOLT_ABILITY_ID then
            call UsFrostBolt(hero,target,120 * lvl * (1 + 0.25 * R2I(GetUnitElementCount(hero,Element_Dark))), GetUnitElementCount(hero,Element_Cold))

        //Sand of time
        elseif abilId == SAND_OF_TIME_ABILITY_ID then
            call CastSandOfTime(hero,1.75 + 0.25 * lvl)

        //Purge wait
        elseif abilId == PURGE_ABILITY_ID then
            call Purge(hero, target, lvl)

        //Eruption
        elseif abilId == ERUPTION_ABILITY_ID then
            call CastEruption(caster, x, y, lvl)

        //Dispel Magic
        elseif abilId == DISPEL_MAGIC_ABILITY_ID then
            call DispelMagicEffect(caster, x, y, lvl)

        //Divine Source
        elseif abilId == THE_DIVINE_SOURCE_ABIL_ID then
            call UseDivineSource(hero)
            call CreateTextTagTimerColor("Divine Source!", 0.8, GetUnitX(hero), GetUnitY(hero), 80, 2, 255, 255, 255)

        //Blessed Striders
        elseif abilId == BLESSED_STRIDERS_ABIL_ID then
            call UseBlessedStriders(hero)
            call CreateTextTagTimerColor("Blessed Striders!", 0.8, GetUnitX(hero), GetUnitY(hero), 80, 2, 255, 255, 255)

        // Death and Decay
        elseif abilId == DEATH_AND_DECAY_ABILITY_ID then
            call CastDeathAndDecay(hero, x, y, lvl)

        // Spirit Shackle (if you try to add a text tag here, it will cancel the ability's effect)
        //elseif abilId == SPIRIT_SHACKLE_ABILITY_ID then
            //call CreateTextTagTimerColor("Spirit Shackle!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Banish
        elseif abilId == BANISH_ABILITY_ID then
            call CreateTextTagTimerColor("Banished!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Unholy Frenzy
        elseif abilId == UNHOLY_FRENZY_ABILITY_ID then
            call CreateTextTagTimerColor("Unholy Frenzy!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Soul Burn (if you try to add a text tag here, it will cancel the ability's effect)
        //elseif abilId == SOUL_BURN_ABILITY_ID then
            //call CreateTextTagTimerColor("Soul Burn!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Entangling Roots (if you try to add a text tag here, it will cancel the ability's effect)
        //elseif abilId == ENTAGLING_ROOTS_ABILITY_ID then
            //call CreateTextTagTimerColor("Entangling Roots!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Curse
        elseif abilId == CURSE_ABILITY_ID then
            call CreateTextTagTimerColor("Curse!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        // Null Void Orb Ability 
        elseif abilId == NULL_VOID_ORB_ABIL_ID then
            call CreateTextTagTimerColor("Null Void Orb!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)

        // Bloodstone Ability 
        elseif abilId == BLOOD_STONE_ABIL_ID then
            call CreateTextTagTimerColor("Bloodstone!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)
            call StartBloodstoneHeal(caster, GetUnitState(caster, UNIT_STATE_MAX_LIFE) * 0.35)

        //Faerie Fire
        elseif abilId == FAERIE_FIRE_ABILITY_ID then
            call CreateTextTagTimerColor("Faerie Fire!", 0.8, GetUnitX(target), GetUnitY(target), 80, 2, 180, 0, 255)

        else
            return false
        endif

        return true
    endfunction
endlibrary

library SpellEffects initializer init requires MultiBonusCast, ChaosMagic, Urn, AbilityChannel, Cooldown, AncientRunes, DummySpell, ToggleSpell

    function SpellEffectActions takes nothing returns nothing
        local unit caster = GetTriggerUnit()
        local unit hero = PlayerHeroes[GetPlayerId(GetOwningPlayer(caster))]
        local unit target = GetSpellTargetUnit()
        local real targetX = GetSpellTargetX()
        local real targetY = GetSpellTargetY()
        local integer abilId = GetSpellAbilityId()
        local integer originalAbilId = GetOriginalSpellIfExists(caster, GetSpellAbilityId())
        local integer abilLvl
        local location spelLLoc = GetSpellTargetLoc()
        local boolean isDummySpell = abilId != originalAbilId
        local boolean abilityChanneled = false
        local integer i 
        //call BJDebugMsg("cx: " + R2S(GetUnitX(caster)) + " cy: " + R2S(GetUnitY(caster)) + " tx: " + R2S(targetX) + " ty: " + R2S(targetY))

        if not ToggleSpell(caster, abilId) then
            if (not HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) or GetOwningPlayer(caster) == Player(11)) then

                set abilId = originalAbilId
                set abilLvl = GetUnitAbilityLevel(caster, abilId)
                set abilityChanneled = AbilityChannel(caster, hero, target,targetX,targetY,abilId, abilLvl)

                //Druidic focus on immobilization
                if UnitHasItemType(hero, DRUIDIC_FOCUS_ITEM_ID) and (abilId == ENTAGLING_ROOTS_ABILITY_ID or abilId == ENSNARE_ABILITY_ID or abilId == 'A075') then
                    call DruidicFocusPhyspowerbonus(hero)
                endif
            
                if GetUnitTypeId(caster) != PRIEST_1_UNIT_ID and IsCastingAllowed(caster) then
                    //call BJDebugMsg("caster: " + GetUnitName(caster))
                    call ElementStartAbility(caster, abilId)

                    if (not abilityChanneled) and isDummySpell then
                        //call BJDebugMsg("channel")
                        call CastSpell(caster, target, abilId, abilLvl, GetAbilityOrderType(abilId), targetX, targetY).activate()
                    endif

                    if GetUnitAbilityLevel(caster, DRUIDIC_FOCUS_BUFF_ID) > 0 and T32_Tick - DruidicFocusLastTick[GetHandleId(caster)] > 320 then
                        call CastDruidicFocus(caster)
                    endif

                    if GetUnitAbilityLevel(caster, ABSOLUTE_POISON_ABILITY_ID) > 0 and IsSpellElement(caster, abilId, Element_Poison) and target != null and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                        call PoisonSpellCast(caster, target)
                    endif

                    if GetUnitAbilityLevel(caster, CHAIN_LIGHTNING_ABILITY_ID) > 0 then
                        call CastChainLightning(caster)
                    endif

                    if GetUnitAbilityLevel(caster, INNER_FIRE_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(caster, INNER_FIRE_ABILITY_ID) == 0 then
                        call CastInnerFireOnSpellCast(caster, GetUnitAbilityLevel(caster, INNER_FIRE_ABILITY_ID))
                    endif

                    if GetUnitAbilityLevel(caster, BLOODLUST_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(caster, BLOODLUST_ABILITY_ID) == 0 then
                        call CastBloodlustOnSpellCast(caster, GetUnitAbilityLevel(caster, BLOODLUST_ABILITY_ID))
                    endif

                    if GetUnitAbilityLevel(caster, FROST_ARMOR_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(caster, FROST_ARMOR_ABILITY_ID) == 0 then
                        if IsSpellElement(caster, abilId, Element_Water) or IsSpellElement(caster, abilId, Element_Cold) then
                            call CastFrostArmorOnSpellCast(caster, GetUnitAbilityLevel(caster, FROST_ARMOR_ABILITY_ID))
                        endif
                    endif

                    if GetUnitAbilityLevel(caster, BLOKKADE_SHIELD_ABIL_ID) > 0 then
                        call ActivateBlokkadeShield(caster)
                    endif

                    if GetUnitAbilityLevel(caster, 'B024') > 0 then
                        call GetRetaliationSource(caster, target, abilId, abilLvl)
                    endif

                    if GetUnitAbilityLevel(caster, DRIED_MUSHROOM_DUMMY_BUFF_ID) > 0 then
                        call DriedMushroomEffects(caster, abilId)
                    endif

                    if UnitHasItemType(caster, ARCANE_RUNESTONE_ITEM_ID) then
                        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (BlzGetAbilityManaCost(abilId, abilLvl - 1) * 0.3))
                    endif

                    if UnitHasItemType(caster, ORB_OF_ELEMENTS_ITEM_ID) then
                        call SetElementalOrbAbil(caster, abilId)
                    endif

                    if GetUnitTypeId(caster) == GNOME_MASTER_UNIT_ID then
                        call CastGnomePassive(caster)
                        call ElemFuncStart(caster, GNOME_MASTER_UNIT_ID)
                    endif

                    if abilId == ACTIVATE_AVATAR_ABILITY_ID then
                        call CastAvatar(caster, abilLvl)
                    endif

                    if abilId == SHADOW_STRIKE_ABILITY_ID then
                        call UnitAddTimeForm(caster,FORM_SHADOW, 1)
                        call CreateTextTagTimerColor("Shadow Strike!", 0.8, GetUnitX(DamageTarget), GetUnitY(DamageTarget), 80, 2, 180, 0, 255)
                    endif                

                    if abilId == URN_ABIL_ID then
                        call Urn(caster)
                        call CreateTextTagTimerColor("Urn of Memories!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)
                    endif   

                    /*if abilId == MYSTERIOUS_TALENT_ABILITY_ID then
                        call MysteriousTalentCast(caster)
                    endif*/

                    if abilId == 'A09Q' then
                        call StaffOfPowerCast(caster)
                    endif

                    if abilId == 'A0ER' then
                        call StoneHelmetCast(caster)
                    endif

                    if abilId == RUNE_MASTERY_ABILITY_ID then
                        call CastRuneMaster(caster)
                    endif

                    if abilId == MASK_OF_PROTECTION_ABIL_ID then
                        call MaskOfProtectionCast(caster)
                        call CreateTextTagTimerColor("Mask of Protection!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)
                    endif
        
                    if abilId == MASK_OF_VITALITY_ABIL_ID then
                        call MaskOfVitality(caster)
                    endif

                    if abilId == ANTI_MAGIC_FLAG_ABIL_ID then
                        call ActivateAntiMagicFlag(caster)
                        call CreateTextTagTimerColor("Anti-Magic Flag!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)
                    endif

                    if abilId == CONQ_BAMBOO_STICK_ABILITY_ID then
                        call CastConqBambooStick(caster)
                        call CreateTextTagTimerColor("Conqueror's Bamboo Stick!", 0.8, GetUnitX(caster), GetUnitY(caster), 80, 2, 255, 255, 255)
                    endif

                    if UnitHasItemType(caster, 'I03O') then
                        call ActivateMoonstone(caster)
                    endif

                    if UnitHasItemType(caster, 'I03R') then
                        call ActivateScepterOfConfusion(caster)
                    endif

                    //if IsAbilityCasteable(abilId, false) then
                       // Wizard's Gemstone
                        //if UnitHasItemType(caster, 'I0BQ') then
                            //if BlzGetUnitAbilityCooldownRemaining(caster, 'A0CS') == 0 then
                                //call ActivateStatRune(caster)
                                //call AbilStartCD(caster, 'A0CS', 5) 
                            //endif
                        //endif

                    if IsAbilityCasteable(abilId, false) then
                        //Wizard's Battlestone
                        if UnitHasItemType(caster, 'I0BX') then
                            if BlzGetUnitAbilityCooldownRemaining(caster, 'A0CS') == 0 then
                                call ActivateStatRune(caster)
                                call AbilStartCD(caster, 'A0CS', 5) 
                            endif
                        endif
                        
                        //multicast
                        if CanMulticast(caster, abilId) and IsSpellResettable(abilId) then
                            call MultiBonusCast(caster, target, abilId, GetAbilityOrder(abilId), spelLLoc)
                        endif
                    endif

                    set i = GetUnitAbilityLevel(caster, CHAOS_MAGIC_ABILITY_ID)
                    if i > 0 and BlzGetAbilityCooldown(abilId,GetUnitAbilityLevel(caster,abilId ) - 1) > 0 then
                        call CastRandomSpell(caster, abilId, target, spelLLoc, false, i)
                    endif

                    if GetUnitAbilityLevel(caster, OVERLOAD_ABILITY_ID) > 0 and (target != null or IsAbilityManifoldable(abilId)) and (not IsCurrentlyManifolding(caster)) then
                        call Overload(caster, target, abilId, abilLvl)
                    elseif GetUnitAbilityLevel(caster, 'A099') > 0 and (target != null or IsAbilityManifoldable(abilId)) and (not IsCurrentlyManifolding(caster)) then
                        call ManifoldStaff(caster, target, abilId, abilLvl)
                    endif

                    if GetUnitAbilityLevel(caster, SPELLBANE_TOKEN_BUFF_ID) > 0 then
                        call SpellbaneSpellCast(caster, abilId, abilLvl)
                    endif

                    if GetUnitAbilityLevel(caster, 'B02Z') > 0 then
                        call ArcaneAbsorptionGauntletsActivate(caster, abilId, target)
                    endif

                    if GetUnitTypeId(caster) == TIME_WARRIOR_UNIT_ID and IsAbilityCasteable(abilId, true) then
                        call ActivateXesilManaCostNegation(caster, abilId, abilLvl)
                    endif

                    call SetCooldown(caster, abilId, false) 
                endif
            endif
        endif

        call RemoveLocation(spelLLoc)
        set spelLLoc = null
        set caster = null
        set target = null
    endfunction


    //===========================================================================
    function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_SPELL_EFFECT)
        call TriggerAddAction( trg, function SpellEffectActions )
        set trg = null
    endfunction
endlibrary