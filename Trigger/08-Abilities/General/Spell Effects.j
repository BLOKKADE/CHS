library AbilityChannel requires RandomShit,ShadowBladeItem, AncientAxe, AncientDagger, AncientStaff, BlinkStrike, Cyclone, ChaosMagic, FrostBolt, SandOfTime, ResetTime, ExtradimensionalCooperation, Purge, AncientRunes, HeroForm, Parasite, ContemporaryRunes

    function AbilityChannel takes unit caster, unit hero, unit target, real x, real y, integer abilId, integer lvl returns boolean
        //call BJDebugMsg("ac" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))

        //Mysterious Runestone
        if abilId == 'A072' then
            call CastMysteriousRunestone(hero)
            return true
        //Scroll of Transformation
        elseif abilId == 'A049' then
            call CastScrollOfTransformation(hero)
            return true
        //Random Spell
        elseif abilId == RANDOM_SPELL_ABILITY_ID then
            //call BJDebugMsg("random spell: " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))
            if target != null then
                //call BJDebugMsg("target")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(hero, abilId, target, RandomSpellLoc, true, lvl)
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            elseif x != 0.00 and y != 0.00 then
                //call BJDebugMsg("point")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(hero, abilId, null, RandomSpellLoc, true, lvl)
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            endif
            return true
        //Contemporary Runes
        elseif abilId == CONTEMPORARY_RUNES_ABILITY_ID then
            call CastContemporaryRunes(hero, lvl)
            return true
        //Mana Starvation
        elseif abilId == MANA_STARVATIO_ABILITY_ID then
            call CastManaStarvation(hero, target, lvl)
            return true
        elseif abilId == PACKING_TAPE_ABILITY_ID then
            call CastPackingTape(hero, target)
            return true
            //Midas Touch
        elseif abilId == MIDAS_TOUCH_ABILITY_ID and SuddenDeathEnabled == false and (not IsUnitType(target, UNIT_TYPE_HERO)) then
            call CastMidasTouch(hero, target, lvl)
            return true
        //Holy Light
        elseif abilId == HOLY_LIGHT_ABILITY_ID then
            call CastHolyLight(caster, target, lvl)
            return true
        //Parasite
        elseif abilId == PARASITE_ABILITY_ID then
            call CastParasite(caster, target, lvl)
            return true
        //Lightning Shield
        elseif abilId == LIGHTNING_SHIELD_ABILITY_ID then
            call CastLightningShield(caster, target, lvl)
            return true
        //Plague
        elseif abilId == PLAGUE_ABILITY_ID then
            call CastPlague(caster, x, y, lvl)
            return true
        //Dousing Hex
        elseif abilId == DOUSING_HE_ABILITY_ID then
            call CastDousingHex(hero, target, lvl)
            return true
        //Dark Seal
        elseif abilId == DARK_SEAL_ABILITY_ID then
            call CastDarkSeal(target, lvl)
            return true
        //Destruction of Block
        elseif abilId == DESTRUCTION_BLOCK_ABILITY_ID then
            call CastDestrOfBlock(target, lvl)
            return true
        //Inner Fire
        elseif abilId == INNER_FIRE_ABILITY_ID then
            call CastInnerFire(hero, target, lvl)
            return true
        //Battle Roar
        elseif abilId == BATTLE_ROAR_ABILITY_ID then
            call CastBattleRoar(hero, abilId, lvl)
            return true
        //Cyclone
        elseif abilId == CYCLONE_ABILITY_ID then
            call Cyclone(caster, x, y, lvl)
            return true
        //Ancient Axe
        elseif abilId == 'A096' then
            call AncientAxe(hero)
            return true
        //Ancient Dagger
        elseif abilId == 'A097' then
            call AncientDagger(hero)
            return true
        //Death Pact
        elseif abilId == DEATH_PACT_ABILITY_ID then
            call CastDeathPact(hero, target, lvl)
            return true
        //Ancient Staff
        elseif abilId == 'A094' then
            call AncientStaff(hero)
            return true
        //ShadowBlade
        elseif abilId == 'A0D2' then
            call ShadowBlade(hero)
        //Reset Time
        elseif abilId == RESET_TIME_ABILITY_ID then
            call ResetTime(hero)
            return true
        //Energy Trap
        elseif abilId == ENERGY_TRAP_ABILITY_ID then
            call CastEnergyTrap(caster, x, y, lvl)
            return true
        //Spirit Link
        elseif abilId == SPIRIT_LINK_ABILITY_ID then
            call CastSpiritLink(hero, lvl)
            return true
        //Blink Strike
        elseif abilId == BLINK_STRIKE_ABILITY_ID or abilId == 'A06I' then
            call BlinkStrike(hero, lvl)
            return true
        //Whirlwind
        elseif abilId == 'A025' then
            call CastWhirlwind(hero, x, y, lvl)
            return true
        //Extra dimensional cooperation
        elseif abilId == EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID then
            call ExtradimensionalCooperation(hero, abilId, lvl)
            return true
        //Frost Bolt
        elseif abilId == FROST_BOLT_ABILITY_ID then
            call UsFrostBolt(hero,target,120 * lvl * (1 + 0.25 * R2I(GetUnitElementCount(hero,Element_Dark))), GetUnitElementCount(hero,Element_Cold))
            return true
        //Sand of time
        elseif abilId == SAND_OF_TIME_ABILITY_ID then
            call SandRefreshAbility(hero,1.75 + 0.25 * lvl)
            return true
        //Purge dummy
        elseif abilId == 'A08A' then
            //remove last breath
            if GetUnitAbilityLevel(target, 'A08B') > 0 then
                call UnitRemoveAbility(target, 'A08B')
                call UnitRemoveAbility(target, 'B01D')
            endif
            
            //remove Cheater Magic
            if GetUnitAbilityLevel(target, 'A08G') > 0 and IsUnitEnemy(target, GetOwningPlayer(hero)) then
                call UnitRemoveAbility(target, 'A08G')
                call UnitRemoveAbility(target, CHEATER_MAGIC_BUFF_ID)
            endif

            return true
        //Purge wait
        elseif abilId == PURGE_ABILITY_ID then
            call Purge(hero, target, lvl)
            return true
        //Eruption
        elseif abilId == ERUPTION_ABILITY_ID then
            call CastEruption(caster, x, y, lvl)
            return true
        endif

        return false
    endfunction
