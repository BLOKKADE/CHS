library IconFrames initializer init requires TooltipFrame, AchievementsFrame, CustomState, GetObjectElement, ElementColorCode, HeroLvlTable, UnitInfoPanel, RuneInit, HeroPassiveDesc, PlayerTracking, SellItems, ReadyButton
	
	globals
		// Sparkly thing that goes around an icon
		private string IndicatorPathPick = "UI\\Feedback\\Autocast\\UI-ModalButtonOn.mdl"

		private constant real SMALL_BUTTON_WIDTH = 0.025
		private constant real BIG_BUTTON_WIDTH = 0.036

		// Main GameUI that all frames should use
		framehandle GameUI

		framehandle MainAchievementFrameHandle // Hat/Pet main frame
		framehandle MainVotingFrameHandle // Voting main frame
		framehandle ScoreboardFrameHandle // Scoreboard main frame
		framehandle RewardsFrameHandle // Rewards main frame

		// All icon events happen in a single trigger
		private trigger ButtonTrigger = null

		// Parent frame and frame for each icon
		framehandle array ButtonId 
		framehandle array ButtonParentId 

		// Button indicator frames
		framehandle array ButtonIndicatorId 
		framehandle array ButtonIndicatorParentId 

		boolean array ShowCreepAbilButton

		// Save the icon number with the parent event
		hashtable ButtonParentHandles = InitHashtable()
	endglobals

	function GetHeroTooltip takes unit SpellU returns string
		local player owningPlayer = GetOwningPlayer(SpellU)
		local string temp = GetObjectElementsAsString(SpellU, GetUnitTypeId(SpellU), false)
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

		set ToolTipS = ToolTipS + "|n|cfffaf61cGold|r: " + I2S(GetPlayerState(owningPlayer, PLAYER_STATE_RESOURCE_GOLD))
		set ToolTipS = ToolTipS + "|n|cff41e400Lumber|r: " + I2S(GetPlayerState(owningPlayer, PLAYER_STATE_RESOURCE_LUMBER))
		set ToolTipS = ToolTipS + "|n|cff8bfdfdGlory|r: " + I2S(R2I(Glory[GetPlayerId(owningPlayer)]))

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
				set ToolTipS = ToolTipS + GetFullElementText(i1) + " : " + I2S(i2) + "|n"
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

		set temp = GetObjectElementsAsString(SpellU, i3, true)
		if temp != "" and temp != null then
			set ToolTipS = ToolTipS + temp + "|n"
		endif
		set ToolTipS = ToolTipS + BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU, i3) - 1)

		// Hero absolutes
		if spellLocation > 10 and spellLocation <= 20 then
			set i1 = GetAbsoluteElement(i3)
			set i2 = GetUnitElementCount(SpellU, i1)
			set ToolTipS = ToolTipS + "|n|n|cffd0ff00Current|r " + GetFullElementText(i1) + " |cffd0ff00count|r: " + I2S(i2)
		endif

		return ToolTipS  
	endfunction

	private function SkillSysStart takes nothing returns nothing
		local integer NumButton = LoadInteger(ButtonParentHandles, GetHandleId(BlzGetTriggerFrame()), 1)
		local player p = GetTriggerPlayer()
		local integer PlID = GetPlayerId(p)
		local string ToolTipS = ""
		local string temp = ""
		local boolean TypT = false
		local integer i1
		local integer i2
		local integer i3
		local unit SpellU
		local integer selectedUnitPid = SelectedUnitPid[PlID]
		local PlayerStats ps

		if BlzGetTriggerFrameEvent() ==  FRAMEEVENT_CONTROL_CLICK then
			
			if p == GetLocalPlayer() then
				call BlzFrameSetEnable(BlzGetTriggerFrame(), false)
				call BlzFrameSetEnable(BlzGetTriggerFrame(), true)
			endif

			// Sell all items
			if NumButton == 3 then
				set SpellU = PlayerHeroes[PlID]

				call SellItemsFromHero(SpellU)
				call ResourseRefresh(p) 
			
			// Scoreboard button
			elseif NumButton == 4 then
				set ps = PlayerStats.forPlayer(p)
				set TypT = ps.toggleHasScoreboardOpen()

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(ScoreboardFrameHandle, TypT)
				endif
			
			// Rewards button
			elseif NumButton == 6 then
				set ps = PlayerStats.forPlayer(p)
				set TypT = ps.toggleHasRewardsOpen()

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(RewardsFrameHandle, TypT)
				endif

			// Ready button
			elseif NumButton == 5 then
				call PlayerReadies(p)

			// Convert to gold
			elseif NumButton == 36 then
				set i1 = GetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER)

				call SetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER,0)
				call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD)  + i1 * 30)
				call ResourseRefresh(p) 
			
			// Convert to lumber
			elseif NumButton == 37 then
				set i1 = GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD)/ 30

				call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) - i1 * 30 )
				call SetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(p,PLAYER_STATE_RESOURCE_LUMBER) + i1)
				call ResourseRefresh(p) 

			// Show hats menu
			elseif NumButton == 39 then
				set ps = PlayerStats.forPlayer(p)
				set TypT = ps.toggleHasAchievementsOpen()

				call AchievementsFrame_UpdateAchievementFrameIcons(p)

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(MainAchievementFrameHandle, TypT)
				endif
			endif

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_UP then

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
			if selectedUnitPid == 27 then
				set selectedUnitPid = PlID
			endif

			// Creep information
			if NumButton == 2 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cfffce177Next level|r: " + RoundCreepTitle)
					set temp = RoundCreepInfo[PlID] + "|n|n|cfffce177Abilities|r: " + RoundAbilities
					call BlzFrameSetText(TooltipTextFrame, temp)
					call BlzFrameSetSize(TooltipFrame, 0.29, 0.12 + GetTooltipSize(RoundAbilities))
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Sell all items
			elseif NumButton == 3 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, SellAllItemsTooltip())
					call BlzFrameSetSize(TooltipFrame, 0.31, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// View scoreboard
			elseif NumButton == 4 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "Toggle the Scoreboard (|cff77f3fcTab|r)")
					call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// View rewards
			elseif NumButton == 6 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "View rewards (|cff77f3fcCtrl+T|r)")
					call BlzFrameSetSize(TooltipFrame, 0.20, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Ready button
			elseif NumButton == 5 then
				set ToolTipS = ReadyButtonTooltip(p, PlID)
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, ToolTipS)
					call BlzFrameSetSize(TooltipFrame, 0.31, GetTooltipSize(ToolTipS))
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Gold conversion
			elseif NumButton == 36 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, GoldConversionTooltip())
					call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Lumber conversion
			elseif NumButton == 37 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, LumberConversionTooltip())
					call BlzFrameSetSize(TooltipFrame, 0.29, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Element count
			elseif NumButton == 38 then
				set SpellU = PlayerHeroes[selectedUnitPid]
				set ToolTipS = GetElementCountTooltip(SpellU)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Element Counts|r")
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetSize(TooltipFrame, 0.125, GetTooltipSize(ToolTipS))
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Player stats
			elseif NumButton == 39 then
				set SpellU = PlayerHeroes[selectedUnitPid]
				set ToolTipS = PlayerStats.getTooltip(GetOwningPlayer(SpellU))
				set ToolTipS = ToolTipS + "|n|n|cffff0000Clicking this toggles the rewards menu!|r"

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Stats for: |r" + GetPlayerNameColour(GetOwningPlayer(SpellU)))
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetSize(TooltipFrame, 0.23, GetTooltipSize(ToolTipS))
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Hero information
			elseif NumButton == 100 then
				set SpellU = PlayerHeroes[selectedUnitPid]
				set ToolTipS = GetHeroTooltip(SpellU)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, GetPlayerNameColour(GetOwningPlayer(SpellU)) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(SpellU)))
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Hero abilities and absolutes
			elseif NumButton > 100 and NumButton <= 120 then
				// Ability
				if SelectedUnitPid[PlID] != 11 then
					set SpellU = PlayerHeroes[selectedUnitPid]
					set i3 = GetHeroSpellAtPosition(SpellU, NumButton - 100) 
					set ToolTipS = GetAbilityElementCountTooltip(SpellU, NumButton - 100)

					if GetLocalPlayer() == p then	
						call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3) - 1))
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif 
					
				// Absolute
				else
					set SpellU = SelectedUnit[PlID]
					set i3 = roundAbilities.integer[NumButton - 100]
					set ToolTipS = BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1)

					if GetLocalPlayer() == p then	
						call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3) - 1))
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(TooltipFrame, 0.29, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(TooltipFrame, true)
					endif       
				endif
			endif

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
			if GetLocalPlayer() == p then	
				call BlzFrameSetText(TooltipTextFrame, ToolTipS)
				call BlzFrameSetVisible(TooltipFrame, false)
			endif
		endif

		// Cleanup
		set SpellU = null
		set p = null
	endfunction

		private function CreateIconWorld takes integer buttonIndex, string iconPath, real x, real y, real size returns nothing
		local framehandle buttonParentFrame = BlzCreateFrame("ScoreScreenBottomButtonTemplate", GameUI, 0, 0)
		local framehandle buttonFrame = BlzCreateFrame("BNetPopupMenuBackdropTemplate", buttonParentFrame, 0, 0)

		// Parent frame
		call BlzFrameSetSize(buttonParentFrame, size, size)
		call BlzFrameSetPoint(buttonParentFrame, FRAMEPOINT_TOPLEFT, GameUI, FRAMEPOINT_TOPLEFT, x, y)
		call BlzFrameSetVisible(buttonParentFrame, false)
		
		// Child frame
		call BlzFrameSetSize(buttonFrame, size, size)
		call BlzFrameSetTexture(buttonFrame, iconPath, 0, true)
		call BlzFrameSetPoint(buttonFrame, FRAMEPOINT_CENTER, buttonParentFrame, FRAMEPOINT_CENTER, 0, 0)

		// Save frames for future reference
		set ButtonId[buttonIndex] = buttonFrame
		set ButtonParentId[buttonIndex] = buttonParentFrame

		call SaveInteger(ButtonParentHandles, GetHandleId(buttonParentFrame), 1, buttonIndex)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonParentFrame, FRAMEEVENT_CONTROL_CLICK)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonParentFrame, FRAMEEVENT_MOUSE_UP)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonParentFrame, FRAMEEVENT_MOUSE_ENTER)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonParentFrame, FRAMEEVENT_MOUSE_LEAVE)

		// Cleanup
		set buttonFrame = null
		set buttonParentFrame = null
	endfunction

	private function CreateIndicatorForButton takes integer buttonIndex returns nothing
		local framehandle buttonIndicatorParentFrame = BlzCreateFrameByType("BUTTON", "AwardIndicatorParent", ButtonParentId[buttonIndex], "", 0)
		local framehandle buttonIndicatorFrame = BlzCreateFrameByType("SPRITE", "AwardIndicator", buttonIndicatorParentFrame, "", 0)

		// Make sure the indicator is on top of everything
		call BlzFrameSetLevel(buttonIndicatorParentFrame, 2)
		call BlzFrameSetVisible(buttonIndicatorParentFrame, false)

		// Create the indicator, offset it around the button
		call BlzFrameSetModel(buttonIndicatorFrame, IndicatorPathPick, 0)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_TOPLEFT, ButtonParentId[buttonIndex], FRAMEPOINT_TOPLEFT, -0.001, 0.001)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_BOTTOMRIGHT, ButtonParentId[buttonIndex], FRAMEPOINT_BOTTOMRIGHT, -0.0012, -0.0016)

		// Save frames for future reference
		set ButtonIndicatorId[buttonIndex] = buttonIndicatorFrame
		set ButtonIndicatorParentId[buttonIndex] = buttonIndicatorParentFrame

		// Cleanup
		set buttonIndicatorFrame = null
		set buttonIndicatorParentFrame = null
	endfunction

	private function IconFramesActions takes nothing returns nothing
		call BlzChangeMinimapTerrainTex("minimap.blp")
		call InitGameUI()

		set GameUI = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)

		set ButtonTrigger = CreateTrigger()
		call TriggerAddAction(ButtonTrigger, function SkillSysStart)

		// -- Big buttons - Bottom left
		// Scoreboard
		call CreateIconWorld(4, "ReplaceableTextures\\CommandButtons\\BTNNotepad.blp", 0.00, -0.39, BIG_BUTTON_WIDTH)

		// Ready
		call CreateIconWorld(5, "ReplaceableTextures\\CommandButtons\\BTNAbility_parry.blp", 0.04, -0.39, BIG_BUTTON_WIDTH)
		call CreateIndicatorForButton(5)

		// Rewards
		call CreateIconWorld(6, "ReplaceableTextures\\CommandButtons\\BTNQuestbook.blp", 0.08, -0.39, BIG_BUTTON_WIDTH)
		call CreateIndicatorForButton(6)

		// Creep info - Create at same place as the Rewards button above. This button will move over after round 5
		call CreateIconWorld(2, "ReplaceableTextures\\CommandButtons\\BTNSpell_Holy_SealOfWrath.blp", 0.08, -0.39, BIG_BUTTON_WIDTH)
		// -- Big buttons

		// -- Currency buttons - Top middle rightish
		// Convert lumber to gold
		call CreateIconWorld(36, "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp", 0.43 + SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)

		// Convert gold to lumber
		call CreateIconWorld(37, "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp", 0.43 + (2 * SMALL_BUTTON_WIDTH), -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)

		// Sell all items - Have a gap between the gold to lumber button
		call CreateIconWorld(3, "ReplaceableTextures\\CommandButtons\\BTNIncreaseIncome2.blp", 0.43 + (4 * SMALL_BUTTON_WIDTH), -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		// -- Currency buttons

		// -- Top left buttons
		// Player element count
		call CreateIconWorld(38, "ReplaceableTextures\\PassiveButtons\\PASElements.blp", 0.04, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)

		// Player stats
		call CreateIconWorld(39, "ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp", 0.018, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)

		// Abilities/absolutes
		call CreateIconWorld(100, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(101, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(102, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 2 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(103, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 3 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(104, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 4 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(105, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 5 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(106, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 6 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(107, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 7 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(108, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 8 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(109, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 9 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(110, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 10 * SMALL_BUTTON_WIDTH, -SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(111, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(112, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 2 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(113, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 3 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(114, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 4 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(115, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 5 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(116, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 6 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(117, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 7 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(118, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 8 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(119, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 9 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(120, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", 0.04 + 10 * SMALL_BUTTON_WIDTH, -2 * SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		// -- Top left buttons
	endfunction

	private function init takes nothing returns nothing
		local trigger iconFramesTrigger = CreateTrigger()
		call TriggerRegisterTimerEventSingle(iconFramesTrigger, 1.00)
		call TriggerAddAction(iconFramesTrigger, function IconFramesActions)
		set iconFramesTrigger = null
	endfunction

endlibrary