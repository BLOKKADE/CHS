library ItemBonus initializer init requires CustomState, RandomShit, LevelUpStats, Utility
	globals
		hashtable HTi= InitHashtable()
	endglobals

	function DestrTimer takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit u = LoadUnitHandle(HTi,GetHandleId(t),1)
		local integer itemId = LoadInteger(HTi,GetHandleId(t),2)
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local integer i = 0
		local integer prevCount = 0
		local integer r =  0
		


		if itemId == 'I04T' then
			if UnitHasItemS(u ,itemId ) then
				call SaveInteger(HTi,GetHandleId(u),1,1)
			else
				call SaveInteger(HTi,GetHandleId(u),1,0)
			endif 	
		endif

		if itemId == 'I04U' then
			if UnitHasItemS(u ,itemId ) then
				call SaveInteger(HTi,GetHandleId(u),2,1)
			else
				call SaveInteger(HTi,GetHandleId(u),2,0)
			endif 
		endif


		
		
		if itemId == 'I05E' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),3) 
			call AddUnitMagicDmg(u ,   50*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),3,i)	
		endif
		
		
		if itemId == 'I05C' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),4) 
			call AddUnitMagicDmg(u ,   30*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),4,i)	
		endif
		
		if itemId == 'I05B' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),5) 
			call AddUnitMagicDmg(u ,   65*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),5,i)	
		endif	
		
		
		
		if itemId == 'I04C' then
			set i = UnitHasItemI(u ,itemId ) 
			set prevCount = LoadInteger(HTi,GetHandleId(u),6) 
			call AddUnitMagicDef(u ,   10*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),6,i)	
		endif	
		
		
		if itemId == 'I05G' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),7) 
			call AddUnitMagicDef(u ,   75*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),7,i)	
		endif	
		
		
		if itemId == 'I059' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),8) 
			call AddUnitBlock(u ,   500*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),8,i)	
		endif	

		//Sword of Bloodthirst
		if itemId == 'I0AI' then
			set i = UnitHasItemI(u, itemId)
			set prevCount = LoadInteger(HTi, GetHandleId(u), 47)
			set r = GetHeroPrimaryStat(u)
			call SetHeroStat(u, r, GetHeroStatBJ(r, u, false) + 300 * (i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),47,i)	
		endif

		//Wisdom Chestplate
		if itemId == 'I0AH' then
			set i = UnitHasItemI(u, itemId)
			set prevCount = LoadInteger(HTi, GetHandleId(u), 48)
			call AddUnitBlock(u, 800 * (i - prevCount))
			call SaveInteger(HTi, GetHandleId(u), 48, i)
		endif
		
		//Mask of Protection
		if itemId == 'I0AE' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),45) 
			call AddUnitMagicDmg(u ,   75*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),45,i)	
		endif	

		//Mask of Elusion
		if itemId == 'I0AD' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),46) 
			call AddUnitEvasion(u, 40*I2R(i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),46,i)	
		endif		
		
		//Ancient Dagger
		if itemId == 'I06X' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),43) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5*(i-prevCount))
			call AddUnitEvasion(u ,   20*I2R(i-prevCount)  )	
			call AddAgilityLevelBonus(u, 15*(i-prevCount))
			call SetHeroAgi(u, GetHeroAgi(u, false) + (15*(i-prevCount))*GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uagp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uagp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,GetHandleId(u),43,i)	
		endif	
		
		//Ancient Axe
		if itemId == 'I06Y' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),42) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5*(i-prevCount))
			call AddUnitBlock(u ,   900*I2R(i-prevCount)  )	
			call AddStrengthLevelBonus(u, 15*(i-prevCount))
			call SetHeroStr(u, GetHeroStr(u, false) + (15*(i-prevCount))*GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('ustp'),  BlzGetUnitRealField(u,ConvertUnitRealField('ustp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,GetHandleId(u),42,i)	
		endif	

		//Ring of Musculature
		if itemId == 'I071' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u), 39) 

			call AddStrengthLevelBonus(u, 2*(i-prevCount))
			call AddUnitBlock(u, -20*(i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),39,i)	
		endif

		//Ring of the Bookworm
		if itemId == 'I072' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u), 40) 

			call AddIntelligenceLevelBonus(u, 2*(i-prevCount))
			call AddUnitBlock(u, -20*(i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),40,i)	
		endif

		//Trainers Ring
		if itemId == 'I073' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u), 41) 

			call AddAgilityLevelBonus(u, 2*(i-prevCount))
			call AddUnitBlock(u, -20*(i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),41,i)	
		endif

		//Arena Ring
		if itemId == 'I0AF' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u), 49) 

			set GloryRoundBonus[pid] = GloryRoundBonus[pid] + 100*(i-prevCount)
			call AddUnitBlock(u, -30*(i-prevCount))
			call SaveInteger(HTi,GetHandleId(u),49,i)	
		endif
		
		if itemId == 'I07A' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),14) 	
			if i > 0 then
			if GetUnitAbilityLevel(u,'A05K') == 0 then
				call UnitAddAbility(u,'A05K')
			endif
				call BlzUnitHideAbility(u,'A05K',true)
				call SetUnitAbilityLevel(u,'A05K',2)
				call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A05K'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, -i*50 )         
				call SetUnitAbilityLevel(u,'A05K',1)
			else
			call UnitRemoveAbility(u,'A05K')
			endif
			call SaveInteger(HTi,GetHandleId(u),14,i)	
		endif	


		if itemId == 'I07B' then

		set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),15) 
		call AddUnitMagicDmg(u ,   20*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),15,i)	
		endif


		if itemId == 'I07E' then

		set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),16) 
		call AddUnitMagicDmg(u ,   10*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),16,i)	
		endif


		if itemId == 'I07G' then
		set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),17) 
		call AddUnitBlock(u ,   50*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),17,i)	
		endif


		

		if itemId == 'I07H' then
		set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),18) 
		call AddUnitBlock(u ,   200*I2R(i-prevCount)  )
		call AddUnitMagicDef(u ,   25*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),18,i)	
		endif
		
		
		if itemId == 'I07T' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),19) 
			call AddUnitEvasion(u ,   10*I2R(i-prevCount)  )
			call BlzSetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128*(i-prevCount ))
			call SaveInteger(HTi,GetHandleId(u),19,i)	
		endif
		
		
		if itemId == 'I07T' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),19) 
			call AddUnitEvasion(u ,   10*I2R(i-prevCount)  )
			call BlzSetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128*(i-prevCount ))
			call SaveInteger(HTi,GetHandleId(u),19,i)	
		endif
		
		if itemId == 'I07V' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),20) 
			
			call AddUnitMagicDmg(u ,   125*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),20,i)	
		endif
		

		if itemId == 'I07W' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),21) 
			
			call AddUnitMagicDef(u ,   25*I2R(i-prevCount)  )	
			call AddUnitBlock(u ,   50*I2R(i-prevCount)  )
			call AddUnitEvasion(u ,   15*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),21,i)	
		endif
		
		
		if itemId == 'I076' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),22) 
			call AddUnitEvasion(u ,   10*I2R(i-prevCount)  )
			call AddUnitMagicDef(u ,   10*I2R(i-prevCount)  )		
			call SaveInteger(HTi,GetHandleId(u),22,i)	
		endif

		if itemId == 'I077' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),23) 
			call AddUnitBlock(u ,   30*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),23,i)	
		endif
		
		if itemId == 'I07Y' then
			set i = UnitHasItemI(u ,itemId )
			if i > 2 then
				set i = 2
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),24) 
			call AddUnitBlock(u ,   750*I2R(i-prevCount)  )	
			call AddUnitEvasion(u ,   30*I2R(i-prevCount)  )
			call AddUnitMagicDef(u ,   60*I2R(i-prevCount)  )	
			call SaveInteger(HTi,GetHandleId(u),24,i)	
		endif
		
		//Ancient Staff
		if itemId == 'I06V' then
			set i = UnitHasItemI(u ,itemId ) 
			set prevCount = LoadInteger(HTi,GetHandleId(u),44) 
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5*(i-prevCount))
			call AddUnitMagicDmg(u ,   40*I2R(i-prevCount)  )	
			call AddIntelligenceLevelBonus(u, 15*(i-prevCount))
			call SetHeroInt(u, GetHeroInt(u, false) + (15*(i-prevCount))*GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uinp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uinp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,GetHandleId(u),44,i)	
		endif
		
		if itemId == 'I080' then
			set i = UnitHasItemI(u ,itemId )
			if i > 1 then
				set i = 1
				call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,7)
			else
			call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,8) 
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),26) 
			call SaveInteger(HTi,GetHandleId(u),26,i)	
		endif
		
		if itemId == 'I083' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),27) 
			call AddUnitLuck(u ,   0.15*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),27,i)	
		endif   
		
		if itemId == 'I08L' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,GetHandleId(u),28) 
			call AddUnitPowerRune(u ,   50*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),28,i)	
		endif   
		
		if itemId == 'I08N' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),29) 
			call AddUnitPowerRune(u ,   75*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),29,i)	
		endif 
		
		if itemId == 'I08P' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),30) 
			call AddUnitPowerRune(u ,   100*I2R(i-prevCount)  )
			call AddUnitPowerRune(u ,   20*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),30,i)	
		endif 
		if itemId == 'I08Q' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),31) 
			call AddUnitPowerRune(u ,   100*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),31,i)	
		endif     
		if itemId == 'I08R' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),32) 
			call AddUnitPowerRune(u ,   100*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),32,i)	
		endif  
		
		if itemId == 'I08S' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),33) 
			call AddUnitPowerRune(u ,   100*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),33,i)	
		endif  
		
		
		if itemId == 'I08X' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),34) 
			call AddUnitMagicDmg(u ,   35*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),34,i)	
		endif  
		
		if itemId == 'I08Z' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),35) 
			call AddUnitEvasion(u ,   30*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),35,i)	
		endif     
		
		if itemId == 'I090' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),36) 
			call AddUnitBlock(u ,   1000*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),36,i)	
		endif  
		
		
		if itemId == 'I091' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),37) 
			call AddUnitMagicDef(u ,   50*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),37,i)	
		endif  
		
		if itemId == 'I092' then
			if UnitHasItemS(u ,itemId ) then
			set i = 1 
			else
			set i = 0
			endif
			set prevCount = LoadInteger(HTi,GetHandleId(u),38) 
			call AddUnitMagicDmg(u ,   -50*I2R(i-prevCount)  )
			call AddUnitMagicDef(u ,   200*I2R(i-prevCount)  )
			call SaveInteger(HTi,GetHandleId(u),38,i)	
		endif  
		
		call FlushChildHashtable(HTi,GetHandleId(t))
		call ReleaseTimer(t)
		set t = null
		set u = null
	endfunction




	function Trig_ItemBonus_Actions takes nothing returns nothing
		local timer Time1 = null


		set Time1 = NewTimer()


		call SaveUnitHandle(HTi,GetHandleId(Time1),1, GetTriggerUnit() )
		call SaveInteger(HTi,GetHandleId(Time1),2, GetItemTypeId(GetManipulatedItem())    ) 
		
		call TimerStart(Time1,0,false,function DestrTimer )




		set Time1 = null

	endfunction
	//call SaveInteger(HTi,GetHandleId(GetTriggerUnit()),1,1)	
	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trg = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_DROP_ITEM )
		call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_PICKUP_ITEM )
		call TriggerAddAction( trg, function Trig_ItemBonus_Actions )
		set trg = null
	endfunction
endlibrary