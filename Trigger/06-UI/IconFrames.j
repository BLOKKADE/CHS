library IconFrames initializer init requires TooltipFrame, AchievementsFrame, CustomState, GetObjectElement, ElementColorCode, HeroLvlTable, UnitInfoPanel, RuneInit, HeroPassiveDesc, PlayerTracking, SellItems, ReadyButton
	
	globals
		// Sparkly thing that goes around an icon
		private string IndicatorPathPick = "UI\\Feedback\\Autocast\\UI-ModalButtonOn.mdl"

		// Button sizes
		private constant real SMALL_BUTTON_WIDTH = 0.025
		private constant real BIG_BUTTON_WIDTH = 0.036
		private constant real BIG_BUTTON_TOTAL_WIDTH = 0.04

		// Starting x positions
		private constant real TOP_RIGHT_ICON_ROW_X = 0.455
		private constant real TOP_LEFT_ICON_ROW_X = 0
		private constant real BOTTOM_LEFT_ICON_ROW_X = 0

		// Starting y positions
		private constant real BOTTOM_ICON_ROW_Y = 0.205
		private constant real TOP_ICON_ROW_Y = 0.575

		// All icon events happen in a single trigger
		private trigger ButtonTrigger = null

		// Save the icon number with the parent event
		private hashtable ButtonParentHandles = InitHashtable()

		// Button indicator frames
		framehandle array ButtonIndicatorId 
		framehandle array ButtonIndicatorParentId 

		// Main GameUI that all frames should use
		framehandle GameUI

		framehandle MainAchievementFrameHandle // Hat/Pet main frame
		framehandle MainVotingFrameHandle // Voting main frame
		framehandle ScoreboardFrameHandle // Scoreboard main frame
		framehandle RewardsFrameHandle // Rewards main frame
        framehandle BattleCreatorFrameHandle // Battle creator main frame

		// Parent frame and frame for each icon
		framehandle array ButtonId 
		framehandle array ButtonParentId 

		boolean array ShowCreepAbilButton
	endglobals
	
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
		local string ToolTipTitle = ""
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
				set ToolTipTitle = ReadyButtonTooltipTitle(p)
				set ToolTipS = ReadyButtonTooltip(p, PlID)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, ToolTipTitle)
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetSize(TooltipFrame, 0.31, GetTooltipSize(ToolTipS))
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

			// Player ready status
			elseif NumButton == 40 then
				set ToolTipTitle = ReadyButtonTooltipTitle(p)
				set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

				if (ps.isReady()) then
					set ToolTipTitle = "|cff00ff08Player is ready|r"
				else
					set ToolTipTitle = "|cffff0000Player is not ready|r"
				endif
	
				if (PlayerIsAlwaysReady[selectedUnitPid]) then
					set ToolTipTitle = "|cffffdd00Player is always ready|r"
				endif

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, ToolTipTitle)
					call BlzFrameSetSize(TooltipFrame, 0.19, 0.02)
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
	
	private function UpdateRoundStartGlobalIcons takes EventInfo eventInfo returns nothing
		local integer pid = GetPlayerId(eventInfo.p)

        // Show scoreboard button
        call BlzFrameSetVisible(ButtonParentId[4], RoundNumber > 0 and ScoreboardFrameHandle != null)
		
        // Show specific button
        if (ShopsCreated == false or BrStarted) then
            call BlzFrameSetVisible(ButtonParentId[3], false) // Sell all items
            call BlzFrameSetVisible(ButtonParentId[5], false) // Ready button
            call BlzFrameSetVisible(ButtonParentId[2], false) // Creep info
        else
            call BlzFrameSetVisible(ButtonParentId[3], true) // Sell all items
            call BlzFrameSetVisible(ButtonParentId[5], true) // Ready button

			if (GetLocalPlayer() == eventInfo.p) then
				call BlzFrameSetVisible(ButtonParentId[2], ShowCreepAbilButton[pid]) // Creep info
			endif
        endif
	endfunction

	private function UpdateRoundEndGlobalIcons takes EventInfo eventInfo returns nothing
		local integer pid = GetPlayerId(eventInfo.p)

        // Move the creep info button over after round 5 since we are now showing the rewards button
        if (RoundNumber == 5) then
            call BlzFrameSetPoint(ButtonParentId[2], FRAMEPOINT_TOPLEFT, GameUI, FRAMEPOINT_TOPLEFT, BOTTOM_LEFT_ICON_ROW_X + 3 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y)
        endif

		// Creep info
		if (GetLocalPlayer() == eventInfo.p) then
			call BlzFrameSetVisible(ButtonParentId[2], ShowCreepAbilButton[pid])
		endif
	endfunction

	public function UpdateAbilityIcons takes player p returns nothing
		local integer i = 1
        local integer pid = GetPlayerId(p)
        local integer abilId = 0
        local string abilIcon = ""
        local integer selectedUnitPid = SelectedUnitPid[pid]
        local integer unitTypeId = 0
		local PlayerStats ps

        if selectedUnitPid == 27 then
            set selectedUnitPid = pid
        endif

		set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

		// Player ready status
        if (ps != 0 and ps.isReady()) then
            call BlzFrameSetTexture(ButtonId[40], GetIconPath("Ready"), 0, true)
		else
            call BlzFrameSetTexture(ButtonId[40], GetIconPath("NotReady"), 0, true)
        endif

		// Update the flashy ready status for the player
		call BlzFrameSetVisible(ButtonIndicatorParentId[40], PlayerIsAlwaysReady[selectedUnitPid])

        // Updates the ability icons displayed in top left
        loop
            exitwhen i > 21

            if selectedUnitPid == 11 then
                set abilId = roundAbilities.integer[i]
            else
                set abilId = GetHeroSpellAtPosition(PlayerHeroes[selectedUnitPid], i)
            endif

            if abilId != 0 then
                set abilIcon = BlzGetAbilityIcon(abilId)

				if (GetLocalPlayer() == p) then
					call BlzFrameSetVisible(ButtonParentId[100 + i], true)
					call BlzFrameSetTexture(ButtonId[100 + i], abilIcon, 0, true)
				endif
            else
				if (GetLocalPlayer() == p) then
                	call BlzFrameSetVisible(ButtonParentId[100 + i], false)
				endif
            endif
            set i = i + 1
        endloop

		// Hero info
		set unitTypeId = GetUnitTypeId(PlayerHeroes[selectedUnitPid])

		if unitTypeId != 0 then
			set abilIcon = GetHeroPassiveDescription(unitTypeId, HeroPassive_Icon)

			if (GetLocalPlayer() == p) then
				call BlzFrameSetVisible(ButtonParentId[38], true) // Element count
				call BlzFrameSetVisible(ButtonParentId[39], true) // Win Counts
				call BlzFrameSetVisible(ButtonParentId[40], true) // Player ready status
				call BlzFrameSetVisible(ButtonParentId[100], true) // Hero passive/description
				call BlzFrameSetTexture(ButtonId[100], abilIcon, 0, true) // Hero info
			endif
		else
			if (GetLocalPlayer() == p) then
				call BlzFrameSetVisible(ButtonParentId[38], false) // Element count
				call BlzFrameSetVisible(ButtonParentId[39], false) // Win Counts
				call BlzFrameSetVisible(ButtonParentId[40], false) // Player ready status
				call BlzFrameSetVisible(ButtonParentId[100], false) // Hero passive/description
			endif
		endif
	endfunction

	private function UpdateAbilityIconsEvent takes EventInfo eventInfo returns nothing
        call UpdateAbilityIcons(eventInfo.p)
	endfunction

    private function UpdateFrameVisibility takes nothing returns nothing
        local integer pid = GetPlayerId(GetLocalPlayer())
        local integer selectedUnitPid = SelectedUnitPid[pid]
		local string playerReadyIconPath
		local PlayerStats ps

		if selectedUnitPid == 27 then
            set selectedUnitPid = pid
        endif

		set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

		// Player ready status
        if (ps != 0 and ps.isReady()) then
			set playerReadyIconPath = GetIconPath("Ready")
		else
			set playerReadyIconPath = GetIconPath("NotReady")
        endif

		if (GetLocalPlayer() == Player(pid)) then
			call BlzFrameSetTexture(ButtonId[40], playerReadyIconPath, 0, true)
			call BlzFrameSetVisible(ButtonIndicatorParentId[40], PlayerIsAlwaysReady[selectedUnitPid])
		endif

		// Indicator if the player is auto-ready
		call BlzFrameSetVisible(ButtonIndicatorParentId[5], PlayerIsAlwaysReady[pid])

		// Indicator if the player has points
		call BlzFrameSetVisible(ButtonIndicatorParentId[6], RoundNumber > 5 and PlayerRewardPoints[pid] > 0)

		// Creep info
		call BlzFrameSetVisible(ButtonParentId[2], ShowCreepAbilButton[pid] and ShopsCreated and (not BrStarted))
    endfunction

	private function CreateIconWorld takes integer buttonIndex, string iconPath, real x, real y, real size returns nothing
		local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", GameUI, 0, 0) 
		local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1)

		// Parent frame
		call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, x, y) 
		call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + size, y - size) 
		call BlzFrameSetVisible(buttonFrameHandle, false)

		// Child frame
		call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
		call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 

		// Save frames for future reference
		set ButtonParentId[buttonIndex] = buttonFrameHandle
		set ButtonId[buttonIndex] = buttonBackdropFrameHandle

		call SaveInteger(ButtonParentHandles, GetHandleId(buttonFrameHandle), 1, buttonIndex)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_UP)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
		call BlzTriggerRegisterFrameEvent(ButtonTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

		// Cleanup
		set buttonBackdropFrameHandle = null
		set buttonFrameHandle = null
	endfunction

	private function CreateIndicatorForButton takes integer buttonIndex, real iconWidth returns nothing
		local framehandle buttonIndicatorParentFrame = BlzCreateFrameByType("BUTTON", "AwardIndicatorParent", ButtonParentId[buttonIndex], "", 0)
		local framehandle buttonIndicatorFrame = BlzCreateFrameByType("SPRITE", "AwardIndicator", buttonIndicatorParentFrame, "", 0)

		// Make sure the indicator is on top of everything
		call BlzFrameSetLevel(buttonIndicatorParentFrame, 2)
		call BlzFrameSetVisible(buttonIndicatorParentFrame, false)

		// Create the indicator, offset it around the button
		call BlzFrameSetModel(buttonIndicatorFrame, IndicatorPathPick, 0)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_TOPLEFT, ButtonParentId[buttonIndex], FRAMEPOINT_TOPLEFT, -0.001, 0.001)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_BOTTOMRIGHT, ButtonParentId[buttonIndex], FRAMEPOINT_BOTTOMRIGHT, -0.0012, -0.0016)
		call BlzFrameSetScale(buttonIndicatorFrame, iconWidth / 0.036) // Scale the model to the icon size

		// Save frames for future reference
		set ButtonIndicatorId[buttonIndex] = buttonIndicatorFrame
		set ButtonIndicatorParentId[buttonIndex] = buttonIndicatorParentFrame

		// Cleanup
		set buttonIndicatorFrame = null
		set buttonIndicatorParentFrame = null
	endfunction

	private function IconFramesActions takes nothing returns nothing
		call InitGameUI()

		set GameUI = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)

		set ButtonTrigger = CreateTrigger()
		call TriggerAddAction(ButtonTrigger, function SkillSysStart)

		// -- Big buttons - Bottom left
		// Scoreboard
		call CreateIconWorld(4, "ReplaceableTextures\\CommandButtons\\BTNScoreboard.blp", BOTTOM_LEFT_ICON_ROW_X + 0 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH)

		// Ready
		call CreateIconWorld(5, "ReplaceableTextures\\CommandButtons\\BTNReady.blp", BOTTOM_LEFT_ICON_ROW_X + 1 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH)
		call CreateIndicatorForButton(5, BIG_BUTTON_WIDTH)

		// Rewards
		call CreateIconWorld(6, "ReplaceableTextures\\CommandButtons\\BTNRewards.blp", BOTTOM_LEFT_ICON_ROW_X + 2 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH)
		call CreateIndicatorForButton(6, BIG_BUTTON_WIDTH)

		// Creep info - Create at same place as the Rewards button above. This button will move over after round 5
		call CreateIconWorld(2, "ReplaceableTextures\\CommandButtons\\BTNWaveInfo.blp", BOTTOM_LEFT_ICON_ROW_X + 2 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH)
		// -- Big buttons

		// -- Currency buttons - Top middle rightish
		// Sell all items
		call CreateIconWorld(3, "ReplaceableTextures\\CommandButtons\\BTNIncreaseIncome2.blp", TOP_RIGHT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		// -- Currency buttons

		// -- Top left buttons
		// Player stats
		call CreateIconWorld(39, "ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp", TOP_LEFT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)

		// Player ready status
		call CreateIconWorld(40, "ReplaceableTextures\\CommandButtons\\BTNNotReady.blp", TOP_LEFT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIndicatorForButton(40, SMALL_BUTTON_WIDTH)

		// Player element count
		call CreateIconWorld(38, "ReplaceableTextures\\PassiveButtons\\PASElements.blp", TOP_LEFT_ICON_ROW_X + 1 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)

		// Abilities/absolutes
		call CreateIconWorld(100, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 1 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(101, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 2 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(102, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 3 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(103, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 4 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(104, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 5 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(105, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 6 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(106, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 7 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(107, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 8 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(108, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 9 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(109, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 10 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(110, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 11 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(111, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 2 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(112, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 3 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(113, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 4 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(114, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 5 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(115, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 6 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(116, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 7 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(117, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 8 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(118, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 9 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(119, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 10 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		call CreateIconWorld(120, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 11 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH)
		// -- Top left buttons
	endfunction

	private function init takes nothing returns nothing
		local trigger iconFramesTrigger = CreateTrigger()
		local trigger iconFrameUpdateTrigger = CreateTrigger()

		// Create frames after a delay
		call TriggerRegisterTimerEventSingle(iconFramesTrigger, 1.00)
		call TriggerAddAction(iconFramesTrigger, function IconFramesActions)
		set iconFramesTrigger = null

		// Update frames every second
        call TriggerRegisterTimerEventPeriodic(iconFrameUpdateTrigger, 1.00)
        call TriggerAddAction(iconFrameUpdateTrigger, function UpdateFrameVisibility)
        set iconFrameUpdateTrigger = null

		call CustomGameEvent_RegisterEventCode(EVENT_LEARN_ABILITY, CustomEvent.UpdateAbilityIconsEvent)
		call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.UpdateRoundStartGlobalIcons)
		call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_END, CustomEvent.UpdateRoundEndGlobalIcons)
	endfunction

endlibrary