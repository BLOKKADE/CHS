function  FunctionAttackSpeedA takes unit u returns nothing
    local real r1 = LoadReal(HT, GetHandleId(u),-1001 )
    local real r2 = 0
    local real i1 = I2R(GetUnitAbilityLevel(u,'A02O'))
    local real i2 = UnitHasItemI(u,'I066')
	


    if i1 > 0 then
        set r2 = 0.92 -  0.02*i1

    else

       set  r2 = r1 
    endif

    set r2 = r2 + i2*1.4


    if UnitHasItemS(u,'I06B') then
      set r2 = r2*0.8
    endif

    if GetUnitTypeId(u) == 'O00A' then

	set r2 =  r2*100/(I2R(100+GetHeroLevel(u))) 
    endif

  //  call DisplayTextToPlayer(GetLocalPlayer(),0,0,R2S(r2))
    call BlzSetUnitAttackCooldown(u,r2,0)



endfunction



function AABfunction takes unit u returns nothing
    if GetUnitAbilityLevel(u,'A05Z') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A05Z') <= 0.001 and BlzIsUnitInvulnerable(u) == false then
        call UseSpellsAT(u)
        call AbilStartCD(u,'A05Z',45-GetUnitAbilityLevel(u,'A05Z') ) 
    endif

    if GetUnitAbilityLevel(u,'A066') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A066') <= 0.001 and BlzIsUnitInvulnerable(u) == false and GetWidgetLife(u)/I2R(BlzGetUnitMaxHP(u)) < 0.75 then
        call UseSpellsHolyShield(u)
        call AbilStartCD(u,'A066',10 ) 
    endif

    if GetUnitAbilityLevel(u,'A073') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A073') <= 0.001 and BlzIsUnitInvulnerable(u) == false and GetUnitState(u,UNIT_STATE_MANA) >= 2000 then
        call CreateRandomRune(0,GetUnitX(u),GetUnitY(u),u )
        call SetUnitState(u,UNIT_STATE_MANA,GetUnitState(u,UNIT_STATE_MANA)-2000)
        call AbilStartCD(u,'A073',20 ) 
    endif

    if GetUnitAbilityLevel(u,'A07L') > 0 and BlzGetUnitAbilityCooldownRemaining(u,'A07L') <= 0.001 and BlzIsUnitInvulnerable(u) == false  then

        call USOrder4field(u,GetUnitX(u),GetUnitY(u),'A07M',"thunderclap",GetUnitAbilityLevel(u,'A07L')*100,ABILITY_RLF_DAMAGE_INCREASE,600,ABILITY_RLF_CAST_RANGE ,0.5,ABILITY_RLF_DURATION_HERO,0.5,ABILITY_RLF_DURATION_NORMAL)
        call AbilStartCD(u,'A07L',5 ) 
    endif
endfunction

