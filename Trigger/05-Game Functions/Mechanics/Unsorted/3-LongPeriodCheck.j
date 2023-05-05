scope LongPeriodCheck initializer init

    private function OnCooldownEnd takes unit u returns nothing
        local integer i
        local integer hid = GetHandleId(u)
        if HasPlayerFinishedLevel(u ,GetOwningPlayer(u)) == false then
            //Mysterious Talent
            set i = GetUnitAbilityLevel(u,MYSTERIOUS_TALENT_ABILITY_ID)
            if i > 0 and BlzGetUnitAbilityCooldownRemaining(u,MYSTERIOUS_TALENT_ABILITY_ID) <= 0.001 then
                call MysteriousTalentActivate(u)
                call AbilStartCD(u,MYSTERIOUS_TALENT_ABILITY_ID,45 - i) 
            endif
            //Sorcerer Passive (uses same spell as thunderwitch for now (A08P), not sure if it matters, easy to change)
            if GetUnitTypeId(u) == SORCERER_UNIT_ID and BlzGetUnitAbilityCooldownRemaining(u, 'A08P') == 0 and FilterListNotEmpty(u, SORCERER_UNIT_ID) and CheckProc(u, 600) then
                call SorcererPassive(u, hid)
                call ElemFuncStart(u, SORCERER_UNIT_ID)
                call AbilStartCD(u, 'A08P', RMaxBJ(15, 50 - I2R(GetHeroLevel(u) / 5)))
            endif
            //Holy Shield
            if GetUnitAbilityLevel(u,'A066') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A066') <= 0.001 and GetWidgetLife(u)/ I2R(BlzGetUnitMaxHP(u)) < 0.75 then
                call UseSpellsHolyShield(u)
                call AbilStartCD(u,'A066', 10) 
            endif

            //Ancient Runes
            set i = GetUnitAbilityLevel(u, ANCIENT_RUNES_ABILITY_ID)
            if i > 0 and BlzGetUnitAbilityCooldownRemaining(u,ANCIENT_RUNES_ABILITY_ID) <= 0.001 then
                call ActivateAncientRunes(u, i)
            endif

            //Ancient Element
            set i = GetUnitAbilityLevel(u, ANCIENT_ELEMENT_ABILITY_ID)
            if i > 0 and BlzGetUnitAbilityCooldownRemaining(u, ANCIENT_ELEMENT_ABILITY_ID) <= 0 and CheckProc(u, 600) then
                call UseAncientElement(u, i)
            endif

            //Arcane Strike
            set i = GetUnitAbilityLevel(u, ARCANE_STRIKE_ABILITY_ID)
            if i > 0 and BlzGetUnitAbilityCooldownRemaining(u, ARCANE_STRIKE_ABILITY_ID) <= 0 then
                call UseArcaneStrike(u)
            endif


            //Runestone of Creation
            if GetUnitAbilityLevel(u,'A073') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A073') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 2000 then
                call CreateRandomRune(0,GetUnitX(u),GetUnitY(u),u)
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 2000)
                call AbilStartCD(u,'A073', 10) 
            endif
            
            //Earthquake
            set i = GetUnitAbilityLevel(u,EARTHQUAKE_ABILITY_ID)
            if i > 0 and BlzGetUnitAbilityCooldownRemaining(u,EARTHQUAKE_ABILITY_ID) <= 0.001 and CheckProc(u, 600) then
                call DummyInstantCast4(u,GetUnitX(u),GetUnitY(u),'A07M',"thunderclap", GetSpellValue(75, 10, i), ABILITY_RLF_DAMAGE_INCREASE,600,ABILITY_RLF_CAST_RANGE ,0.5 + (0.05 * i),ABILITY_RLF_DURATION_HERO,0.5 + (0.05 * i),ABILITY_RLF_DURATION_NORMAL)
                call AbilStartCD(u,EARTHQUAKE_ABILITY_ID,5) 
            endif

            //Gnome
            if GetUnitTypeId(u) == GNOME_MASTER_UNIT_ID and CheckProc(u, 2200) and BlzGetUnitAbilityCooldownRemaining(u, GNOME_MASTER_PASSIVE_ABILITY_ID) == 0 then
                call ElemFuncStart(u,GNOME_MASTER_UNIT_ID)
                call AbilStartCD(u, GNOME_MASTER_PASSIVE_ABILITY_ID, 11 + (GetHeroLevel(u) * 0.04))
                call DummyInstantCast4(u,GetUnitX(u),GetUnitY(u),'A03Z',"stomp",55 * GetHeroLevel(u),ABILITY_RLF_DAMAGE_INCREASE,2200,ABILITY_RLF_AREA_OF_EFFECT , 1 +(GetHeroLevel(u) * 0.04),ABILITY_RLF_DURATION_HERO,1 +(GetHeroLevel(u) * 0.04),ABILITY_RLF_DURATION_NORMAL)
            endif
        endif
    endfunction

    private function OnPeriod takes nothing returns nothing
        local unit u = GetEnumUnit()
        local integer hid = GetHandleId(u)
        local real hpBonus = 0
        local real r1 = 0
        local real r2 = 0
        local real r3 = 0
        local integer i1 = 0
        local integer i2 = 0
        
        if UnitAlive(u) then

            //modify attack speed
            call ModifyAttackCooldown(u, hid)

            //Guide To Rune Mastery
            if GetUnitAbilityLevel(u ,'A09O') >= 1 then
                set i1 = R2I(100 + GetUnitCustomState(u, BONUS_RUNEPOW) + GetHeroLevel(u))
                set i2 = LoadInteger(HT, hid, 'A09O')
                if i1 != i2 then
                    call SaveInteger(HT, hid, 'A09O', i1)

                    call AddUnitBonus(u, BONUS_STRENGTH, i1 - i2)
                    call AddUnitBonus(u, BONUS_AGILITY, i1 - i2)
                    call AddUnitBonus(u, BONUS_INTELLIGENCE, i1 - i2)
                endif
            elseif LoadInteger(HT, hid, 'A09O') != 0 then
                set i1 = LoadInteger(HT, hid, 'A09O')
                call AddUnitBonus(u, BONUS_STRENGTH, 0 - i1)
                call AddUnitBonus(u, BONUS_AGILITY, 0 - i1)
                call AddUnitBonus(u, BONUS_INTELLIGENCE, 0 - i1)
                call SaveInteger(HT, hid, 'A09O', 0)
            endif

            //Double Armor
            if GetUnitAbilityLevel(u ,'B00F') >= 1 then
                set r1 = BlzGetUnitArmor(u)
                set r2 = LoadReal(HT, hid, 11)
                set r3 = (r1 - r2) - r2 
                call SaveReal(HT, hid, 11, r2 + r3 )

                call BlzSetUnitArmor(u, r1 + r3  )
            elseif LoadReal(HT, hid, 11) != 0 then
                call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - LoadReal(HT, hid, 11)  )
                call SaveReal(HT, hid, 11,0)
            endif

            //Panda Relic
            if GetUnitAbilityLevel(u ,'B00S') >= 1 then
                //agi
                set i1 = R2I(GetHeroAgi(u, false) * 0.35)
                set i2 = LoadInteger(HT, hid, 1001)

                if i1 != i2 then
                    call SaveInteger(HT, hid, 1001, i1)
                    call AddUnitBonus(u, BONUS_AGILITY, i1 - i2)
                endif

                //str
                set i1 = R2I(GetHeroStr(u, false) * 0.35)
                set i2 = LoadInteger(HT, hid, 1002)

                if i1 != i2 then
                    call SaveInteger(HT, hid, 1002, i1)
                    call AddUnitBonus(u, BONUS_STRENGTH, i1 - i2)
                endif

                //int
                set i1 = R2I(GetHeroInt(u, false) * 0.35)
                set i2 = LoadInteger(HT, hid, 1003)

                if i1 != i2 then
                    call SaveInteger(HT, hid, 1003, i1)
                    call AddUnitBonus(u, BONUS_INTELLIGENCE, i1 - i2)
                endif

            elseif (LoadInteger(HT, hid, 1001) != 0) or (LoadInteger(HT, hid, 1002) != 0) or (LoadInteger(HT, hid, 1003) != 0) then
                call AddUnitBonus(u, BONUS_AGILITY, 0 - LoadInteger(HT, hid, 1001))
                call SaveInteger(HT, hid, 1001,0)

                call AddUnitBonus(u, BONUS_STRENGTH, 0 - LoadInteger(HT, hid, 1002))
                call SaveInteger(HT, hid, 1002,0)

                call AddUnitBonus(u, BONUS_INTELLIGENCE, 0 - LoadInteger(HT, hid, 1003))
                call SaveInteger(HT, hid, 1003,0)		
            endif

            //Relic of Magic
            if GetUnitAbilityLevel(u ,'B00Q') >= 1 then	
                set r1 = BlzGetUnitMaxHP(u)  - GetWidgetLife(u) 

                if r1 > 0 then
                    set r2 = GetUnitState(u, UNIT_STATE_MANA)/ 100 

                    if r2 > r1 then
                        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - r1 )
                        call SetWidgetLife(u,  GetWidgetLife(u) + r1) 
                    else
                        call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - r2 )
                        call SetWidgetLife(u,  GetWidgetLife(u) + r2)      
                    endif
                endif
            endif
            
            set hpBonus = 0
            //Heart of a Hero
            if GetUnitAbilityLevel(u ,'B00N') >= 1 then
                set hpBonus = hpBonus + 1
            endif

            //Absolute Light
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_LIGHT_ABILITY_ID)
            if i1 >= 1  then
                set i1 = i1 * GetUnitElementCount(u, Element_Light)
                set hpBonus = hpBonus + 0.005 * I2R(i1)
            endif

            //Divine Gift
            set i1 = GetUnitAbilityLevel(u ,DIVINE_GIFT_ABILITY_ID)
            if i1 >= 1 then
                set hpBonus = hpBonus + 0.05 * I2R(i1)
            endif

            call SetUnitProcHp(u,hpBonus)

            set i2 = LoadInteger(HT, hid,'B026')
            //Goblet of Blood
            if GetUnitAbilityLevel(u, 'B026') > 0 then
                set i1 = R2I(BlzGetUnitMaxHP(u) * 0.03)

                if i1 != i2 then
                    call AddUnitBonus(u, BONUS_DAMAGE, 0 - i2 + i1)
                    call SaveInteger(HT, hid,'B026',i1)
                endif
            elseif i2 != 0 then
                call AddUnitBonus(u, BONUS_DAMAGE, 0 - i2)
                call SaveInteger(HT, hid,'B026',0)
            endif

            if not HasPlayerFinishedLevel(u, GetOwningPlayer(u)) then
                //Drain aura
                set i1 = GetUnitAbilityLevel(u, DRAIN_AURA_ABILITY_ID)
                if i1 > 0 or UnitHasItemType(u, DARK_RUNESTONE_ITEM_ID) then
                    if UnitHasItemType(u, DARK_RUNESTONE_ITEM_ID) then
                        call ActivateDrainAura(u, GetUnitX(u), GetUnitY(u), (i1 * 0.01) + 0.1, 500, true)
                    else
                        call ActivateDrainAura(u, GetUnitX(u), GetUnitY(u), (i1 * 0.01), 500, true)
                    endif
                endif
            endif
            call OnCooldownEnd(u)

            //Banshee
            if GetUnitTypeId(u) == BANSHEE_UNIT_ID then
                set i1 = (BlzGetUnitMaxHP(u)/ 10) * 4
                set i2 = LoadInteger(HT, hid,BANSHEE_UNIT_ID)

                call BlzSetUnitMaxMana(u,BlzGetUnitMaxMana(u)+ i1 - i2  )
                call SaveInteger(HT, hid,BANSHEE_UNIT_ID,i1 )

            endif

            //Robes of the Archmage
            if GetUnitAbilityLevel(u ,'B00L') >= 1 then

                set r1 = R2I((BlzGetUnitMaxMana(u)  - GetUnitState(u  , UNIT_STATE_MANA ) )/ 300)
                set r2 = LoadReal(HT, hid,291)

                set r3 = r1 + BlzGetUnitArmor(u) - r2

                call SaveReal(HT, hid,291, r1 )
                call BlzSetUnitArmor(u, r3 )

            elseif LoadReal(HT, hid,291) != 0 then
                call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - LoadReal(HT, hid,291)  )
                call SaveReal(HT, hid,291,0)
            endif

            //Contract of the Living
            if IsContractLivingAvailable(u, 0) then
                call ActivateContractLiving(u)
            endif

            if TestFx != null then
                set r1 = GetUnitLifePercent(u) * 2.55
                call BlzSetSpecialEffectColor(TestFx, 255, 255, R2I(r1))
            endif

            //Absolute Fire
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_FIRE_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_FIRE_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
                    set r1 = 1 - RMaxBJ(0.25 * GetUnitElementCount(u, Element_Water), 0)
                    set i1 = R2I(/*(1+ GetUnitAbsoluteEffective(u, Element_Fire)) * */(i1 * GetUnitElementCount(u, Element_Fire)) * (1 + (0.005 * GetHeroLevel(u))) * r1)
                else
                    set i1 = R2I(i1 * GetUnitElementCount(u, Element_Fire)/* * (1+ GetUnitAbsoluteEffective(u, Element_Fire))*/)
                endif
                call AddUnitCustomState(u, BONUS_MAGICPOW, 0.3 * I2R(i1 - i2))	
                call SaveInteger(HT, hid,ABSOLUTE_FIRE_ABILITY_ID,i1)	
            endif

            //Absolute Water
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WATER_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_WATER_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                set i1 = R2I(i1 * GetUnitElementCount(u, Element_Water)/* * (1+ GetUnitAbsoluteEffective(u, Element_Water))*/)
                call SetHeroInt(u, GetHeroInt(u, false) + (10 * (i1 -i2)), false)
                call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) +(30 * (i1 -i2)))

                call SaveInteger(HT, hid,ABSOLUTE_WATER_ABILITY_ID,i1)
            endif

            //Absolute Wind
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WIND_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_WIND_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                set i1 = R2I(i1 * GetUnitElementCount(u, Element_Wind)/* * (1+ GetUnitAbsoluteEffective(u, Element_Wind))*/)
                call AddUnitCustomState(u , BONUS_EVASION,   0.25 * I2R(i1 - i2) )
                call SetHeroAgi(u,GetHeroAgi(u, false)+ 10 *(i1 - i2), false    )
                call SaveInteger(HT, hid,ABSOLUTE_WIND_ABILITY_ID,i1)	
            endif

            //Absolute Earth
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_EARTH_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_EARTH_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                set i1 = R2I(i1 * GetUnitElementCount(u, Element_Earth)/* * (1+ GetUnitAbsoluteEffective(u, Element_Earth))*/)
                call AddUnitCustomState(u , BONUS_BLOCK,   20 * I2R(i1 - i2) )	
                call SaveInteger(HT, hid,ABSOLUTE_EARTH_ABILITY_ID,i1)	
            endif

            //Absolute Blood
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_BLOOD_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_BLOOD_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                set i1 = R2I(i1 * GetUnitElementCount(u, Element_Blood)/* * (1+ GetUnitAbsoluteEffective(u, Element_Blood))*/)
                call SetHeroStr(u,GetHeroStr(u, false)+ 10 *(i1 - i2), false    )
                call SaveInteger(HT, hid,ABSOLUTE_BLOOD_ABILITY_ID,i1)	
            endif

            //Decaying Scythe
            set i2 = LoadInteger(HT, hid, DECAYING_SCYTHE_ABILITY_ID)
            if GetUnitAbilityLevel(u, DECAYING_SCYTHE_ABILITY_ID) > 0 then
                set i1 = GetUnitElementCount(u, Element_Poison)
                if i1 != i2 then
                    call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) + ((i1 - i2) * 300))
                    call SaveInteger(HT, hid,DECAYING_SCYTHE_ABILITY_ID,i1)
                endif
            elseif i2 != 0 then
                call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) - i2 * 300)
                call SaveInteger(HT, hid,DECAYING_SCYTHE_ABILITY_ID,0)
            endif

            //Brilliance Aura
            set i1 = GetUnitAbilityLevel(u, BRILLIANCE_AURA_ABILITY_ID)
            if i1 > 0 then
                call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + ((0.0001 * i1) * GetUnitState(u, UNIT_STATE_MAX_MANA)))
            endif

            //strength hp regen
            set i1 = GetHeroStr(u, true)
            set i2 = GetHeroSavedStrength(u)
            if i1 != i2 then
                call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, (i1 * 0.075) - (i2 * 0.075))
                call SaveHeroStrength(u, i1)
            endif

            //Absolute Wild
            set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WILD_ABILITY_ID)
            set i2 = LoadInteger(HT, hid,ABSOLUTE_WILD_ABILITY_ID)
            if i1 >= 1 or i2 != 0 then
                set i1 = R2I (i1 * GetUnitElementCount(u, Element_Wild)/* * (1+ GetUnitAbsoluteEffective(u, Element_Wild))*/)
                call AddUnitCustomState(u , BONUS_SUMMONPOW,   1 * I2R(i1 - i2) )	
                call SaveInteger(HT, hid,ABSOLUTE_WILD_ABILITY_ID,i1)	
            endif

            //Mana Bonus
            if GetUnitAbilityLevel(u ,MANA_BONUS_ABILITY_ID) >= 1 then
                set i1 = LoadInteger(HT, hid, 12)
                set i2 = 10000 * GetUnitAbilityLevel(u ,MANA_BONUS_ABILITY_ID)
                if i1 != i2 then
                    call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + i2 - i1)
                    call SaveInteger(HT, hid, 12,i2 )
                endif
            elseif LoadInteger(HT, hid, 12) != 0 then
                call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) - LoadInteger(HT, hid, 12) )
                call SaveInteger(HT, hid, 12,0)	
            endif

            //Thunder Witch
            if GetUnitTypeId(u) == THUNDER_WITCH_UNIT_ID then
                if BlzGetUnitAbilityCooldownRemaining(u, 'A08P') == 0 and CheckProc(u, 610) then
                    call ThunderWitchBolt(u, GetHeroLevel(u), hid)
                endif
            endif

            //Cold Knight
            if GetUnitTypeId(u) == COLD_KNIGHT_UNIT_ID then
                if BlzGetUnitAbilityCooldownRemaining(u, COLD_KNIGHT_PASSIVE_ABILITY_ID) == 0 and CheckProc(u, 600) then
                    call ColdKnight(u, GetUnitElementCount(u,Element_Cold), GetHeroLevel(u))
                endif
            endif

            //Pit Lord
            if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
                set r1 = 1 - RMaxBJ(0.25 * GetUnitElementCount(u, Element_Water), 0)
                set i1 = R2I(GetUnitCustomState(u, BONUS_MAGICPOW) * r1)
                set i2 = LoadInteger(HT, hid,PIT_LORD_UNIT_ID)
                if i1 != i2 then
                    call AddUnitCustomState(u, BONUS_PHYSPOW, 0 - i2)
                    call AddUnitCustomState(u, BONUS_PHYSPOW, i1)
                    call SaveInteger(HT, hid,PIT_LORD_UNIT_ID,i1)	
                endif
            endif

            //Naga Siren
            if GetUnitTypeId(u) == NAGA_SIREN_UNIT_ID then
                set i1 = NagaSirenBonus[hid] * GetHeroInt(u, true)
                set i2 = LoadInteger(HT, hid,NAGA_SIREN_UNIT_ID)
                if i1 != i2 then
                    call AddUnitBonus(u, BONUS_DAMAGE, 0 - i2 + i1)
                    call SaveInteger(HT, hid, NAGA_SIREN_UNIT_ID, i1)
                endif
            endif

            //Time Manipulation
            if GetUnitAbilityLevel(u, TIME_MANIPULATION_ABILITY_ID) > 0 and CurrentlyFighting[GetPlayerId(GetOwningPlayer(u))] and TimeManipulationTable[hid].boolean[1] then
                if BlzGetUnitAbilityCooldownRemaining(u, TIME_MANIPULATION_ABILITY_ID) == 0 then
                    set TimeManipulationTable[hid].real[2] = TimeManipulationTable[hid].real[2] + 1
                    call StartFunctionSpell(u, 6)
                endif
            endif

            //hp regen
            set r1 = GetUnitTotalHpRegen(u) * 0.1
            if r1 > 0 then
                call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) + r1)
            endif
        endif

        set u = null
    endfunction

    private function LongPeriodCheckActions takes nothing returns nothing
        call ForGroup(OnPeriodGroup, function OnPeriod)
    endfunction

    private function init takes nothing returns nothing
        local trigger longPeriodCheckTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(longPeriodCheckTrigger, 0.1)
        call TriggerAddAction(longPeriodCheckTrigger, function LongPeriodCheckActions)
        set longPeriodCheckTrigger = null
    endfunction

endscope

