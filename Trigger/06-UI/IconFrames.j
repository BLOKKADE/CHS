library IconFrames initializer init requires TooltipFrame, ItemStock, AchievementsFrame, CustomState, GetObjectElement, ElementColorCode, HeroLvlTable, UnitInfoPanel, RuneInit, HeroPassiveDesc, PlayerTracking, SellItems, ReadyButton
	
	globals
		// Sparkly thing that goes around an icon
		private string IndicatorPathPick = "UI\\Feedback\\Autocast\\UI-ModalButtonOn.mdl"

		// Button sizes
		private constant real SMALL_BUTTON_WIDTH = 0.025
		private constant real BIG_BUTTON_WIDTH = 0.036
		private constant real BIG_BUTTON_TOTAL_WIDTH = 0.04

		// Starting x positions
		private constant real TOP_RIGHT_ICON_ROW_X = 0.459
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
		framehandle array AbilityButtonId 
		framehandle array AbilityButtonParentId 

		boolean array ShowCreepAbilButton
	endglobals
	
	function GetElementCountTooltip takes unit u returns string
		local integer i1 = 1
		local integer i2 = 1
		local string description = ""

		loop
			set i2 = GetUnitElementCount(u, i1)

			// Don't include empty elements in the list
			if i2 > 0 then
				set description = description + GetFullElementText(i1) + " : " + I2S(i2) + "|n"
			endif

			set i1 = i1 + 1
			exitwhen i1 > 13 // Based off the amount of elements in ClassAbil array. 2-InitDescription.j
		endloop

		return description
	endfunction

	function GetAbilityElementCountTooltip takes unit u, integer spellLocation returns string
		local integer i1 = 1
		local integer i2 = 1
		local integer i3 = GetHeroSpellAtPosition(u, spellLocation) 
		local string description = ""
		local string temp

		set temp = GetObjectElementsAsString(u, i3, true)
		if temp != "" and temp != null then
			set description = description + temp + "|n"
		endif
		set description = description + BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(u, i3) - 1)

		// Hero absolutes
		if spellLocation > 10 and spellLocation <= 20 then
			set i1 = GetAbsoluteElement(i3)
			set i2 = GetUnitElementCount(u, i1)
			set description = description + "|n|n|cffd0ff00Current|r " + GetFullElementText(i1) + " |cffd0ff00count|r: " + I2S(i2)
		endif

		return description  
	endfunction

	private function SkillSysStart takes nothing returns nothing
		local framehandle frame = BlzGetTriggerFrame()
		local integer NumButton = LoadInteger(ButtonParentHandles, GetHandleId(frame), 1)
		local player p = GetTriggerPlayer()
		local integer pid = GetPlayerId(p)
		local string tooltipTitle
		local string description
		local string temp
		local boolean toggleBool = false
		local integer i1
		local integer i2
		local integer i3
		local unit u = null
		local integer selectedUnitPid = SelectedUnitPid[pid]
		local PlayerStats ps
		local unit itemStock
		local real tooltipSize

		if BlzGetTriggerFrameEvent() ==  FRAMEEVENT_CONTROL_CLICK then
			
			if p == GetLocalPlayer() then
				call BlzFrameSetEnable(frame, false)
				call BlzFrameSetEnable(frame, true)
			endif

			// Sell all items
			if NumButton == 3 then
				set u = PlayerHeroes[pid]

				call SellItemsFromHero(u)
				call ResourseRefresh(p) 
			
			// Scoreboard button
			elseif NumButton == 4 then
				set ps = PlayerStats.forPlayer(p)
				set toggleBool = ps.toggleHasScoreboardOpen()

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(ScoreboardFrameHandle, toggleBool)
				endif
			
			// Battle creator button
			elseif NumButton == 7 then
				set ps = PlayerStats.forPlayer(p)
				set toggleBool = ps.toggleHasBattleCreatorOpen()

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(BattleCreatorFrameHandle, toggleBool)
				endif

			// Rewards button
			elseif NumButton == 6 then
				set ps = PlayerStats.forPlayer(p)
				set toggleBool = ps.toggleHasRewardsOpen()

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(RewardsFrameHandle, toggleBool)
				endif

			// Ready button
			elseif NumButton == 5 then
				call PlayerReadies(p, false)

			// Show hats/achievments menu
			elseif NumButton == 39 then
				set ps = PlayerStats.forPlayer(p)
				set toggleBool = ps.toggleHasAchievementsOpen()

				call AchievementsFrame_UpdateAchievementFrameIcons(p)

				if GetLocalPlayer() == p then
					call BlzFrameSetVisible(MainAchievementFrameHandle, toggleBool)
				endif
			elseif NumButton == 8 then
				set itemStock = GetItemStock(pid)

				if ItemStockEnabled and GetLocalPlayer() == p then
					call SelectUnitSingle(itemStock)
				endif
			endif

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_UP then

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
			if selectedUnitPid == 27 then
				set selectedUnitPid = pid
			endif

			// Creep information
			if NumButton == 2 then
				set tooltipSize = GetTooltipSize(RoundAbilities)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cfffce177Next level|r: " + RoundCreepTitle)
					call BlzFrameSetText(TooltipTextFrame, RoundCreepInfo[pid] + "|n|n|cfffce177Abilities|r: " + RoundAbilities)
					call BlzFrameSetSize(TooltipFrame, 0.29, 0.12 + tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Sell all items
			elseif NumButton == 3 then
				set description = SellAllItemsTooltip()

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, description)
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

			// Battle creator
			elseif NumButton == 7 then
				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "View Battle Creator (|cff77f3fcCtrl+B|r)")
					call BlzFrameSetSize(TooltipFrame, 0.20, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Ready button
			elseif NumButton == 5 then
				set tooltipTitle = ReadyButtonTooltipTitle(p)
				set description = ReadyButtonTooltip(p, pid)
				set tooltipSize = GetTooltipSize(description)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, tooltipTitle)
					call BlzFrameSetText(TooltipTextFrame, description)
					call BlzFrameSetSize(TooltipFrame, 0.31, tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Element count
			elseif NumButton == 38 then
				set u = PlayerHeroes[selectedUnitPid]
				set description = GetElementCountTooltip(u)
				set tooltipSize = GetTooltipSize(description)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Element Counts|r")
					call BlzFrameSetText(TooltipTextFrame, description)
					call BlzFrameSetSize(TooltipFrame, 0.125, tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Player stats
			elseif NumButton == 8 then
				if ItemStockEnabled then
					set description = "You now have an item stock! Store extra items you can't carry in there, and swap them in during the Battle Royale.|n|n|cffd0ff00Ctrl+Q|r: Swaps items in slot 1.|n|cff00ffffCtrl+W|r: Swaps items in slot 2.|r"
				else
					set description = "When the Battle Royale preperation starts you can store extra items in your item stock, and swap them in during the Battle Royale.|n|n|cffd0ff00Ctrl+Q|r: Swaps items in slot 1.|n|cff00ffffCtrl+W|r: Swaps items in slot 2.|r"
				endif

				set tooltipSize = GetTooltipSize(description)

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Storage Box|r")
					call BlzFrameSetText(TooltipTextFrame, description)
					call BlzFrameSetSize(TooltipFrame, 0.23, tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Other Player stats
			elseif NumButton == 39 then
				set u = PlayerHeroes[selectedUnitPid]
				set description = PlayerStats.getTooltip(GetOwningPlayer(u))
				set description = description + "|n|n|cffff0000Clicking this toggles the rewards menu!|r"
				set tooltipSize = GetTooltipSize(description)
				set temp = GetPlayerNameColour(GetOwningPlayer(u))

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, "|cffd0ff00Stats for: |r" + temp)
					call BlzFrameSetText(TooltipTextFrame, description)
					call BlzFrameSetSize(TooltipFrame, 0.23, tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Player ready status
			elseif NumButton == 40 then
				set tooltipTitle = ReadyButtonTooltipTitle(p)
				set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

				if (ps.isReady()) then
					set tooltipTitle = "|cff00ff08Player is ready|r"
				else
					set tooltipTitle = "|cffff0000Player is not ready|r"
				endif
	
				if (PlayerIsAlwaysReady[selectedUnitPid]) then
					set tooltipTitle = "|cffffdd00Player is always ready|r"
				endif

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, tooltipTitle)
					call BlzFrameSetSize(TooltipFrame, 0.19, 0.02)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Hero information
			elseif NumButton == 100 then
				set u = PlayerHeroes[selectedUnitPid]
				set description = GetHeroTooltip(u)
				set tooltipSize = GetTooltipSize(description)
				set temp = GetPlayerNameColour(GetOwningPlayer(u)) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(u))

				if GetLocalPlayer() == p then
					call BlzFrameSetText(TooltipTitleFrame, temp)
					call BlzFrameSetText(TooltipTextFrame, description)
					call BlzFrameSetSize(TooltipFrame, 0.29, tooltipSize)
					call BlzFrameSetVisible(TooltipFrame, true)
				endif

			// Hero abilities and absolutes
			elseif NumButton > 100 and NumButton <= 120 then
				// player heroes/units
				if selectedUnitPid != 11 then
					set u = PlayerHeroes[selectedUnitPid]
					set i3 = GetHeroSpellAtPosition(u, NumButton - 100) 
					set description = GetAbilityElementCountTooltip(u, NumButton - 100)
					set tooltipSize = GetTooltipSize(description)
					set temp = BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(u,i3) - 1)

					if GetLocalPlayer() == p then	
						call BlzFrameSetText(TooltipTitleFrame, temp)
						call BlzFrameSetText(TooltipTextFrame, description)
						call BlzFrameSetSize(TooltipFrame, 0.29, tooltipSize)
						call BlzFrameSetVisible(TooltipFrame, true)
					endif 
					
				// Creeps
				else
					set u = SelectedUnit[pid]
					set i3 = roundAbilities.integer[NumButton - 100]
					set description = BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(u,i3)- 1)
					set tooltipSize = GetTooltipSize(description)
					set temp = BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(u,i3) - 1)

					if GetLocalPlayer() == p then	
						call BlzFrameSetText(TooltipTitleFrame, temp)
						call BlzFrameSetText(TooltipTextFrame, description)
						call BlzFrameSetSize(TooltipFrame, 0.29, tooltipSize)
						call BlzFrameSetVisible(TooltipFrame, true)
					endif       
				endif
			endif

		elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
			if GetLocalPlayer() == p then	
				call BlzFrameSetText(TooltipTextFrame, "")
				call BlzFrameSetVisible(TooltipFrame, false)
			endif
		endif

		// Cleanup
		set u = null
		set p = null
		set itemStock = null
		set frame = null
	endfunction
	
	private function UpdateRoundStartGlobalIcons takes EventInfo eventInfo returns nothing
		local integer pid = GetPlayerId(eventInfo.p)

		// Show stats button
        call BlzFrameSetVisible(ButtonParentId[8], RoundNumber > 0 and MainAchievementFrameHandle != null)

        // Show scoreboard button
        call BlzFrameSetVisible(ButtonParentId[4], RoundNumber > 0 and ScoreboardFrameHandle != null)
		
		// Show rewards button
        call BlzFrameSetVisible(ButtonParentId[6], RoundNumber > 0 and RewardsFrameHandle != null)

		// Show battle creator button
        call BlzFrameSetVisible(ButtonParentId[7], IsFunBRRound and BattleCreatorFrameHandle != null)

        // Show specific button
        if (ShopsCreated == false or BrStarted) then
            call BlzFrameSetVisible(ButtonParentId[2], false) // Creep info
            call BlzFrameSetVisible(ButtonParentId[3], false) // Sell all items
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

		if (IsFunBRRound and WaitingForBattleRoyal) then
            call BlzFrameSetVisible(ButtonParentId[3], true) // Sell all items
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
        local integer abilLevel = 0
        local string abilIcon = ""
        local integer selectedUnitPid = SelectedUnitPid[pid]
        local integer unitTypeId = 0
		local PlayerStats ps
		local string iconPath

        if selectedUnitPid == 27 then
            set selectedUnitPid = pid
        endif

		set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

		// Player ready status
		if (ps != 0 and ps.isReady()) then
			set iconPath = GetIconPath("ReadyNoText")

			if (GetLocalPlayer() == p) then
				call BlzFrameSetTexture(ButtonId[40], iconPath, 0, true)
			endif
		else
			set iconPath = GetIconPath("NotReadyNoText")

			if (GetLocalPlayer() == p) then
				call BlzFrameSetTexture(ButtonId[40], iconPath, 0, true)
			endif
		endif

		// Update the flashy ready status for the player
		if (GetLocalPlayer() == p) then
			call BlzFrameSetVisible(ButtonIndicatorParentId[40], PlayerIsAlwaysReady[selectedUnitPid])
		endif

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
				
				if selectedUnitPid == 11 then
					set abilLevel = GetUnitAbilityLevel(SelectedUnit[pid], abilId)
				else
					set abilLevel = GetUnitAbilityLevel(PlayerHeroes[selectedUnitPid], abilId)
				endif

				if (GetLocalPlayer() == p) then
					call BlzFrameSetVisible(ButtonParentId[100 + i], true)
					call BlzFrameSetVisible(AbilityButtonParentId[100 + i], true)
					call BlzFrameSetTexture(ButtonId[100 + i], abilIcon, 0, true)
					call BlzFrameSetText(AbilityButtonId[100 + i], I2S(abilLevel))

					if (abilLevel > 9) then
						call BlzFrameSetSize(AbilityButtonParentId[100 + i], 0.016, 0.0128)
					else
						call BlzFrameSetSize(AbilityButtonParentId[100 + i], 0.0125, 0.0128)
					endif
				endif
            else
				if (GetLocalPlayer() == p) then
					call BlzFrameSetVisible(ButtonParentId[100 + i], false)
					call BlzFrameSetVisible(AbilityButtonParentId[100 + i], false)
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
		local boolean hideEndGameIcons = BrStarted or IsFunBRRound
		local string playerReadyIconPath
		local PlayerStats ps

		if selectedUnitPid == 27 then
            set selectedUnitPid = pid
        endif

		set ps = PlayerStats.forPlayer(Player(selectedUnitPid))

		// Player ready status
        if (ps != 0 and ps.isReady()) then
			set playerReadyIconPath = GetIconPath("ReadyNoText")
		else
			set playerReadyIconPath = GetIconPath("NotReadyNoText")
        endif

		if (GetLocalPlayer() == Player(pid)) then
			// Ready icon
			call BlzFrameSetTexture(ButtonId[40], playerReadyIconPath, 0, true)
			call BlzFrameSetVisible(ButtonIndicatorParentId[40], PlayerIsAlwaysReady[selectedUnitPid] and (not hideEndGameIcons))

			// Indicator if the player is auto-ready
			call BlzFrameSetVisible(ButtonIndicatorParentId[5], PlayerIsAlwaysReady[pid])

			// Rewards button
			call BlzFrameSetVisible(ButtonIndicatorParentId[6], PlayerRewardPoints[pid] > 0)
			call BlzFrameSetVisible(ButtonParentId[6], ShopsCreated)

			// Creep info
			call BlzFrameSetVisible(ButtonParentId[2], ShowCreepAbilButton[pid] and ShopsCreated and (not hideEndGameIcons))

			// Battle creator button
			call BlzFrameSetVisible(ButtonParentId[7], IsFunBRRound)
		endif
    endfunction

	private function CreateIconWorld takes integer buttonIndex, string iconPath, real x, real y, real size, boolean isAbility returns nothing
		local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", GameUI, 0, 0) 
		local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1)
		local framehandle abilityLevelParentFrameHandle
		local framehandle abilityLevelFrameHandle

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

		if (isAbility) then
			set abilityLevelParentFrameHandle = BlzCreateFrame("TooltipText", GameUI, 0, 0)
			set abilityLevelFrameHandle = BlzGetFrameByName("TooltipTextTitle", 0)
			call BlzFrameSetLevel(abilityLevelParentFrameHandle, 2) // To have it appear above the button
			call BlzFrameSetText(abilityLevelFrameHandle, "0")
			call BlzFrameSetScale(abilityLevelFrameHandle, 0.55) 
			call BlzFrameSetPoint(abilityLevelParentFrameHandle, FRAMEPOINT_BOTTOMRIGHT, buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, 0.001, -0.001)
			call BlzFrameSetSize(abilityLevelParentFrameHandle, 0.0125, 0.0128)
			call BlzFrameSetVisible(abilityLevelParentFrameHandle, false)

			set AbilityButtonParentId[buttonIndex] = abilityLevelParentFrameHandle
			set AbilityButtonId[buttonIndex] = abilityLevelFrameHandle
		endif

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
		// Stats/Achievements
		call CreateIconWorld(8, "ReplaceableTextures\\CommandButtonsDisabled\\DISBTNRiderlessHorse.blp", BOTTOM_LEFT_ICON_ROW_X + 0 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)

		// Scoreboard
		call CreateIconWorld(4, "ReplaceableTextures\\CommandButtons\\BTNScoreboard.blp", BOTTOM_LEFT_ICON_ROW_X + 1 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)

		// Rewards
		call CreateIconWorld(6, "ReplaceableTextures\\CommandButtons\\BTNRewards.blp", BOTTOM_LEFT_ICON_ROW_X + 2 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)
		call CreateIndicatorForButton(6, BIG_BUTTON_WIDTH)

		// Ready
		call CreateIconWorld(5, "ReplaceableTextures\\CommandButtons\\BTNReady.blp", BOTTOM_LEFT_ICON_ROW_X + 3 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)
		call CreateIndicatorForButton(5, BIG_BUTTON_WIDTH)

		// Creep info
		call CreateIconWorld(2, "ReplaceableTextures\\CommandButtons\\BTNWaveInfo.blp", BOTTOM_LEFT_ICON_ROW_X + 4 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)

		// Battle Creator - Same position as creep info since it will replace it during fun br
		call CreateIconWorld(7, "ReplaceableTextures\\CommandButtons\\BTNBattleCreator.blp", BOTTOM_LEFT_ICON_ROW_X + 4 * BIG_BUTTON_TOTAL_WIDTH, BOTTOM_ICON_ROW_Y, BIG_BUTTON_WIDTH, false)
		// -- Big buttons

		// -- Currency buttons - Top middle rightish
		// Sell all items
		call CreateIconWorld(3, "ReplaceableTextures\\CommandButtons\\BTNIncreaseIncome2.blp", TOP_RIGHT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, false)
		// -- Currency buttons

		// -- Top left buttons
		// Player stats
		call CreateIconWorld(39, "ReplaceableTextures\\CommandButtons\\BTNStatsNoText.blp", TOP_LEFT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, false)

		// Player ready status
		call CreateIconWorld(40, "ReplaceableTextures\\CommandButtons\\BTNNotReadyNoText.blp", TOP_LEFT_ICON_ROW_X + 0 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, false)
		call CreateIndicatorForButton(40, SMALL_BUTTON_WIDTH)

		// Player element count
		call CreateIconWorld(38, "ReplaceableTextures\\CommandButtons\\BTNElements.blp", TOP_LEFT_ICON_ROW_X + 1 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, false)

		// Abilities/absolutes
		call CreateIconWorld(100, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 1 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(101, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 2 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(102, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 3 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(103, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 4 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(104, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 5 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(105, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 6 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(106, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 7 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(107, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 8 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(108, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 9 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(109, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 10 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(110, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 11 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(111, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 2 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(112, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 3 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(113, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 4 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(114, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 5 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(115, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 6 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(116, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 7 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(117, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 8 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(118, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 9 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(119, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 10 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
		call CreateIconWorld(120, "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp", TOP_LEFT_ICON_ROW_X + 11 * SMALL_BUTTON_WIDTH, TOP_ICON_ROW_Y - SMALL_BUTTON_WIDTH, SMALL_BUTTON_WIDTH, true)
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
		call CustomGameEvent_RegisterEventCode(EVENT_FUN_BR_ROUND_END, CustomEvent.UpdateRoundEndGlobalIcons)
	endfunction

endlibrary