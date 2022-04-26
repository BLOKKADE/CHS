library AbilityChannel requires RandomShit, AncientAxe, AncientDagger, AncientStaff, BlinkStrike, Cyclone, ChaosMagic, FrostBolt, SandOfTime, ResetTime, ExtradimensionalCooperation, Purge, AncientRunes
    
    function AbilityChannel takes unit caster, unit target, real x, real y, integer abilId, integer lvl returns boolean

        //call BJDebugMsg("ac" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))
        if GetUnitTypeId(caster) == 'h014' or GetUnitTypeId(caster) == PRIEST_1_UNIT_ID then
            set caster = PlayerHeroes[GetConvertedPlayerId(GetOwningPlayer( caster ) ) ]
        endif

        //Mysterious Runestone
        if abilId == 'A072' then
            call CastMysteriousRunestone(caster)
            return true
        /*elseif IsChannelAbility(abilId) and not Trig_Disable_Abilities_Func001C(caster) then
            call CastChannelAbility(caster, abilId, x, y, lvl)
            return true*/
        //Scroll of Transformation
        elseif abilId == 'A049' then
            call CastScrollOfTransformation(caster)
            return true
        //Staff of Lightning
        elseif abilId == 'A09T' then
            call CastStaffOfLightning(caster, target)
            return true
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
            return true
            //Mana Starvation
        elseif abilId == MANA_STARVATIO_ABILITY_ID then
            call CastManaStarvation(caster, target, lvl)
            return true
            //Midas Touch
        elseif abilId == MIDAS_TOUCH_ABILITY_ID and SuddenDeathEnabled == false then
            call CastMidasTouch(caster, target, lvl)
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
            call CastDousingHex(caster, target, lvl)
            return true
            //Inner Fire
        elseif abilId == INNER_FIRE_ABILITY_ID then
            call CastInnerFire(caster, target, lvl)
            return true
            //Battle Roar
        elseif abilId == BATTLE_ROAR_ABILITY_ID then
            call CastBattleRoar(caster, abilId, lvl)
            return true
            //Cyclone
        elseif abilId == CYCLONE_ABILITY_ID then
            call Cyclone(caster, x, y)
            return true
            //Ancient Axe
        elseif abilId == 'A096' then
            call AncientAxe(caster)
            return true
            //Ancient Dagger
        elseif abilId == 'A097' then
            call AncientDagger(caster)
            return true
            //Death Pact
        elseif abilId == DEATH_PACT_ABILITY_ID then
            call CastDeathPact(caster, target, lvl)
            return true
            //Ancient Staff
        elseif abilId == 'A094' then
            call AncientStaff(caster)
            return true
            //Reset Time
        elseif abilId == RESET_TIME_ABILITY_ID then
            call ResetTime(caster)
            return true
            //Energy Trap
        elseif abilId == ENERGY_TRAP_ABILITY_ID then
            call CastEnergyTrap(caster, x, y, lvl)
            return true
            //Spirit Link
        elseif abilId == SPIRIT_LINK_ABILITY_ID then
            call CastSpiritLink(caster, lvl)
            return true
            //Blink Strike
        elseif abilId == BLINK_STRIKE_ABILITY_ID or abilId == 'A06I' then
            call BlinkStrike(caster, lvl)
            return true
            //Whirlwind
        elseif abilId == 'A025' then
            call CastWhirlwind(caster, x, y, lvl)
            return true
            //Extra dimensional cooperation
        elseif abilId == EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID then
            call ExtradimensionalCooperation(caster, abilId, lvl)
            return true
            //Frost Bolt
        elseif abilId == FROST_BOLT_ABILITY_ID then
            call UsFrostBolt(caster,target,120 * lvl * (1 + 0.25 * R2I(GetUnitElementCount(caster,Element_Dark))), GetUnitElementCount(caster,Element_Cold))
            return true
            //Sand of time
        elseif abilId == SAND_OF_TIME_ABILITY_ID then
            call SandRefreshAbility(caster,1.75 + 0.25 * lvl)
            return true
            //Purge dummy
        elseif abilId == 'A08A' then
            //remove last breath
            if GetUnitAbilityLevel(target, 'A08B') > 0 and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                call UnitRemoveAbility(target, 'A08B')
                call UnitRemoveAbility(target, 'B01D')
            endif
            
            //remove Cheater Magic
            if GetUnitAbilityLevel(target, 'A08G') > 0 and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                call UnitRemoveAbility(target, 'A08G')
                call UnitRemoveAbility(target, CHEATER_MAGIC_BUFF_ID)
            endif

            return true
            //Purge wait
        elseif abilId == PURGE_ABILITY_ID then
            call Purge(caster, target)    
            return true  
        endif

        return false
    endfunction
endlibrary