endlibrary

library SpellEffects initializer init requires MultiBonusCast, ChaosMagic, Urn, AbilityChannel, Cooldown, AncientRunes, DummyActiveSpell, ToggleSpell

    function SpellEffectActions takes nothing returns nothing
        local unit caster = GetTriggerUnit()
        local unit target = GetSpellTargetUnit()
        local real targetX = GetSpellTargetX()
        local real targetY = GetSpellTargetY()
        local integer abilId = GetSpellAbilityId()
        local integer abilLvl
        local location spelLLoc = GetSpellTargetLoc()
        local boolean dummyAbilId = GetAssociatedSpell(caster, abilId) != 0
        local integer lvl = 0
        local boolean abilityChanneled = false
        //call BJDebugMsg("cx: " + R2S(GetUnitX(caster)) + " cy: " + R2S(GetUnitY(caster)) + " tx: " + R2S(targetX) + " ty: " + R2S(targetY))

        if not ToggleSpell(caster, abilId) then
            if (not HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) or GetOwningPlayer(caster) == Player(11)) then

                set abilId = CheckAssociatedSpell(caster, abilId)
                set abilLvl = GetUnitAbilityLevel(caster, abilId)
                    //call BJDebugMsg("abil: " + GetObjectName(abilId) + " lvl: " + I2S(abilLvl))
                
                //call BJDebugMsg("se" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + I2S(GetUnitCurrentOrder(caster)))
                set abilityChanneled = AbilityChannel(caster, PlayerHeroes[GetPlayerId(GetOwningPlayer(caster)) + 1], target,targetX,targetY,abilId, abilLvl)
            
                if GetUnitTypeId(caster) != PRIEST_1_UNIT_ID and (not CheckIfCastAllowed(caster)) then
                    //call BJDebugMsg("caster: " + GetUnitName(caster))
                    call ElementStartAbility(caster, abilId)

                    if (not abilityChanneled) and dummyAbilId then
                        //call BJDebugMsg("channel")
                        call CastSpell(caster, target, abilId, abilLvl, GetAbilityOrderType(abilId), targetX, targetY).activate()
                    endif

                    if GetUnitAbilityLevel(caster, ABSOLUTE_POISON_ABILITY_ID) > 0 and IsSpellElement(caster, abilId, Element_Poison) and target != null and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                        call PoisonSpellCast(caster, target)
                    endif

                    if GetUnitAbilityLevel(caster, 'A01X') > 0 then
                        call ActivateBlokkadeShield(caster)
                    endif

                    if GetUnitTypeId(caster) == TIME_WARRIOR_UNIT_ID then
                        call ActivateXesilManaCostNegation(caster, abilId, abilLvl)
                    endif

                    if GetUnitAbilityLevel(caster, 'B024') > 0 then
                        call GetRetaliationSource(caster, target, abilId, abilLvl)
                    endif

                    if UnitHasItemType(caster, ARCANE_RUNESTONE_ITEM_ID) then
                        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (BlzGetAbilityManaCost(abilId, abilLvl - 1) * 0.3))
                    endif

                    if UnitHasItemType(caster, ORB_OF_ELEMENTS) then
                        call SetElementalOrbAbil(caster, abilId)
                    endif

                    if abilId == ACTIVATE_AVATAR_ABILITY_ID then
                        call CastAvatar(caster, abilLvl)
                    endif

                    if abilId == 'AEsh' then
                        call UnitAddTimeForm(caster,FORM_SHADOW, 1)
                    endif

                    if abilId == 'A044' then
                        call Urn(caster)
                    endif   

                    /*if abilId == MYSTERIOUS_TALENT_ABILITY_ID then
                        call MysteriousTalentCast(caster)
                    endif*/

                    if abilId == 'A09Q' then
                        call StaffOfPowerCast(caster)
                    endif

                    if abilId == RUNE_MASTERY_ABILITY_ID then
                        call CastRuneMaster(caster)
                    endif

                    if abilId == 'A09D' then
                        call MaskOfProtectionCast(caster)
                    endif
        
                    if abilId == 'A09F' then
                        call MaskOfVitality(caster)
                    endif

                    if abilId == 'A085' then
                        call ActivateAntiMagicFlag(caster)
                    endif

                    if abilId == CONQ_BAMBOO_STICK_ABILITY_ID then
                        call CastConqBambooStick(caster)
                    endif

                    if UnitHasItemType(caster, 'I03O') then
                        call ActivateMoonstone(caster)
                    endif

                    if UnitHasItemType(caster, 'I03R') then
                        call ActivateScepterOfConfusion(caster)
                    endif

                    if IsAbilityCasteable(abilId, false) then
                        //Wizard's Gemstone
                        if UnitHasItemType(caster, 'I0BQ') then
                            if BlzGetUnitAbilityCooldownRemaining(caster, 'A0CS') == 0 then
                                call ActivateStatRune(caster)
                                call AbilStartCD(caster, 'A0CS', 5) 
                            endif
                        endif
                        
                        //multicast
                        if (GetUnitAbilityLevel(caster, MULTICAST_ABILITY_ID) > 0 or GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID or UnitHasItemType(caster, 'I08X'))  and abilId != RESET_TIME_ABILITY_ID then
                            call MultiBonusCast(caster, target, abilId, GetAbilityOrder(abilId), spelLLoc)
                        endif
                    endif

                    set lvl = GetUnitAbilityLevel(caster, CHAOS_MAGIC_ABILITY_ID)
                    if lvl > 0 and BlzGetAbilityCooldown(abilId,GetUnitAbilityLevel(caster,abilId ) - 1) > 0 then
                        call CastRandomSpell(caster, abilId, target, spelLLoc, false, lvl)
                    endif

                    if GetUnitAbilityLevel(caster, 'A099') > 0 and (target != null or IsAbilityManifoldable(abilId)) and (not IsCurrentlyManifolding(caster)) then
                        call ManifoldStaff(caster, target, abilId, GetUnitAbilityLevel(caster, abilId))
                    endif

                    if GetUnitAbilityLevel(caster, SPELLBANE_TOKEN_BUFF_ID) > 0 then
                        call SpellbaneSpellCast(caster, abilId, abilLvl)
                    endif

                    //call BJDebugMsg("cd")
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