function FunUpdateSkill takes integer i returns nothing
    local integer i1= 1
    local player Pl= Player(i)
    local integer SpellId= 0
    local string textureS= ""
    local integer unitId = GetUnitTypeId(udg_units01[NumPlayerLast[i] + 1])

    if unitId != 0 and i != NumPlayerLast[i] then
        if GetLocalPlayer() == Pl then
            set textureS = LoadStr(HT_data, unitId, 1)
            call BlzFrameSetVisible(SpellUP[100], true)
            call BlzFrameSetTexture(SpellFR[100], textureS, 0, true)
        endif
    else
        if GetLocalPlayer() == Pl then
            call BlzFrameSetVisible(SpellUP[100], false)
        endif
    endif

    loop
        exitwhen i1 > 21
        set SpellId=GetInfoHeroSpell(udg_units01[NumPlayerLast[i] + 1] , i1)
        if SpellId != 0 then
            set textureS=BlzGetAbilityIcon(SpellId)

            if GetLocalPlayer() == Pl then
              call BlzFrameSetVisible(SpellUP[100 + i1], true)
              call BlzFrameSetTexture(SpellFR[100 + i1], textureS, 0, true)
            endif
        else
            if GetLocalPlayer() == Pl then
              call BlzFrameSetVisible(SpellUP[100 + i1], false)
            endif
        endif
        set i1=i1 + 1
    endloop

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


    loop
    exitwhen   II > 8



        call FunUpdateSkill(II)

        if GetWidgetLife(udg_units01[II]) > 0 then
            call SaveReal(HT,GetHandleId(udg_units01[II]),-32145, GetClassUnitSpell(udg_units01[II],11))
            call FunctionAttackSpeedA(udg_units01[II])
            
            if GetUnitAbilityLevel(udg_units01[II] ,'B00F') >= 1 then
                set ARMORN = BlzGetUnitArmor(udg_units01[II])
                set ARMORN2 = LoadReal(HT,GetHandleId(udg_units01[II]),11)
                set ARMFIN  = ARMORN - ARMORN2
                set ARMG  = ARMFIN  - ARMORN2 
                call SaveReal(HT,GetHandleId(udg_units01[II]),11,ARMORN2+ARMG  )
                
                call BlzSetUnitArmor(udg_units01[II],ARMORN + ARMG   )
            elseif LoadReal(HT,GetHandleId(udg_units01[II]),11) != 0 then
                call BlzSetUnitArmor(udg_units01[II], BlzGetUnitArmor(udg_units01[II]) - LoadReal(HT,GetHandleId(udg_units01[II]),11)   )
                call SaveReal(HT,GetHandleId(udg_units01[II]),11,0)
            endif
            
            if GetUnitAbilityLevel(udg_units01[II] ,'B00S') >= 1 then
                set Agi1 = GetHeroAgi(udg_units01[II],false)
                set Agi2 = LoadReal(HT,GetHandleId(udg_units01[II]),1001)
                set Smat1 = R2I((Agi1-Agi2)*0.35)  //?????? ????
                
                call SaveReal(HT,GetHandleId(udg_units01[II]),1001 ,Smat1   )
                call SetHeroAgi(udg_units01[II],R2I(Agi1+Smat1-Agi2 ) ,false)
                
                set Str1 = GetHeroStr(udg_units01[II],false)
                set Str2 = LoadReal(HT,GetHandleId(udg_units01[II]),1002)
                set Smat1 = R2I((Str1-Str2)*0.35)  //?????? ????
                
                call SaveReal(HT,GetHandleId(udg_units01[II]),1002 ,Smat1   )
                call SetHeroStr(udg_units01[II],R2I(Str1+Smat1-Str2 ) ,false)
                
                set Int1 = GetHeroInt(udg_units01[II],false)
                set Int2 = LoadReal(HT,GetHandleId(udg_units01[II]),1003)
                set Smat1 = R2I((Int1-Int2)*0.35)  //?????? ????
                
                call SaveReal(HT,GetHandleId(udg_units01[II]),1003 ,Smat1   )
                call SetHeroInt(udg_units01[II],R2I(Int1+Smat1-Int2 ) ,false)
            elseif (LoadReal(HT,GetHandleId(udg_units01[II]),1001) != 0) or (LoadReal(HT,GetHandleId(udg_units01[II]),1002) != 0) or (LoadReal(HT,GetHandleId(udg_units01[II]),1003) != 0) then
                call SetHeroAgi(udg_units01[II],R2I(GetHeroAgi(udg_units01[II],false) - (LoadReal(HT,GetHandleId(udg_units01[II]),1001)) ) ,false)	
                call SaveReal(HT,GetHandleId(udg_units01[II]),1001,0)
                
                call SetHeroStr(udg_units01[II],R2I(GetHeroStr(udg_units01[II],false) - (LoadReal(HT,GetHandleId(udg_units01[II]),1002)) ) ,false)	
                call SaveReal(HT,GetHandleId(udg_units01[II]),1002,0)
                
                call SetHeroInt(udg_units01[II],R2I(GetHeroInt(udg_units01[II],false) - (LoadReal(HT,GetHandleId(udg_units01[II]),1003)) ) ,false)	
                call SaveReal(HT,GetHandleId(udg_units01[II]),1003,0)		
            endif
            
            if GetUnitAbilityLevel(udg_units01[II] ,'B00Q') >= 1 then	
                   set HpR =  BlzGetUnitMaxHP(udg_units01[II])  - GetWidgetLife(udg_units01[II]) 
                   
                   if HpR > 0 then
                       set MpR = GetUnitState(udg_units01[II], UNIT_STATE_MANA)/100 
                       
                       if MpR  >  HpR then
                           call SetUnitState(udg_units01[II], UNIT_STATE_MANA, GetUnitState(udg_units01[II], UNIT_STATE_MANA) - HpR  )
                           call SetWidgetLife(udg_units01[II],  GetWidgetLife(udg_units01[II]) + HpR) 
                       else
                           call SetUnitState(udg_units01[II], UNIT_STATE_MANA, GetUnitState(udg_units01[II], UNIT_STATE_MANA) - MpR  )
                           call SetWidgetLife(udg_units01[II],  GetWidgetLife(udg_units01[II]) + MpR)      
                       endif
                   endif
            endif

            if GetWidgetLife(udg_units01[II]) > 0 then
                set HpBonus = 0
                if GetUnitAbilityLevel(udg_units01[II] ,'B00N') >= 1 then
                    set HpBonus = HpBonus + 1
                endif
                
                set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07P')
                if i1 >= 1  then
                    set i1 = i1*GetClassUnitSpell(udg_units01[II],8)
                    set HpBonus = HpBonus + 0.005*I2R(i1)
                endif
                
                set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A082')
                if i1 >= 1 then
                    set HpBonus = HpBonus + 0.05*I2R(i1)
                endif
                
                call SetUnitProcHp(udg_units01[II],HpBonus)
                
                
                if BlzIsUnitInvulnerable(udg_units01[II]) == false  then
                    set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07Q')
                    if i1 >= 1  then
                        set i1 = i1*GetClassUnitSpell(udg_units01[II],7)
                        call AoeDrainAura(udg_units01[II], (0.5*I2R(i1)),500,false)
                    endif
                    
                    set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A023')
                    if i1 >= 1  then
                        call AoeDrainAura(udg_units01[II], I2R(i1),500,true)
                    endif
                endif
                call AABfunction(udg_units01[II])
                
                
                if GetUnitTypeId(udg_units01[II]) == 'H01I' then
                    set i1 = (BlzGetUnitMaxHP(udg_units01[II])*3)/4
                    set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'H01I')
                    
                    call BlzSetUnitMaxMana(udg_units01[II],BlzGetUnitMaxMana(udg_units01[II])+i1-i2   )
                    call SaveInteger(HT,GetHandleId(udg_units01[II]),'H01I',i1  )
                
                endif
                
                
                
                if GetUnitAbilityLevel(udg_units01[II] ,'B00L') >= 1 then

                    set ARMORN =      R2I( (BlzGetUnitMaxMana( udg_units01[II] )  -  GetUnitState( udg_units01[II]  , UNIT_STATE_MANA  )  )/300 )
                    set ARMORN2 = LoadReal(HT,GetHandleId(udg_units01[II]),291)

                    set ARMFIN  = BlzGetUnitArmor(udg_units01[II])

                    set ARMG  = ARMORN  + ARMFIN  - ARMORN2

                    call SaveReal(HT,GetHandleId(udg_units01[II]),291,ARMORN  )
                    call BlzSetUnitArmor(udg_units01[II],ARMG  )

                elseif LoadReal(HT,GetHandleId(udg_units01[II]),291) != 0 then
                    call BlzSetUnitArmor(udg_units01[II], BlzGetUnitArmor(udg_units01[II]) - LoadReal(HT,GetHandleId(udg_units01[II]),291)   )
                    call SaveReal(HT,GetHandleId(udg_units01[II]),291,0)
                endif
            endif
                
            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07B')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07B')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],1)
                call AddUnitMagicDmg(udg_units01[II] ,   0.5*I2R(i1-i2)  )	
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07B',i1)	
            endif

            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07C')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07C')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],2)
                call BlzSetUnitMaxMana(udg_units01[II],BlzGetUnitMaxMana(udg_units01[II]) + 100*(i1-i2)    )
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07C',i1)	
            endif
            
            
            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07E')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07E')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],3)
                call AddUnitEvasion(udg_units01[II] ,   0.5*I2R(i1-i2)  )
                call SetHeroAgi(udg_units01[II],GetHeroAgi(udg_units01[II],false)+10*(i1-i2),false     )
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07E',i1)	
            endif
            
            
            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07D')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07D')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],4)
                call AddUnitBlock(udg_units01[II] ,   20*I2R(i1-i2)  )	
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07D',i1)	
            endif

            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07R')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07R')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],11)
                call SetHeroStr(udg_units01[II],GetHeroStr(udg_units01[II],false)+12*(i1-i2),false     )
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07R',i1)	
            endif



            set i1 = GetUnitAbilityLevel(udg_units01[II] ,'A07K')
            set i2 = LoadInteger(HT,GetHandleId(udg_units01[II]),'A07K')
            if i1 >= 1 or i2 != 0 then
                set i1 = i1*GetClassUnitSpell(udg_units01[II],5)
                call AddUnitSummonStronger(udg_units01[II] ,   1*I2R(i1-i2)  )	
                call SaveInteger(HT,GetHandleId(udg_units01[II]),'A07K',i1)	
            endif



            if GetUnitAbilityLevel(udg_units01[II] ,'A02X') >= 1 then
                set MANA1  = LoadInteger(HT,GetHandleId(udg_units01[II]),12)
                set MANA2  =  10000*GetUnitAbilityLevel(udg_units01[II] ,'A02X')
                if MANA1 != MANA2 then
                    call BlzSetUnitMaxMana(udg_units01[II], BlzGetUnitMaxMana(udg_units01[II]) + MANA2-MANA1 )
                    call SaveInteger(HT,GetHandleId(udg_units01[II]),12,MANA2  )
                endif
            elseif LoadInteger(HT,GetHandleId(udg_units01[II]),12) != 0 then
                call BlzSetUnitMaxMana(udg_units01[II], BlzGetUnitMaxMana(udg_units01[II]) -LoadInteger(HT,GetHandleId(udg_units01[II]),12)  )
                call SaveInteger(HT,GetHandleId(udg_units01[II]),12,0 )	
            endif
        endif
        set II = II + 1
    endloop
endfunction

//===========================================================================
function InitTrig_LongPeriodCheck takes nothing returns nothing
    set gg_trg_LongPeriodCheck = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_LongPeriodCheck, 0.1 )
    call TriggerAddAction( gg_trg_LongPeriodCheck, function Trig_LongPeriodCheck_Actions )
endfunction

