scope ShortPeriodCheck initializer init

    private function OnPeriod takes nothing returns nothing
        local integer i1 = 0
        local integer i2 = 0
        local string s = null
        local string s2 = null
        local string s3 = null
        local unit u = GetEnumUnit()
        local integer hid = GetHandleId(u)
        local real r1 = 0
        local real r2 = 0
        local integer unitTypeId = GetUnitTypeId(u)

        if UnitAlive(u) then
            if not HasPlayerFinishedLevel(u, GetOwningPlayer(u)) then
                
                //Blokkades Shield
                if GetUnitAbilityLevel(u, BLOKKADE_SHIELD_ABIL_ID) > 0 then
                    if T32_Tick - BlokShieldStartTick[hid] > 32 * 6 then
                        set BlokShieldStartTick[hid] = T32_Tick
                        set BlokShieldCharges[hid] = BlokShieldCharges[hid] + 1
                        call SetBlokShieldCharges(u, hid)
                    endif
                endif

                //Crypt Lord
                if unitTypeId == CRYPT_LORD_UNIT_ID then
                    if BlzGetUnitAbilityCooldownRemaining(u, 'A0F3') == 0 then
                        call ElemFuncStart(u, CRYPT_LORD_UNIT_ID)
                        call BlzStartUnitAbilityCooldown(u, 'A0F3', 10)
                        call SpawnLocustSwarm(u)
                    endif
                endif
                
                //Fire Shield
                set i1 = GetUnitAbilityLevel(u, FIRE_SHIELD_ABILITY_ID)
                if i1 > 0 then
                    call AreaDamage(u, GetUnitX(u), GetUnitY(u), 40 * i1, 300, false, FIRE_SHIELD_ABILITY_ID, true, false)
                endif

                //Absolute Arcane Drain
                set i1 = GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID)
                if i1 > 0 then
                    call AbsoluteArcaneDrain(u)
                endif

                set i1 = GetUnitAbilityLevel(u, ABSOLUTE_DARK_ABILITY_ID)
                if i1 > 0 then
                    call CastAbsoluteDark(u)
                endif

                //Vigour token
                if GetUnitAbilityLevel(u, 'A09A') > 0 then
                    call VigourTokenHpLoss(u)
                endif

                //Power of Ice
                if GetUnitAbilityLevel(u, POWER_OF_ICE_ABILITY_ID) >= 1 then
                    if CheckProc(u, 610) then
                        call DummyInstantCast1(u, GetUnitX(u), GetUnitY(u),'A02Y',"fanofknives", (100 * GetUnitAbilityLevel(u, POWER_OF_ICE_ABILITY_ID)) * (1 + (GetHeroLevel(u)* 0.02)), ConvertAbilityRealLevelField('Ocl1'), 4)
                    endif
                endif
                
                //Absolute Blood
                set i1 = GetUnitAbilityLevel(u,ABSOLUTE_BLOOD_ABILITY_ID)
                if i1 > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0 then
                    set s = GetAbilityDescription(ABSOLUTE_BLOOD_ABILITY_ID,i1 - 1)
                    if LoadReal(HT, hid, -93001) == 0 then
                        set s2 = "50"
                    else
                        set s2 = I2S(R2I(LoadReal(HT, hid, -93001)))
                    endif
                        
                    set s3 = ReplaceText("2000",s2,s)
                    set s3 = ReplaceText(",0000,", R2S(  LoadReal(HT, hid, -93000)), s3)

                    if GetLocalPlayer() == GetOwningPlayer(u) then
                        call BlzSetAbilityExtendedTooltip(ABSOLUTE_BLOOD_ABILITY_ID, s3, i1 - 1 ) 
                    endif
                endif
                        
                //Divine Gift
                set i1 = GetUnitAbilityLevel(u,DIVINE_GIFT_ABILITY_ID)
                if i1 > 0 then
                    if BlzGetUnitAbilityCooldownRemaining(u,DIVINE_GIFT_ABILITY_ID) == 0 and GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(u, UNIT_STATE_MAX_LIFE) then
                        call AbilStartCD(u, DIVINE_GIFT_ABILITY_ID, 8)
                        call SetWidgetLife(u, GetWidgetLife(u) + 2500 * i1)
                        call TempFx.target("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", u, "chest",3, false)
                        call RemoveUnitBuffs(u, BUFFTYPE_NEGATIVE, false)
                    endif
                endif
            endif

            //Trueshot Aura
            set i1 = GetUnitAbilityLevel(u,TRUESHOT_AURA_ABILITY_ID)
            set r1 = LoadReal(HT, hid,TRUESHOT_AURA_ABILITY_ID)
            if i1 > 0 or r1 != 0 then
                set r2 = (BlzGetUnitBaseDamage(u, 0) * (0.05 * (i1)))
                if r2 != r1 then
                    call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                    call SaveReal(HT, hid, TRUESHOT_AURA_ABILITY_ID, r2)	
                endif
            endif

            //Command Aura
            set i1 = GetUnitAbilityLevel(u,COMMAND_AURA_ABILITY_ID)
            set r1 = LoadReal(HT, hid,COMMAND_AURA_ABILITY_ID)
            if i1 > 0 or r1 != 0 then
                set r2 = (BlzGetUnitBaseDamage(u, 0) * (0.1 * (i1)))
                if r2 != r1 then
                    call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                    call SaveReal(HT, hid, COMMAND_AURA_ABILITY_ID, r2)	
                endif
            endif

            //Frostmourne
            set i1 = GetUnitAbilityLevel(u, 'A02C')
            set r1 = LoadReal(HT, hid,'A02C')
            if i1 > 0 or r1 != 0 then
                set r2 = (BlzGetUnitBaseDamage(u, 0) * (3.5 * i1))
                if r1 != r2 then
                    call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                    call SaveReal(HT, hid, 'A02C', r2)	
                endif
            endif

            //Titanium Armor
            set i1 = GetUnitAbilityLevel(u, 'A05T')
            set i2 = LoadInteger(HT, hid,'A05T')
            if i1 > 0 or i2 != 0 then
                set i1 = R2I(GetHeroStr(u, true) * 0.15) * i1
                if i1 != i2 then
                    call AddUnitCustomState(u, BONUS_BLOCK, i1 - i2)
                    call SaveInteger(HT, hid, 'A05T', i1)	
                endif
            endif

            //glory hp regen
            if GloryRegenLevel[hid] > 0 then
                set r2 = GetUnitCustomState(u, BONUS_GLORYREGEN)
                set r1 = GetUnitPositiveHpRegen(u) - r2

                set r1 = r1 * (GloryRegenLevel[hid] * 0.15)
                if r1 != r2 then
                    call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 0 - r2 + r1)
                    call SetUnitCustomState(u, BONUS_GLORYREGEN, r1)
                endif
            endif

            //Gemstone
            if GetUnitAbilityLevel(u, 'A02G') > 0 then
                call SetUnitManaPercentBJ(u, GetUnitManaPercent(u) + 1)
            endif

            //Blood Elf Mage
            if unitTypeId == BLOOD_MAGE_UNIT_ID then
                set r1 = 60 - (3 * R2I((GetHeroLevel(u) - ModuloInteger(GetHeroLevel(u), 30)) / 30))
                set i1 = GetHeroInt(u, true)
                set i1 = R2I((i1 - ModuloInteger(i1, R2I(r1))) / r1)
                set i2 = LoadInteger(DataUnitHT, hid, 542)
                if i1 != i2 then
                    call AddUnitCustomState(u, BONUS_MAGICPOW, 0 - i2)
                    call AddUnitCustomState(u, BONUS_MAGICPOW, i1)
                    call SaveInteger(DataUnitHT, hid, 542, i1)
                endif

                //Letinant passive
            elseif unitTypeId == LIEUTENANT_UNIT_ID then
                set i1 = GetHeroInt(u, true) + GetHeroAgi(u, true)
                set i2 = LoadInteger(DataUnitHT, hid, 542)
                if i1 != i2 then
                    call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) - i2 + i1, 0)
                    call SaveInteger(DataUnitHT, hid, 542, i1)
                endif

                //Head Hunter
            elseif unitTypeId == TROLL_HEADHUNTER_UNIT_ID then
                set i1 = R2I(GetHeroStr(u, true) * (0.4 + (0.015 * GetHeroLevel(u))))
                set i2 = LoadInteger(DataUnitHT, hid, 542)
                if i1 != i2 then
                    call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 0 - i2 + i1)
                    //call AddUnitBonusR(u, BONUS_HEALTH_REGEN, 0 - i2 + i1)
                    //call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),(BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) - i2) + i1)
                    call SaveInteger(DataUnitHT, hid, 542, i1)
                endif
                
                //War Golem
            elseif unitTypeId == WAR_GOLEM_UNIT_ID then
                set i1 = R2I((GetHeroStr(u, true) * 26) * (0.49 + (0.01 * GetHeroLevel(u))))
                set i2 = LoadInteger(DataUnitHT, hid, 542)
                if i1 != i2 then
                    call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) - i2 + i1)
                    call SaveInteger(DataUnitHT, hid, 542, i1)
                endif

                //Doom Guard
            elseif unitTypeId == DOOM_GUARD_UNIT_ID then
                if CheckProc(u, 600) then
                    call DoomGuardHellfire(u)
                endif

                //Abomination
            elseif unitTypeId == ABOMINATION_UNIT_ID then
                if CheckProc(u, 350) then
                    call ElemFuncStart(u,ABOMINATION_UNIT_ID)
                    call AreaDamage(u, GetUnitX(u), GetUnitY(u), 40 * GetHeroLevel(u), 350, false, ABOMINATION_UNIT_ID, true, false)
                endif

                //Yeti
            elseif unitTypeId == YETI_UNIT_ID then
                set i1 = LoadInteger(DataUnitHT, hid, YETI_UNIT_ID)
                set i2 = R2I((GetHeroStr(u, false) - i1) * ((YetiStrengthBonus.integer[hid] * 0.005) * GetUnitElementCount(u, Element_Cold)))
                if i1 != i2 then
                    call SetHeroStr(u, GetHeroStr(u, false) - i1 + i2, false)
                    call SaveInteger(DataUnitHT, hid, YETI_UNIT_ID, i2)
                endif
            elseif unitTypeId == WOLF_RIDER_UNIT_ID then
                call WolfRiderStatBonus(u, hid)
            
                //Rock Golem
            elseif unitTypeId == ROCK_GOLEM_UNIT_ID then
                set i1 = LoadInteger(DataUnitHT, hid,542)
                set i2 = R2I((GetUnitCustomState(u, BONUS_BLOCK) - i1) * (0.01 * GetHeroLevel(u)))
                if i1 != i2 then
                    call AddUnitCustomState(u, BONUS_BLOCK, 0 - i1)
                    call AddUnitCustomState(u, BONUS_BLOCK, i2)
                    call SaveInteger(DataUnitHT, hid, 542, i2)
                endif
            
                //Dark Avatar
            elseif unitTypeId == AVATAR_SPIRIT_UNIT_ID then
                call SetAvatarMode(u, GetHeroLevel(u))
            
                //Gnome
            elseif unitTypeId == GNOME_MASTER_UNIT_ID then
                call GnomeIncreaseCharge(u)

            endif
        endif

        set u = null
    endfunction
    
    private function ShortPeriodCheckActions takes nothing returns nothing
        call ForGroup(OnPeriodGroup, function OnPeriod)
    endfunction

    private function init takes nothing returns nothing
        local trigger shortPeriodCheckTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(shortPeriodCheckTrigger, 1)
        call TriggerAddAction(shortPeriodCheckTrigger, function ShortPeriodCheckActions)
        set shortPeriodCheckTrigger = null
    endfunction

endscope