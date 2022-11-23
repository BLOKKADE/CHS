library ItemBonus initializer init requires CustomState, ReplaceItem, RandomShit, LevelUpStats, Utility, PandaSkin
	globals
		hashtable HTi = InitHashtable()
		Table UniqueItemCount
		private integer EVENT_ITEM_PICKUP = 0
		private integer EVENT_ITEM_DROP = 1
	endglobals

	function SetupItem takes unit u, item it, integer ev returns nothing
		local integer hid = GetHandleId(u)
		local integer itemId = GetItemTypeId(it)
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local integer itemCount = GetUnitItemTypeCount(u ,itemId )
		local integer prevCount = LoadInteger(HTi, hid, itemId)
		local integer diff = 0
		local integer uniqueDiff = 0
		
		if ((GetItemType(it) == ITEM_TYPE_POWERUP or GetItemType(it) == ITEM_TYPE_CAMPAIGN) and not IsHeroUnitId(GetUnitTypeId(u))) then
			return
		endif

		if ev == EVENT_ITEM_DROP then
			set itemCount = itemCount - 1
		endif

		call SaveInteger(HTi, hid, itemId,itemCount)
		set diff = itemCount - prevCount
		set uniqueDiff = IMinBJ(itemCount, 1) - UniqueItemCount[hid].integer[itemId]
		set UniqueItemCount[hid].integer[itemId] = IMinBJ(itemCount, 1)

		if pid == 0 and GetUnitTypeId(u) != SELL_ITEM_DUMMY then
			call BJDebugMsg("it: " + GetObjectName(itemId) + ", u: " + GetUnitName(u))
			call BJDebugMsg("ic: " + I2S(itemCount) + "- prevc: " + I2S(prevCount) + " = " + I2S(diff) + ". icMin: " + I2S(IMinBJ(itemCount, 1)) + "- prevUicMin: " + I2S(UniqueItemCount[hid].integer[itemId]) + " = " + I2S(uniqueDiff))

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
			call AddUnitCustomState(u, BONUS_MAGICPOW, 25 * uniqueDiff)
		
			//Staff of Lightning
		elseif itemId == 'I05C' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 15 * uniqueDiff)
		
			//Robe of the ARchmage
		elseif itemId == 'I05B' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 30 * uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Water, uniqueDiff)
		
			//Runic Bracer
		elseif itemId == 'I04C' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 10 * diff)
			
			//Scroll of Transformation
		elseif itemId == 'I065' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 25 * diff)

			//Magic Necklace
		elseif itemId == 'I05G' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 75 * uniqueDiff)
			set MnXpBonus.real[hid] = MnXpBonus.real[hid] + (0.2 * uniqueDiff)

			//Legendary Shield
		elseif itemId == 'I059' then
			call AddUnitCustomState(u, BONUS_BLOCK, 500 * uniqueDiff)

			//Grass of Immortality
		elseif itemId == 'I04N' then
			call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, (1500 * diff ))

			//Staff of the archmage of water
		elseif itemId == 'I08Y' then
			call AddUnitBonusReal(u, BONUS_MANA_REGEN, (500 * diff ))
			call AddUnitAbsoluteBonusCount(u,Element_Water, uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Arcane, uniqueDiff)

			//Sword of Bloodthirst
		elseif itemId == SWORD_OF_BLOODTHRIST_ITEM_ID then
			call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) + 300 * diff)

			//Wisdom Chestplate
		elseif itemId == WISDOM_CHESTPLATE_ITEM_ID then
			call AddUnitCustomState(u, BONUS_BLOCK, 800 * diff)
		
			//Mask of Protection
		elseif itemId == MASK_OF_PROTECTION_ITEM_ID then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 35 * diff)
			
			//Mask of Elusion
		elseif itemId == MASK_OF_ELUSION_ITEM_ID then
			call AddUnitCustomState(u, BONUS_EVASION, 40 * diff)

			//Flimsy Token
		elseif itemId == FLIMSY_TOKEN_ITEM_ID then
			call AddUnitCustomState(u, BONUS_EVASION, 30 * diff)

			//Spellbane Token
		elseif itemId == SPELL_BANE_TOKEN_ITEM_ID then
			call AddUnitCustomState(u, BONUS_MAGICRES, 40 * diff)
				
			//Ancient Dagger
		elseif itemId == ANCIENT_DAGGER_ITEM_ID then
			//set PvpBonus[pid] = PvpBonus[pid] + 5*diff
			call AddUnitCustomState(u, BONUS_PVP, 5 * diff)
			call AddUnitCustomState(u, BONUS_EVASION, 20 * diff)
			call AddAgilityLevelBonus(u, 15 *diff)
			call SetHeroAgi(u, GetHeroAgi(u, false) + (15 *diff)* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uagp'), BlzGetUnitRealField(u,ConvertUnitRealField('uagp')) + 15*diff )
			
			//Ancient Axe
		elseif itemId == ANCIENT_AXE_ITEM_ID then
			//set PvpBonus[pid] = PvpBonus[pid] + 5*diff
			call AddUnitCustomState(u, BONUS_PVP, 5 * diff)
			call AddUnitCustomState(u, BONUS_BLOCK, 900 * diff)
			call AddStrengthLevelBonus(u, 15 *diff)
			call SetHeroStr(u, GetHeroStr(u, false) + (15 *diff)* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('ustp'), BlzGetUnitRealField(u,ConvertUnitRealField('ustp')) + 15*diff )
			
			//Ring of Musculature
		elseif itemId == 'I071' then
			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddStrengthLevelBonus(u, 4 *diff)
			else
				call AddStrengthLevelBonus(u, 2 *diff)
			endif
			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *diff)
		
			//Ring of the Bookworm
		elseif itemId == 'I072' then
			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddIntelligenceLevelBonus(u, 4 *diff)
			else
				call AddIntelligenceLevelBonus(u, 2 *diff)
			endif
			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *diff)
		
			//Trainers Ring
		elseif itemId == 'I073' then
			if GetUnitTypeId(u) == ARENA_MASTER_UNIT_ID then
				call AddAgilityLevelBonus(u, 4 *diff)
			else
				call AddAgilityLevelBonus(u, 2 *diff)
			endif
			call AddUnitCustomState(u, BONUS_BLOCK, - 20 *diff)
		
			//Arena Ring
		elseif itemId == 'I0AF' then
			call RegisterEndOfRoundItem(pid, it)
			call AddUnitCustomState(u, BONUS_BLOCK, - 30 *diff)

			//Gladiator Helmet
		elseif itemId == 'I07A' then
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
			
		elseif itemId == ORB_OF_ELEMENTS then
			call AddUnitAbsoluteBonusCount(u,Element_Fire, 2*uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Water, 2*uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Earth, 2*uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Wind, 2*uniqueDiff)

		elseif itemId == SHADOW_BLADE_ITEM_ID then
			call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u,0) + 1500*diff, 0 )
			call AddUnitBonus(u, BONUS_DAMAGE, 6000 * diff)
			call AddUnitCustomState(u, BONUS_EVASION, 20 * diff)

			//Magic Amulet
		elseif itemId == 'I07B' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 10 * diff)
		
			//Night Amulet
		elseif itemId == 'I07E' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 5 * diff)
		
			//Armor of the Ancestors
		elseif itemId == 'I07G' then
			call AddUnitCustomState(u, BONUS_BLOCK, 50 * diff)
		
			//Obsidian Armor
		elseif itemId == 'I0CW' then
			call AddUnitCustomState(u, BONUS_BLOCK, 200 * diff)
			call RegisterEndOfRoundItem(pid, it)

			//Golden Armor
		elseif itemId == 'I0CV' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 10 * diff)
			call RegisterEndOfRoundItem(pid, it)

		elseif itemId == 'I0CX' then
			call RegisterEndOfRoundItem(pid, it)
			//Leather Armor
		elseif itemId == 'I0CY' then
			call RegisterEndOfRoundItem(pid, it)
			//Rapira
		elseif itemId == 'I0CZ' then
			call AddUnitBonus(u, BONUS_DAMAGE, 300 * diff)
			call RegisterEndOfRoundItem(pid, it)

			//Blokkades Shield - imba
		elseif itemId == BLOKKADE_SHIELD_ITEM_ID then
			call AddUnitCustomState(u, BONUS_BLOCK, 1000 * uniqueDiff)
			call AddUnitCustomState(u, BONUS_MAGICRES, 30 * uniqueDiff)

			//Contract of the Living
		elseif itemId == CONTRACT_LIVING_ITEM_ID then
			call AddUnitCustomState(u, BONUS_MAGICRES, 50 * uniqueDiff)
			//Avoid item CD resetting, dunno how to make it the actual remaining cd but probably not necessary, just don't drop the item 4Head
			call AbilStartCD(u, CONTRACT_LIVING_ABIL_ID, 90)
			
			//Fishing Rod
		elseif itemId == 'I07T' then
			call AddUnitCustomState(u, BONUS_EVASION, 10 * uniqueDiff)
			call AddUnitBonus(u, BONUS_DAMAGE, 800 * uniqueDiff)
			call BlzSetUnitWeaponIntegerField(u, ConvertUnitWeaponIntegerField('ua1r') ,0,BlzGetUnitWeaponIntegerField(u, ConvertUnitWeaponIntegerField('ua1r') ,0) + 1128 *uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Wind, uniqueDiff)

			//Snowww's wand
		elseif itemId == 'I07V' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 60 * uniqueDiff)
		
			//Holy Shield
		elseif itemId == 'I07W' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 50 * uniqueDiff)
			call AddUnitCustomState(u, BONUS_BLOCK, 500 * uniqueDiff)
			call AddUnitCustomState(u, BONUS_EVASION, 30 * uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Light, uniqueDiff)
		
			//Light Armor
		elseif itemId == 'I076' then
			call AddUnitCustomState(u, BONUS_EVASION, 10 * diff)
			call AddUnitCustomState(u, BONUS_MAGICRES, 10 * diff)
		
			//Unusual Wooden Shield
		elseif itemId == 'I077' then
			call AddUnitCustomState(u, BONUS_BLOCK, 30 * uniqueDiff)
		
			//Universal Chain Mail
		elseif itemId == 'I07Y' then

			if itemCount > 2 then
				set itemCount = 2
				set diff = itemCount - prevCount
				call SaveInteger(HTi, hid, itemId, itemCount)
			endif
			call AddUnitCustomState(u, BONUS_BLOCK, 750 * diff)
			call AddUnitCustomState(u, BONUS_EVASION, 30 * diff)
			call AddUnitCustomState(u, BONUS_MAGICRES, 60 * diff)
		
			//Ancient Staff
		elseif itemId == ANCIENT_STAFF_ITEM_ID then
			//set PvpBonus[pid] = PvpBonus[pid] + 5*diff
			call AddUnitCustomState(u, BONUS_PVP, 5 * diff)
			call AddUnitCustomState(u, BONUS_MAGICPOW, 20 * diff)
			call AddIntelligenceLevelBonus(u, 15 *diff)
			call SetHeroInt(u, GetHeroInt(u, false) + (15 *diff)* GetHeroLevel(u), false)
			//call BlzSetUnitRealField(u,ConvertUnitRealField('uinp'), BlzGetUnitRealField(u,ConvertUnitRealField('uinp')) + 15*diff )
		
			//Archmage Staff
		elseif itemId == 'I086' then
			call AddUnitAbsoluteBonusCount(u,Element_Water, diff)

			//Wizards Gemstone
		elseif itemId == 'I0BQ' then
			call AddUnitAbsoluteBonusCount(u,Element_Arcane, diff)

			//Book of Creatures
		elseif itemId == 'I07K' then
			call AddUnitAbsoluteBonusCount(u,Element_Wild, diff)

			//Bloodstone
		elseif itemId == 'I0AK' then
			call AddUnitAbsoluteBonusCount(u,Element_Blood, diff)

			//Bone Armor
		elseif itemId == 'I07O' then
			call AddUnitAbsoluteBonusCount(u,Element_Dark, diff)

			//Panda Relic
		elseif itemId == 'I086' then
			call AddUnitAbsoluteBonusCount(u,Element_Blood, diff)
			call AddUnitAbsoluteBonusCount(u,Element_Water, diff)
			call AddUnitAbsoluteBonusCount(u,Element_Wind, diff)

			//Frost Circlet
		elseif itemId == 'I0BP' then
			call AddUnitAbsoluteBonusCount(u,Element_Cold, diff)

			//Frostmourne
		elseif itemId == 'I04P' then
			call AddUnitAbsoluteBonusCount(u,Element_Cold, diff)
			call AddUnitAbsoluteBonusCount(u,Element_Dark, diff)

			//Good Luck Charm
		elseif itemId == 'I083' then
			call AddUnitCustomState(u, BONUS_LUCK, 0.15 * diff)
		 
			//Shining Runestone
		elseif itemId == SHINING_RUNESTONE_ITEM_ID then
			call AddUnitCustomState(u, BONUS_RUNEPOW, 50 * diff)
		 
			//runestone of Creation
		elseif itemId == RUNESTONE_OF_CREATION_ITEM_ID then
			call AddUnitCustomState(u, BONUS_RUNEPOW, 75 * uniqueDiff)

			//Guide to Rune Master
		elseif itemId == 'I0BZ' then
			call AddUnitCustomState(u, BONUS_RUNEPOW, 50 * diff)

			//Conqueror's Bamboo Stick
		elseif itemId == 'I0C2' then
			call AddUnitCustomState(u, BONUS_EVASION, 20 * uniqueDiff)
			call AddUnitCustomState(u, BONUS_MAGICRES, 30 * uniqueDiff)
			call AddUnitBonus(u, BONUS_ARMOR, 100 * uniqueDiff)
			call AddUnitBonus(u, BONUS_HEALTH, 10000 * uniqueDiff)

			//Runestones
		elseif itemId == FIRE_RUNESTONE_ITEM_ID or itemId == POISON_RUNESTONE_ITEM_ID or itemId == ARCANE_RUNESTONE_ITEM_ID or itemId == WILD_RUNESTONE_ITEM_ID or itemId == LIGHT_RUNESTONE_ITEM_ID or itemId == DARK_RUNESTONE_ITEM_ID or itemId == WIND_RUNESTONE_ITEM_ID or itemId == EARTH_RUNESTONE_ITEM_ID or itemId == WATER_RUNESTONE_ITEM_ID or itemId == 'I0BX' then
			call AddUnitCustomState(u, BONUS_RUNEPOW, 100 * uniqueDiff)
			
			if itemId == FIRE_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Fire, uniqueDiff)
			elseif itemId == POISON_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Poison, uniqueDiff)
			elseif itemId == ARCANE_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Arcane, uniqueDiff)
			elseif itemId == WILD_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Wild, uniqueDiff)
			elseif itemId == LIGHT_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Light, uniqueDiff)
			elseif itemId == DARK_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Dark, uniqueDiff)
			elseif itemId == WIND_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Wind, uniqueDiff)
			elseif itemId == WATER_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Water, uniqueDiff)
			elseif itemId == EARTH_RUNESTONE_ITEM_ID then
				call AddUnitAbsoluteBonusCount(u,Element_Earth, uniqueDiff)
			endif
		
			//Blaze Staff
		elseif itemId == 'I08X' then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 15 * uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Fire, uniqueDiff)
		
			//Fan
		elseif itemId == 'I08Z' then
			call AddUnitCustomState(u, BONUS_EVASION, 15 * uniqueDiff)

			//Stone Helmet
		elseif itemId == 'I090' then
			call AddUnitCustomState(u, BONUS_BLOCK, 1000 * uniqueDiff)
			call AddUnitAbsoluteBonusCount(u,Element_Earth, uniqueDiff)
		
			//Mithril Helmet
		elseif itemId == 'I091' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 50 * uniqueDiff)
		
			//anti-magic Cape
		elseif itemId == 'I092' then
			call AddUnitCustomState(u, BONUS_MAGICPOW,0 - 25 * uniqueDiff)
			call AddUnitCustomState(u, BONUS_MAGICRES,200 * uniqueDiff)

			//Hero's hammer
		elseif itemId == 'I064' then
			call AddUnitCustomState(u, BONUS_PHYSPOW, 60 * uniqueDiff)
			call SetHeroStat(u, GetHeroPrimaryStat(u), GetHeroStatBJ(GetHeroPrimaryStat(u), u, false) + 400 * uniqueDiff)
		
			//Heart of Darkness
		elseif itemId == 'I04V' then
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * diff)

		//Hammer of the Gods
		elseif itemId == 'I066' then
			call AddUnitBonus(u, BONUS_DAMAGE, 10000 * diff)

		//Hammer of Chaos
		elseif itemId == 'I06H' then
			//call AddUnitBonus(u, BONUS_DAMAGE, -300 * diff)

		//Titanium Armor
		elseif itemId == 'I07M' then
			call AddUnitBonus(u, BONUS_DAMAGE, -500 * diff)

		//Titanium Spike
		elseif itemId == TITANIUM_SPIKE_ITEM_ID then
			call BlzSetUnitBaseDamage(u, BlzGetUnitBaseDamage(u, 0) + (1000 * diff), 0)

		//Heavy Mace
		elseif itemId == 'I07I' then
			call AddUnitBonus(u, BONUS_DAMAGE, 350 * diff)

		//Speed Blade
		elseif itemId == 'I06B' then
			call AddUnitBonus(u, BONUS_DAMAGE, 750 * diff)

		//Bloody Axe
		elseif itemId == 'I078' then
			call AddUnitBonus(u, BONUS_DAMAGE, 100 * diff)

		//Battle Axe
		elseif itemId == 'I075' then
			call AddUnitBonus(u, BONUS_DAMAGE, 30 * diff)

		//Reaver's Axe
		elseif itemId == 'I04A' then
			call AddUnitBonus(u, BONUS_DAMAGE, 150 * diff)

			//Aduxxors Blade
		elseif itemId == 'I015' then
			call AddUnitBonus(u, BONUS_DAMAGE, 34 * diff)

			//Soul Reaper
		elseif itemId == 'I01C' then
			call AddUnitBonus(u, BONUS_DAMAGE, 80 * diff)

			//Null Void Orb
		elseif itemId == 'I0AL' then
			call AddUnitCustomState(u, BONUS_MAGICRES, 40 * diff)

		//Rapier of the Gods
		elseif itemId == 'I01E' then
			call AddUnitBonus(u, BONUS_DAMAGE, 120 * diff)

		//Scorched Scimitar
		elseif itemId == SCORCHED_SCIMITAR_ITEM_ID then
			call AddUnitCustomState(u, BONUS_MAGICPOW, 20 * diff)
			call AddUnitCustomState(u, BONUS_PHYSPOW, 20 * diff)
		
			//Druidic Focus
		elseif itemId == DRUIDIC_FOCUS_ITEM_ID then
			if itemCount <= 0 then
				call UnitRemoveAbility(u, DRUIDIC_FOCUS_ABILITY_ID)
			elseif GetUnitAbilityLevel(u, DRUIDIC_FOCUS_ABILITY_ID) == 0 then
				call UnitAddAbility(u, DRUIDIC_FOCUS_ABILITY_ID)
			endif
		endif 

		call SecretCheck_CheckAbilitiesAndItems(u)
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

		set UniqueItemCount = Table.create()
	endfunction
endlibrary