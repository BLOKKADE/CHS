library ItemBonus initializer init requires CustomState, RandomShit, LevelUpStats, Utility
	globals
		hashtable HTi = InitHashtable()
	endglobals

	function DestrTimer takes nothing returns nothing
		local timer t = GetExpiredTimer()
		local unit u = LoadUnitHandle(HTi,GetHandleId(t),1)
		local item it = LoadItemHandle(HTi,GetHandleId(t),2)
		local integer itemId = LoadInteger(HTi, GetHandleId(t), 3)
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local integer i = 0
		local integer i2 = 0
		local integer prevCount = 0
		local integer r = 0
		local integer hid = GetHandleId(u)
		
		//Mask of Death
		if itemId == 'I04T' then
			if UnitHasItemS(u ,itemId ) then
				call SaveInteger(HTi,hid,1,1)
			else
				call SaveInteger(HTi,hid,1,0)
			endif 	

			//Medal of Honour
		elseif itemId == 'I04U' then
			if UnitHasItemS(u ,itemId ) then
				call SaveInteger(HTi,hid,2,1)
			else
				call SaveInteger(HTi,hid,2,0)
			endif 
		
		
			//Staff of Absolute Magic
		elseif itemId == 'I05E' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,3) 
			call AddUnitMagicDmg(u ,   50 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,3,i)	
		
		
			//Staff of Lightning
		elseif itemId == 'I05C' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,4) 
			call AddUnitMagicDmg(u ,   30 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,4,i)	
		
		
			//Robe of the ARchmage
		elseif itemId == 'I05B' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,5) 
			call AddUnitMagicDmg(u ,   65 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,5,i)	
			
		
			//Runic Bracer
		elseif itemId == 'I04C' then
			set i = UnitHasItemI(u ,itemId ) 
			set prevCount = LoadInteger(HTi,hid,6) 
			call AddUnitMagicDef(u ,   10 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,6,i)	
			

			//Scroll of Transformation
		elseif itemId == 'I065' then
			set i = UnitHasItemI(u ,itemId ) 
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitMagicDef(u ,   25 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid, itemId,i)	
			
		
			//Magic Necklace
		elseif itemId == 'I05G' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,7) 
			call AddUnitMagicDef(u ,   75 * I2R(i - prevCount)  )	
			set MnXpBonus.real[hid] = MnXpBonus.real[hid] + (0.2 * I2R(i - prevCount))
			call SaveInteger(HTi,hid,7,i)	
			
		
			//Legendary Shield
		elseif itemId == 'I059' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,8) 
			call AddUnitBlock(u ,   500 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,8,i)	
			

			//Sword of Bloodthirst
		elseif itemId == SWORD_OF_BLOODTHRIST_ITEM_ID then
			set i = UnitHasItemI(u, itemId)
			set prevCount = LoadInteger(HTi, hid, 47)
			set r = GetHeroPrimaryStat(u)
			call SetHeroStat(u, r, GetHeroStatBJ(r, u, false) + 300 * (i - prevCount))
			call SaveInteger(HTi,hid,47,i)	
		

			//Wisdom Chestplate
		elseif itemId == WISDOM_CHESTPLATE_ITEM_ID then
			set i = UnitHasItemI(u, itemId)
			set prevCount = LoadInteger(HTi, hid, 48)
			call AddUnitBlock(u, 800 * (i - prevCount))
			call SaveInteger(HTi, hid, 48, i)
		
		
			//Mask of Protection
		elseif itemId == MASK_OF_PROTECTION_ITEM_ID then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,45) 
			call AddUnitMagicDmg(u ,   75 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,45,i)	
			

			//Mask of Elusion
		elseif itemId == MASK_OF_ELUSION_ITEM_ID then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,46) 
			call AddUnitEvasion(u, 40 * I2R(i - prevCount))
			call SaveInteger(HTi,hid,46,i)	
				
		
			//Ancient Dagger
		elseif itemId == ANCIENT_DAGGER_ITEM_ID then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,43) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5 *(i - prevCount))
			call AddUnitEvasion(u ,   20 * I2R(i - prevCount)  )	
			call AddAgilityLevelBonus(u, 15 *(i - prevCount))
			call SetHeroAgi(u, GetHeroAgi(u, false) + (15 *(i - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uagp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uagp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,hid,43,i)	
			
		
			//Ancient Axe
		elseif itemId == ANCIENT_AXE_ITEM_ID then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,42) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5 *(i - prevCount))
			call AddUnitBlock(u ,   900 * I2R(i - prevCount)  )	
			call AddStrengthLevelBonus(u, 15 *(i - prevCount))
			call SetHeroStr(u, GetHeroStr(u, false) + (15 *(i - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('ustp'),  BlzGetUnitRealField(u,ConvertUnitRealField('ustp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,hid,42,i)	
			

			//Ring of Musculature
		elseif itemId == 'I071' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, 39) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				set i2 = 4
			else
				set i2 = 2
			endif

			call AddStrengthLevelBonus(u, i2 *(i - prevCount))
			call AddUnitBlock(u, - 20 *(i - prevCount))
			call SaveInteger(HTi,hid,39,i)	
		

			//Ring of the Bookworm
		elseif itemId == 'I072' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, 40) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				set i2 = 4
			else
				set i2 = 2
			endif

			call AddIntelligenceLevelBonus(u, i2 *(i - prevCount))
			call AddUnitBlock(u, - 20 *(i - prevCount))
			call SaveInteger(HTi,hid,40,i)	
		

			//Trainers Ring
		elseif itemId == 'I073' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, 41) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				set i2 = 4
			else
				set i2 = 2
			endif

			call AddAgilityLevelBonus(u, i2 *(i - prevCount))
			call AddUnitBlock(u, - 20 *(i - prevCount))
			call SaveInteger(HTi,hid,41,i)	
		

			//Arena Ring
		elseif itemId == 'I0AF' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, 49) 

			call RegisterEndOfRoundItem(pid, it)

			call AddUnitBlock(u, - 30 *(i - prevCount))
			call SaveInteger(HTi,hid,49,i)	

			//Gladiator Helmet
		elseif itemId == 'I07A' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,14) 	
			if i > 0 then
				if GetUnitAbilityLevel(u,'A05K') == 0 then
					call UnitAddAbility(u,'A05K')
				endif
				call BlzUnitHideAbility(u,'A05K',true)
				call SetUnitAbilityLevel(u,'A05K',2)
				call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A05K'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, - i * 50 )         
				call SetUnitAbilityLevel(u,'A05K',1)
			else
				call UnitRemoveAbility(u,'A05K')
			endif
			call SaveInteger(HTi,hid,14,i)	
			

			//Magic Amulet
		elseif itemId == 'I07B' then

			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,15) 
			call AddUnitMagicDmg(u ,   20 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,15,i)	
		

			//Night Amulet
		elseif itemId == 'I07E' then

			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,16) 
			call AddUnitMagicDmg(u ,   10 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,16,i)	
		

			//Armor of the Ancestors
		elseif itemId == 'I07G' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,17) 
			call AddUnitBlock(u ,   50 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,17,i)	
		
			//Golden Armor
		elseif itemId == 'I07H' then
			call RegisterEndOfRoundItem(pid, it)
	
			//Fishing Rod
		elseif itemId == 'I07T' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,19) 
			call AddUnitEvasion(u ,   10 * I2R(i - prevCount)  )
			call AddUnitBonus(u, BONUS_DAMAGE, 800 * i - prevCount)
			call BlzSetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128 *(i - prevCount ))
			call SaveInteger(HTi,hid,19,i)	
		

			//Snowww's wand
		elseif itemId == 'I07V' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,20) 
			
			call AddUnitMagicDmg(u ,   125 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,20,i)	
		
		
			//Holy Shield
		elseif itemId == 'I07W' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,21) 
			
			call AddUnitMagicDef(u ,   25 * I2R(i - prevCount)  )	
			call AddUnitBlock(u ,   50 * I2R(i - prevCount)  )
			call AddUnitEvasion(u ,   15 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,21,i)	
		
		
			//Light Armor
		elseif itemId == 'I076' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,22) 
			call AddUnitEvasion(u ,   10 * I2R(i - prevCount)  )
			call AddUnitMagicDef(u ,   10 * I2R(i - prevCount)  )		
			call SaveInteger(HTi,hid,22,i)	
		

			//Unusual Wooden Shield
		elseif itemId == 'I077' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,23) 
			call AddUnitBlock(u ,   30 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,23,i)	
		
			//Universal Chain Mail
		elseif itemId == 'I07Y' then
			set i = UnitHasItemI(u ,itemId )
			if i > 2 then
				set i = 2
			endif
			set prevCount = LoadInteger(HTi,hid,24) 
			call AddUnitBlock(u ,   750 * I2R(i - prevCount)  )	
			call AddUnitEvasion(u ,   30 * I2R(i - prevCount)  )
			call AddUnitMagicDef(u ,   60 * I2R(i - prevCount)  )	
			call SaveInteger(HTi,hid,24,i)	
		
		
			//Ancient Staff
		elseif itemId == ANCIENT_STAFF_ITEM_ID then
			set i = UnitHasItemI(u ,itemId ) 
			set prevCount = LoadInteger(HTi,hid,44) 
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(i-prevCount)
			call AddUnitPvpBonus(u, 5 *(i - prevCount))
			call AddUnitMagicDmg(u ,   40 * I2R(i - prevCount)  )	
			call AddIntelligenceLevelBonus(u, 15 *(i - prevCount))
			call SetHeroInt(u, GetHeroInt(u, false) + (15 *(i - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uinp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uinp')) + 15*(i-prevCount) )
			call SaveInteger(HTi,hid,44,i)	
		
			//Staff of Power
		elseif itemId == 'I080' then
			set i = UnitHasItemI(u ,itemId )
			if i > 1 then
				set i = 1
				call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,7)
			else
				call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,8) 
			endif
			set prevCount = LoadInteger(HTi,hid,26) 
			call SaveInteger(HTi,hid,26,i)	
		
			//Good Luck Charm
		elseif itemId == 'I083' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,27) 
			call AddUnitLuck(u ,   0.15 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,27,i)	
		   
			//Shining Runestone
		elseif itemId == 'I08L' then
			set i = UnitHasItemI(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,28) 
			call AddUnitPowerRune(u ,   50 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,28,i)	
		   
			//runestone of Creation
		elseif itemId == 'I08N' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,29) 
			call AddUnitPowerRune(u ,   75 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,29,i)	
		 
			/*
			if itemId == 'I08P' then
				if UnitHasItemS(u ,itemId ) then
					set i = 1 
				else
					set i = 0
				endif
				set prevCount = LoadInteger(HTi,hid,30) 
				call AddUnitPowerRune(u ,   100 * I2R(i - prevCount)  )
				call SaveInteger(HTi,hid,30,i)	
			endif 
			if itemId == 'I08Q' then
				if UnitHasItemS(u ,itemId ) then
					set i = 1 
				else
					set i = 0
				endif
				set prevCount = LoadInteger(HTi,hid,31) 
				call AddUnitPowerRune(u ,   100 * I2R(i - prevCount)  )
				call SaveInteger(HTi,hid,31,i)	
			endif     
			if itemId == 'I08R' then
				if UnitHasItemS(u ,itemId ) then
					set i = 1 
				else
					set i = 0
				endif
				set prevCount = LoadInteger(HTi,hid,32) 
				call AddUnitPowerRune(u ,   100 * I2R(i - prevCount)  )
				call SaveInteger(HTi,hid,32,i)	
			endif  
		
			if itemId == 'I08S' then
				if UnitHasItemS(u ,itemId ) then
					set i = 1 
				else
					set i = 0
				endif
				set prevCount = LoadInteger(HTi,hid,33) 
				call AddUnitPowerRune(u ,   100 * I2R(i - prevCount)  )
				call SaveInteger(HTi,hid,33,i)	
			endif */

			//Runestones
		elseif itemId == 'I08P' or itemId == 'I0B8' or itemId == 'I0B7' or itemId == 'I0B6' or itemId == 'I095' or itemId == 'I0B5' or itemId == 'I08S' or itemId == 'I08R' or itemId == 'I08Q' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,itemId) 
			call AddUnitPowerRune(u ,   100 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,itemId,i)	
		  
		
			//Blaze Staff
		elseif itemId == 'I08X' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,34) 
			call AddUnitMagicDmg(u ,   35 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,34,i)	
		  
		
			//Fan
		elseif itemId == 'I08Z' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,35) 
			call AddUnitEvasion(u ,   30 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,35,i)	
		     
		
			//Stone Helmet
		elseif itemId == 'I090' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,36) 
			call AddUnitBlock(u ,   1000 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,36,i)	
		  
		
			//Mithril Helmet
		elseif itemId == 'I091' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,37) 
			call AddUnitMagicDef(u ,   50 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,37,i)	
		  
		
			//anti-magic Cape
		elseif itemId == 'I092' then
			if UnitHasItemS(u ,itemId ) then
				set i = 1 
			else
				set i = 0
			endif
			set prevCount = LoadInteger(HTi,hid,38) 
			call AddUnitMagicDmg(u ,   - 50 * I2R(i - prevCount)  )
			call AddUnitMagicDef(u ,   200 * I2R(i - prevCount)  )
			call SaveInteger(HTi,hid,38,i)	
		
			//Heart of Darkness
		elseif itemId == 'I04V' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

			//Heart of Darkness
		elseif itemId == 'I04V' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

			//Heart of Darkness
		elseif itemId == 'I04V' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Hammer of the Gods
		elseif itemId == 'I066' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 10000 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Hammer of Chaos
		elseif itemId == 'I06H' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, -300 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Titanium Armor
		elseif itemId == 'I07M' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, -500 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Heavy Mace
		elseif itemId == 'I07I' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 350 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Speed Blade
		elseif itemId == 'I06B' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 750 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Bloody Axe
		elseif itemId == 'I078' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 100 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Battle Axe
		elseif itemId == 'I075' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 30 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Reaver's Axe
		elseif itemId == 'I04A' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

			//Aduxxors Blade
		elseif itemId == 'I015' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 34 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

			//Soul Reaper
		elseif itemId == 'I01C' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 80 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	

		//Rapier of the Gods
		elseif itemId == 'I01E' then
			set i = UnitHasItemI(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 120 * (i - prevCount))
			call SaveInteger(HTi, hid, itemId, i)	
		endif  
		
		call RemoveSavedHandle(HTi, GetHandleId(t), 2)
		call FlushChildHashtable(HTi,GetHandleId(t))
		call ReleaseTimer(t)

		set it = null
		set t = null
		set u = null
	endfunction




	function Trig_ItemBonus_Actions takes nothing returns nothing
		local timer Time1 = null


		set Time1 = NewTimer()

		call SaveUnitHandle(HTi,GetHandleId(Time1),1, GetTriggerUnit() )
		call SaveItemHandle(HTi, GetHandleId(Time1), 2, GetManipulatedItem())
		call SaveInteger(HTi, GetHandleId(Time1), 3, GetItemTypeId(GetManipulatedItem()))
		
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