library SpellEffects initializer init requires MultiBonusCast, ChaosMagic, Urn, AbilityChannel, Cooldown, AncientRunes, DummyActiveSpell

    function ToggleSpell takes unit caster, integer abilId returns boolean
        if abilId == IMMOLATION_ABILITY_ID then
            call ToggleImmolation(caster)
            return true
        elseif abilId == SEARING_ARROWS_ABILITY_ID then
            call ToggleSearingArrows(caster)
            return true
        elseif abilId == COLD_ARROWS_ABILITY_ID then
            call ToggleColdArrows(caster)
            return true
        elseif abilId == MAGNET_OSC_ABILITY_ID then
            call ToggleMagnetOsc(caster)
            return true
        elseif abilId == MANA_SHIELD_ABILITY_ID then
            return true
        endif

        return false
    endfunction

    function SpellEffectActions takes nothing returns nothing
        local unit caster = GetTriggerUnit()
        local unit target = GetSpellTargetUnit()
        local real targetX = GetSpellTargetX()
        local real targetY = GetSpellTargetY()
        local integer abilId = GetSpellAbilityId()
        local integer abilLvl = GetUnitAbilityLevel(caster, abilId)
        local location spelLLoc = GetSpellTargetLoc()
        local integer dummyAbilId = 0
        local integer lvl = 0
        local boolean abilityChanneled = false
        //call BJDebugMsg("cx: " + R2S(GetUnitX(caster)) + " cy: " + R2S(GetUnitY(caster)) + " tx: " + R2S(targetX) + " ty: " + R2S(targetY))

        if not ToggleSpell(caster, abilId) then
            if (not HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) or GetOwningPlayer(caster) == Player(11)) then

                set dummyAbilId = GetAssociatedSpell(caster, abilId)
                if dummyAbilId != 0 then
                    set abilId = dummyAbilId
                    set abilLvl = GetUnitAbilityLevel(caster, abilId)
                    //call BJDebugMsg("abil: " + GetObjectName(abilId) + " lvl: " + I2S(abilLvl))
                endif
                
                //call BJDebugMsg("se" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + I2S(GetUnitCurrentOrder(caster)))
                set abilityChanneled = AbilityChannel(caster,target,targetX,targetY,abilId, abilLvl)
            
                if GetUnitTypeId(caster) != PRIEST_1_UNIT_ID and (not Trig_Disable_Abilities_Func001C(caster)) then
                    //call BJDebugMsg("caster: " + GetUnitName(caster))
                    call ElementStartAbility(caster, abilId)

                    if (not abilityChanneled) and dummyAbilId != 0 then
                        //call BJDebugMsg("channel")
                        call CastSpell(caster, target, abilId, abilLvl, GetAbilityOrderType(dummyAbilId), targetX, targetY).activate()
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

                    if UnitHasItemS(caster, 'I0B7') then
                        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (BlzGetAbilityManaCost(abilId, abilLvl - 1) * 0.3))
                    endif

                    if abilId == ACTIVATE_AVATAR_ABILITY_ID then
                        call CastAvatar(caster, abilLvl)
                    endif

                    if abilId == 'A044' then
                        call Urn(caster)
                    endif   

                    if abilId == MYSTERIOUS_TALENT_ABILITY_ID then
                        call MysteriousTalentCast(caster)
                    endif

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

                    if UnitHasItemS(caster, 'I03O') then
                        call ActivateMoonstone(caster)
                    endif

                    if UnitHasItemS(caster, 'I03R') then
                        call ActivateScepterOfConfusion(caster)
                    endif

                    if IsAbilityCasteable(abilId, false) and (GetUnitAbilityLevel(caster, MULTICAST_ABILITY_ID) > 0 or GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID or UnitHasItemS(caster, 'I08X'))  and abilId != RESET_TIME_ABILITY_ID then
                        call MultiBonusCast(caster, target, abilId, GetAbilityOrder(abilId), spelLLoc)
                    endif

                    set lvl = GetUnitAbilityLevel(caster, CHAOS_MAGIC_ABILITY_ID)
                    if lvl > 0 and BlzGetAbilityCooldown(abilId,GetUnitAbilityLevel(caster,abilId ) - 1) > 0 then
                        call CastRandomSpell(caster, abilId, target, spelLLoc, false, lvl)
                    endif

                    if GetUnitAbilityLevel(caster, 'A099') > 0 and (target != null or IsAbilityManifoldable(abilId)) and SpellData[GetHandleId(caster)].boolean[8] == false then
                        call ManifoldStaff(caster, target, abilId, GetUnitAbilityLevel(caster, abilId))
                    endif

                    if GetUnitAbilityLevel(caster, SPELLBANE_TOKEN_BUFF_ID) > 0 then
                        call SpellbaneSpellCast(caster, abilId, abilLvl)
                    endif

                    //Wizard's Gemstone
                    if UnitHasItemS(caster, 'I0BQ') then
                        if BlzGetUnitAbilityCooldownRemaining(caster, 'A0CS') == 0 then
                            call ActivateStatRune(caster)
                            call AbilStartCD(caster, 'A0CS', 5) 
                        endif
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