globals
    hashtable HTi= InitHashtable()
endglobals

function DestrTimer takes nothing returns nothing
	local timer Time2 = GetExpiredTimer()
	local unit U2 = LoadUnitHandle(HTi,GetHandleId(Time2),1)
	local integer Id2 = LoadInteger(HTi,GetHandleId(Time2),2)
	local integer Pid = GetPlayerId(GetOwningPlayer(U2))
	local integer i = 0
	local integer i2 = 0
	local integer r =  0
	


	if Id2 == 'I04T' then
    	if UnitHasItemS(U2 ,Id2 ) then
    		call SaveInteger(HTi,GetHandleId(U2),1,1)
    	else
    		call SaveInteger(HTi,GetHandleId(U2),1,0)
    	endif 	
	endif

	if Id2 == 'I04U' then
    	if UnitHasItemS(U2 ,Id2 ) then
    		call SaveInteger(HTi,GetHandleId(U2),2,1)
    	else
    		call SaveInteger(HTi,GetHandleId(U2),2,0)
    	endif 
	endif


	
	
	if Id2 == 'I05E' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),3) 
        call AddUnitMagicDmg(U2 ,   50*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),3,i)	
	endif
	
	
	if Id2 == 'I05C' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),4) 
        call AddUnitMagicDmg(U2 ,   30*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),4,i)	
	endif
	
	if Id2 == 'I05B' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),5) 
        call AddUnitMagicDmg(U2 ,   65*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),5,i)	
	endif	
	
	
	
	if Id2 == 'I04C' then
	    set i = UnitHasItemI(U2 ,Id2 ) 
    	set i2 = LoadInteger(HTi,GetHandleId(U2),6) 
        call AddUnitMagicDef(U2 ,   10*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),6,i)	
	endif	
	
	
	if Id2 == 'I05G' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),7) 
        call AddUnitMagicDef(U2 ,   75*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),7,i)	
	endif	
	
	
	if Id2 == 'I059' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),8) 
        call AddUnitBlock(U2 ,   500*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),8,i)	
	endif		
	
	if Id2 == 'I06X' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),9) 
    	
    	//set PvpBonus[Pid] = PvpBonus[Pid] + 5*(i-i2)
        call AddUnitPvpBonus(U2, 5*(i-i2))
    	call AddUnitEvasion(U2 ,   20*I2R(i-i2)  )	
    	call BlzSetUnitRealField(U2,ConvertUnitRealField('uagp'),  BlzGetUnitRealField(U2,ConvertUnitRealField('uagp')) + 10*(i-i2) )
    	call SaveInteger(HTi,GetHandleId(U2),9,i)	
	endif	
	
	if Id2 == 'I06Y' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),10) 
    	
    	//set PvpBonus[Pid] = PvpBonus[Pid] + 5*(i-i2)
        call AddUnitPvpBonus(U2, 5*(i-i2))
    	call AddUnitBlock(U2 ,   900*I2R(i-i2)  )	
    	call BlzSetUnitRealField(U2,ConvertUnitRealField('ustp'),  BlzGetUnitRealField(U2,ConvertUnitRealField('ustp')) + 10*(i-i2) )
    	call SaveInteger(HTi,GetHandleId(U2),10,i)	
	endif	
    
 
 
	if Id2 >= 'I071' and Id2 <= 'I073' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),11 + (Id2 -'I071') )
    	call AddUnitBlock(U2 ,  -20*(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),11 + (Id2 -'I071'),i)	
	endif


    
    
    if Id2 == 'I07A' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),14) 	
    	if i > 0 then
    	   if GetUnitAbilityLevel(U2,'A05K') == 0 then
    	       call UnitAddAbility(U2,'A05K')
    	   endif
    	    call BlzUnitHideAbility(U2,'A05K',true)
    	    call SetUnitAbilityLevel(U2,'A05K',2)
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(U2,'A05K'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, -i*50 )         
            call SetUnitAbilityLevel(U2,'A05K',1)
    	else
    	   call UnitRemoveAbility(U2,'A05K')
    	endif
    	call SaveInteger(HTi,GetHandleId(U2),14,i)	
	endif	


	if Id2 == 'I07B' then

	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),15) 
	call AddUnitMagicDmg(U2 ,   20*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),15,i)	
	endif


	if Id2 == 'I07E' then

	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),16) 
	call AddUnitMagicDmg(U2 ,   10*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),16,i)	
	endif


	if Id2 == 'I07G' then
	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),17) 
	call AddUnitBlock(U2 ,   50*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),17,i)	
	endif


    

	if Id2 == 'I07H' then
	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),18) 
	call AddUnitBlock(U2 ,   200*I2R(i-i2)  )
	call AddUnitMagicDef(U2 ,   25*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),18,i)	
	endif
    
    
    if Id2 == 'I07T' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),19) 
    	call AddUnitEvasion(U2 ,   10*I2R(i-i2)  )
        call BlzSetUnitWeaponIntegerField(U2,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(U2,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128*(i-i2 ))
    	call SaveInteger(HTi,GetHandleId(U2),19,i)	
	endif
    
    
    if Id2 == 'I07T' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),19) 
    	call AddUnitEvasion(U2 ,   10*I2R(i-i2)  )
        call BlzSetUnitWeaponIntegerField(U2,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(U2,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128*(i-i2 ))
    	call SaveInteger(HTi,GetHandleId(U2),19,i)	
	endif
    
    if Id2 == 'I07V' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),20) 
        
        call AddUnitMagicDmg(U2 ,   125*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),20,i)	
	endif
	

    if Id2 == 'I07W' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),21) 
        
        call AddUnitMagicDef(U2 ,   25*I2R(i-i2)  )	
        call AddUnitBlock(U2 ,   50*I2R(i-i2)  )
    	call AddUnitEvasion(U2 ,   15*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),21,i)	
	endif
    
    
    if Id2 == 'I076' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),22) 
    	call AddUnitEvasion(U2 ,   10*I2R(i-i2)  )
    	call AddUnitMagicDef(U2 ,   10*I2R(i-i2)  )		
    	call SaveInteger(HTi,GetHandleId(U2),22,i)	
	endif

	if Id2 == 'I077' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),23) 
    	call AddUnitBlock(U2 ,   30*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),23,i)	
	endif
    
    if Id2 == 'I07Y' then
        set i = UnitHasItemI(U2 ,Id2 )
        if i > 2 then
            set i = 2
        endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),24) 
    	call AddUnitBlock(U2 ,   750*I2R(i-i2)  )	
        call AddUnitEvasion(U2 ,   30*I2R(i-i2)  )
    	call AddUnitMagicDef(U2 ,   60*I2R(i-i2)  )	
    	call SaveInteger(HTi,GetHandleId(U2),24,i)	
	endif
    
    
    if Id2 == 'I06V' then
    	set i = UnitHasItemI(U2 ,Id2 ) 
    	set i2 = LoadInteger(HTi,GetHandleId(U2),25) 
    	//set PvpBonus[Pid] = PvpBonus[Pid] + 5*(i-i2)
        call AddUnitPvpBonus(U2, 5*(i-i2))
    	call AddUnitMagicDmg(U2 ,   40*I2R(i-i2)  )	
    	call BlzSetUnitRealField(U2,ConvertUnitRealField('uinp'),  BlzGetUnitRealField(U2,ConvertUnitRealField('uinp')) + 10*(i-i2) )
    	call SaveInteger(HTi,GetHandleId(U2),25,i)	
	endif
    
    if Id2 == 'I080' then
        set i = UnitHasItemI(U2 ,Id2 )
        if i > 1 then
            set i = 1
            call BlzSetUnitWeaponIntegerField(U2,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,7)
        else
           call BlzSetUnitWeaponIntegerField(U2,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,8) 
        endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),26) 
    	call SaveInteger(HTi,GetHandleId(U2),26,i)	
	endif
    
	
    
     if Id2 == 'I083' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),27) 
    	call AddUnitLuck(U2 ,   0.15*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),27,i)	
	endif   
    
     if Id2 == 'I08L' then
    	set i = UnitHasItemI(U2 ,Id2 )
    	set i2 = LoadInteger(HTi,GetHandleId(U2),28) 
    	call AddUnitPowerRune(U2 ,   50*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),28,i)	
	endif   
    
    if Id2 == 'I08N' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),29) 
    	call AddUnitPowerRune(U2 ,   75*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),29,i)	
	endif 
    
    if Id2 == 'I08P' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),30) 
    	call AddUnitPowerRune(U2 ,   100*I2R(i-i2)  )
        call AddUnitPowerRune(U2 ,   20*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),30,i)	
	endif 
    if Id2 == 'I08Q' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),31) 
    	call AddUnitPowerRune(U2 ,   100*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),31,i)	
	endif     
    if Id2 == 'I08R' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),32) 
    	call AddUnitPowerRune(U2 ,   100*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),32,i)	
	endif  
    
    if Id2 == 'I08S' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),33) 
    	call AddUnitPowerRune(U2 ,   100*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),33,i)	
	endif  
    
    
    if Id2 == 'I08X' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),34) 
    	call AddUnitMagicDmg(U2 ,   35*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),34,i)	
	endif  
    
     if Id2 == 'I08Z' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),35) 
    	call AddUnitEvasion(U2 ,   30*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),35,i)	
	endif     
    
      if Id2 == 'I090' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),36) 
    	call AddUnitBlock(U2 ,   1000*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),36,i)	
	endif  
    
    
    if Id2 == 'I091' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),37) 
    	call AddUnitMagicDef(U2 ,   50*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),37,i)	
	endif  
    
    if Id2 == 'I092' then
	    if UnitHasItemS(U2 ,Id2 ) then
	       set i = 1 
	    else
	       set i = 0
	    endif
    	set i2 = LoadInteger(HTi,GetHandleId(U2),38) 
        call AddUnitMagicDmg(U2 ,   -50*I2R(i-i2)  )
    	call AddUnitMagicDef(U2 ,   200*I2R(i-i2)  )
    	call SaveInteger(HTi,GetHandleId(U2),38,i)	
	endif  
    
	call FlushChildHashtable(HTi,GetHandleId(Time2))
	call DestroyTimer(Time2)
	set Time2 = null
	set U2 = null
endfunction




function Trig_ItemBonus_Copy_Actions takes nothing returns nothing
	local timer Time1 = null


	set Time1 = CreateTimer()


	call SaveUnitHandle(HTi,GetHandleId(Time1),1, GetTriggerUnit() )
	call SaveInteger(HTi,GetHandleId(Time1),2, GetItemTypeId(GetManipulatedItem())    ) 
    
	call TimerStart(Time1,0,false,function DestrTimer )




	set Time1 = null

endfunction
//call SaveInteger(HTi,GetHandleId(GetTriggerUnit()),1,1)	
//===========================================================================
function InitTrig_ItemBonus_Copy takes nothing returns nothing
    set gg_trg_ItemBonus_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ItemBonus_Copy, EVENT_PLAYER_UNIT_DROP_ITEM )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_ItemBonus_Copy, EVENT_PLAYER_UNIT_PICKUP_ITEM )
    call TriggerAddAction( gg_trg_ItemBonus_Copy, function Trig_ItemBonus_Copy_Actions )
endfunction

