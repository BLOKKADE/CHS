library Scoreboard requires PlayerTracking, HeroAbilityTable, IconFrames, SelectedUnits

    globals
        // Scoreboard static titles
        private constant string CREDITS                                 = "Developed by |cffff0000BLOKKADE|r, Snowww, |cffae4affA Black Death|r, and |cff57f4ffKomoset|r"
        private string ScoreboardTitle

        // How often the scoreboard is updated
        private constant real SCOREBOARD_UPDATE_INTERVAL                = 2.0

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.14
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.56
        private constant real MAIN_FRAME_X_MARGIN                       = 0.03
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.027
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.025
        private constant real TITLE_HEIGHT                              = 0.03
        private constant real CREDITS_HEIGHT                            = 0.008

        // Specifications for a button
        private constant real ICON_WIDTH                                = 0.016
        private constant real ICON_SPACING                              = 0.003
        private constant real ROW_SPACING                               = 0.01

        // Column indexes
        private constant integer PLAYER_STATS_INDEX                     = 0
        private constant integer PLAYER_HERO_INDEX                      = 1
        private constant integer PLAYER_ELEMENT_COUNT_INDEX             = 2
        private constant integer PLAYER_NAME_INDEX                      = 3
        private constant integer PLAYER_DUELS_INDEX                     = 4
        private constant integer PLAYER_ITEMS_START_INDEX               = 5
        private constant integer PLAYER_ABILITIES_START_INDEX           = 11

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.012
        private constant real TEXT_WIDTH                                = 0.2

        // Column widths
        private constant real PLAYER_NAME_WIDTH                         = 0.12
        private constant real PLAYER_DUELS_WIDTH                        = 0.043

        // Colors
        private constant string COLOR_END_TAG                           = "|r"
        private constant string HEADER_COLOR                            = "|cff00ffff"
        private constant string PVP_LOSSES_COLOR                        = "|cffdd2c00"
        private constant string PVP_WINS_COLOR                          = "|cffbfff81"
        private constant string LEAVER_COLOR                            = "|cff404040"	
        private constant string SLASH 			 	                    = "|cff4a4a4a/|r"

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
        private framehandle ScoreboardTooltipFrame
		private framehandle ScoreboardTooltipTitleFrame
		private framehandle ScoreboardTooltipTextFrame

        // Keep track of what is currently in the scoreboard to be smarter about what needs to be updated/removed to improve performance. Is also a separation of concerns from the PlayerHeroes array and if the hero gets removed for whatever reason.
        // NOTE: CachedPlayerItems and CachedPlayerAbilities could be merged into a single array, but I thought it would be simpler if they are separate
        private constant integer CACHING_BUFFER = 50 // Used as a separator in the caching arrays so we can use a single array for all players. This value just needs to be bigger than the amount of columns in the scoreboard
        private integer array CachedPlayerItems // Item ids for each player hero
        private integer array CachedPlayerAbilities // Ability ids for each player hero
        private string array CachedPlayerStrings // Strings for each player column. NOTE: Not the most useful caching, but it could help with performance to not have to update a framehandle
        private string array CachedPlayerTooltipNames // Tooltip names
        private string array CachedPlayerTooltipDescriptions // Tooltip descriptions

        // Framehandles for all columns for each player to easily be referenced to update them
        private framehandle array CachedPlayerFramehandles
        private framehandle array CachedPlayerParentFramehandles

        // Keep track if a player has left the game
        private boolean array PlayerLeftGame
    endglobals

    function UpdateScoreboardPlayerLeaves takes player currentPlayer returns nothing
        // Mark the player left the game. Will be reflected in the update interval
        set PlayerLeftGame[GetPlayerId(currentPlayer)] = true
    endfunction

    private function GetTopLeftX takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN
        local real offset

        // Don't move the x-coordinate any more for PLAYER_STATS_INDEX

        // Player hero and element count
        if (CurrentColumnIndex >= PLAYER_HERO_INDEX) then
            set value = value + ICON_WIDTH + ICON_SPACING
        endif

        // Player name
        if (CurrentColumnIndex >= PLAYER_NAME_INDEX) then
            set value = value + ICON_WIDTH + ICON_SPACING
        endif

        // PLayer duels
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
            set value = value + offset + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ICON_WIDTH) + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ICON_SPACING)
        endif

        // Bottom 10 row absolutes
        if (CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set offset = PLAYER_DUELS_WIDTH + (ICON_WIDTH * 4) + (ICON_SPACING * 2) // Item and buffer offset
            set value = value + offset + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ICON_WIDTH) + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ICON_SPACING)
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

        // Top row player stats icon, player hero icon, item icons, or ability icons
        if (CurrentColumnIndex == PLAYER_STATS_INDEX or CurrentColumnIndex == PLAYER_HERO_INDEX or CurrentColumnIndex >= PLAYER_ITEMS_START_INDEX and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 2) or CurrentColumnIndex >= PLAYER_ABILITIES_START_INDEX and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 9)) then
            set value = value + offset
        endif

        // Bottom row player element count icon, item icons, or ability icons
        if (CurrentColumnIndex == PLAYER_ELEMENT_COUNT_INDEX or CurrentColumnIndex >= (PLAYER_ITEMS_START_INDEX + 3) and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 5) or CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set value = value - offset
        endif

        return value
    endfunction

    private function CreateIcon takes string iconPath, integer playerId returns nothing
        local framehandle buttonFrameHandle
        local framehandle buttonBackdropFrameHandle
        local integer buttonHandleId
        local integer backdropHandleId

        // Only create the new frame if it doesn't exist. Otherwise reuse the existing frame for performance reasons
        if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] == null) then
            call BJDebugMsg("Creating icon frame")

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

            call BJDebugMsg("Created icon frame")

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

        // NOTE: I didn't add functionality to remove text since we currently don't need it. If we do, look at CreateIcon above

        // Only create the new frame if it doesn't exist. Otherwise reuse the existing frame for performance reasons
        if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] == null) then
            call BJDebugMsg("Creating text frame")

            set playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 
            set CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = playerNameTextFrameHandle

            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY() - 0.003)
            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TEXT_WIDTH, GetTopLeftY() - TEXT_HEIGHT - 0.005) 
            call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
            call BlzFrameSetScale(playerNameTextFrameHandle, 1.2) 
            call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

            call BJDebugMsg("Created text frame")
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
        local unit playerHero = PlayerHeroes[playerId + 1]
        local item currentItem
        local integer currentItemTypeId

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

        // Cleanup
        set playerHero = null
        set currentItem = null
    endfunction

    private function UpdatePlayerAbilities takes player currentPlayer returns nothing
        local integer abilityIndex = 1
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local integer currentAbility

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

                // Cache the tooltip information about the ability. Need to always recalculate since abilities show element counts
                set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = BlzGetAbilityTooltip(currentAbility, GetUnitAbilityLevel(playerHero, currentAbility) - 1) // What is the -1 for?
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

            set CurrentColumnIndex = CurrentColumnIndex + 1
            set abilityIndex = abilityIndex + 1
        endloop

        // Cleanup
        set playerHero = null
    endfunction

    private function AddPlayerToScoreboard takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[GetPlayerId(currentPlayer) + 1]

        // This function was called when it was not supposed to. Should only be called when all heroes are selected
        if (playerHero == null) then
            // Cleanup
            set currentPlayer = null
            set playerHero = null

            return
        endif

        set CurrentColumnIndex = 0
        
        // Player stats icon
        set CurrentColumnIndex = PLAYER_STATS_INDEX
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp", playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = "|cffd0ff00Stats for: |r" + GetPlayerNameColour(currentPlayer)
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = PlayerStats.getTooltip(currentPlayer)

        // Set the player hero icon
        set CurrentColumnIndex = PLAYER_HERO_INDEX
        call CreateIcon(BlzGetAbilityIcon(GetUnitTypeId(playerHero)), playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = "|cffffa8a8" + GetObjectName(GetUnitTypeId(playerHero)) + COLOR_END_TAG
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = GetHeroTooltip(playerHero)

        // Element icons
        set CurrentColumnIndex = PLAYER_ELEMENT_COUNT_INDEX
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASElements.blp", playerId)
        set CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = "|cffd0ff00Element Counts|r"
        set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = GetElementCountTooltip(playerHero)

        // Set the player name
        set CurrentColumnIndex = PLAYER_NAME_INDEX
        call CreateText(GetPlayerNameColour(currentPlayer), playerId)

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

            // Toggle selected player's hero if it exists and is alive
            if (columnIndex == PLAYER_HERO_INDEX and (not PlayerLeftGame[playerId]) and PlayerHeroes[playerId + 1] != null and UnitAlive(PlayerHeroes[playerId + 1])) then
                call SelectUnitForPlayerSingle(PlayerHeroes[playerId + 1], triggerPlayer)
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            // Retrieve the cached information
            set tooltipName = CachedPlayerTooltipNames[(playerId * CACHING_BUFFER) + columnIndex]
            set tooltipDescription = CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + columnIndex]

            // Player hero icon - Add error message if player isn't in game or hero is invalid
            if (columnIndex == PLAYER_HERO_INDEX) then
                if (PlayerLeftGame[playerId] or PlayerHeroes[playerId + 1] == null or (not UnitAlive(PlayerHeroes[playerId + 1]))) then
                    set tooltipName = tooltipName + " - |cffff0000Cannot select hero!|r"
                else
                    set tooltipName = tooltipName + " - |cffff0000Click for more details!|r"
                endif

            // Element count - Change the width of the tooltip
            elseif (columnIndex == PLAYER_ELEMENT_COUNT_INDEX) then
                set tooltipWidth = 0.125
            endif

            // Show the tooltip information if valid
            if (tooltipName != "" and tooltipDescription != "") then
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

        // This will only have players that have selected a hero. Anyone that quits before hero selection won't be here.
        set ScoreboardForce = GetValidPlayerForce()

        call CreateHeaderRow()

        // Populate the rows with actual player data
        call ForForce(ScoreboardForce, function AddPlayerToScoreboard)

        // Compute the main scoreboard box
        // Width - Main frame margins, all icon widths, all icon spacings
        set mainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + (2 * MAIN_FRAME_X_MARGIN) + PLAYER_NAME_WIDTH + PLAYER_DUELS_WIDTH + (16 * ICON_WIDTH) + (14 * ICON_SPACING)
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

        // Cleanup
        set titleFrameHandle = null
        set creditsTextFrameHandle = null
    endfunction
    
    private function UpdateDynamicPlayerValues takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)

        // Change the color of the player's name if they left the game
        if (PlayerLeftGame[playerId]) then
            set CurrentColumnIndex = PLAYER_NAME_INDEX
            call CreateText(LEAVER_COLOR + GetPlayerNameNoTag(GetPlayerName(currentPlayer)) + COLOR_END_TAG, playerId)

        // Don't try to update anything else if the player left the game or if the player died in rounds
        elseif (not IsPlayerInForce(currentPlayer, DefeatedPlayers)) then
            // Update the tooltip description information about the player's hero since it changes over time. We don't need to update the icon since that should never change
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_HERO_INDEX] = GetHeroTooltip(PlayerHeroes[playerId + 1])

            // Update the tooltip description for the player stats
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_STATS_INDEX] = PlayerStats.getTooltip(currentPlayer)

            // Set the PVP stats
            set CurrentColumnIndex = PLAYER_DUELS_INDEX
            call CreateText(PVP_WINS_COLOR + I2S(ps.getPVPWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getPVPLosses()) + COLOR_END_TAG, playerId)

            // Update the tooltip description for the player element count
            set CachedPlayerTooltipDescriptions[(playerId * CACHING_BUFFER) + PLAYER_ELEMENT_COUNT_INDEX] = GetElementCountTooltip(PlayerHeroes[playerId + 1])

            // Set the player items
            set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
            call UpdatePlayerItems(currentPlayer)

            // Set the player abilities
            set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
            call UpdatePlayerAbilities(currentPlayer)
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

    function InitializeScoreboard takes nothing returns nothing
        set IconEventHandles = InitHashtable()

        set ScoreboardTitle = "|cff2ff1ffCustom Hero Survival - |r |cffadff2f" + CurrentGameVersion.getVersionString() + "|r"

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

        // Timer to refresh the scoreboard at an interval
        call TimerStart(CreateTimer(), SCOREBOARD_UPDATE_INTERVAL, true, function UpdateDynamicPlayersValues)
    endfunction

endlibrary
