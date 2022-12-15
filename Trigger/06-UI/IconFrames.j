library IconFrames initializer init requires TooltipFrame, AchievementsFrame, CustomState, GetObjectElement, ElementColorCode, HeroLvlTable, UnitInfoPanel, RuneInit, HeroPassiveDesc, PlayerTracking, SellItems
	globals
		// Hat/Pet main frame
		framehandle MainAchievementFrameHandle 

		// Voting main frame
		framehandle MainVotingFrameHandle 

		// Scoreboard main frame
		framehandle ScoreboardFrameHandle 

		framehandle GameUI

		trigger ButtonTrigger = null

		boolean array ShowCreepAbilButton

		framehandle array ButtonId 
		framehandle array ButtonParentId 

		hashtable ButtonParentHandles = InitHashtable()
	endglobals

	function GetHeroTooltip takes unit SpellU returns string
		local player owningPlayer = GetOwningPlayer(SpellU)
		local string temp = GetObjectelementsAsString(SpellU, GetUnitTypeId(SpellU), false)
		local string ToolTipS = ""

		if temp != "" and temp != null then
			set ToolTipS = ToolTipS + temp + "|n"
		endif

		set temp = GetHeroPassiveDescription(GetUnitTypeId(SpellU), HeroPassive_Desc)
		if temp != "" and temp != null then
			set ToolTipS = ToolTipS + temp + "|n"
		endif

		set temp = GetHeroPassiveDescription(GetUnitTypeId(SpellU), HeroPassive_Lvlup)
		if temp != "" and temp != null then
			set ToolTipS = ToolTipS + temp
		endif

		set ToolTipS = ToolTipS + GetPassiveStr(SpellU)

		if EconomyMode or IncomeMode != 2 then
			set ToolTipS = ToolTipS + "|n|n|cffd4954dIncome|r: " + I2S(Income[GetPlayerId(owningPlayer)])
		endif

		//if p != GetOwningPlayer(SpellU) then
			set ToolTipS = ToolTipS + "|n|cfffaf61cGold|r: " + I2S(GetPlayerState(owningPlayer, PLAYER_STATE_RESOURCE_GOLD))
			set ToolTipS = ToolTipS + "|n|cff41e400Lumber|r: " + I2S(GetPlayerState(owningPlayer, PLAYER_STATE_RESOURCE_LUMBER))
			set ToolTipS = ToolTipS + "|n|cff8bfdfdGlory|r: " + I2S(R2I(Glory[GetPlayerId(owningPlayer)]))
		//endif

		// Cleanup
		set owningPlayer = null

		return ToolTipS
	endfunction
	
	function GetElementCountTooltip takes unit SpellU returns string
		local integer i1 = 1
		local integer i2 = 1
		local string ToolTipS = ""

		loop
			set i2 = GetUnitElementCount(SpellU, i1)

			// Don't include empty elements in the list
			if i2 > 0 then
				set ToolTipS = ToolTipS + ClassAbil[i1] + " : " + I2S(i2) + "|n"
			endif

			set i1 = i1 + 1
			exitwhen i1 > 13 // Based off the amount of elements in ClassAbil array. 2-InitDescription.j
		endloop

		return ToolTipS
	endfunction

	function GetAbilityElementCountTooltip takes unit SpellU, integer spellLocation returns string
		local integer i1 = 1
		local integer i2 = 1
		local integer i3 = GetHeroSpellAtPosition(SpellU, spellLocation) 
		local string ToolTipS = ""
		local string temp

		set temp = GetObjectelementsAsString(SpellU, i3, true)
		if temp != "" and temp != null then
			set ToolTipS = ToolTipS + temp + "|n"
		endif
		set ToolTipS = ToolTipS + BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU, i3) - 1)

		// Hero absolutes
		if spellLocation > 11 and spellLocation <= 20 then
			set i1 = GetAbsoluteElement(i3)
			set i2 = GetUnitElementCount(SpellU, i1)
			set ToolTipS = ToolTipS + "|n|n|cffd0ff00Current|r " + ClassAbil[i1] + " |cffd0ff00count|r: " + I2S(i2)
		endif

		return ToolTipS  
	endfunction

	function SkillSysStart takes nothing returns nothing
		local integer NumButton = LoadInteger(ButtonParentHandles ,GetHandleId(BlzGetTriggerFrame()),1)
		local integer i_ck = 1
		local player p = GetTriggerPlayer()
		local integer PlID = GetPlayerId(p)
		local integer SpellId_1 = 0
		local integer AbilLevel = 0
		local integer ULT_ID = 0
		local string ToolTipS = ""
		local string temp = ""
		local boolean TypT = false
		local boolean en_d = true
		local integer i1
		local integer i2
		local integer i3
		local unit SpellU
		local PlayerStats ps

		if BlzGetTriggerFrameEvent() ==  FRAMEEVENT_CONTROL_CLICK then
			
			if p == GetLocalPlayer() then
				call BlzFrameSetEnable(BlzGetTriggerFrame() , false)
				call BlzFrameSetEnable(BlzGetTriggerFrame() , true)
			endif

			//Sell all items
			if NumButton == 3 then
				set SpellU = PlayerHeroes[PlID + 1]

				call SellItemsFromHero(SpellU)
				call ResourseRefresh(p) 
			
			//Convert to gold
			elseif NumButton == 36 then
				set i1 = GetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER)

				call SetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER,0)
				call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD)  + i1 * 30)
				call ResourseRefresh(p) 
			
			//Convert to lumber
			elseif NumButton == 37 then
				set i1 = GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD)/ 30

				call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD)- i1 * 30  )
				call SetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER) + i1)
				call ResourseRefresh(p) 

			//Show hats menu
			elseif NumButton == 39 then
				set ps = PlayerStats.forPlayer(p)
				set TypT = ps.toggleHasAchievementsOpen()

				call AchievementsFrame_UpdateAchievementFrameIcons(p)

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(MainAchievementFrameHandle, TypT)
				endif
			endif

		elseif BlzGetTriggerFrameEvent()  ==FRAMEEVENT_MOUSE_UP then

		elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_ENTER then
				if NumButton == 2 then
					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, "|cfffce177Next level|r: " + RoundCreepTitle)
						set temp = RoundCreepInfo[PlID] + "|n|n|cfffce177Abilities|r: " + RoundAbilities
						call BlzFrameSetText(TooltipTextFrame, temp)
						call BlzFrameSetSize(TooltipFrame, 0.29, 0.12 + GetTooltipSize(RoundAbilities))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
				elseif NumButton == 3 then
					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, SellAllItemsTooltip())
						call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
					//Hero passive
				elseif NumButton == 36 then
					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, GoldConversionTooltip())
						call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
				elseif NumButton == 37 then
					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, LumberConversionTooltip())
						call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
				elseif NumButton == 38 then
					set SpellU = PlayerHeroes[SelectedUnitPid[PlID] + 1]
					set ToolTipS = GetElementCountTooltip(SpellU)

					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Element Counts|r")
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(TooltipFrame, 0.125, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
				elseif NumButton == 39 then
					set SpellU = PlayerHeroes[SelectedUnitPid[PlID] + 1]
					set ToolTipS = PlayerStats.getTooltip(GetOwningPlayer(SpellU))
					set ToolTipS = ToolTipS + "|n|n|cffff0000Clicking this toggles the rewards menu!|r"

					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Stats for: |r" + GetPlayerNameColour(GetOwningPlayer(SpellU)))
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(TooltipFrame, 0.23, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif
				elseif NumButton == 100 then
					set SpellU = PlayerHeroes[SelectedUnitPid[PlID] + 1]
					set ToolTipS = GetHeroTooltip(SpellU)

					if GetLocalPlayer() == p then
						call BlzFrameSetText(TooltipTitleFrame, GetPlayerNameColour(GetOwningPlayer(SpellU)) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(SpellU)))
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif

					//Hero abilities and absolutes
				elseif NumButton > 100 and NumButton <= 120 then
					if SelectedUnitPid[PlID] != 11 then
						set SpellU = PlayerHeroes[SelectedUnitPid[PlID] + 1]
						set i3 = GetHeroSpellAtPosition(SpellU, NumButton - 100) 
						set ToolTipS = GetAbilityElementCountTooltip(SpellU, NumButton - 100)

						if GetLocalPlayer() == p then	
							call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3) - 1))
							call BlzFrameSetText(TooltipTextFrame, ToolTipS)
							call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
							call BlzFrameSetVisible(TooltipFrame, true)
						endif       
					else
						set SpellU = SelectedUnit[PlID]
						set i3 = roundAbilities.integer[NumButton - 100]
						set ToolTipS = BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1 )

						if GetLocalPlayer() == p then	
							call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3) - 1))
							call BlzFrameSetText(TooltipTextFrame, ToolTipS)
							call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
							call BlzFrameSetVisible(TooltipFrame, true)
						endif       
					endif
				endif
			elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_LEAVE then

				if GetLocalPlayer() == p then	
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetVisible(TooltipFrame, false)
				endif
			endif

			set SpellU = null
			set p = null
		endfunction

		function CreateIconWorld takes integer NumAb, string Icon, real x,real y,real size returns nothing
			local framehandle buttonFrame
			local framehandle buttonParentFrame = BlzCreateFrame("ScoreScreenBottomButtonTemplate", GameUI , 0, 0)

			call BlzFrameSetSize(buttonParentFrame, size , size )
			call BlzFrameSetPoint(buttonParentFrame, FRAMEPOINT_TOPLEFT, GameUI, FRAMEPOINT_TOPLEFT , x, y)
			set buttonFrame = BlzCreateFrame("BNetPopupMenuBackdropTemplate", buttonParentFrame, 0, 0)
			call BlzFrameSetSize(buttonFrame , size , size )
			call BlzFrameSetTexture(buttonFrame , Icon , 1, true)
			call BlzFrameSetPoint(buttonFrame , FRAMEPOINT_CENTER, buttonParentFrame, FRAMEPOINT_CENTER, 0, 0)
			call BlzFrameSetVisible(buttonParentFrame ,false )

			set ButtonId[NumAb] = buttonFrame
			set ButtonParentId[NumAb] = buttonParentFrame

			call SaveInteger(ButtonParentHandles,GetHandleId(buttonParentFrame ),1, NumAb)
			call BlzTriggerRegisterFrameEvent(ButtonTrigger , buttonParentFrame , FRAMEEVENT_CONTROL_CLICK)
			call BlzTriggerRegisterFrameEvent(ButtonTrigger , buttonParentFrame , FRAMEEVENT_MOUSE_UP)
			call BlzTriggerRegisterFrameEvent(ButtonTrigger , buttonParentFrame , FRAMEEVENT_MOUSE_ENTER)
			call BlzTriggerRegisterFrameEvent(ButtonTrigger , buttonParentFrame , FRAMEEVENT_MOUSE_LEAVE)

			set buttonFrame = null
			set buttonParentFrame = null
		endfunction

		function Trig_ABIL_TAKE_Actions takes nothing returns nothing
			local integer I_i = 1
			local integer X___1 = 0
			local integer Y___1 = 0
			local real sizeAbil = 0.022
			call BlzChangeMinimapTerrainTex("minimap.blp")
			call InitGameUI()
			set GameUI = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
			set ButtonTrigger = CreateTrigger()
			call TriggerAddAction(ButtonTrigger, function SkillSysStart)
			call CreateIconWorld(2 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - 0.39 , 0.036)
			call BlzFrameSetTexture(ButtonId[2] , "ReplaceableTextures\\CommandButtons\\BTNSpell_Holy_SealOfWrath.blp" , 0, true)
			call CreateIconWorld(3 , "ReplaceableTextures\\CommandButtons\\BTNIncreaseIncome2.blp" , 0.08 , - 0.4 , 0.025)
			call BlzFrameSetVisible(ButtonParentId[3], false)
			call CreateIconWorld(36 , "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" , 0.43 + 0.025 , - 0.024 , 0.025)
			call BlzFrameSetVisible(ButtonParentId[36], true)
			call CreateIconWorld(37 , "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" , 0.43 + 0.05 , - 0.024 , 0.025)
			call BlzFrameSetVisible(ButtonParentId[37], true)
			call CreateIconWorld(38 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - 2 * sizeAbil , sizeAbil)
			call BlzFrameSetTexture(ButtonId[38] , "ReplaceableTextures\\PassiveButtons\\PASElements.blp" , 0, true)
			call CreateIconWorld(39 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.018 , - sizeAbil , sizeAbil)
			call BlzFrameSetTexture(ButtonId[39] , "ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp" , 0, true)
			call CreateIconWorld(100 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - sizeAbil , sizeAbil)
			call CreateIconWorld(101 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(102 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(103 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(104 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(105 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(106 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 6 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(107 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7 * sizeAbil , - sizeAbil, sizeAbil)
			call CreateIconWorld(108 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(109 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(110 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(111 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(112 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(113 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(114 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(115 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(116 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 6 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(117 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(118 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(119 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(120 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10 * sizeAbil , - 2 * sizeAbil , sizeAbil)
		endfunction

		//===========================================================================
		private function init takes nothing returns nothing
			local trigger trg = CreateTrigger()
			call TriggerRegisterTimerEventSingle( trg, 1.00 )
			call TriggerAddAction( trg, function Trig_ABIL_TAKE_Actions )
			set trg = null
		endfunction
	endlibrary