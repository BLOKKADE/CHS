library Scoreboard initializer init requires PlayerTracking, HeroAbilityTable, IconFrames, SelectedUnits, ReadyButton, ScoreboardManager

    globals
        // Scoreboard static titles
        private constant string CREDITS                                 = "Developed by |cffff0000BLOKKADE|r, |cffae4affA Black Death|r, and |cff57f4ffKomoset|r"
        private string ScoreboardTitle

        // How often the scoreboard is updated
        private constant real SCOREBOARD_UPDATE_INTERVAL                = 2.0

        private constant string CLOSE_BUTTON_ICON                       = "ReplaceableTextures\\CommandButtons\\BTNuncheck.blp"

        // Sparkly thing that goes around an icon
		private constant string IndicatorPathPick                       = "UI\\Feedback\\Autocast\\UI-ModalButtonOn.mdl"

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.05
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.56
        private constant real MAIN_FRAME_X_MARGIN                       = 0.03
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.027
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.025
        private constant real TITLE_HEIGHT                              = 0.03
        private constant real CREDITS_HEIGHT                            = 0.008

        // Specifications for a button
        private constant real ICON_WIDTH                                = 0.016
        private constant real ICON_SPACING                              = 0.003
        private constant real ABILITY_ICON_SPACING                      = 0.01
        private constant real ROW_SPACING                               = 0.01
        private constant real CLOSE_ICON_WIDTH                          = 0.032

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.012
        private constant real TEXT_WIDTH                                = 0.2

        // Column widths
        private constant real PLAYER_NAME_WIDTH                         = 0.12
        private constant real PLAYER_DUELS_WIDTH                        = 0.043

        // Colors
        private constant string BR_WINNER_STATUS_COLOR                  = "|cfffcff4a"	
        private constant string BR_LIVES_COLOR                          = "|cffff3e25"	
        private constant string FELL_IN_BR_STATUS_COLOR                 = "|cffff9925"	
        private constant string HEADER_COLOR                            = "|cff00ffff"
        private constant string HERO_PICKED_COLOR                       = "|cfffffc34"
        private constant string HERO_RANDOMED_COLOR                     = "|cffffae34"
        private constant string INVALID_ACTION_COLOR                    = "|cffff0000"	
        private constant string LEAVER_COLOR                            = "|cff858585"	
        private constant string LEFT_FUN_BR_COLOR                       = "|cffb1ff69"	
        private constant string NO_HERO_STATUS_COLOR                    = "|cffff2525"	
        private constant string OBSERVER_STATUS_COLOR                   = "|cff2cd8ff"	
        private constant string PLAYER_ALWAYS_READY_COLOR               = "|cffffdd00"
        private constant string PLAYER_ELEMENT_COUNT_COLOR              = "|cffd0ff00"
        private constant string PLAYER_HERO_LEVEL_COLOR                 = "|cff98fff6"
        private constant string PLAYER_HERO_NAME_COLOR                  = "|cffffa8a8"
        private constant string PLAYER_NOT_READY_COLOR                  = "|cffff0000"
        private constant string PLAYER_READY_COLOR                      = "|cff00ff08"
        private constant string PLAYER_STATS_COLOR                      = "|cffd0ff00"
        private constant string PVP_LOSSES_COLOR                        = "|cffdd2c00"
        private constant string PVP_WINS_COLOR                          = "|cffbfff81"
        private constant string SURVIVED_UNTIL_STATUS_COLOR             = "|cffdf50e4"	
        private constant string ABILITY_LEVEL_COLOR                     = "|cfffff8b9"	

        private constant string COLOR_END_TAG                           = "|r"
        private constant string SLASH                                   = "|cff858585/|r"

        private constant string NOTES                                   = HERO_RANDOMED_COLOR + " (r)" + COLOR_END_TAG + " = Random Hero" + HERO_PICKED_COLOR + " (p)" + COLOR_END_TAG + " = Picked Hero"

        // Specifications about the rows/columns
        private integer CurrentRowIndex                                 = 0
        private integer CurrentColumnIndex                              = 0

        // The force for the leaderboard. Should never change, even if people leave the game
        private force ScoreboardForce

        // The only trigger that handles hovering over scoreboard icons
        private trigger IconEventTrigger

        // Save relavant information for each framehandle. Currently, we save the playerId and the CurrentColumnIndex. Used for interacting with the framehandle
        private hashtable IconEventHandles
        
        // Tooltip information
        private framehandle ScoreboardBrTimesFrameHandle
        private framehandle ScoreboardBrTimesTextFrameHandle
        private framehandle ScoreboardTooltipFrame
		private framehandle ScoreboardTooltipTitleFrame
		private framehandle ScoreboardTooltipTextFrame
        private framehandle ScoreboardGameDescriptionFrameHandle
        private framehandle ScoreboardGameDescriptionTextFrameHandle

        private integer CloseHandleId

        // Keep track of what is currently in the scoreboard to be smarter about what needs to be updated/removed to improve performance. Is also a separation of concerns from the PlayerHeroes array and if the hero gets removed for whatever reason.
        // NOTE: CachedPlayerItems and CachedPlayerAbilities could be merged into a single array, but I thought it would be simpler if they are separate
        private integer array CachedPlayerItems // Item ids for each player hero
        private integer array CachedPlayerAbilities // Ability ids for each player hero
        private integer array CachedPlayerAbilityLevels // Ability levels for each player hero
        private boolean array CachedPlayerPlayerReadyStatus // Cached status if their ready status has changed
        private string array CachedPlayerTooltipNames // Tooltip names
        private string array CachedPlayerTooltipDescriptions // Tooltip descriptions

        // Framehandles for all columns for each player to easily be referenced to update them
        private framehandle array CachedPlayerAbilityLevelFramehandles
        private framehandle array CachedPlayerAbilityLevelParentFramehandles
        private framehandle array CachedPlayerFramehandles
        private framehandle array CachedPlayerIndicatorParentFramehandles
        private framehandle array CachedPlayerIndicatorFramehandles
    endglobals
    
    private function GetTopLeftX takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN
        local real offset

        // Don't move the x-coordinate any more for PLAYER_STATS_INDEX or PLAYER_READY_STATUS_INDEX

        // Player hero and element count
        if (CurrentColumnIndex >= PLAYER_HERO_INDEX and CurrentColumnIndex != PLAYER_READY_STATUS_INDEX) then
            set value = value + ICON_WIDTH + ICON_SPACING
        endif

        // Player name and player status
        if (CurrentColumnIndex >= PLAYER_NAME_INDEX) then
            set value = value + ICON_WIDTH + ICON_SPACING
        endif

        // Player duels
        if (CurrentColumnIndex >= PLAYER_DUELS_INDEX) then
            set value = value + PLAYER_NAME_WIDTH
        endif

        // Top 3 row items
        if (CurrentColumnIndex >= PLAYER_ITEMS_START_INDEX and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 2)) then
            set offset = PLAYER_DUELS_WIDTH + ICON_SPACING // Element count offset
            set value = value + offset + ((CurrentColumnIndex - PLAYER_ITEMS_START_INDEX) * ICON_WIDTH) + ((CurrentColumnIndex - PLAYER_ITEMS_START_INDEX) * ICON_SPACING)
        endif

        // Bottom 3 row items
        if (CurrentColumnIndex >= (PLAYER_ITEMS_START_INDEX + 3) and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 5)) then
            set offset = PLAYER_DUELS_WIDTH + ICON_SPACING // Element count offset
            set value = value + offset + ((CurrentColumnIndex - (PLAYER_ITEMS_START_INDEX + 3)) * ICON_WIDTH) + ((CurrentColumnIndex - (PLAYER_ITEMS_START_INDEX + 3)) * ICON_SPACING)
        endif

        // Top 10 row abilities
        if (CurrentColumnIndex >= PLAYER_ABILITIES_START_INDEX and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 9)) then
            set offset = PLAYER_DUELS_WIDTH + (ICON_WIDTH * 4) + (ICON_SPACING * 2) // Item and buffer offset
            set value = value + offset + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ICON_WIDTH) + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ABILITY_ICON_SPACING)
        endif

        // Bottom 10 row absolutes
        if (CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set offset = PLAYER_DUELS_WIDTH + (ICON_WIDTH * 4) + (ICON_SPACING * 2) // Item and buffer offset
            set value = value + offset + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ICON_WIDTH) + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ABILITY_ICON_SPACING)
        endif

        return value
    endfunction

    private function GetTopLeftY takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN
        local real offset = (ICON_WIDTH / 2) + (ICON_SPACING / 2) // Offset to have 2 icons in the same column

        // Header row
        if (CurrentRowIndex == 0) then
            return value
        endif

        // (+ ICON_WIDTH) is used to offset back up one row since we go down (2 * ICON_WIDTH) for each row
        // (+ ROW_SPACING) is used to shift everything closer to the header row
        set value = value - TEXT_HEIGHT - (2 * ICON_WIDTH * CurrentRowIndex) - (ROW_SPACING * CurrentRowIndex) + ICON_WIDTH + ROW_SPACING

        // Player hero level
        if (CurrentColumnIndex == PLAYER_HERO_LEVEL_INDEX) then
            return value - ICON_SPACING
        endif

        // Player status
        if (CurrentColumnIndex == PLAYER_STATUS_INDEX) then
            return value - offset - ICON_SPACING
        endif

        // Player name, top row player stats icon, player hero icon, item icons, or ability icons
        if (CurrentColumnIndex == PLAYER_NAME_INDEX or CurrentColumnIndex == PLAYER_STATS_INDEX or CurrentColumnIndex == PLAYER_HERO_INDEX or CurrentColumnIndex >= PLAYER_ITEMS_START_INDEX and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 2) or CurrentColumnIndex >= PLAYER_ABILITIES_START_INDEX and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 9)) then
            set value = value + offset
        endif

        // Bottom row player ready status, player element count icon, item icons, or ability icons
        if (CurrentColumnIndex == PLAYER_READY_STATUS_INDEX or CurrentColumnIndex == PLAYER_ELEMENT_COUNT_INDEX or CurrentColumnIndex >= (PLAYER_ITEMS_START_INDEX + 3) and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 5) or CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set value = value - offset
        endif

        return value
    endfunction

    private function CreateIndicatorForIcon takes integer playerId returns nothing
        local framehandle parentIconFrame = CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
		local framehandle buttonIndicatorParentFrame = BlzCreateFrameByType("BUTTON", "PlayerStatusIndicatorParent", parentIconFrame, "", 0)
		local framehandle buttonIndicatorFrame = BlzCreateFrameByType("SPRITE", "PlayerStatusIndicator", buttonIndicatorParentFrame, "", 0)

		// Make sure the indicator is on top of everything
		call BlzFrameSetLevel(buttonIndicatorParentFrame, 2)
		call BlzFrameSetVisible(buttonIndicatorParentFrame, false)

		// Create the indicator, offset it around the button
		call BlzFrameSetModel(buttonIndicatorFrame, IndicatorPathPick, 0)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_TOPLEFT, parentIconFrame, FRAMEPOINT_TOPLEFT, -0.001, 0.001)
		call BlzFrameSetPoint(buttonIndicatorFrame, FRAMEPOINT_BOTTOMRIGHT, parentIconFrame, FRAMEPOINT_BOTTOMRIGHT, -0.0012, -0.0016)
        call BlzFrameSetScale(buttonIndicatorFrame, ICON_WIDTH / 0.036) // Scale the model to the icon size

		// Save frames for future reference
        set CachedPlayerIndicatorParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = buttonIndicatorParentFrame
        set CachedPlayerIndicatorFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = buttonIndicatorFrame

		// Cleanup
		set parentIconFrame = null
        set buttonIndicatorFrame = null
		set buttonIndicatorParentFrame = null
	endfunction

    private function CreateIcon takes string iconPath, integer playerId returns nothing
        local framehandle buttonFrameHandle
        local framehandle buttonBackdropFrameHandle
        local integer buttonHandleId
        local integer backdropHandleId

        // Only create the new frame if it doesn't exist. Otherwise reuse the existing frame for performance reasons
        if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] == null) then
            // Create the icons frames and save them for later
            set buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", ScoreboardFrameHandle, 0, 0) 
            set buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1)
            set buttonHandleId = GetHandleId(buttonFrameHandle)
            set backdropHandleId = GetHandleId(buttonBackdropFrameHandle)

            set CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = buttonFrameHandle
            set CachedPlayerFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = buttonBackdropFrameHandle

            // Dimensions for the button
            call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
            call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ICON_WIDTH, GetTopLeftY() - ICON_WIDTH) 

            // Save the handle of this button to look it up later for mouse events
            call SaveInteger(IconEventHandles, buttonHandleId, 1, playerId)
            call SaveInteger(IconEventHandles, buttonHandleId, 2, CurrentColumnIndex)

            // Register with the single trigger about hovering over the icon
            call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
            call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
            call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        else
            // Retrieve the cached framehandle
            set buttonFrameHandle = CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
            set buttonBackdropFrameHandle = CachedPlayerFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
        endif
        
        // Hide the icon if the path is null
        if (iconPath == null) then
            call BlzFrameSetVisible(buttonFrameHandle, false)
        else
            // Apply the icon
            call BlzFrameSetVisible(buttonFrameHandle, true)
            call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
            call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        endif

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateText takes string value, integer playerId returns nothing
        local framehandle playerNameTextFrameHandle

        // Only create the new frame if it doesn't exist. Otherwise reuse the existing frame for performance reasons
        if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] == null) then
            set playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 
            set CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = playerNameTextFrameHandle

            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY() - 0.003)
            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TEXT_WIDTH, GetTopLeftY() - TEXT_HEIGHT - 0.005) 
            call BlzFrameSetEnable(playerNameTextFrameHandle, false) 

            // Show smaller text for the player status
            if (CurrentColumnIndex == PLAYER_STATUS_INDEX or CurrentColumnIndex == PLAYER_HERO_LEVEL_INDEX) then
                call BlzFrameSetScale(playerNameTextFrameHandle, 0.8) 
            else
                call BlzFrameSetScale(playerNameTextFrameHandle, 1.2) 
            endif

            call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 
        else
            // Retrieve the cached framehandle
            set playerNameTextFrameHandle = CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
        endif

        // Check if the text should be updated. Could possibly save performance
        if (CachedPlayerStrings[(playerId * CACHING_BUFFER) + CurrentColumnIndex] != value) then
            set CachedPlayerStrings[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = value

            call BlzFrameSetText(playerNameTextFrameHandle, value) 
        endif

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    private function UpdatePlayerItems takes player currentPlayer returns nothing
        local integer itemSlotIndex = 0
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId]
        local item currentItem
        local integer currentItemTypeId

        if (playerHero != null) then
            loop
                exitwhen itemSlotIndex > 5

                set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

                if (currentItem != null) then
                    set currentItemTypeId = GetItemTypeId(currentItem)

                    // Only update the data if it changed
                    if (CachedPlayerItems[(playerId * CACHING_BUFFER) + itemSlotIndex] != currentItemTypeId) then
                        set CachedPlayerItems[(playerId * CACHING_BUFFER) + itemSlotIndex] = currentItemTypeId

                        // Display the icon
                        call CreateIcon(BlzGetItemIconPath(currentItem), playerId)

                        // Cache the tooltip information about the item
                        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = GetItemName(currentItem)
                        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = BlzGetAbilityExtendedTooltip(currentItemTypeId, 0)
                    endif
                else
                    // Hide the icon if something was there
                    if (CachedPlayerItems[(playerId * CACHING_BUFFER) + itemSlotIndex] != -1) then
                        call CreateIcon(null, playerId)
                    endif

                    // Wipe the tooltip information and itemId
                    set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = ""
                    set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = ""
                    set CachedPlayerItems[(playerId * CACHING_BUFFER) + itemSlotIndex] = -1
                endif

                set CurrentColumnIndex = CurrentColumnIndex + 1
                set itemSlotIndex = itemSlotIndex + 1
            endloop
        endif

        // Cleanup
        set playerHero = null
        set currentItem = null
    endfunction

    private function UpdatePlayerAbilities takes player currentPlayer returns nothing
        local integer abilityIndex = 1
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId]
        local integer currentAbility
        //local framehandle abilityLevelParentFrameHandle
        local framehandle abilityLevelFrameHandle
        local integer abilityLevel = 0

        if (playerHero != null) then
            loop
                exitwhen abilityIndex > 20

                // Check if there is a valid ability in the next slot
                set currentAbility = GetHeroSpellAtPosition(playerHero, abilityIndex)

                if (currentAbility != 0) then
                    // Only update the data if it changed
                    if (CachedPlayerAbilities[(playerId * CACHING_BUFFER) + abilityIndex] != currentAbility) then
                        set CachedPlayerAbilities[(playerId * CACHING_BUFFER) + abilityIndex] = currentAbility

                        // Display the icon
                        call CreateIcon(BlzGetAbilityIcon(currentAbility), playerId)
                    endif

                    set abilityLevel = GetUnitAbilityLevel(playerHero, currentAbility) - 1 // What is the -1 for?

                    // Cache the tooltip information about the ability. Need to always recalculate since abilities show element counts
                    set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = BlzGetAbilityTooltip(currentAbility, abilityLevel) 
                    set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = GetAbilityElementCountTooltip(playerHero, abilityIndex)
                else
                    // Hide the icon if something was there
                    if (CachedPlayerAbilities[(playerId * CACHING_BUFFER) + abilityIndex] != -1) then
                        call CreateIcon(null, playerId)
                    endif

                    // Wipe the tooltip information, abilityId, and ability level
                    set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = ""
                    set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = ""
                    set CachedPlayerAbilities[(playerId * CACHING_BUFFER) + abilityIndex] = -1
                endif

                if (CachedPlayerAbilityLevelFramehandles[(playerId * CACHING_BUFFER) + abilityIndex] == null) then
                    // Ability level for the button. Save the framehandle for later to easily update the value
                    set abilityLevelFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 
                    call BlzFrameSetLevel(abilityLevelFrameHandle, 2) // To have it appear above the scoreboard
                    call BlzFrameSetPoint(abilityLevelFrameHandle, FRAMEPOINT_TOPLEFT, CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex], FRAMEPOINT_BOTTOMRIGHT, -(ICON_WIDTH / 6), 0.01)
                    call BlzFrameSetEnable(abilityLevelFrameHandle, false) 
                    call BlzFrameSetScale(abilityLevelFrameHandle, 0.7) 
                    call BlzFrameSetText(abilityLevelFrameHandle, "0") 

                    set CachedPlayerAbilityLevels[(playerId * CACHING_BUFFER) + abilityIndex] = 0

                    set CachedPlayerAbilityLevelFramehandles[(playerId * CACHING_BUFFER) + abilityIndex] = abilityLevelFrameHandle
                else
                    set abilityLevelFrameHandle = CachedPlayerAbilityLevelFramehandles[(playerId * CACHING_BUFFER) + abilityIndex]
                endif

                // Only update the text if it is different
                if (currentAbility != 0 and CachedPlayerAbilityLevels[(playerId * CACHING_BUFFER) + abilityIndex] != (abilityLevel + 1)) then
                    call BlzFrameSetText(abilityLevelFrameHandle, ABILITY_LEVEL_COLOR + I2S(abilityLevel + 1) + COLOR_END_TAG) // Ability level is 0 based above for our other libraries

                    if (abilityLevel > 9) then
                        call BlzFrameSetPoint(abilityLevelFrameHandle, FRAMEPOINT_TOPLEFT, CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex], FRAMEPOINT_BOTTOMRIGHT, -(ICON_WIDTH / 6), 0.01)
                    endif
                endif

                // Only show the ability level ui if has at least one level
                call BlzFrameSetVisible(abilityLevelFrameHandle, currentAbility != 0)

                set CurrentColumnIndex = CurrentColumnIndex + 1
                set abilityIndex = abilityIndex + 1
            endloop
        endif

        // Cleanup
        set playerHero = null
        set abilityLevelFrameHandle = null
        //set abilityLevelParentFrameHandle = null
    endfunction

    private function AddPlayerToScoreboard takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]

        // Player stats icon
        set CurrentColumnIndex = PLAYER_STATS_INDEX
        call CreateIcon("ReplaceableTextures\\CommandButtons\\BTNStatsNoText.blp", playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = PLAYER_STATS_COLOR + "Stats for: " + COLOR_END_TAG + GetPlayerNameColour(currentPlayer)
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = PlayerStats.getTooltip(currentPlayer)

        // Default to the non ready status
        set CurrentColumnIndex = PLAYER_READY_STATUS_INDEX
        call CreateIcon(GetIconPath("NotReadyNoText"), playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = INVALID_ACTION_COLOR + "Player is not ready" + COLOR_END_TAG
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = ""

        // Create indicator for player ready status
        call CreateIndicatorForIcon(playerId)

        // Set the player hero icon to a missing icon
        set CurrentColumnIndex = PLAYER_HERO_INDEX
        call CreateIcon("ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp", playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = INVALID_ACTION_COLOR + "Player has no hero" + COLOR_END_TAG
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = ""

        // Element icon
        set CurrentColumnIndex = PLAYER_ELEMENT_COUNT_INDEX
        call CreateIcon("ReplaceableTextures\\CommandButtons\\BTNElements.blp", playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = INVALID_ACTION_COLOR + "Player has no hero" + COLOR_END_TAG
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = ""

        // Set the player name
        set CurrentColumnIndex = PLAYER_NAME_INDEX
        call CreateText(GetPlayerNameColour(currentPlayer), playerId)

        // Set the player hero level
        set CurrentColumnIndex = PLAYER_HERO_LEVEL_INDEX
        call CreateText(INVALID_ACTION_COLOR + "No Hero Level" + COLOR_END_TAG, playerId)

        // Initialize the player status
        set CurrentColumnIndex = PLAYER_STATUS_INDEX
        call CreateText("", playerId)

        // Set the player stats
        set CurrentColumnIndex = PLAYER_DUELS_INDEX
        call CreateText(PVP_WINS_COLOR + "0" + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + "0" + COLOR_END_TAG, playerId)

        // Set the player items
        set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
        call UpdatePlayerItems(currentPlayer)

        // Set the player abilities
        set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
        call UpdatePlayerAbilities(currentPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function ScoreboardMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local player triggerPlayer = GetTriggerPlayer()
        local integer triggerPlayerId = GetPlayerId(triggerPlayer)
        local integer handleId = GetHandleId(currentFrameHandle)
        local integer playerId = LoadInteger(IconEventHandles, handleId, 1)
        local integer columnIndex = LoadInteger(IconEventHandles, handleId, 2)
        local real tooltipWidth = 0.29 // Default used by almost everything
        local string tooltipDescription
        local string tooltipName

        if (BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK) then
            if (GetLocalPlayer() == triggerPlayer) then	
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

            // Close
            if (handleId == CloseHandleId) then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetVisible(ScoreboardFrameHandle, false) 
                    call PlayerStats.forPlayer(triggerPlayer).setHasScoreboardOpen(false)
                endif

            // Toggle selected player's hero if it exists and is alive
            elseif (columnIndex == PLAYER_HERO_INDEX and (not PlayerLeftGame[playerId]) and PlayerHeroes[playerId] != null and UnitAlive(PlayerHeroes[playerId])) then
                call SelectUnitForPlayerSingle(PlayerHeroes[playerId], triggerPlayer)
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            // Retrieve the cached information
            set tooltipName = CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + columnIndex]
            set tooltipDescription = CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + columnIndex]

            // Player hero icon - Add error message if player isn't in game or hero is invalid
            if (columnIndex == PLAYER_HERO_INDEX) then
                if (PlayerLeftGame[playerId] or PlayerHeroes[playerId] == null or (not UnitAlive(PlayerHeroes[playerId]))) then
                    set tooltipName = tooltipName + " - " + INVALID_ACTION_COLOR + "Cannot select hero!" + COLOR_END_TAG
                else
                    set tooltipName = tooltipName + " - " + INVALID_ACTION_COLOR + "Click for more details!" + COLOR_END_TAG
                endif

            // Element count - Change the width of the tooltip
            elseif (columnIndex == PLAYER_ELEMENT_COUNT_INDEX) then
                set tooltipWidth = 0.125

            // Player ready status - Change the width of the tooltip
            elseif (columnIndex == PLAYER_READY_STATUS_INDEX) then
                set tooltipWidth = 0.15
            endif

            // Show the tooltip information if valid
            if (tooltipName != "") then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetText(ScoreboardTooltipTitleFrame, tooltipName)
                    call BlzFrameSetText(ScoreboardTooltipTextFrame, tooltipDescription)
                    call BlzFrameSetPoint(ScoreboardTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_BOTTOM, 0, 0)
                    call BlzFrameSetSize(ScoreboardTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                    call BlzFrameSetVisible(ScoreboardTooltipFrame, true)
                endif
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE) then
            // Empty the text box
            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(ScoreboardTooltipTitleFrame, "")
                call BlzFrameSetText(ScoreboardTooltipTextFrame, "")
                call BlzFrameSetVisible(ScoreboardTooltipFrame, false)
            endif
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function CreateHeaderRow takes nothing returns nothing
        set CurrentRowIndex = 0

        // Need a player id to save text, but since this is for the header values it doesn't matter what it is (As long as it is not an actual player id)
        set CurrentColumnIndex = PLAYER_NAME_INDEX
        call CreateText(HEADER_COLOR + "Player" + COLOR_END_TAG, 25) 
        set CurrentColumnIndex = PLAYER_DUELS_INDEX
        call CreateText(HEADER_COLOR + "Duels" + COLOR_END_TAG, 25)
        set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
        call CreateText(HEADER_COLOR + "Items" + COLOR_END_TAG, 25)
        set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
        call CreateText(HEADER_COLOR + "Abilities" + COLOR_END_TAG, 25)

        set CurrentRowIndex = 1
    endfunction

    private function InitializeDefaultValues takes nothing returns nothing
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY
        local framehandle titleFrameHandle
        local framehandle creditsTextFrameHandle
        local framehandle closeButtonFrameHandle
        local framehandle closeIconButtonFrameHandle
        local framehandle notesTextFrameHandle

        // This will get all players, even if they left the game already
        set ScoreboardForce = GetPlayerForce()

        call CreateHeaderRow()

        // Populate the rows with actual player data
        call ForForce(ScoreboardForce, function AddPlayerToScoreboard)

        // Compute the main scoreboard box
        // Width - Main frame margins, all icon widths, all icon spacings
        set mainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + (2 * MAIN_FRAME_X_MARGIN) + PLAYER_NAME_WIDTH + PLAYER_DUELS_WIDTH + (16 * ICON_WIDTH) + (5 * ICON_SPACING) + (9 * ABILITY_ICON_SPACING)
        // Height - Compute the same y coordinate like normal, but use the top row offset. Then add the credits height, and main frame margin
        set mainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH * CurrentRowIndex) - (ROW_SPACING * CurrentRowIndex) + ICON_WIDTH + ROW_SPACING - CREDITS_HEIGHT - MAIN_FRAME_Y_BOTTOM_MARGIN + (ICON_WIDTH / 2) + (ICON_SPACING / 2)

        // Set the frame for the backdrop of the entire scoreboard
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X, MAIN_FRAME_TOP_LEFT_Y) 
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Create the scoreboard title
        set titleFrameHandle = BlzCreateFrameByType("GLUETEXTBUTTON", "ScoreboardTitle", ScoreboardFrameHandle, "ScriptDialogButton", 0) 
        call BlzFrameSetLevel(titleFrameHandle, 2) // To have it appear above the scoreboard
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.2, MAIN_FRAME_TOP_LEFT_Y + (TITLE_HEIGHT / 2)) 
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.8, MAIN_FRAME_TOP_LEFT_Y - TITLE_HEIGHT) 
        call BlzFrameSetEnable(titleFrameHandle, false) 
        call BlzFrameSetScale(titleFrameHandle, 1.2) 
        call BlzFrameSetText(titleFrameHandle, ScoreboardTitle) 

        // Create the scoreboard credits
        set creditsTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 
        call BlzFrameSetLevel(ScoreboardTooltipFrame, 2) // To have it appear above the scoreboard
        call BlzFrameSetAbsPoint(creditsTextFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + CREDITS_HEIGHT) 
        call BlzFrameSetAbsPoint(creditsTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetEnable(creditsTextFrameHandle, false) 
        call BlzFrameSetScale(creditsTextFrameHandle, 0.8) 
        call BlzFrameSetTextAlignment(creditsTextFrameHandle, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_RIGHT) 
        call BlzFrameSetText(creditsTextFrameHandle, CREDITS) 

        // Create the scoreboard notes
        set notesTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardNotes", ScoreboardFrameHandle, "", 0) 
        call BlzFrameSetLevel(ScoreboardTooltipFrame, 2) // To have it appear above the scoreboard
        call BlzFrameSetAbsPoint(notesTextFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + CREDITS_HEIGHT) 
        call BlzFrameSetAbsPoint(notesTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetEnable(notesTextFrameHandle, false) 
        call BlzFrameSetScale(notesTextFrameHandle, 0.8) 
        call BlzFrameSetTextAlignment(notesTextFrameHandle, TEXT_JUSTIFY_BOTTOM, TEXT_JUSTIFY_LEFT) 
        call BlzFrameSetText(notesTextFrameHandle, NOTES) 

        // Create the box for the scoreboard description 
        set ScoreboardGameDescriptionFrameHandle = BlzCreateFrame("CheckListBox", ScoreboardFrameHandle, 0, 0)
        call BlzFrameSetAbsPoint(ScoreboardGameDescriptionFrameHandle, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX, MAIN_FRAME_TOP_LEFT_Y - 0.04) // Move it down a little so it doesn't block the timer

        // Create the box for the BR times
        set ScoreboardBrTimesFrameHandle = BlzCreateFrame("CheckListBox", ScoreboardFrameHandle, 0, 0)
        call BlzFrameSetAbsPoint(ScoreboardBrTimesFrameHandle, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX, MAIN_FRAME_TOP_LEFT_Y - 0.2) // Move it under the game description
        call BlzFrameSetVisible(ScoreboardBrTimesFrameHandle, false) 

        // Create the actual text element that shows the scoreboard description
        set ScoreboardGameDescriptionTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardDescriptionTextArea", ScoreboardFrameHandle, "", 0)    
        call BlzFrameSetEnable(ScoreboardGameDescriptionTextFrameHandle, false) 
        call BlzFrameSetScale(ScoreboardGameDescriptionTextFrameHandle, 1.05) 
        call BlzFrameSetTextAlignment(ScoreboardGameDescriptionTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)

        // Create the actual text element that shows the br times
        set ScoreboardBrTimesTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardBrTimesTextArea", ScoreboardFrameHandle, "", 0)    
        call BlzFrameSetEnable(ScoreboardBrTimesTextFrameHandle, false) 
        call BlzFrameSetScale(ScoreboardBrTimesTextFrameHandle, 1.05) 
        call BlzFrameSetTextAlignment(ScoreboardBrTimesTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_CENTER)

        // Create the close button
        set closeButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", ScoreboardFrameHandle, 0, 0) 
        set closeIconButtonFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", closeButtonFrameHandle, "", 1)
        call BlzFrameSetPoint(closeButtonFrameHandle, FRAMEPOINT_TOPRIGHT, ScoreboardFrameHandle, FRAMEPOINT_TOPRIGHT, -(CLOSE_ICON_WIDTH / 4), -(CLOSE_ICON_WIDTH / 4))
        call BlzFrameSetAllPoints(closeIconButtonFrameHandle, closeButtonFrameHandle) 
        call BlzFrameSetTexture(closeIconButtonFrameHandle, CLOSE_BUTTON_ICON, 0, true) 
        call BlzFrameSetSize(closeButtonFrameHandle, CLOSE_ICON_WIDTH, CLOSE_ICON_WIDTH)
        set CloseHandleId = GetHandleId(closeButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, closeButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Cleanup
        set titleFrameHandle = null
        set creditsTextFrameHandle = null
        set closeButtonFrameHandle = null
        set closeIconButtonFrameHandle = null
    endfunction

    private function GetPluralLife takes integer value, string singular, string plural returns string
        if (value <= 0) then
            return "0 " + plural
        elseif (value == 1) then
            return "1 " + singular
        endif
        
        return I2S(value) + " " + plural
    endfunction

    private function GetPlayerHeroLevelText takes PlayerStats ps, integer playerId returns string
        local string text = PLAYER_HERO_LEVEL_COLOR + "Hero Level " + I2S(GetHeroLevel(PlayerHeroes[playerId])) + COLOR_END_TAG

        // Hero select status
        if (ps.getIsHeroRandom()) then
            set text = text + HERO_RANDOMED_COLOR + " (r)" + COLOR_END_TAG
        else
            set text = text + HERO_PICKED_COLOR + " (p)" + COLOR_END_TAG
        endif

        // Show lives
        if (BrStarted == true) then
            set text = text + " " + BR_LIVES_COLOR + GetPluralLife(IMaxBJ(MaxBRDeathCount - PlayerBRDeaths[playerId], 0), "BR Life", "BR Lives") + COLOR_END_TAG
        elseif (ModeNoDeath == false) then
            set text = text + " " + BR_LIVES_COLOR + GetPluralLife(Lives[playerId], "Life", "Lives") + COLOR_END_TAG
        endif

        return text
    endfunction

    private function UpdateDynamicPlayerValues takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        set CurrentColumnIndex = PLAYER_STATUS_INDEX

        if (IsFunBRRound and IsPlayerInForce(currentPlayer, BRObservers)) then
            call CreateText(OBSERVER_STATUS_COLOR + "Fun Battle Royale Observer" + COLOR_END_TAG, playerId)
        else
            // If this is the BR winner, set the status
            if (IsPlayerInForce(currentPlayer, WinnerPlayerForce)) then
                if (IsFunBRRound) then
                    call CreateText(BR_WINNER_STATUS_COLOR + "Fun Battle Royale Winner with " + ps.getBRPVPKillCount() + COLOR_END_TAG, playerId)
                else
                    call CreateText(BR_WINNER_STATUS_COLOR + "Battle Royale Winner with " + ps.getBRPVPKillCount() + COLOR_END_TAG, playerId)
                endif

            // Player status for dying
            elseif (PlayerDeathRound[playerId] != 0) then
                if (PlayerDeathRound[playerId] == -1) then
                    call CreateText(NO_HERO_STATUS_COLOR + "Left before hero selection" + COLOR_END_TAG, playerId)
                elseif (PlayerDiedInBR[playerId] and (PlayerDeathRound[playerId] == 50 or (GameModeShort == true and PlayerDeathRound[playerId] == 25))) then
                    if (IsFunBRRound and IsPlayerInForce(currentPlayer, LeaverPlayers)) then
                        call CreateText(LEFT_FUN_BR_COLOR + "Left the game" + COLOR_END_TAG, playerId)
                    elseif (IsFunBRRound) then
                        call CreateText(FELL_IN_BR_STATUS_COLOR + "Fell in Fun Battle Royale with " + ps.getBRPVPKillCount() + COLOR_END_TAG, playerId)
                    else
                        call CreateText(FELL_IN_BR_STATUS_COLOR + "Fell in Battle Royale with " + ps.getBRPVPKillCount() + COLOR_END_TAG, playerId)
                    endif
                else
                    call CreateText(SURVIVED_UNTIL_STATUS_COLOR + "Survived until round " + I2S(PlayerDeathRound[playerId]) + COLOR_END_TAG, playerId)
                endif
            endif
        endif

        // Change the color of the player's name if they left the game
        if (PlayerLeftGame[playerId]) then
            set CurrentColumnIndex = PLAYER_NAME_INDEX
            call CreateText(LEAVER_COLOR + GetPlayerNameNoTag(GetPlayerName(currentPlayer)) + COLOR_END_TAG, playerId)
        endif

        // Don't try to update anything else if the player left the game or if the player died in rounds
        if (not PlayerLeftGame[playerId] and PlayerDeathRound[playerId] == 0) then
            // Update player ready status icon
            set CurrentColumnIndex = PLAYER_READY_STATUS_INDEX
            if (ps.isReady()) then
                if (CachedPlayerPlayerReadyStatus[playerId] != ps.isReady()) then
                    call CreateIcon(GetIconPath("ReadyNoText"), playerId)
                endif

                set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = PLAYER_READY_COLOR + "Player is ready" + COLOR_END_TAG
                set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = ""
            else
                if (CachedPlayerPlayerReadyStatus[playerId] != ps.isReady()) then
                    call CreateIcon(GetIconPath("NotReadyNoText"), playerId)
                endif

                set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = PLAYER_NOT_READY_COLOR + "Player is not ready" + COLOR_END_TAG
                set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = ""
            endif

            set CachedPlayerPlayerReadyStatus[playerId] = ps.isReady()

            // Update the flashy ready status for the player
            call BlzFrameSetVisible(CachedPlayerIndicatorParentFramehandles[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX], PlayerIsAlwaysReady[playerId])

            if (PlayerIsAlwaysReady[playerId]) then
                set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = PLAYER_ALWAYS_READY_COLOR + "Player is always ready" + COLOR_END_TAG
                set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = ""
            endif

            // Update the tooltip description information about the player's hero since it changes over time. We don't need to update the icon since that should never change
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = GetHeroTooltip(PlayerHeroes[playerId])

            // Update the tooltip description for the player stats. We don't need to update the icon since that should never change
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = PlayerStats.getTooltip(currentPlayer)

            // Update the player's hero level
            set CurrentColumnIndex = PLAYER_HERO_LEVEL_INDEX
            call CreateText(GetPlayerHeroLevelText(ps, playerId), playerId)

            // Set the PVP stats. We don't need to update the icon since that should never change
            set CurrentColumnIndex = PLAYER_DUELS_INDEX
            call CreateText(PVP_WINS_COLOR + I2S(ps.getDuelWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getDuelLosses()) + COLOR_END_TAG, playerId)

            // Update the tooltip description for the player element count. We don't need to update the icon since that should never change
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = GetElementCountTooltip(PlayerHeroes[playerId])

            // Set the player items
            set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
            call UpdatePlayerItems(currentPlayer)

            // Set the player abilities
            set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
            call UpdatePlayerAbilities(currentPlayer)
        else
            // Disable player ready status icon
            set CurrentColumnIndex = PLAYER_READY_STATUS_INDEX
            call CreateIcon(GetIconPath("NotReadyNoText"), playerId)

            set CachedPlayerPlayerReadyStatus[playerId] = false

            set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = INVALID_ACTION_COLOR + "Cannot ready up" + COLOR_END_TAG
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX] = INVALID_ACTION_COLOR + "Defeated players cannot ready up" + COLOR_END_TAG + ".|n"

            // Disable the flashy ready status for the player
            call BlzFrameSetVisible(CachedPlayerIndicatorParentFramehandles[(playerId * CACHING_BUFFER) + PLAYER_READY_STATUS_INDEX], false)
        endif

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set currentPlayer = null
    endfunction

    private function UpdateDynamicPlayersValues takes nothing returns nothing
        // Start at the first player row index
        set CurrentRowIndex = 1

        call ForForce(ScoreboardForce, function UpdateDynamicPlayerValues)
    endfunction

    private function InitializePlayerHero takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer)]

        if (playerHero != null) then
            // Set the player hero icon
            set CurrentColumnIndex = PLAYER_HERO_INDEX
            call CreateIcon(BlzGetAbilityIcon(GetUnitTypeId(playerHero)), playerId)
            set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = PLAYER_HERO_NAME_COLOR + GetObjectName(GetUnitTypeId(playerHero)) + COLOR_END_TAG
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = GetHeroTooltip(playerHero)

            // Element icon
            set CurrentColumnIndex = PLAYER_ELEMENT_COUNT_INDEX
            call CreateIcon("ReplaceableTextures\\CommandButtons\\BTNElements.blp", playerId)
            set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = PLAYER_ELEMENT_COUNT_COLOR + "Element Counts" + COLOR_END_TAG
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = GetElementCountTooltip(playerHero)
        endif

        // Set the player items
        set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
        call UpdatePlayerItems(currentPlayer)

        // Set the player abilities
        set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
        call UpdatePlayerAbilities(currentPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function UpdateBrTimes takes nothing returns nothing
        local string brTimes
        local integer sec
        local integer min
        
        if (BattleRoyaleEndTime == 0) then
            // Ongoing Game time
            set sec = ModuloInteger(T32_Tick, 1920)
            set min = ((T32_Tick - sec) / 1920)
            set brTimes = "|cffff49d1Game Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"

            if (BattleRoyaleStartTime > 0) then
                // Ongoing BR time
                set sec = ModuloInteger(T32_Tick - BattleRoyaleStartTime, 1920)
                set min = ((T32_Tick - BattleRoyaleStartTime - sec) / 1920)
                set brTimes = brTimes + "|n|cff00ffffBr Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"
            endif
        else
            // Ending Game time
            set sec = ModuloInteger(BattleRoyaleEndTime, 1920)
            set min = ((BattleRoyaleEndTime - sec) / 1920)
            set brTimes = "|cffff49d1Game Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"

            // Ending BR time
            set sec = ModuloInteger(BattleRoyaleEndTime - BattleRoyaleStartTime, 1920)
            set min = ((BattleRoyaleEndTime - BattleRoyaleStartTime - sec) / 1920)
            set brTimes = "|n|cff00ffffBr Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"
        endif

        if (FunBattleRoyaleStartTime != 0) then
            if (FunBattleRoyaleEndTime == 0) then
                // Ongoing Fun BR time
                set sec = ModuloInteger(T32_Tick - FunBattleRoyaleStartTime, 1920)
                set min = ((T32_Tick - FunBattleRoyaleStartTime - sec) / 1920)
                set brTimes = brTimes + "|n|cff00ff62Fun Br Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"
            else
                // Ending Fun BR time
                set sec = ModuloInteger(FunBattleRoyaleEndTime - FunBattleRoyaleStartTime, 1920)
                set min = ((FunBattleRoyaleEndTime - FunBattleRoyaleStartTime - sec) / 1920)
                set brTimes = brTimes + "|n|cff00ff62Fun Br Duration:|r|n|ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r|n"
            endif
        endif

        call BlzFrameSetVisible(ScoreboardBrTimesFrameHandle, true) 
        call BlzFrameSetSize(ScoreboardBrTimesFrameHandle, 0.17, GetTooltipSize(brTimes))
        call BlzFrameSetText(ScoreboardBrTimesTextFrameHandle, brTimes) 
        call BlzFrameSetAllPoints(ScoreboardBrTimesTextFrameHandle, ScoreboardBrTimesFrameHandle)
    endfunction

    function StartScoreboardUpdate takes nothing returns nothing
        // Need to update the scoreboard game mode description since it didn't exist when the frames were created
        call BlzFrameSetSize(ScoreboardGameDescriptionFrameHandle, 0.17, GetTooltipSize(ScoreboardGameDescription))
        call BlzFrameSetText(ScoreboardGameDescriptionTextFrameHandle, ScoreboardGameDescription) 
        call BlzFrameSetAllPoints(ScoreboardGameDescriptionTextFrameHandle, ScoreboardGameDescriptionFrameHandle)

        call BlzFrameSetAbsPoint(ScoreboardBrTimesFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + (2 * MAIN_FRAME_X_MARGIN) + PLAYER_NAME_WIDTH + PLAYER_DUELS_WIDTH + (16 * ICON_WIDTH) + (5 * ICON_SPACING) + (9 * ABILITY_ICON_SPACING), MAIN_FRAME_TOP_LEFT_Y - 0.04 - BlzFrameGetHeight(ScoreboardGameDescriptionFrameHandle)) // Move it under the game description

        // Start at the first player row index
        set CurrentRowIndex = 1

        call ForForce(ScoreboardForce, function InitializePlayerHero)

        // Timer to refresh the scoreboard at an interval
        call TimerStart(CreateTimer(), SCOREBOARD_UPDATE_INTERVAL, true, function UpdateDynamicPlayersValues)
        call TimerStart(CreateTimer(), .1, true, function UpdateBrTimes)
    endfunction

    private function InitializeScoreboard takes nothing returns nothing
        set IconEventHandles = InitHashtable()

        set ScoreboardTitle = "|cff2ff1ffCustom Hero Survival - |r|cffadff2f" + CurrentGameVersion.getVersionString() + "|r"

        // All buttons use the same trigger. However everything has a unique id to handle later on
        set IconEventTrigger = CreateTrigger()
        call TriggerAddAction(IconEventTrigger, function ScoreboardMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set ScoreboardFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetLevel(ScoreboardFrameHandle, 1)
        call BlzFrameSetVisible(ScoreboardFrameHandle, false) 

        // Create the primary tooltip window
        set ScoreboardTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set ScoreboardTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set ScoreboardTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(ScoreboardTooltipFrame, 2) // To have it appear above the scoreboard
        call BlzFrameSetVisible(ScoreboardTooltipFrame, false) 

        call InitializeDefaultValues()
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 4, false, function InitializeScoreboard)
    endfunction

endlibrary
