library AbilityChannel requires RandomShit, AncientAxe, AncientDagger, AncientStaff, BlinkStrike, Cyclone, ChaosMagic, FrostBolt, SandOfTime, ResetTime, ExtradimensionalCooperation, Purge, AncientRunes
    
    function AbilityChannel takes unit caster, unit target, real x, real y, integer abilId, integer lvl returns boolean

        //call BJDebugMsg("ac" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))
        
        if GetUnitTypeId(caster) ==  'h00T' or GetUnitTypeId(caster) == 'h014' or GetUnitTypeId(caster) == 'h015' then
            set caster = udg_units01[GetConvertedPlayerId(GetOwningPlayer( caster ) ) ]
        endif

        //Mysterious Runestone
        if abilId == 'A072' then
            call CastMysteriousRunestone(caster)
            return true
        endif

        if IsChannelAbility(abilId) and not Trig_Disable_Abilities_Func001C(caster) then
            call CastChannelAbility(caster, abilId, x, y, lvl)
            return true
        endif

        //Scroll of Transformation
        if abilId == 'A049' then
            call CastScrollOfTransformation(caster)
            return true
        endif

        //Staff of Lightning
        if abilId == 'A09T' then
            call CastStaffOfLightning(caster, target)
            return true
        endif

        //Random Spell
        if abilId == 'A07U' then
            //call BJDebugMsg("random spell: " + GetUnitName(target) + " x: " + R2S(x) + " y: " + R2S(y))
            if target != null then
                //call BJDebugMsg("target")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(caster, abilId, target, RandomSpellLoc, true, GetUnitAbilityLevel(caster, 'A07U'))
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            elseif x != 0.00 and y != 0.00 then
                //call BJDebugMsg("point")
                set RandomSpellLoc = Location(x, y)
                call CastRandomSpell(caster, abilId, null, RandomSpellLoc, true, GetUnitAbilityLevel(caster, 'A07U'))
                call RemoveLocation(RandomSpellLoc)
                set RandomSpellLoc = null
            endif
            return true
            //Mana Starvation
        elseif abilId == 'A09J' then
            call CastManaStarvation(caster, target, lvl)
            return true
            //Midas Touch
        elseif abilId == 'A0A2' and SuddenDeathEnabled == false then
            call CastMidasTouch(caster, target, lvl)
            return true
            //Dousing Hex
        elseif abilId == 'A09I' then
            call CastDousingHex(caster, target, lvl)
            return true
            //Cyclone
        elseif abilId == 'A05X' then
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
            //Ancient Staff
        elseif abilId == 'A094' then
            call AncientStaff(caster)
            return true
            //Reset Time
        elseif abilId == 'A024' then
            call ResetTime(caster)
            return true
            //Blink Strike
        elseif abilId == 'A08J' then
            call BlinkStrike(caster, lvl)
            return true
            //Extra dimensional cooperation
        elseif abilId == 'A08I' then
            call ExtradimensionalCooperation(caster, abilId)
            return true
            //Frost Bolt
        elseif abilId == 'A07X' then
            call UsFrostBolt(caster,target,120 * GetUnitAbilityLevel(caster,'A07X')*(1 + 0.25 * R2I(GetClassUnitSpell(caster,7))), GetClassUnitSpell(caster,9))
            return true
            //Sand of time
        elseif abilId == 'A083' then
            call SandRefreshAbility(caster,1.75 + 0.25 * I2R(GetUnitAbilityLevel(caster,'A083')))
            return true
            //Purge dummy
        elseif abilId == 'A08A' then
            //remove last breath
            if GetUnitAbilityLevel(target, 'A08B') > 0 and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                call UnitRemoveAbility(target, 'A08B')
                call UnitRemoveAbility(target, 'B01D')
            endif
            
            if GetUnitAbilityLevel(target, 'A08G') > 0 and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                call UnitRemoveAbility(target, 'A08G')
                call UnitRemoveAbility(target, 'B01G')
            endif
            return true
            //Purge wait
        elseif abilId == 'A08E' then
            call Purge(caster, target)    
            return true  
        endif

        return false
    endfunction
