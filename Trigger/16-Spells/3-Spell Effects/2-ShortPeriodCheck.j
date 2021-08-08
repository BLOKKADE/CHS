function Trig_ShortPeriodCheck_Actions takes nothing returns nothing
    local integer II = 0
    local integer i1 = 0
    local integer i2 = 0
    local string s = null
    local string s2 = null
    local string s3 = null

    
    loop
        exitwhen II > 8
        if GetWidgetLife(udg_units01[II]) > 0 then

            if GetUnitAbilityLevel(udg_units01[II] ,'A02Z') >= 1 then
                if CheckProc(udg_units01[II], 610) then
                    call ElemFuncStart(udg_units01[II],'A02Z')
                endif
                call USOrderA(udg_units01[II],GetUnitX(udg_units01[II]),GetUnitY(udg_units01[II]),'A02Y',"fanofknives", 200 + GetUnitAbilityLevel(udg_units01[II] ,'A02Z')*50 + GetHeroLevel(udg_units01[II])*(0.8 + 0.2*GetUnitAbilityLevel(udg_units01[II] ,'A02Z')), ConvertAbilityRealLevelField('Ocl1') )
            endif
            
            set i1 = GetUnitAbilityLevel(udg_units01[II],'A07R')
            if i1 > 0 then
                    set s = GetDesriptionAbility('A07R',i1-1)
                    if LoadReal(HT,GetHandleId(udg_units01[II]),-93001) == 0 then
                        set s2 = "50"
                    else
                         set s2 = I2S(R2I(LoadReal(HT,GetHandleId(udg_units01[II]),-93001)))
                    endif
                    
                    set s3 = ReplaceText("2000",s2,s)
                    set s3 = ReplaceText(",0000,", R2S(   LoadReal(HT,GetHandleId(udg_units01[II]),-93000) ) ,s3)
                if GetLocalPlayer() == GetOwningPlayer(udg_units01[II]) then
                    call BlzSetAbilityExtendedTooltip('A07R',s3  , i1-1  ) 
                endif
            
            endif
            
            set i1 = GetUnitAbilityLevel(udg_units01[II],'A07T')
            if i1 > 0 then
                set s = GetDesriptionAbility('A07T',i1-1)
                if LoadReal(HT,GetHandleId(udg_units01[II]),82341) == 0 then
                    set s2 =    "20000"
                else
                     set s2 = I2S(R2I(LoadReal(HT,GetHandleId(udg_units01[II]),82341)*(1- I2R(i1)*0.01 ) ))
                endif
                
                set s3 = ReplaceText("20,000",s2,s) 
                set s3 = ReplaceText(",0000,", R2S(   LoadReal(HT,GetHandleId(udg_units01[II]),82340) ) ,s3)
                    
                if GetLocalPlayer() == GetOwningPlayer(udg_units01[II]) then
                    call BlzSetAbilityExtendedTooltip('A07T',s3  , i1-1  ) 
                endif
            
            endif
                    
            set i1 = GetUnitAbilityLevel(udg_units01[II],'A07V')
            if i1 > 0 then
                set i2 =  LoadInteger(HT,GetHandleId(udg_units01[II]),-41256)
                if i2 == 4 then
                    set i2 = 0
                    call AbsoluteCold(udg_units01[II],GetClassUnitSpell(udg_units01[II],9)*20*i1 )
                else
                    set i2 = i2 + 1
                  
                endif
                call SaveInteger(HT,GetHandleId(udg_units01[II]),-41256,i2)
            endif
            
            set i1 = GetUnitAbilityLevel(udg_units01[II],'A082')
            if i1 > 0 then
                set i2 =  LoadInteger(HT,GetHandleId(udg_units01[II]),-41257)
                if i2 == 8 then
                    set i2 = 0
                    call SetWidgetLife(udg_units01[II],GetWidgetLife(udg_units01[II])+2500*i1)
                    call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", udg_units01[II], "chest",3)
                    call RemoveDebuff( udg_units01[II] )
                else
                    set i2 = i2 + 1
                  
                endif
                call SaveInteger(HT,GetHandleId(udg_units01[II]),-41257,i2)
            endif       
            
            
            
            
            if GetUnitTypeId(udg_units01[II]) == 'O001' then
                if CheckProc(udg_units01[II], 610) then
                    call ElemFuncStart(udg_units01[II],'O001')
                endif
                call USOrderA(udg_units01[II],GetUnitX(udg_units01[II]),GetUnitY(udg_units01[II]),'A036',"fanofknives",  40+GetHeroLevel(udg_units01[II])*40 , ConvertAbilityRealLevelField('Ocl1') )
            endif
            
            if GetUnitTypeId(udg_units01[II]) == 'O00B' then
               if BlzGetUnitArmor(udg_units01[II]) <= 50 then
                   set i1 = LoadInteger(DataUnitHT,GetHandleId(udg_units01[II]),542)
                   set i2 = 20*GetHeroLevel(udg_units01[II])-i1
                   call SetHeroStr(udg_units01[II],GetHeroStr(udg_units01[II],false)+ i2, false)
                   call SaveInteger(DataUnitHT,GetHandleId(udg_units01[II]),542,20*GetHeroLevel(udg_units01[II]))
               else
                   set i1 = LoadInteger(DataUnitHT,GetHandleId(udg_units01[II]),542)
                   call SetHeroStr(udg_units01[II],GetHeroStr(udg_units01[II],false)-i1, false)
                   call SaveInteger(DataUnitHT,GetHandleId(udg_units01[II]),542,0)
               endif
            endif
        endif
    set II = II + 1
    endloop


endfunction

//===========================================================================
function InitTrig_ShortPeriodCheck takes nothing returns nothing
    set gg_trg_ShortPeriodCheck = CreateTrigger(  )
    call TriggerRegisterTimerEventPeriodic( gg_trg_ShortPeriodCheck, 1 )
    call TriggerAddAction( gg_trg_ShortPeriodCheck, function Trig_ShortPeriodCheck_Actions )
endfunction

