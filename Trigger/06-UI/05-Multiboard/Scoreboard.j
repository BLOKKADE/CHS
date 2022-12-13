library Scoreboard requires PlayerTracking, HeroAbilityTable, IconFrames

    globals
        private string INITIAL_BOARD_NAME

        // The X,Y coordinate for the top left of the main frame
        private constant real MainFrameTopLeftX              = 0.01
        private constant real MainFrameTopLeftY              = 0.55
        private constant real MainFrameXMargin               = 0.03
        private constant real MainFrameYMargin               = 0.025

        // Specifications for a button
        private constant real ButtonWidth                    = 0.023
        private constant real ButtonSpacing                  = 0.003
        private constant real HeroIconSpacing                = 0.003
        private constant real RowSpacing                     = 0.01

        // Column indexes
        private constant integer HERO_INDEX                  = 0
        private constant integer PLAYER_STATS_INDEX          = 1
        private constant integer PLAYER_NAME_INDEX           = 2
        private constant integer DUELS_INDEX                 = 3
        private constant integer ELEMENT_COUNT_INDEX         = 4
        private constant integer PLAYER_ITEMS_START_INDEX    = 5
        private constant integer PLAYER_ABILITIES_START_INDEX= 11

        // Specifications for a player name text
        private real TextHeight                              = 0.016
        private real TextWidth                               = 0.2

        // Column widths
        private constant real HeroIconWidth                  = 0.023
        private constant real PlayerNameWidth                = 0.2
        private constant real DuelsWidth                     = 0.07

        // Tooltip information
        private framehandle ScoreboardTooltipFrame
		private framehandle ScoreboardTooltipTitleFrame
		private framehandle ScoreboardTooltipTextFrame

        // Colors
        private constant string COLOR_END_TAG                = "|r"
        private constant string HEADER_COLOR                 = "|cff00ffff"
        private constant string PVP_LOSSES_COLOR             = "|cffdd2c00"
        private constant string PVP_WINS_COLOR               = "|cffbfff81"
        private constant string LEAVER_COLOR                 = "|cff404040"	
        private constant string SLASH 			 	         = "|cff4a4a4a/|r"

        // Specifications about the rows/columns
        private integer CurrentRowIndex                      = 0
        private integer CurrentColumnIndex                   = 0

        // Array to keep track of what player id belongs where on the multiboard. A fast lookup
        private integer array PlayerMultiboardLookup
        private integer GameMultiboardCurrentPlayerCount     = 0

        // The only trigger that handles hovering over scoreboard icons
        private trigger IconEventTrigger
        private hashtable IconEventHandles
    endglobals

    function UpdateMultiboardPVPCounts takes player playingPlayer returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(playingPlayer)
        local string duelStats = PVP_WINS_COLOR + I2S(ps.getPVPWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getPVPLosses()) + COLOR_END_TAG

        // Set the PVP stats
        //call SetColumnRowValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], DuelsWidth, duelStats)
    endfunction

    function UpdateMultiboardPlayerLeaves takes player playingPlayer returns nothing
        // Set the player name
       // call SetColumnRowValueAndColor(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], PlayerNameWidth, GetPlayerName(playingPlayer), LEAVER_COLOR)
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

    private function CreateIcon takes string iconPath, hashtable buttonEventHandles, integer playerId returns nothing
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", ScoreboardFrameHandle, 0, 0) 
        local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1)
        local integer buttonHandleId = GetHandleId(buttonFrameHandle)
        local integer backdropHandleId = GetHandleId(buttonBackdropFrameHandle)

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ButtonWidth, GetTopLeftY() - ButtonWidth) 

        // Apply the icon
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(buttonEventHandles, buttonHandleId, 1, playerId)
        call SaveInteger(buttonEventHandles, buttonHandleId, 2, CurrentColumnIndex)

        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        
        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateText takes string value returns nothing
        local framehandle playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "ScoreboardText", ScoreboardFrameHandle, "", 0) 

        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY() - 0.004)
        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TextWidth, GetTopLeftY() - TextHeight - 0.004) 
        call BlzFrameSetText(playerNameTextFrameHandle, value) 
        call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.8) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    function UpdatePlayerItems takes player playingPlayer returns nothing
        local integer itemSlotIndex = 0
        local integer playerId = GetPlayerId(playingPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local item currentItem

        loop
            exitwhen itemSlotIndex > 5

            set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

            if (currentItem != null) then
                // Display the icon
                call CreateIcon(BlzGetItemIconPath(currentItem), IconEventHandles, playerId)
            else
                // Display the icon

                call CreateIcon(BlzGetItemIconPath(CreateItem('I099', 0, 0)), IconEventHandles, playerId)
            endif

            set itemSlotIndex = itemSlotIndex + 1
        endloop

        // Cleanup
        set playerHero = null
        set currentItem = null
    endfunction

    function UpdatePlayerAbilities takes player playingPlayer returns nothing
        local integer abilityIndex = 1
        local integer playerId = GetPlayerId(playingPlayer)
        local unit playerHero = PlayerHeroes[playerId + 1]
        local integer currentAbility

        loop
            exitwhen abilityIndex > 20

            // Check if there is a valid ability in the next slot
            set currentAbility = GetHeroSpellAtPosition(playerHero, abilityIndex)

            if (currentAbility != 0) then
                // Display the icon
                call CreateIcon(BlzGetAbilityIcon(currentAbility), IconEventHandles, playerId)
            else
                call CreateIcon(BlzGetAbilityIcon('ANab'), IconEventHandles, playerId)
            endif

            set abilityIndex = abilityIndex + 1
        endloop

        // Cleanup
        set playerHero = null
    endfunction

    private function AddPlayerToMultiboard takes nothing returns nothing
        local player playingPlayer = GetEnumPlayer()
        local integer playerId = GetPlayerId(playingPlayer)
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]

        // This function was called when it was not supposed to. Should only be called when all heroes are selected
        if (playerHero == null) then
            // Cleanup
            set playingPlayer = null
            set playerHero = null

            return
        endif

        set CurrentColumnIndex = 0

        // Increment the amount of players that we have added to the multiboard to know how to save them for lookup in the future
        set GameMultiboardCurrentPlayerCount = GameMultiboardCurrentPlayerCount + 1

        // Save where this player is in the multiboard for lookup in the future
        set PlayerMultiboardLookup[GameMultiboardCurrentPlayerCount] = playerId
        
        // Set the player hero icon
        call CreateIcon(BlzGetAbilityIcon(GetUnitTypeId(playerHero)), IconEventHandles, playerId)

        // Player stats icon
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASSaveBook.blp", IconEventHandles, playerId)

        // Set the player name
        call CreateText(GetPlayerNameColour(playingPlayer))

        // Set the PVP stats
        call CreateText(PVP_WINS_COLOR + "0" + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + "0" + COLOR_END_TAG)

        // Element icons
        call CreateIcon("ReplaceableTextures\\PassiveButtons\\PASElements.blp", IconEventHandles, playerId)

        // Set the player items
        call UpdatePlayerItems(playingPlayer)

        // Set the player abilities
        call UpdatePlayerAbilities(playingPlayer)

        set CurrentRowIndex = CurrentRowIndex + 1

        // Cleanup
        set playingPlayer = null
        set playerHero = null
    endfunction

    private function ScoreboardMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local integer handleId = GetHandleId(currentFrameHandle)
        local integer playerId = LoadInteger(IconEventHandles, handleId, 1)
        local integer columnIndex = LoadInteger(IconEventHandles, handleId, 2)
        local framepointtype tooltipFramepoint = FRAMEPOINT_BOTTOMRIGHT
        local framepointtype tooltipRelativeFramepoint = FRAMEPOINT_BOTTOMRIGHT
        local string tooltipDescription
        local string tooltipName
        local unit playerHero
        local item currentItem
        local integer currentAbility
        local integer currentAbilityIndex

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            if GetLocalPlayer() == GetTriggerPlayer() then
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            // Player hero
            if (columnIndex == HERO_INDEX) then
                set playerHero = PlayerHeroes[playerId + 1]

                set tooltipName = "|cffffa8a8" + GetObjectName(GetUnitTypeId(playerHero)) + COLOR_END_TAG
                set tooltipDescription = GetHeroTooltip(playerHero)

                //set tooltipFramepoint = FRAMEPOINT_TOPLEFT
                //set tooltipRelativeFramepoint = FRAMEPOINT_BOTTOMLEFT

            // Player stats
            elseif (columnIndex == PLAYER_STATS_INDEX) then
                set tooltipName = "|cffd0ff00Stats for: |r" + GetPlayerNameColour(Player(playerId))
                set tooltipDescription = PlayerStats.getTooltip(Player(playerId))
                            
                // set tooltipFramepoint = FRAMEPOINT_TOPLEFT
                // set tooltipRelativeFramepoint = FRAMEPOINT_BOTTOMLEFT

            // Element count
            elseif (columnIndex == ELEMENT_COUNT_INDEX) then
                set playerHero = PlayerHeroes[playerId + 1]
                
                set tooltipName = "|cffd0ff00Element Counts|r"
                set tooltipDescription = GetElementCountTooltip(playerHero)

            // Item descriptions
            elseif (columnIndex >= PLAYER_ITEMS_START_INDEX and columnIndex <= (PLAYER_ITEMS_START_INDEX + 5)) then
                set playerHero = PlayerHeroes[playerId + 1]
                set currentItem = UnitItemInSlot(playerHero, columnIndex - PLAYER_ITEMS_START_INDEX)

                if (currentItem != null) then
                    set tooltipName = GetItemName(currentItem)
                    set tooltipDescription = BlzGetItemExtendedTooltip(currentItem)
                else
                    // Should hopefully never happen?
                    set tooltipName = "Invalid item"
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
                    set tooltipName = "Invalid ability"
                    set tooltipDescription = ""
                endif
            endif

            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(ScoreboardTooltipTitleFrame, tooltipName)
                call BlzFrameSetText(ScoreboardTooltipTextFrame, tooltipDescription)
                call BlzFrameSetPoint(ScoreboardTooltipFrame, tooltipFramepoint, currentFrameHandle, tooltipRelativeFramepoint, 0, -0.052)
                call BlzFrameSetSize(ScoreboardTooltipFrame, 0.29, GetTooltipSize(tooltipDescription))

                // TODO Change framepoint depending on column index somehow
                call BlzFrameSetVisible(ScoreboardTooltipFrame, true)
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
            // Empty the text box
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(ScoreboardTooltipTitleFrame, "")
                call BlzFrameSetText(ScoreboardTooltipTextFrame, "")
                call BlzFrameSetVisible(ScoreboardTooltipFrame, false)
            endif
        endif

        // Cleanup
        set currentFrameHandle = null
        set tooltipFramepoint = null
        set tooltipRelativeFramepoint = null
        set playerHero = null
        set currentItem = null
    endfunction

    private function CreateHeaderRow takes nothing returns nothing
        set CurrentRowIndex = 0

        set CurrentColumnIndex = PLAYER_NAME_INDEX
        call CreateText(HEADER_COLOR + "Player" + COLOR_END_TAG)
        set CurrentColumnIndex = DUELS_INDEX
        call CreateText(HEADER_COLOR + "Duels" + COLOR_END_TAG)
        set CurrentColumnIndex = PLAYER_ITEMS_START_INDEX
        call CreateText(HEADER_COLOR + "Items" + COLOR_END_TAG)
        set CurrentColumnIndex = PLAYER_ABILITIES_START_INDEX
        call CreateText(HEADER_COLOR + "Abilities" + COLOR_END_TAG)

        set CurrentRowIndex = 1
    endfunction

    private function InitializeDefaultValues takes nothing returns nothing
        local force playersOrComputersForce = GetPlayersMatching(Condition(function ValidPlayerFilter))
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY

        call CreateHeaderRow()

        // Populate the rows with actual player data
        call ForForce(playersOrComputersForce, function AddPlayerToMultiboard)

        // Compute the main voting box based on how many buttons there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameXMargin) + HeroIconWidth + HeroIconSpacing + PlayerNameWidth + DuelsWidth + (15 * ButtonWidth) + (12 * ButtonSpacing)
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameYMargin) - (CurrentRowIndex * ButtonWidth * 2) - ((CurrentRowIndex - 1) * ButtonSpacing)

        // Set the frame for the backdrop of the entire scoreboard
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(ScoreboardFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Cleanup
        call DestroyForce(playersOrComputersForce)
        set playersOrComputersForce = null
    endfunction
    
    function InitializeMultiboard takes nothing returns nothing
        set INITIAL_BOARD_NAME = "|cff2ff1ffCustom Hero Survival - |r |cffadff2f" + GetMapVersionName(CURRENT_GAME_VERSION) + "|r"

        // All buttons use the same trigger. However everything has a unique id to handle later on
        set IconEventTrigger = CreateTrigger()
        call TriggerAddAction(IconEventTrigger, function ScoreboardMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set ScoreboardFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetLevel(ScoreboardFrameHandle, 1)

        // Create the tooltip window
        set ScoreboardTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set ScoreboardTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set ScoreboardTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(ScoreboardTooltipFrame, 2) // To have it appear above the scoreboard
        call BlzFrameSetVisible(ScoreboardTooltipFrame, false) 

        set IconEventHandles = InitHashtable()

        call InitializeDefaultValues()
    endfunction

endlibrary
