library ItemBonus initializer init requires CustomState, ReplaceItem, RandomShit, LevelUpStats, Utility, PandaSkin
	globals
		hashtable HTi = InitHashtable()

		private integer EVENT_ITEM_PICKUP = 0
		private integer EVENT_ITEM_DROP = 1
	endglobals

	function SetupItem takes unit u, item it, integer ev returns nothing
		local integer hid = GetHandleId(u)
		local integer itemId = GetItemTypeId(it)
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local integer itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
		local integer prevCount = LoadInteger(HTi, hid, itemId) 
		
		if ((GetItemType(it) == ITEM_TYPE_POWERUP or GetItemType(it) == ITEM_TYPE_CAMPAIGN) and not IsHeroUnitId(GetUnitTypeId(u))) then
			return
		endif

		if IsItemReplaceable(itemId) and ev == EVENT_ITEM_PICKUP then
			call SetItemReplaced(GetHandleId(it))
			call RemoveItem(it)
			call UnitAddItemById(u, GetItemReplacement(itemId))
		endif
		
		//Mask of Death
		if itemId == 'I04T' then
			if UnitHasItemType(u ,itemId ) then
				call SaveInteger(HTi, hid, itemId,1)
			else
				call SaveInteger(HTi, hid, itemId,0)
			endif 	

			//Medal of Honour
		elseif itemId == 'I04U' then
			if UnitHasItemType(u ,itemId ) then
				call SaveInteger(HTi, hid, itemId,1)
			else
				call SaveInteger(HTi, hid, itemId,0)
			endif 
		
		
			//Staff of Absolute Magic
		elseif itemId == 'I05E' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   25 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
		
			//Staff of Lightning
		elseif itemId == 'I05C' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   15 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
		
			//Robe of the ARchmage
		elseif itemId == 'I05B' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   30 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
			call AddUnitAbsoluteBonusCount(u,Element_Water, (itemCount-prevCount))
		
			//Runic Bracer
		elseif itemId == 'I04C' then
			set itemCount = GetUnitItemTypeCount(u ,itemId ) 
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   10 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
			

			//Scroll of Transformation
		elseif itemId == 'I065' then
			set itemCount = GetUnitItemTypeCount(u ,itemId ) 
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   25 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi,hid, itemId,itemCount)	

			//Magic Necklace
		elseif itemId == 'I05G' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   75 * I2R(itemCount - prevCount)  )	
			set MnXpBonus.real[hid] = MnXpBonus.real[hid] + (0.2 * I2R(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Legendary Shield
		elseif itemId == 'I059' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   500 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Grass of Immortality
		elseif itemId == 'I04N' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, (1500 * I2R(itemCount - prevCount) ))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Staff of the archmage of water
		elseif itemId == 'I08Y' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonusReal(u, BONUS_MANA_REGEN, (500 * I2R(itemCount - prevCount) ))
			call SaveInteger(HTi, hid, itemId,itemCount)	
			set itemCount = IMinBJ(itemCount, 1)
			call AddUnitAbsoluteBonusCount(u,Element_Water, (itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Arcane, (itemCount-prevCount))

			//Sword of Bloodthirst
		elseif itemId == SWORD_OF_BLOODTHRIST_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u, itemId)
			set prevCount = LoadInteger(HTi, hid, itemId)
			call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) + 300 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Wisdom Chestplate
		elseif itemId == WISDOM_CHESTPLATE_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u, itemId)
			set prevCount = LoadInteger(HTi, hid, itemId)
			call AddUnitCustomState(u, BONUS_BLOCK, 800 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)
		
		
			//Mask of Protection
		elseif itemId == MASK_OF_PROTECTION_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   35 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
			

			//Mask of Elusion
		elseif itemId == MASK_OF_ELUSION_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u, BONUS_EVASION, 40 * I2R(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Flimsy Token
		elseif itemId == FLIMSY_TOKEN_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u, BONUS_EVASION, 30 * I2R(itemCount - prevCount))
			call SaveInteger(HTi,hid,itemId,itemCount)	

			//Spellbane Token
		elseif itemId == SPELL_BANE_TOKEN_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid,itemId) 
			call AddUnitCustomState(u, BONUS_MAGICRES, 40 * I2R(itemCount - prevCount))
			call SaveInteger(HTi,hid,itemId,itemCount)	
				
		
			//Ancient Dagger
		elseif itemId == ANCIENT_DAGGER_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(itemCount-prevCount)
			call AddUnitCustomState(u , BONUS_PVP,   5 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_EVASION,   20 * I2R(itemCount - prevCount)  )	
			call AddAgilityLevelBonus(u, 15 *(itemCount - prevCount))
			call SetHeroAgi(u, GetHeroAgi(u, false) + (15 *(itemCount - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uagp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uagp')) + 15*(itemCount-prevCount) )
			call SaveInteger(HTi, hid, itemId,itemCount)	
			
		
			//Ancient Axe
		elseif itemId == ANCIENT_AXE_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(itemCount-prevCount)
			call AddUnitCustomState(u , BONUS_PVP,   5 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_BLOCK,   900 * I2R(itemCount - prevCount)  )	
			call AddStrengthLevelBonus(u, 15 *(itemCount - prevCount))
			call SetHeroStr(u, GetHeroStr(u, false) + (15 *(itemCount - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('ustp'),  BlzGetUnitRealField(u,ConvertUnitRealField('ustp')) + 15*(itemCount-prevCount) )
			call SaveInteger(HTi, hid, itemId,itemCount)	
			

			//Ring of Musculature
		elseif itemId == 'I071' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddStrengthLevelBonus(u, 4 *(itemCount - prevCount))
			else
				call AddStrengthLevelBonus(u, 2 *(itemCount - prevCount))
			endif
			
			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Ring of the Bookworm
		elseif itemId == 'I072' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddIntelligenceLevelBonus(u, 4 *(itemCount - prevCount))
			else
				call AddIntelligenceLevelBonus(u, 2 *(itemCount - prevCount))
			endif
			
			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Trainers Ring
		elseif itemId == 'I073' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 

			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddAgilityLevelBonus(u, 4 *(itemCount - prevCount))
			else
				call AddAgilityLevelBonus(u, 2 *(itemCount - prevCount))
			endif

			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Arena Ring
		elseif itemId == 'I0AF' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 

			call RegisterEndOfRoundItem(pid, it)

			call AddUnitCustomState(u, BONUS_BLOCK, - 30 *(itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Gladiator Helmet
		elseif itemId == 'I07A' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 	
			if itemCount > 0 then
				if GetUnitAbilityLevel(u,'A05K') == 0 then
					call UnitAddAbility(u,'A05K')
				endif
				call BlzUnitHideAbility(u,'A05K',true)
				call SetUnitAbilityLevel(u,'A05K',2)
				call BlzSetAbilityRealLevelField( BlzGetUnitAbility(u,'A05K'),ABILITY_RLF_ARMOR_BONUS_HAD1,0, - itemCount * 50 )         
				call SetUnitAbilityLevel(u,'A05K',1)
			else
				call UnitRemoveAbility(u,'A05K')
			endif
			call SaveInteger(HTi, hid, itemId,itemCount)	
			

		elseif itemId == ORB_OF_ELEMENTS then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Fire, 2*(itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Water, 2*(itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Earth, 2*(itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Wind, 2*(itemCount-prevCount))

			call SaveInteger(HTi,hid, itemId,itemCount)	

		elseif itemId == SHADOW_BLADE_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + 1500*(itemCount - prevCount), 0 )
			call AddUnitBonus(u, BONUS_DAMAGE, 6000 * (itemCount - prevCount))
			call AddUnitCustomState(u , BONUS_EVASION,   20 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Magic Amulet
		elseif itemId == 'I07B' then

			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   10 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Night Amulet
		elseif itemId == 'I07E' then

			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   5 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Armor of the Ancestors
		elseif itemId == 'I07G' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   50 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
			//Obsidian Armor
		elseif itemId == 'I0CW' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   200 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi,hid, itemId,itemCount)	
			call RegisterEndOfRoundItem(pid, it)

			//Golden Armor
		elseif itemId == 'I0CV' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   10 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi,hid, itemId,itemCount)	
			call RegisterEndOfRoundItem(pid, it)

		elseif itemId == 'I0CX' then
			call RegisterEndOfRoundItem(pid, it)
			//Leather Armor
		elseif itemId == 'I0CY' then
			call RegisterEndOfRoundItem(pid, it)
			//Rapira
		elseif itemId == 'I0CZ' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 300 * (itemCount - prevCount))
			call SaveInteger(HTi,hid, itemId,itemCount)	

			call RegisterEndOfRoundItem(pid, it)

			//Blokkades Shield - imba
		elseif itemId == BLOKKADE_SHIELD_ITEM_ID then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   1000 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_MAGICRES,   30 * I2R(itemCount - prevCount)  )		
			call SaveInteger(HTi,hid, itemId,itemCount)	

			//Contract of the Living
		elseif itemId == CONTRACT_LIVING_ITEM_ID then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   50 * I2R(itemCount - prevCount)  )		
			call SaveInteger(HTi,hid, itemId,itemCount)	
			//Avoid item CD resetting, dunno how to make it the actual remaining cd but probably not necessary, just don't drop the item 4Head
			call AbilStartCD(u, CONTRACT_LIVING_ABIL_ID, 90)
			
			//Fishing Rod
		elseif itemId == 'I07T' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_EVASION,   10 * I2R(itemCount - prevCount)  )
			call AddUnitBonus(u, BONUS_DAMAGE, 800 * (itemCount - prevCount))
			call BlzSetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(u,	ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128 *(itemCount - prevCount ))
			call SaveInteger(HTi, hid, itemId,itemCount)	
			call AddUnitAbsoluteBonusCount(u,Element_Wind, (itemCount-prevCount))

			//Snowww's wand
		elseif itemId == 'I07V' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			
			call AddUnitCustomState(u , BONUS_MAGICPOW,   60 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
		
			//Holy Shield
		elseif itemId == 'I07W' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			
			call AddUnitCustomState(u , BONUS_MAGICRES,   50 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_BLOCK,   500 * I2R(itemCount - prevCount)  )
			call AddUnitCustomState(u , BONUS_EVASION,   30 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
			call AddUnitAbsoluteBonusCount(u,Element_Light, (itemCount-prevCount))
		
			//Light Armor
		elseif itemId == 'I076' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_EVASION,   10 * I2R(itemCount - prevCount)  )
			call AddUnitCustomState(u , BONUS_MAGICRES,   10 * I2R(itemCount - prevCount)  )		
			call SaveInteger(HTi, hid, itemId,itemCount)	
		

			//Unusual Wooden Shield
		elseif itemId == 'I077' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   30 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
			//Universal Chain Mail
		elseif itemId == 'I07Y' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			if itemCount > 2 then
				set itemCount = 2
			endif
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   750 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_EVASION,   30 * I2R(itemCount - prevCount)  )
			call AddUnitCustomState(u , BONUS_MAGICRES,   60 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
		
			//Ancient Staff
		elseif itemId == ANCIENT_STAFF_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId ) 
			set prevCount = LoadInteger(HTi, hid, itemId) 
			//set PvpBonus[pid] = PvpBonus[pid] + 5*(itemCount-prevCount)
			call AddUnitCustomState(u , BONUS_PVP,   5 * I2R(itemCount - prevCount)  )	
			call AddUnitCustomState(u , BONUS_MAGICPOW,   20 * I2R(itemCount - prevCount)  )	
			call AddIntelligenceLevelBonus(u, 15 *(itemCount - prevCount))
			call SetHeroInt(u, GetHeroInt(u, false) + (15 *(itemCount - prevCount))* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uinp'),  BlzGetUnitRealField(u,ConvertUnitRealField('uinp')) + 15*(itemCount-prevCount) )
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
			//Staff of Power
		elseif itemId == 'I080' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			if itemCount > 1 then
				set itemCount = 1
				call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,7)
			else
				call BlzSetUnitWeaponIntegerField(u,UNIT_WEAPON_IF_ATTACK_ATTACK_TYPE,0,8) 
			endif
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call SaveInteger(HTi, hid, itemId,itemCount)	
		
			//Archmage Staff
		elseif itemId == 'I086' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Water, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Wizards Gemstone
		elseif itemId == 'I0BQ' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Arcane, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Book of Creatures
		elseif itemId == 'I07K' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Wild, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Bloodstone
		elseif itemId == 'I0AK' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Blood, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Bone Armor
		elseif itemId == 'I07O' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Dark, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Panda Relic
		elseif itemId == 'I086' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Blood, (itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Water, (itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Wind, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Frost Circlet
		elseif itemId == 'I0BP' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Cold, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Frostmourne
		elseif itemId == 'I04P' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitAbsoluteBonusCount(u,Element_Cold, (itemCount-prevCount))
			call AddUnitAbsoluteBonusCount(u,Element_Dark, (itemCount-prevCount))
			call SaveInteger(HTi, hid, itemId,itemCount)

			//Good Luck Charm
		elseif itemId == 'I083' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_LUCK,   0.15 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
		   
			//Shining Runestone
		elseif itemId == SHINING_RUNESTONE_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_RUNEPOW,   50 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
		   
			//runestone of Creation
		elseif itemId == RUNESTONE_OF_CREATION_ITEM_ID then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_RUNEPOW,   75 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Guide to Rune Master
		elseif itemId == 'I0BZ' then
			set itemCount = GetUnitItemTypeCount(u ,itemId )
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u , BONUS_RUNEPOW,   50 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi,hid, itemId,itemCount)	

			//Conqueror's Bamboo Stick
		elseif itemId == 'I0C2' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid, itemId) 
			call AddUnitCustomState(u, BONUS_EVASION, 20 * I2R(itemCount - prevCount))
			call AddUnitCustomState(u, BONUS_MAGICRES, 30  * I2R(itemCount - prevCount))
			call AddUnitBonus(u, BONUS_ARMOR, 100 * (itemCount - prevCount))
			call AddUnitBonus(u, BONUS_HEALTH, 10000 * (itemCount - prevCount))
			call SaveInteger(HTi,hid, itemId,itemCount)	
		 
			/*
			if itemId == FIRE_RUNESTONE_ITEM_ID then
				if UnitHasItemType(u ,itemId ) then
					set itemCount = 1 
				else
					set itemCount = 0
				endif
				set prevCount = LoadInteger(HTi, hid, itemId) 
				call AddUnitCustomState(u , BONUS_RUNEPOW,   100 * I2R(itemCount - prevCount)  )
				call SaveInteger(HTi, hid, itemId,itemCount)	
			endif 
			if itemId == WATER_RUNESTONE_ITEM_ID then
				if UnitHasItemType(u ,itemId ) then
					set itemCount = 1 
				else
					set itemCount = 0
				endif
				set prevCount = LoadInteger(HTi, hid, itemId) 
				call AddUnitCustomState(u , BONUS_RUNEPOW,   100 * I2R(itemCount - prevCount)  )
				call SaveInteger(HTi, hid, itemId,itemCount)	
			endif     
			if itemId == EARTH_RUNESTONE_ITEM_ID then
				if UnitHasItemType(u ,itemId ) then
					set itemCount = 1 
				else
					set itemCount = 0
				endif
				set prevCount = LoadInteger(HTi, hid, itemId) 
				call AddUnitCustomState(u , BONUS_RUNEPOW,   100 * I2R(itemCount - prevCount)  )
				call SaveInteger(HTi, hid, itemId,itemCount)	
			endif  
		
			if itemId == WIND_RUNESTONE_ITEM_ID then
				if UnitHasItemType(u ,itemId ) then
					set itemCount = 1 
				else
					set itemCount = 0
				endif
				set prevCount = LoadInteger(HTi, hid, itemId) 
				call AddUnitCustomState(u , BONUS_RUNEPOW,   100 * I2R(itemCount - prevCount)  )
				call SaveInteger(HTi, hid, itemId,itemCount)	
			endif */

			//Runestones
		elseif itemId == FIRE_RUNESTONE_ITEM_ID or itemId == POISON_RUNESTONE_ITEM_ID or itemId == ARCANE_RUNESTONE_ITEM_ID or itemId == WILD_RUNESTONE_ITEM_ID or itemId == LIGHT_RUNESTONE_ITEM_ID or itemId == DARK_RUNESTONE_ITEM_ID or itemId == WIND_RUNESTONE_ITEM_ID or itemId == EARTH_RUNESTONE_ITEM_ID or itemId == WATER_RUNESTONE_ITEM_ID or itemId == 'I0BX' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid,itemId) 
			call AddUnitCustomState(u , BONUS_RUNEPOW,   100 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi,hid,itemId,itemCount)	
			
			if itemId == FIRE_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Fire, (itemCount-prevCount))
			elseif itemId == POISON_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Poison, (itemCount-prevCount))
			elseif itemId == ARCANE_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Arcane, (itemCount-prevCount))
			elseif itemId == WILD_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Wild, (itemCount-prevCount))
			elseif itemId == LIGHT_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Light, (itemCount-prevCount))
			elseif itemId == DARK_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Dark, (itemCount-prevCount))
			elseif itemId == WIND_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Wind, (itemCount-prevCount))
			elseif itemId == WATER_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Water, (itemCount-prevCount))
			elseif itemId == EARTH_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Earth, (itemCount-prevCount))
			endif
		
			//Blaze Staff
		elseif itemId == 'I08X' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,   15 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
			call AddUnitAbsoluteBonusCount(u,Element_Fire, (itemCount-prevCount))
		
			//Fan
		elseif itemId == 'I08Z' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_EVASION,   15 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
		     
		
			//Stone Helmet
		elseif itemId == 'I090' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_BLOCK,   1000 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
			call AddUnitAbsoluteBonusCount(u,Element_Earth, (itemCount-prevCount))
		
			//Mithril Helmet
		elseif itemId == 'I091' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   50 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	
		  
		
			//anti-magic Cape
		elseif itemId == 'I092' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW,0 - 25 * I2R(itemCount - prevCount)  )
			call AddUnitCustomState(u , BONUS_MAGICRES,200 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId,itemCount)	

			//Hero's hammer
		elseif itemId == 'I064' then
			set itemCount = IMinBJ(GetUnitItemTypeCount(u ,itemId ), 1)
			set prevCount = LoadInteger(HTi,hid,itemId) 
			call AddUnitCustomState(u , BONUS_PHYSPOW,   60 * I2R(itemCount - prevCount)  )	
			call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) + 400 * (itemCount - prevCount))
			call SaveInteger(HTi,hid,itemId,itemCount)	
		
			//Heart of Darkness
		elseif itemId == 'I04V' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Hammer of the Gods
		elseif itemId == 'I066' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 10000 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Hammer of Chaos
		elseif itemId == 'I06H' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			//call AddUnitBonus(u, BONUS_DAMAGE, -300 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		/*//Titanium Armor
		elseif itemId == 'I07M' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, -500 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	*/

		//Titanium Spike
		elseif itemId == TITANIUM_SPIKE_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (1000 * (itemCount - prevCount)), 0)
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Heavy Mace
		elseif itemId == 'I07I' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 350 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Speed Blade
		elseif itemId == 'I06B' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 750 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Bloody Axe
		elseif itemId == 'I078' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 100 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Battle Axe
		elseif itemId == 'I075' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 30 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Reaver's Axe
		elseif itemId == 'I04A' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

			//Aduxxors Blade
		elseif itemId == 'I015' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 34 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

			//Soul Reaper
		elseif itemId == 'I01C' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 80 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

			//Null Void Orb
		elseif itemId == 'I0AL' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICRES,   40 * I2R(itemCount - prevCount)  )
			call SaveInteger(HTi, hid, itemId, itemCount)

		//Rapier of the Gods
		elseif itemId == 'I01E' then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitBonus(u, BONUS_DAMAGE, 120 * (itemCount - prevCount))
			call SaveInteger(HTi, hid, itemId, itemCount)	

		//Scorched Scimitar
		elseif itemId == SCORCHED_SCIMITAR_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			call AddUnitCustomState(u , BONUS_MAGICPOW, 20 * I2R(itemCount - prevCount))
			call AddUnitCustomState(u , BONUS_PHYSPOW,   20 * I2R(itemCount - prevCount)  )	
			call SaveInteger(HTi, hid, itemId, itemCount)
		
			//Druidic Focus
		elseif itemId == DRUIDIC_FOCUS_ITEM_ID then
			set itemCount = GetUnitItemTypeCount(u , itemId)
			set prevCount = LoadInteger(HTi, hid, itemId) 
			if itemCount <= 0 then
				call UnitRemoveAbility(u, DRUIDIC_FOCUS_ABILITY_ID)
			elseif GetUnitAbilityLevel(u, DRUIDIC_FOCUS_ABILITY_ID) == 0 then
				call UnitAddAbility(u, DRUIDIC_FOCUS_ABILITY_ID)
			endif
			call SaveInteger(HTi, hid, itemId, itemCount)
		endif  

		call PandaSkin_CheckAbilitiesAndItems(u)
	endfunction

	private function ItemDrop takes nothing returns nothing
		call SetupItem(GetTriggerUnit(), GetManipulatedItem(), EVENT_ITEM_DROP)
	endfunction

	private function ItemPickup takes nothing returns nothing
		call SetupItem(GetTriggerUnit(), GetManipulatedItem(), EVENT_ITEM_PICKUP)
	endfunction

	//===========================================================================
	private function init takes nothing returns nothing
		local trigger trg = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_PICKUP_ITEM)
		call TriggerAddCondition(trg, Condition(function ItemPickup))
		
		set trg = CreateTrigger()
		call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_DROP_ITEM)
		call TriggerAddCondition(trg, Condition(function ItemDrop))

		set trg = null
	endfunction
endlibrary