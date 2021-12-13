scope LongPeriodCheck initializer init
    function FunctionAttackSpeedA takes unit u returns nothing
        local real r1 = LoadReal(HT, GetHandleId(u),- 1001 )
        local real r2 = 0
        local real i1 = I2R(GetUnitAbilityLevel(u,MEGA_SPEED_ABILITY_ID))
        local real i2 = UnitHasItemI(u,'I066')



        if i1 > 0 then
            set r2 = 0.92 - 0.02 * i1

        else

            set r2 = r1 
        endif

        set r2 = r2 + i2 * 1.4

        if GetUnitAbilityLevel(u, FLIMSY_TOKEN_BUFF_ID) > 0 then
            set r2 = r2 + 0.4
        endif

        if UnitHasItemS(u,'I06B') then
            set r2 = r2 * 0.8
        endif

        if GetUnitTypeId(u) == TROLL_BERSERKER_UNIT_ID then

            set r2 = r2 * 100 /(I2R(100 + GetHeroLevel(u))) 
        endif

        //  call DisplayTextToPlayer(GetLocalPlayer(),0,0,R2S(r2))
        call BlzSetUnitAttackCooldown(u,r2,0)



    endfunction



    function AABfunction takes unit u returns nothing
        if HasPlayerFinishedLevel(u ,GetOwningPlayer(u)) == false then
            //Mysterious Talent
            if GetUnitAbilityLevel(u,MYSTERIOUS_TALENT_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u,MYSTERIOUS_TALENT_ABILITY_ID) <= 0.001 then
                call MysteriousTalentActivate(u)
                call AbilStartCD(u,MYSTERIOUS_TALENT_ABILITY_ID,45 - GetUnitAbilityLevel(u,MYSTERIOUS_TALENT_ABILITY_ID) ) 
            endif

            //Holy Shield
            if GetUnitAbilityLevel(u,'A066') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A066') <= 0.001 and GetWidgetLife(u)/ I2R(BlzGetUnitMaxHP(u)) < 0.75 then
                call UseSpellsHolyShield(u)
                call AbilStartCD(u,'A066',10 ) 
            endif

            //Runestone of Creation
            if GetUnitAbilityLevel(u,'A073') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A073') <= 0.001 and GetUnitState(u,UNIT_STATE_MANA) >= 2000 then
                call CreateRandomRune(0,GetUnitX(u),GetUnitY(u),u )
                call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)- 2000)
                call AbilStartCD(u,'A073',20 ) 
            endif

            //Earthquake
            if GetUnitAbilityLevel(u,EARTHQUAKE_ABILITY_ID) > 0 and BlzGetUnitAbilityCooldownRemaining(u,EARTHQUAKE_ABILITY_ID) <= 0.001 and CheckProc(u, 600) then
                call USOrder4field(u,GetUnitX(u),GetUnitY(u),'A07M',"thunderclap",GetUnitAbilityLevel(u,EARTHQUAKE_ABILITY_ID)* 100,ABILITY_RLF_DAMAGE_INCREASE,600,ABILITY_RLF_CAST_RANGE ,0.5,ABILITY_RLF_DURATION_HERO,0.5,ABILITY_RLF_DURATION_NORMAL)
                call AbilStartCD(u,EARTHQUAKE_ABILITY_ID,5 ) 
            endif
        endif
    endfunction

    function FunUpdateSkill takes integer i returns nothing
        local integer i1 = 1
        local player Pl = Player(i)
        local integer SpellId = 0
        local string textureS = ""
        local integer unitId = GetUnitTypeId(udg_units01[NumPlayerLast[i] + 1])

        if unitId != 0 then
            if GetLocalPlayer() == Pl then
                set textureS = LoadStr(HT_data, unitId, 1)
                call BlzFrameSetVisible(SpellUP[38], true) // Element count
                call BlzFrameSetVisible(SpellUP[100], true) // Hero passive/description
                call BlzFrameSetTexture(SpellFR[100], textureS, 0, true)
            endif
        else
            if GetLocalPlayer() == Pl then
                call BlzFrameSetVisible(SpellUP[38], false) // Element count
                call BlzFrameSetVisible(SpellUP[100], false) // Hero passive/description
            endif
        endif

        if NumPlayerLast[i] == 11 then
            loop
                exitwhen i1 > 21
                set SpellId = roundAbilities[i1]
                if SpellId != 0 then
                    set textureS = BlzGetAbilityIcon(SpellId)

                    if GetLocalPlayer() == Pl then
                        call BlzFrameSetVisible(SpellUP[100 + i1], true)
                        call BlzFrameSetTexture(SpellFR[100 + i1], textureS, 0, true)
                    endif
                else
                    if GetLocalPlayer() == Pl then
                        call BlzFrameSetVisible(SpellUP[100 + i1], false)
                    endif
                endif
                set i1 = i1 + 1
            endloop
        else
            loop
                exitwhen i1 > 21
                set SpellId = GetInfoHeroSpell(udg_units01[NumPlayerLast[i] + 1] , i1)
                if SpellId != 0 then
                    set textureS = BlzGetAbilityIcon(SpellId)

                    if GetLocalPlayer() == Pl then
                        call BlzFrameSetVisible(SpellUP[100 + i1], true)
                        call BlzFrameSetTexture(SpellFR[100 + i1], textureS, 0, true)
                    endif
                else
                    if GetLocalPlayer() == Pl then
                        call BlzFrameSetVisible(SpellUP[100 + i1], false)
                    endif
                endif
                set i1 = i1 + 1
            endloop
        endif

        if ShowCreepAbilButton[i] then
            if GetLocalPlayer() == Pl then
                call BlzFrameSetVisible(SpellUP[2], true)
            endif
        else
            if GetLocalPlayer() == Pl then
                call BlzFrameSetVisible(SpellUP[2], false)
            endif
        endif

        set Pl = null
    endfunction




    function Trig_LongPeriodCheck_Actions takes nothing returns nothing
        local integer II = 0

        local real ARMORN = 0
        local real ARMORN2 = 0
        local real ARMFIN = 0
        local real ARMG = 0
        local real HpR = 0
        local real MpR = 0
        local integer MANA1 = 0
        local integer MANA2 = 0

        local real r1 = 0
        local real r2 = 0

        local integer i1 = 0
        local integer i2 = 0


        local real Agi1 = 0
        local real Agi2 = 0
        local real Str1 = 0
        local real Str2 = 0
        local real Int1 = 0
        local real Int2 = 0

        local real Smat1 = 0
        local real Smat2 = 0
        local real HpBonus = 0
        local unit u
        local integer hid = 0

        loop
            exitwhen II > 8



            call FunUpdateSkill(II)
            set u = udg_units01[II]
            set hid = GetHandleId(u)
            if GetWidgetLife(u) > 0.405 then
                call FunctionAttackSpeedA(u)

                //Double Armor
                if GetUnitAbilityLevel(u ,'B00F') >= 1 then
                    set ARMORN = BlzGetUnitArmor(u)
                    set ARMORN2 = LoadReal(HT,hid,11)
                    set ARMFIN = ARMORN - ARMORN2
                    set ARMG = ARMFIN - ARMORN2 
                    call SaveReal(HT,hid,11,ARMORN2 + ARMG  )

                    call BlzSetUnitArmor(u,ARMORN + ARMG   )
                elseif LoadReal(HT,hid,11) != 0 then
                    call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - LoadReal(HT,hid,11)   )
                    call SaveReal(HT,hid,11,0)
                endif

                //Panda Relic
                if GetUnitAbilityLevel(u ,'B00S') >= 1 then
                    set Agi1 = GetHeroAgi(u,false)
                    set Agi2 = LoadReal(HT,hid,1001)
                    set Smat1 = R2I((Agi1 - Agi2)* 0.35)  //?????? ????

                    call SaveReal(HT,hid,1001 ,Smat1   )
                    call SetHeroAgi(u,R2I(Agi1 + Smat1 - Agi2 ) ,false)

                    set Str1 = GetHeroStr(u,false)
                    set Str2 = LoadReal(HT,hid,1002)
                    set Smat1 = R2I((Str1 - Str2)* 0.35)  //?????? ????

                    call SaveReal(HT,hid,1002 ,Smat1   )
                    call SetHeroStr(u,R2I(Str1 + Smat1 - Str2 ) ,false)

                    set Int1 = GetHeroInt(u,false)
                    set Int2 = LoadReal(HT,hid,1003)
                    set Smat1 = R2I((Int1 - Int2)* 0.35)  //?????? ????

                    call SaveReal(HT,hid,1003 ,Smat1   )
                    call SetHeroInt(u,R2I(Int1 + Smat1 - Int2 ) ,false)
                elseif (LoadReal(HT,hid,1001) != 0) or (LoadReal(HT,hid,1002) != 0) or (LoadReal(HT,hid,1003) != 0) then
                    call SetHeroAgi(u,R2I(GetHeroAgi(u,false) - (LoadReal(HT,hid,1001)) ) ,false)	
                    call SaveReal(HT,hid,1001,0)

                    call SetHeroStr(u,R2I(GetHeroStr(u,false) - (LoadReal(HT,hid,1002)) ) ,false)	
                    call SaveReal(HT,hid,1002,0)

                    call SetHeroInt(u,R2I(GetHeroInt(u,false) - (LoadReal(HT,hid,1003)) ) ,false)	
                    call SaveReal(HT,hid,1003,0)		
                endif

                //Relic of Magic
                if GetUnitAbilityLevel(u ,'B00Q') >= 1 then	
                    set HpR = BlzGetUnitMaxHP(u)  - GetWidgetLife(u) 

                    if HpR > 0 then
                        set MpR = GetUnitState(u, UNIT_STATE_MANA)/ 100 

                        if MpR > HpR then
                            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - HpR  )
                            call SetWidgetLife(u,  GetWidgetLife(u) + HpR) 
                        else
                            call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) - MpR  )
                            call SetWidgetLife(u,  GetWidgetLife(u) + MpR)      
                        endif
                    endif
                endif
                
                set HpBonus = 0
                //Heart of a Hero
                if GetUnitAbilityLevel(u ,'B00N') >= 1 then
                    set HpBonus = HpBonus + 1
                endif

                //Absolute Light
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_LIGHT_ABILITY_ID)
                if i1 >= 1  then
                    set i1 = i1 * GetClassUnitSpell(u,8)
                    set HpBonus = HpBonus + 0.005 * I2R(i1)
                endif

                //Divine Gift
                set i1 = GetUnitAbilityLevel(u ,DIVINE_GIFT_ABILITY_ID)
                if i1 >= 1 then
                    set HpBonus = HpBonus + 0.05 * I2R(i1)
                endif

                call SetUnitProcHp(u,HpBonus)

                set i2 = LoadInteger(HT,hid,'B026')
                //Goblet of Blood
                if GetUnitAbilityLevel(u, 'B026') > 0 then
                    set i1 = R2I(BlzGetUnitMaxHP(u) * 0.1)

                    if i1 != i2 then
                        call UnitAddAttackDamage(u, 0 - i2 + i1)
                        call SaveInteger(HT,hid,'B026',i1)
                    endif
                elseif i2 != 0 then
                    call UnitAddAttackDamage(u, 0 - i2)
                    call SaveInteger(HT,hid,'B026',0)
                endif

                if not HasPlayerFinishedLevel(u, GetOwningPlayer(u)) then
                    //Drain aura
                    set i1 = GetUnitAbilityLevel(u ,DRAIN_AURA_ABILITY_ID)
                    if i1 >= 1 or UnitHasItemS(u, 'I0B5') then
                        if UnitHasItemS(u, 'I0B5') then
                            call AoeDrainAura(u, (I2R(i1) * 0.0001) + 0.001,500,true)
                        else
                            call AoeDrainAura(u, (I2R(i1) * 0.0001),500,true)
                        endif
                    endif
                endif
                call AABfunction(u)

                //Banshee
                if GetUnitTypeId(u) == BANSHEE_UNIT_ID then
                    set i1 = (BlzGetUnitMaxHP(u)* 3)/ 4
                    set i2 = LoadInteger(HT,hid,BANSHEE_UNIT_ID)

                    call BlzSetUnitMaxMana(u,BlzGetUnitMaxMana(u)+ i1 - i2   )
                    call SaveInteger(HT,hid,BANSHEE_UNIT_ID,i1  )

                endif


                //Robes of the Archmage
                if GetUnitAbilityLevel(u ,'B00L') >= 1 then

                    set ARMORN = R2I( (BlzGetUnitMaxMana( u )  - GetUnitState( u  , UNIT_STATE_MANA  )  )/ 300 )
                    set ARMORN2 = LoadReal(HT,hid,291)

                    set ARMFIN = BlzGetUnitArmor(u)

                    set ARMG = ARMORN + ARMFIN - ARMORN2

                    call SaveReal(HT,hid,291,ARMORN  )
                    call BlzSetUnitArmor(u,ARMG  )

                elseif LoadReal(HT,hid,291) != 0 then
                    call BlzSetUnitArmor(u, BlzGetUnitArmor(u) - LoadReal(HT,hid,291)   )
                    call SaveReal(HT,hid,291,0)
                endif

                //Absolute Fire
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_FIRE_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_FIRE_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
                        set r1 = 1 - RMaxBJ(0.25 * GetClassUnitSpell(u, Element_Water), 0)
                        set i1 = R2I((i1 * GetClassUnitSpell(u, Element_Fire)) * (1 + (0.005 * GetHeroLevel(u))) * r1)
                    else
                        set i1 = i1 * GetClassUnitSpell(u, Element_Fire)
                    endif
                    call AddUnitMagicDmg(u ,   0.5 * I2R(i1 - i2)  )	
                    call SaveInteger(HT,hid,ABSOLUTE_FIRE_ABILITY_ID,i1)	
                endif

                //Absolute Water
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WATER_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_WATER_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    set i1 = i1 * GetClassUnitSpell(u,2)
                    call BlzSetUnitMaxMana(u,BlzGetUnitMaxMana(u) + 100 *(i1 - i2)    )
                    call SaveInteger(HT,hid,ABSOLUTE_WATER_ABILITY_ID,i1)	
                endif

                //Absolute Wind
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WIND_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_WIND_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    set i1 = i1 * GetClassUnitSpell(u,3)
                    call AddUnitEvasion(u ,   0.5 * I2R(i1 - i2)  )
                    call SetHeroAgi(u,GetHeroAgi(u,false)+ 10 *(i1 - i2),false     )
                    call SaveInteger(HT,hid,ABSOLUTE_WIND_ABILITY_ID,i1)	
                endif

                //Absolute Earth
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_EARTH_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_EARTH_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    set i1 = i1 * GetClassUnitSpell(u,4)
                    call AddUnitBlock(u ,   20 * I2R(i1 - i2)  )	
                    call SaveInteger(HT,hid,ABSOLUTE_EARTH_ABILITY_ID,i1)	
                endif

                //Absolute Blood
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_BLOOD_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_BLOOD_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    set i1 = i1 * GetClassUnitSpell(u,11)
                    call SetHeroStr(u,GetHeroStr(u,false)+ 12 *(i1 - i2),false     )
                    call SaveInteger(HT,hid,ABSOLUTE_BLOOD_ABILITY_ID,i1)	
                endif

                //Brilliance Aura
                set i1 = GetUnitAbilityLevel(u, BRILLIANCE_AURA_ABILITY_ID)
                if i1 > 0 then
                    call SetUnitState(u, UNIT_STATE_MANA, GetUnitState(u, UNIT_STATE_MANA) + ((0.0001 * i1) * GetUnitState(u, UNIT_STATE_MAX_MANA)))
                endif

                //Absolute Wild
                set i1 = GetUnitAbilityLevel(u ,ABSOLUTE_WILD_ABILITY_ID)
                set i2 = LoadInteger(HT,hid,ABSOLUTE_WILD_ABILITY_ID)
                if i1 >= 1 or i2 != 0 then
                    set i1 = i1 * GetClassUnitSpell(u,5)
                    call AddUnitSummonStronger(u ,   1 * I2R(i1 - i2)  )	
                    call SaveInteger(HT,hid,ABSOLUTE_WILD_ABILITY_ID,i1)	
                endif

                //Thunder Witch
                if GetUnitTypeId(u) == THUNDER_WITCH_UNIT_ID then
                    if BlzGetUnitAbilityCooldownRemaining(u, 'A08P') == 0 and CheckProc(u, 610) then
                        call ThunderWitchBolt(u, GetHeroLevel(u), hid)
                    endif
                endif

                //Pit Lord
                if GetUnitTypeId(u) == PIT_LORD_UNIT_ID then
                    set r1 = 1 - RMaxBJ(0.25 * GetClassUnitSpell(u, Element_Water), 0)
                    set i1 = R2I(GetUnitMagicDmg(u) * r1)
                    set i2 = LoadInteger(HT,hid,PIT_LORD_UNIT_ID)
                    if i1 != i2 then
                        call AddUnitPhysPow(u, 0 - i2)
                        call AddUnitPhysPow(u, i1)
                        call SaveInteger(HT,hid,PIT_LORD_UNIT_ID,i1)	
                    endif
                endif

                //Mana Bonus
                if GetUnitAbilityLevel(u ,MANA_BONUS_ABILITY_ID) >= 1 then
                    set MANA1 = LoadInteger(HT,hid,12)
                    set MANA2 = 10000 * GetUnitAbilityLevel(u ,MANA_BONUS_ABILITY_ID)
                    if MANA1 != MANA2 then
                        call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + MANA2 - MANA1 )
                        call SaveInteger(HT,hid,12,MANA2  )
                    endif
                elseif LoadInteger(HT,hid,12) != 0 then
                    call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) - LoadInteger(HT,hid,12)  )
                    call SaveInteger(HT,hid,12,0 )	
                endif

                //Time Manipulation
                if GetUnitAbilityLevel(u, TIME_MANIPULATION_ABILITY_ID) > 0 and CurrentlyFighting[GetPlayerId(GetOwningPlayer(u))] and TimeManipulationTable[hid].boolean[1] then
                    if BlzGetUnitAbilityCooldownRemaining(u, TIME_MANIPULATION_ABILITY_ID) == 0 then
                        set TimeManipulationTable[hid].real[2] = TimeManipulationTable[hid].real[2] + 1
                        call StartFunctionSpell(u, 6)
                    endif
                endif
            endif
            set II = II + 1
        endloop

        set u = null
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic( trg, 0.1 )
        call TriggerAddAction( trg, function Trig_LongPeriodCheck_Actions )
        set trg = null
    endfunction
endscope