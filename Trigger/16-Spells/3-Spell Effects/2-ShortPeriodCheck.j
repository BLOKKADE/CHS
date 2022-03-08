scope ShortPeriodCheck initializer init
    function Trig_ShortPeriodCheck_Actions takes nothing returns nothing
        local integer II = 0
        local integer i1 = 0
        local integer i2 = 0
        local string s = null
        local string s2 = null
        local string s3 = null
        local unit u
        local integer hid = 0
        local real r1 = 0
        local real r2 = 0
        
        loop
            exitwhen II > 8
            set u = PlayerHeroes[II]
            set hid = GetHandleId(u)
            if GetWidgetLife(u) > 0.405 then

                if not HasPlayerFinishedLevel(u, Player(II - 1)) then
                    
                    //Blokkades Shield
                    if GetUnitAbilityLevel(u, BLOKKADE_SHIELD_ABIL_ID) > 0 then
                        if T32_Tick - BlokShieldStartTick[hid] > 32 * 6 then
                            set BlokShieldStartTick[hid] = T32_Tick
                            set BlokShieldCharges[hid] = BlokShieldCharges[hid] + 1
                            call SetBlokShieldCharges(u, hid)
                        endif
                    endif
                    
                    //Fire Shield
                    set i1 = GetUnitAbilityLevel(u, FIRE_SHIELD_ABILITY_ID)
                    if i1 > 0 then
                        call AreaDamage(u, GetUnitX(u), GetUnitY(u), 40 * i1, 300, false, FIRE_SHIELD_ABILITY_ID)
                    endif

                    //Absolute Arcane Drain
                    set i1 = GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID)
                    if i1 > 0 then
                        call AbsoluteArcaneDrain(u)
                    endif

                    //Vigour token
                    if GetUnitAbilityLevel(u, 'A09A') > 0 then
                        call VigourTokenHpLoss(u)
                    endif

                    //Power of Ice
                    if GetUnitAbilityLevel(u ,POWER_OF_ICE_ABILITY_ID) >= 1 then
                        if CheckProc(u, 610) then
                            call USOrderA(u,GetUnitX(u),GetUnitY(u),'A02Y',"fanofknives", (100 * GetUnitAbilityLevel(u ,POWER_OF_ICE_ABILITY_ID)) * (1 + (GetHeroLevel(u)* 0.02)), ConvertAbilityRealLevelField('Ocl1') )
                        endif
                        
                    endif
                    
                    //Absolute Blood
                    set i1 = GetUnitAbilityLevel(u,ABSOLUTE_BLOOD_ABILITY_ID)
                    if i1 > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0 then
                        set s = GetAbilityDescription(ABSOLUTE_BLOOD_ABILITY_ID,i1 - 1)
                        if LoadReal(HT,hid,- 93001) == 0 then
                            set s2 = "50"
                        else
                            set s2 = I2S(R2I(LoadReal(HT,hid,- 93001)))
                        endif
                            
                        set s3 = ReplaceText("2000",s2,s)
                        set s3 = ReplaceText(",0000,", R2S(   LoadReal(HT,hid,- 93000) ) ,s3)
                        if GetLocalPlayer() == GetOwningPlayer(u) then
                            call BlzSetAbilityExtendedTooltip(ABSOLUTE_BLOOD_ABILITY_ID,s3  , i1 - 1  ) 
                        endif
                    
                    endif
                    
                    //Ancient Blood
                    set i1 = GetUnitAbilityLevel(u,ANCIENT_BLOOD_ABILITY_ID)
                    if i1 > 0 then
                        set s = GetAbilityDescription(ANCIENT_BLOOD_ABILITY_ID,i1 - 1)
                        if LoadReal(HT,hid,82341) == 0 then
                            set s2 = "20000"
                        else
                            set s2 = I2S(R2I(LoadReal(HT,hid,82341)*(1 - I2R(i1)* 0.01 ) ))
                        endif
                        
                        set s3 = ReplaceText("20,000",s2,s) 
                        set s3 = ReplaceText(",0000,", R2S(   LoadReal(HT,hid,82340) ) ,s3)
                            
                        if GetLocalPlayer() == GetOwningPlayer(u) then
                            call BlzSetAbilityExtendedTooltip(ANCIENT_BLOOD_ABILITY_ID,s3  , i1 - 1  ) 
                        endif
                    
                    endif
                            
                    //Absolute Cold
                    set i1 = GetUnitAbilityLevel(u,ABSOLUTE_COLD_ABILITY_ID)
                    if i1 > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0  then
                        if BlzGetUnitAbilityCooldownRemaining(u,ABSOLUTE_COLD_ABILITY_ID) == 0 and CheckProc(u, 500) then
                            call AbilStartCD(u, ABSOLUTE_COLD_ABILITY_ID, 20.5 - (0.5 * i1))
                            call AbsoluteCold(u,GetClassUnitSpell(u,9)* 20 * i1 )
                        endif
                    endif
                    
                    //Divine Gift
                    set i1 = GetUnitAbilityLevel(u,DIVINE_GIFT_ABILITY_ID)
                    if i1 > 0 then
                        if BlzGetUnitAbilityCooldownRemaining(u,DIVINE_GIFT_ABILITY_ID) == 0 and GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(u, UNIT_STATE_MAX_LIFE) then
                            call AbilStartCD(u, DIVINE_GIFT_ABILITY_ID, 8)
                            call SetWidgetLife(u,GetWidgetLife(u)+ 2500 * i1)
                            call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", u, "chest",3, false)
                            call RemoveDebuff( u, 1)
                        endif
                    endif
                endif

                //Trueshot Aura
                set i1 = GetUnitAbilityLevel(u ,TRUESHOT_AURA_ABILITY_ID)
                set r1 = LoadReal(HT,hid,TRUESHOT_AURA_ABILITY_ID)
                if i1 > 0 or r1 != 0 then
                    set r2 = (BlzGetUnitBaseDamage(u, 0) * (0.05 * (i1)))
                    if r2 != r1 then
                        call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                        call SaveReal(HT, hid, TRUESHOT_AURA_ABILITY_ID, r2)	
                    endif
                endif

                //Command Aura
                set i1 = GetUnitAbilityLevel(u ,COMMAND_AURA_ABILITY_ID)
                set r1 = LoadReal(HT,hid,COMMAND_AURA_ABILITY_ID)
                if i1 > 0 or r1 != 0 then
                    set r2 = (BlzGetUnitBaseDamage(u, 0) * (0.1 * (i1)))
                    if r2 != r1 then
                        call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                        call SaveReal(HT, hid, COMMAND_AURA_ABILITY_ID, r2)	
                    endif
                endif

                //Frostmourne
                set i1 = GetUnitAbilityLevel(u , 'A02C')
                set r1 = LoadReal(HT,hid,'A02C')
                if i1 > 0 or r1 != 0 then
                    set r2 = (BlzGetUnitBaseDamage(u, 0) * (3.5 * i1))
                    if r1 != r2 then
                        call AddUnitBonus(u, BONUS_DAMAGE, R2I(r2 - r1))
                        call SaveReal(HT, hid, 'A02C', r2)	
                    endif
                endif

                //Titanium Armor
                set i1 = GetUnitAbilityLevel(u , 'A05T')
                set i2 = LoadInteger(HT,hid,'A05T')
                if i1 > 0 or i2 != 0 then
                    set i1 = R2I(GetHeroStr(u, true) * 0.25) * i1
                    if i1 != i2 then
                        call AddUnitBlock(u, i1 - i2)
                        call SaveInteger(HT, hid, 'A05T', i1)	
                    endif
                endif

                //glory hp regen
                if GloryRegenLevel[hid] > 0 then
                    set r1 = BlzGetUnitRealField(u, ConvertUnitRealField('uhpr')) + GetSpellValue(10, 5, GetUnitAbilityLevel(u, UNHOLY_AURA_ABILITY_ID)) + (UnitHasItemI(u, 'I04N') * 1500)
                    set r1 = r1 * (GloryRegenLevel[hid] * 0.15)
                    set r2 = LoadReal(DataUnitHT, hid, 1000)
                    if r1 != r2 then
                        call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 0 - r2 + r1)
                        //call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),(BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) - i2) + i1)
                        call SaveReal(DataUnitHT, hid, 1000, r1)
                    endif
                endif

                //Blood Elf Mage
                if GetUnitTypeId(u) == BLOOD_MAGE_UNIT_ID then
                    set i1 = R2I(GetUnitState(u, UNIT_STATE_MAX_MANA))
                    set i1 = R2I((i1 - ModuloInteger(i1, 1000)) / 1000)
                    set i2 = LoadInteger(DataUnitHT, hid, 542)
                    if i1 != i2 then
                        call AddUnitMagicDmg(u, 0 - i2)
                        call AddUnitMagicDmg(u, i1)
                        call SaveInteger(DataUnitHT, hid, 542, i1)
                    endif

                    //Head Hunter
                elseif GetUnitTypeId(u) == TROLL_HEADHUNTER_UNIT_ID then
                    set i1 = R2I(GetHeroStr(u, true) * (0.4 + (0.015 * GetHeroLevel(u))))
                    set i2 = LoadInteger(DataUnitHT, hid, 542)
                    if i1 != i2 then
                        //call AddUnitBonusR(u, BONUS_HEALTH_REGEN, 0 - i2 + i1)
                        call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),(BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) - i2) + i1)
                        call SaveInteger(DataUnitHT, hid, 542, i1)
                    endif
                    
                    //War Golem
                elseif GetUnitTypeId(u) == WAR_GOLEM_UNIT_ID then
                    set i1 = R2I((GetHeroStr(u, true) * 26) * (0.49 + (0.01 * GetHeroLevel(u))))
                    set i2 = LoadInteger(DataUnitHT, hid, 542)
                    if i1 != i2 then
                        call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) - i2 + i1)
                        call CalculateNewCurrentHP(u, i1 - i2)
                        call SaveInteger(DataUnitHT, hid, 542, i1)
                    endif

                    //Abomination
                elseif GetUnitTypeId(u) == ABOMINATION_UNIT_ID then
                    if CheckProc(u, 350) then
                        call ElemFuncStart(u,ABOMINATION_UNIT_ID)
                        call AreaDamage(u, GetUnitX(u), GetUnitY(u), 40 * GetHeroLevel(u), 350, false, ABOMINATION_UNIT_ID)
                    endif

                    //Yeti
                elseif GetUnitTypeId(u) == YETI_UNIT_ID then
                    if BlzGetUnitArmor(u) <= 50 + (2 * GetHeroLevel(u)) * (1 + (0.1 * GetClassUnitSpell(u, Element_Cold))) then
                        if GetUnitAbilityLevel(u, 'A092') == 0 then
                            call UnitAddAbility(u, 'A092')
                        endif
                        set i1 = LoadInteger(DataUnitHT,hid,542)
                        set i2 = R2I((20 * GetHeroLevel(u)) * (1 + (0.1 * GetClassUnitSpell(u, Element_Cold))) - i1)
                        call SetHeroStr(u,GetHeroStr(u,false)+ i2, false)
                        call SaveInteger(DataUnitHT,hid,542, R2I((20 * GetHeroLevel(u)) * (1 + (0.1 * GetClassUnitSpell(u, Element_Cold)))))
                    else
                        set i1 = LoadInteger(DataUnitHT,hid,542)
                        call SetHeroStr(u,GetHeroStr(u,false)- i1, false)
                        call SaveInteger(DataUnitHT,hid,542,0)
                        call UnitRemoveAbility(u, 'A092')
                    endif

                elseif GetUnitTypeId(u) == 'U000' then
                    call WolfRiderStatBonus(u, hid)
                
                    //Rock Golem
                elseif GetUnitTypeId(u) == ROCK_GOLEM_UNIT_ID then
                    set i1 = LoadInteger(DataUnitHT,hid,542)
                    set i2 = R2I((GetUnitBlock(u) - i1) * (0.01 * GetHeroLevel(u)))
                    if i1 != i2 then
                        call AddUnitBlock(u, 0 - i1)
                        call AddUnitBlock(u, i2)
                        call SaveInteger(DataUnitHT, hid, 542, i2)
                    endif
                
                    //Dark Avatar
                elseif GetUnitTypeId(u) == AVATAR_SPIRIT_UNIT_ID then
                    call SetAvatarMode(u, GetHeroLevel(u))
                endif
            endif
            set II = II + 1
        endloop

        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic( trg, 1 )
        call TriggerAddAction( trg, function Trig_ShortPeriodCheck_Actions )
        set trg = null
    endfunction
endscope