endlibrary

library SpellEffects initializer init requires MultiBonusCast, ChaosMagic, Urn, AbilityChannel, Cooldown, AncientRunes
    function SpellEffectActions takes nothing returns nothing
        local unit caster = GetTriggerUnit()
        local unit target = GetSpellTargetUnit()
        local real targetX = GetSpellTargetX()
        local real targetY = GetSpellTargetY()
        local integer abilId = GetSpellAbilityId()
        local integer abilLvl = GetUnitAbilityLevel(caster, abilId)
        local location spelLLoc = GetSpellTargetLoc()
        local integer ID = 0 
        local integer lvl = 0

        if not HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) then
            //call BJDebugMsg("se" + GetUnitName(caster) + " : " + GetObjectName(abilId) + " : " + I2S(GetUnitCurrentOrder(caster)))

            if not DousingHexFailCheck(caster, abilId) then
            
                call AbilityChannel(caster,target,targetX,targetY,abilId, abilLvl)
            
                if not Trig_Disable_Abilities_Func001C(caster) then
                    call ElementStartAbility(caster, abilId)

                    if GetUnitAbilityLevel(caster, 'A0AC') > 0 and IsSpellElement(caster, abilId, Element_Poison) and target != null and IsUnitEnemy(target, GetOwningPlayer(caster)) then
                        call PoisonSpellCast(caster, target)
                    endif

                    if GetUnitAbilityLevel(caster, 'B024') > 0 then
                        call GetRetaliationSource(caster, target, abilId, abilLvl)
                    endif

                    if UnitHasItemS(caster, 'I0B7') then
                        call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) + (BlzGetAbilityManaCost(abilId, abilLvl - 1) * 0.3))
                    endif

                    if abilId == 'A0AE' then
                        call CastAvatar(caster, abilLvl)
                    endif

                    if abilId == 'A044' then
                        call Urn(caster)
                    endif   

                    if abilId == 'A05Z' then
                        call MysteriousTalentCast(caster)
                    endif

                    if abilId == 'A09Q' then
                        call StaffOfPowerCast(caster)
                    endif

                    if abilId == 'A09O' then
                        call CastAncientRunes(caster)
                    endif

                    if abilId == 'A09D' then
                        call MaskOfProtectionCast(caster)
                    endif
        
                    if abilId == 'A09F' then
                        call MaskOfVitality(caster)
                    endif

                    if GetUnitAbilityLevel(caster, 'A04F') > 0 or GetUnitTypeId(caster) == 'H01E' or UnitHasItemS(caster, 'I08X')  and abilId != 'A024' then
                        call MultiBonusCast(caster, target, abilId, GetAbilityOrder(abilId), spelLLoc)
                    endif

                    set lvl = GetUnitAbilityLevel(caster, 'A04L')
                    if abilId != 'AEim' and abilId != 'ANms' and lvl > 0 and BlzGetAbilityCooldown(abilId,GetUnitAbilityLevel(caster,abilId ) - 1) > 0 then
                        call CastRandomSpell(caster, abilId, target, spelLLoc, false, lvl)
                    endif

                    if GetUnitAbilityLevel(caster, 'A099') > 0 and target != null and SpellData[GetHandleId(caster)].boolean[8] == false then
                        call ManifoldStaff(caster, target, abilId, GetUnitAbilityLevel(caster, abilId))
                    endif

                    if GetUnitAbilityLevel(caster, 'B01R') > 0 then
                        call SpellbaneSpellCast(caster, abilId, abilLvl)
                    endif
                
                    call SetCooldown(caster, abilId, false) 
                endif
            else
                call SetCooldown(caster, abilId, true) 
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