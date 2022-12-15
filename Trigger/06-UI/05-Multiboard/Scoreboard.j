library Scoreboard requires PlayerTracking, HeroAbilityTable, IconFrames

    globals
        private string INITIAL_BOARD_NAME // Not using currently, but could show somewhere in the scoreboard
        private real SCOREBOARD_UPDATE_INTERVAL                         = 2.

        // The X,Y coordinate for the top left of the main frame
        private constant real MainFrameTopLeftX                         = 0.1
        private constant real MainFrameTopLeftY                         = 0.56
        private constant real MainFrameXMargin                          = 0.03
        private constant real MainFrameYMargin                          = 0.025

        // Specifications for a button
        private constant real ButtonWidth                               = 0.016
        private constant real ButtonSpacing                             = 0.003
        private constant real HeroIconSpacing                           = 0.003
        private constant real RowSpacing                                = 0.01

        // Column indexes
        private constant integer HERO_INDEX                             = 0
        private constant integer PLAYER_STATS_INDEX                     = 1
        private constant integer PLAYER_NAME_INDEX                      = 2
        private constant integer DUELS_INDEX                            = 3
        private constant integer ELEMENT_COUNT_INDEX                    = 4
        private constant integer PLAYER_ITEMS_START_INDEX               = 5
        private constant integer PLAYER_ABILITIES_START_INDEX           = 11

        // Specifications for a player name text
        private real TextHeight                                         = 0.012
        private real TextWidth                                          = 0.2

        // Column widths
        private constant real HeroIconWidth                             = 0.016
        private constant real PlayerNameWidth                           = 0.2
        private constant real DuelsWidth                                = 0.07

        // Tooltip information
        private framehandle ScoreboardTooltipFrame
		private framehandle ScoreboardTooltipTitleFrame
		private framehandle ScoreboardTooltipTextFrame

        private framehandle ScoreboardSecondaryTooltipFrame
		private framehandle ScoreboardSecondaryTooltipTitleFrame
		private framehandle ScoreboardSecondaryTooltipTextFrame

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
        private hashtable IconEventHandles

        // Keep track of what is currently in the scoreboard to be smarter about what needs to be updated/removed to improve performance
        // NOTE: CachedPlayerItems and CachedPlayerAbilities could be merged into a single array, but I thought it would be simpler if they are separate
        private constant integer CACHING_BUFFER = 50 // Used as a separator in the caching arrays so we can use a single array for all players. This value just needs to be bigger than the amount of columns in the scoreboard
        private integer array CachedPlayerItems
        private integer array CachedPlayerAbilities
        private string array CachedPlayerStrings
        private framehandle array CachedPlayerFramehandles
        private framehandle array CachedPlayerParentFramehandles
        private boolean array PlayerLeftGame
    endglobals

    function UpdateMultiboardPlayerLeaves takes player currentPlayer returns nothing
        // Mark the player left the game. Will be reflected in the update interval
        set PlayerLeftGame[GetPlayerId(currentPlayer)] = true
    endfunction

    private function ValidPlayerFilter takes nothing returns boolean
        return GetPlayerId(GetFilterPlayer()) < 8
    endfunction

    private function GetTopLeftX takes nothing returns real
        local real value = MainFrameTopLeftX + MainFrameXMargin
        local real offset

        // Don't move the x-coordinate any more for HERO_INDEX or PLAYER_STATS_INDEX

        // Player name
        if (CurrentColumnIndex >= PLAYER_NAME_INDEX) then
            set value = value + HeroIconWidth + HeroIconSpacing
        endif

        // Duels
        if (CurrentColumnIndex >= DUELS_INDEX) then
            set value = value + PlayerNameWidth
        endif

        // Element Counts
        if (CurrentColumnIndex >= ELEMENT_COUNT_INDEX) then
            set value = value + DuelsWidth
        endif

        // Top 3 row items
        if (CurrentColumnIndex >= PLAYER_ITEMS_START_INDEX and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 2)) then
            set offset = ButtonWidth + ButtonSpacing // Element count offset
            set value = value + offset + ((CurrentColumnIndex - PLAYER_ITEMS_START_INDEX) * ButtonWidth) + ((CurrentColumnIndex - PLAYER_ITEMS_START_INDEX) * ButtonSpacing)
        endif

        // Bottom 3 row items
        if (CurrentColumnIndex >= (PLAYER_ITEMS_START_INDEX + 3) and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 5)) then
            set offset = ButtonWidth + ButtonSpacing // Element count offset
            set value = value + offset + ((CurrentColumnIndex - (PLAYER_ITEMS_START_INDEX + 3)) * ButtonWidth) + ((CurrentColumnIndex - (PLAYER_ITEMS_START_INDEX + 3)) * ButtonSpacing)
        endif

        // Top 10 row abilities
        if (CurrentColumnIndex >= PLAYER_ABILITIES_START_INDEX and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 9)) then
            set offset = ButtonWidth + ButtonSpacing + (ButtonWidth * 4) + (ButtonSpacing * 2) // Item and buffer offset
            set value = value + offset + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ButtonWidth) + ((CurrentColumnIndex - PLAYER_ABILITIES_START_INDEX) * ButtonSpacing)
        endif

        // Bottom 10 row absolutes
        if (CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set offset = ButtonWidth + ButtonSpacing + (ButtonWidth * 4) + (ButtonSpacing * 2) // Item and buffer offset
            set value = value + offset + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ButtonWidth) + ((CurrentColumnIndex - (PLAYER_ABILITIES_START_INDEX + 10)) * ButtonSpacing)
        endif

        return value
    endfunction

    private function GetTopLeftY takes nothing returns real
        local real value = MainFrameTopLeftY - MainFrameYMargin - (2 * ButtonWidth * CurrentRowIndex) - (RowSpacing * CurrentRowIndex) + TextHeight
        local real offset = ((ButtonWidth / 2) + (ButtonSpacing / 2))

        // Header row
        if (CurrentRowIndex == 0) then
            return MainFrameTopLeftY - MainFrameYMargin
        endif

        // Top row items or Top row abilities
        if (CurrentColumnIndex == HERO_INDEX or CurrentColumnIndex >= PLAYER_ITEMS_START_INDEX and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 2) or CurrentColumnIndex >= PLAYER_ABILITIES_START_INDEX and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 9)) then
            set value = value + offset
        endif

        // Bottom row items or Bottom row absolutes
        if (CurrentColumnIndex == PLAYER_STATS_INDEX or CurrentColumnIndex >= (PLAYER_ITEMS_START_INDEX + 3) and CurrentColumnIndex <= (PLAYER_ITEMS_START_INDEX + 5) or CurrentColumnIndex >= (PLAYER_ABILITIES_START_INDEX + 10) and CurrentColumnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
            set value = value - offset
        endif

        return value
    endfunction

    private function CreateIcon takes string iconPath, integer playerId returns nothing
        local framehandle buttonFrameHandle
        local framehandle buttonBackdropFrameHandle
        local integer buttonHandleId
        local integer backdropHandleId

        // Hide the icon if the path is null
        if (iconPath == null) then
            // Make sure it exists before trying to do anything with it
            if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] != null) then
                call BlzFrameSetVisible(CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex], false)
            endif

            set CurrentColumnIndex = CurrentColumnIndex + 1

            return
        endif

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
            call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ButtonWidth, GetTopLeftY() - ButtonWidth) 

            // Save the handle of this button to look it up later for mouse events
            call SaveInteger(IconEventHandles, buttonHandleId, 1, playerId)
            call SaveInteger(IconEventHandles, buttonHandleId, 2, CurrentColumnIndex)

            // Register with the single trigger about hovering over the icon
            call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
            call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        else
            // Retrieve the cached framehandle
            set buttonFrameHandle = CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
            set buttonBackdropFrameHandle = CachedPlayerFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex]
        endif

        // Apply the icon
        call BlzFrameSetVisible(buttonFrameHandle, true)
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        
        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateText takes string value, integer playerId returns nothing
        local framehandle playerNameTextFrameHandle

        // NOTE: I didn't add functionality to remove text since we currently don't need it. If we do, look at CreateIcon above

        // Only create the new frame if it doesn't exist. Otherwise reuse the existing frame for performance reasons
        if (CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] == null) then
            set playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 
            set CachedPlayerParentFramehandles[(playerId * CACHING_BUFFER) + CurrentColumnIndex] = playerNameTextFrameHandle

            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY() - 0.003)
            call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TextWidth, GetTopLeftY() - TextHeight - 0.004) 
            call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
            call BlzFrameSetScale(playerNameTextFrameHandle, 1.6) 
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

        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    private function UpdatePlayerItems takes player currentPlayer returns nothing
        local integer itemSlotIndex = 0
        local integer playerId = GetPlayerId(currentPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local item currentItem

        loop
            exitwhen itemSlotIndex > 5

            set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

            if (currentItem != null) then
                // Only update the data if it changed
                if (CachedPlayerItems[(playerId * 6) + itemSlotIndex] != GetItemTypeId(currentItem)) then
                    set CachedPlayerItems[(playerId * 6) + itemSlotIndex] = GetItemTypeId(currentItem)

                    // Display the icon
                    call CreateIcon(BlzGetItemIconPath(currentItem), playerId)
                else
                    // CreateIcon increments the column index, if we don't call it we need to increase it here
                    set CurrentColumnIndex = CurrentColumnIndex + 1
                endif
            else
                // Hide the icon if something was there
                if (CachedPlayerItems[(playerId * 6) + itemSlotIndex] != -1) then
                    call CreateIcon(null, playerId)
                else
                    // CreateIcon increments the column index, if we don't call it we need to increase it here
                    set CurrentColumnIndex = CurrentColumnIndex + 1
                endif

                set CachedPlayerItems[(playerId * 6) + itemSlotIndex] = -1
            endif

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
                if (CachedPlayerAbilities[(playerId * 20) + abilityIndex] != currentAbility) then
                    set CachedPlayerAbilities[(playerId * 20) + abilityIndex] = currentAbility

                    // Display the icon
                    call CreateIcon(BlzGetAbilityIcon(currentAbility), playerId)
                else
                    // CreateIcon increments the column index, if we don't call it we need to increase it here
                    set CurrentColumnIndex = CurrentColumnIndex + 1
                endif
            else
                // Hide the icon if something was there
                if (CachedPlayerAbilities[(playerId * 20) + abilityIndex] != -1) then
                    call CreateIcon(null, playerId)
                else
                    // CreateIcon increments the column index, if we don't call it we need to increase it here
                    set CurrentColumnIndex = CurrentColumnIndex + 1
                endif

                set CachedPlayerAbilities[(playerId * 20) + abilityIndex] = -1
            endif

            set abilityIndex = abilityIndex + 1
        endloop

        // Cleanup
        set playerHero = null
    endfunction

    private function AddPlayerToMultiboard takes nothing returns nothing
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
        
        // Set the player hero icon
        call CreateIcon(BlzGetAbilityIcon(GetUnitTypeId(playerHero)), playerId)

        // Player stats icon
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp", playerId)

        // Set the player name
        call CreateText(GetPlayerNameColour(currentPlayer), playerId)

        // Set the PVP stats
        call CreateText(PVP_WINS_COLOR + "0" + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + "0" + COLOR_END_TAG, playerId)

        // Element icons
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASElements.blp", playerId)

        // Set the player items
        call UpdatePlayerItems(currentPlayer)

        // Set the player abilities
        call UpdatePlayerAbilities(currentPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set currentPlayer = null
        set playerHero = null
    endfunction

    private function ScoreboardMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local integer handleId = GetHandleId(currentFrameHandle)
        local integer playerId = LoadInteger(IconEventHandles, handleId, 1)
        local player currentPlayer = Player(playerId)
        local integer columnIndex = LoadInteger(IconEventHandles, handleId, 2)
        local boolean usePrimaryTooltipFrame = true
        local real tooltipWidth = 0.29 // Default used by almost everything
        local string tooltipDescription
        local string tooltipName
        local unit playerHero
        local item currentItem
        local integer currentAbility
        local integer currentAbilityIndex
        local boolean showAchievements
        local PlayerStats ps

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            if GetLocalPlayer() == GetTriggerPlayer() then
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

            // Toggle player stats
            if (columnIndex == PLAYER_STATS_INDEX) then
                set ps = PlayerStats.forPlayer(currentPlayer)
                set showAchievements = ps.toggleHasAchievementsOpen()
    
                call AchievementsFrame_UpdateAchievementFrameIcons(currentPlayer)
    
                if (GetLocalPlayer() == currentPlayer) then
                    call BlzFrameSetVisible(MainAchievementFrameHandle, showAchievements)
                endif
            endif

        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            // Player hero
            if (columnIndex == HERO_INDEX) then
                set playerHero = PlayerHeroes[playerId + 1]

                set tooltipName = "|cffffa8a8" + GetObjectName(GetUnitTypeId(playerHero)) + COLOR_END_TAG
                set tooltipDescription = GetHeroTooltip(playerHero)

                set usePrimaryTooltipFrame = false

            // Player stats
            elseif (columnIndex == PLAYER_STATS_INDEX) then
                set tooltipName = "|cffd0ff00Stats for: |r" + GetPlayerNameColour(currentPlayer)
                set tooltipDescription = PlayerStats.getTooltip(currentPlayer)
                            
                set usePrimaryTooltipFrame = false

            // Element count
            elseif (columnIndex == ELEMENT_COUNT_INDEX) then
                set playerHero = PlayerHeroes[playerId + 1]
                
                set tooltipName = "|cffd0ff00Element Counts|r"
                set tooltipDescription = GetElementCountTooltip(playerHero)
                set tooltipWidth = 0.125

            // Item descriptions
            elseif (columnIndex >= PLAYER_ITEMS_START_INDEX and columnIndex <= (PLAYER_ITEMS_START_INDEX + 5)) then
                set playerHero = PlayerHeroes[playerId + 1]
                set currentItem = UnitItemInSlot(playerHero, columnIndex - PLAYER_ITEMS_START_INDEX)

                if (currentItem != null) then
                    set tooltipName = GetItemName(currentItem)
                    set tooltipDescription = BlzGetItemExtendedTooltip(currentItem)
                else
                    // Should hopefully never happen?
                    set tooltipName = ""
                    set tooltipDescription = ""
                endif

            // Ability/absolute descriptions
            elseif (columnIndex >= PLAYER_ABILITIES_START_INDEX and columnIndex <= (PLAYER_ABILITIES_START_INDEX + 19)) then
                set playerHero = PlayerHeroes[playerId + 1]
                set currentAbilityIndex = columnIndex - PLAYER_ABILITIES_START_INDEX + 1 // Abilities are base 1 indexed
                set currentAbility = GetHeroSpellAtPosition(playerHero, currentAbilityIndex)

                if (currentAbility != 0) then
                    set tooltipName = BlzGetAbilityTooltip(currentAbility, GetUnitAbilityLevel(playerHero, currentAbilityIndex) - 1)
                    set tooltipDescription = GetAbilityElementCountTooltip(playerHero, currentAbilityIndex)
                else
                    // Should hopefully never happen?
                    set tooltipName = ""
                    set tooltipDescription = ""
                endif
            endif

            if GetLocalPlayer() == GetTriggerPlayer() then
                if (tooltipDescription != "") then
                    if (usePrimaryTooltipFrame) then
                        call BlzFrameSetText(ScoreboardTooltipTitleFrame, tooltipName)
                        call BlzFrameSetText(ScoreboardTooltipTextFrame, tooltipDescription)
                        call BlzFrameSetPoint(ScoreboardTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_TOP, 0, -0.052)
                        call BlzFrameSetSize(ScoreboardTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                        call BlzFrameSetVisible(ScoreboardTooltipFrame, true)
                    else
                        call BlzFrameSetText(ScoreboardSecondaryTooltipTitleFrame, tooltipName)
                        call BlzFrameSetText(ScoreboardSecondaryTooltipTextFrame, tooltipDescription)
                        call BlzFrameSetPoint(ScoreboardSecondaryTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_TOP, 0, -0.052)
                        call BlzFrameSetSize(ScoreboardSecondaryTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                        call BlzFrameSetVisible(ScoreboardSecondaryTooltipFrame, true)
                    endif
                endif
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
            // Empty the text box
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(ScoreboardTooltipTitleFrame, "")
                call BlzFrameSetText(ScoreboardTooltipTextFrame, "")
                call BlzFrameSetText(ScoreboardSecondaryTooltipTitleFrame, "")
                call BlzFrameSetText(ScoreboardSecondaryTooltipTextFrame, "")
                call BlzFrameSetVisible(ScoreboardTooltipFrame, false)
                call BlzFrameSetVisible(ScoreboardSecondaryTooltipFrame, false)
            endif
        endif

        // Cleanup
        set currentFrameHandle = null
        set playerHero = null
        set currentPlayer = null
        set currentItem = null
    endfunction

    private function CreateHeaderRow takes nothing returns nothing
        set CurrentRowIndex = 0

        // Need a player id to save text, but since this is for the header values it doesn't matter what it is (As long as it is not an actual player id)
        set CurrentColumnIndex = PLAYER_NAME_INDEX
        call CreateText(HEADER_COLOR + "Player" + COLOR_END_TAG, 25) 
        set CurrentColumnIndex = DUELS_INDEX
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

        set ScoreboardForce = GetPlayersMatching(Condition(function ValidPlayerFilter))

        call CreateHeaderRow()

        // Populate the rows with actual player data
        call ForForce(ScoreboardForce, function AddPlayerToMultiboard)

        // Compute the main voting box based on how many buttons there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameXMargin) + HeroIconWidth + HeroIconSpacing + PlayerNameWidth + DuelsWidth + (15 * ButtonWidth) + (12 * ButtonSpacing)
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameYMargin) - ((CurrentRowIndex - 1) * ButtonWidth * 2) - ((CurrentRowIndex - 1) * ButtonSpacing) - ((CurrentRowIndex - 1) * RowSpacing) - TextHeight

        // Set the frame for the backdrop of the entire scoreboard
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 
    endfunction
    
    private function UpdateDynamicPlayerValues takes nothing returns nothing
        local player currentPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(currentPlayer)
        local PlayerStats ps = PlayerStats.forPlayer(currentPlayer)
        local string duelStats = PVP_WINS_COLOR + I2S(ps.getPVPWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getPVPLosses()) + COLOR_END_TAG

        // NOTE: We only need to update player name, duels, items, and abilities since other data is static and changes when you hover over it

        // Change the color of the player's name if they left the game
        if (PlayerLeftGame[playerId]) then
            set CurrentColumnIndex = PLAYER_NAME_INDEX
            call CreateText(LEAVER_COLOR + GetPlayerNameNoTag(GetPlayerName(currentPlayer)) + COLOR_END_TAG, playerId)
        endif

        // Set the PVP stats
        set CurrentColumnIndex = DUELS_INDEX
        call CreateText(duelStats, playerId)

        // Set the player items
        set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
        call UpdatePlayerItems(currentPlayer)

        // Set the player abilities
        set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
        call UpdatePlayerAbilities(currentPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set currentPlayer = null
    endfunction

    private function UpdateDynamicPlayersValues takes nothing returns nothing
        // Start at the first player row index
        set CurrentRowIndex = 1

        call ForForce(ScoreboardForce, function UpdateDynamicPlayerValues)
    endfunction

    function InitializeMultiboard takes nothing returns nothing
        set INITIAL_BOARD_NAME = "|cff2ff1ffCustom Hero Survival - |r |cffadff2f" + GetMapVersionName(CURRENT_GAME_VERSION) + "|r"

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

        // Create the secondary tooltip window
        set ScoreboardSecondaryTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set ScoreboardSecondaryTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set ScoreboardSecondaryTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(ScoreboardSecondaryTooltipFrame, 2) // To have it appear above the scoreboard
        call BlzFrameSetVisible(ScoreboardSecondaryTooltipFrame, false) 

        set IconEventHandles = InitHashtable()

        call InitializeDefaultValues()

        // Timer to refresh the scoreboard at an interval
        call TimerStart(CreateTimer(), SCOREBOARD_UPDATE_INTERVAL, true, function UpdateDynamicPlayersValues)
    endfunction

endlibrary
