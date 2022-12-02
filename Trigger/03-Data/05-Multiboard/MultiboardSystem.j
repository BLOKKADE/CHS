library MultiboardSystem requires PlayerTracking, HeroAbilityTable

    globals
        private string INITIAL_BOARD_NAME

        private constant integer MULTIBOARD_COLUMN_COUNT    = 3 + 6 + 1 + 10 // (Hero icon, player name, duels), (Items), (Spacer), (Abilities)

        private constant integer HERO_ICON_COLUMN_INDEX     = 0
        private constant integer PLAYER_COLUMN_INDEX        = 1
        private constant integer DUELS_COLUMN_INDEX         = 2
        private constant integer ITEM_START_COLUMN_INDEX    = 3
        private constant integer SPACER_COLUMN_INDEX        = 9
        private constant integer ABILITY_START_COLUMN_INDEX = 10

        private constant string COLOR_END_TAG               = "|r"
        private constant string HEADER_COLOR                = "|cff00ffff"
        private constant string PVP_LOSSES_COLOR            = "|cffdd2c00"
        private constant string PVP_WINS_COLOR              = "|cffbfff81"

        // Colors that are applied during the game
        private constant string LEAVER_COLOR                = "|cff404040"
		
        private constant string SLASH 			 	        = "|cff4a4a4a/|r"

        private real array ColumnWidths

        // Array to keep track of what player id belongs where on the multiboard. A fast lookup
        private integer array PlayerMultiboardLookup

        // Temporary value uses for adding players to the multiboard. Need to know how many have been added
        private integer GameMultiboardCurrentPlayerCount = 0

        // The only multiboard in the entire game that should never be destroyed
        private multiboard GameMultiboard	
    endglobals
		
    private function SetupColumnWidths takes nothing returns nothing
        set ColumnWidths[HERO_ICON_COLUMN_INDEX]              = 1.55
        set ColumnWidths[PLAYER_COLUMN_INDEX]                 = 10.00
        set ColumnWidths[DUELS_COLUMN_INDEX]                  = 4.00
        set ColumnWidths[ITEM_START_COLUMN_INDEX]             = 1.55
        set ColumnWidths[ITEM_START_COLUMN_INDEX + 1]         = 1.55
        set ColumnWidths[ITEM_START_COLUMN_INDEX + 2]         = 1.55
        set ColumnWidths[ITEM_START_COLUMN_INDEX + 3]         = 1.55
        set ColumnWidths[ITEM_START_COLUMN_INDEX + 4]         = 1.55
        set ColumnWidths[ITEM_START_COLUMN_INDEX + 5]         = 1.55
        set ColumnWidths[SPACER_COLUMN_INDEX]                 = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX]          = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 1]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 2]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 3]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 4]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 5]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 6]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 7]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 8]      = 1.55
        set ColumnWidths[ABILITY_START_COLUMN_INDEX + 9]      = 1.55
    endfunction

    private function SetColumnIconValue takes integer row, integer column, string iconPath returns nothing
        local multiboarditem multiboardItem = MultiboardGetItem(GameMultiboard, row, column)
        call MultiboardSetItemIcon(multiboardItem, iconPath)
        call MultiboardSetItemStyle(multiboardItem, false, true) // Set to icon mode
        call MultiboardSetItemWidth(multiboardItem, ColumnWidths[column] / 100.0)
        call MultiboardReleaseItem(multiboardItem)
        set multiboardItem = null
    endfunction

    private function SetColumnRowValueAndColor takes integer row, integer column, string value, string color returns nothing
        local multiboarditem multiboardItem = MultiboardGetItem(GameMultiboard, row, column)
        call MultiboardSetItemValue(multiboardItem, color + value + COLOR_END_TAG)
        call MultiboardSetItemStyle(multiboardItem, true, false) // Set to text mode
        call MultiboardSetItemWidth(multiboardItem, ColumnWidths[column] / 100.0)
        call MultiboardReleaseItem(multiboardItem)
        set multiboardItem = null
    endfunction

    private function SetColumnRowValueAndColorAndWidth takes integer row, integer column, string value, string color, real width returns nothing
        local multiboarditem multiboardItem = MultiboardGetItem(GameMultiboard, row, column)
        call MultiboardSetItemValue(multiboardItem, color + value + COLOR_END_TAG)
        call MultiboardSetItemStyle(multiboardItem, true, false) // Set to text mode
        call MultiboardSetItemWidth(multiboardItem, width / 100.0)
        call MultiboardReleaseItem(multiboardItem)
        set multiboardItem = null
    endfunction

    private function SetColumnRowValue takes integer row, integer column, string value returns nothing
        local multiboarditem multiboardItem = MultiboardGetItem(GameMultiboard, row, column)
        call MultiboardSetItemValue(multiboardItem, value)
        call MultiboardSetItemStyle(multiboardItem, true, false) // Set to text mode
        call MultiboardSetItemWidth(multiboardItem, ColumnWidths[column] / 100.0)
        call MultiboardReleaseItem(multiboardItem)
        set multiboardItem = null
    endfunction
    
    function UpdatePlayerAbilities takes player playingPlayer returns nothing
        local integer abilityIndex = 1
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]
        local integer currentAbility

        loop
            exitwhen abilityIndex > 10

            // Check if there is a valid ability in the next slot
            set currentAbility = GetHeroSpellAtPosition(playerHero, abilityIndex)

            if (currentAbility != 0) then
                // Display the icon
                call SetColumnIconValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], ABILITY_START_COLUMN_INDEX + abilityIndex - 1, BlzGetAbilityIcon(currentAbility))
            else
                call SetColumnRowValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], ABILITY_START_COLUMN_INDEX + abilityIndex - 1, "")
            endif

            set abilityIndex = abilityIndex + 1
        endloop

        // Cleanup
        set playerHero = null
    endfunction

    function UpdatePlayerItems takes player playingPlayer returns nothing
        local integer itemSlotIndex = 0
        local unit playerHero = PlayerHeroes[GetPlayerId(playingPlayer) + 1]
        local integer validColumnIndex = 0
        local item currentItem

        loop
            exitwhen itemSlotIndex > 5

            call SetColumnRowValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], ITEM_START_COLUMN_INDEX + itemSlotIndex, "")

            set currentItem = UnitItemInSlot(playerHero, itemSlotIndex)

            if (currentItem != null) then
                // Display the icon
                call SetColumnIconValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], ITEM_START_COLUMN_INDEX + validColumnIndex, BlzGetItemIconPath(currentItem))

                set validColumnIndex = validColumnIndex + 1
            endif

            set itemSlotIndex = itemSlotIndex + 1
        endloop

        // Cleanup
        set playerHero = null
        set currentItem = null
    endfunction

    function UpdateMultiboardPVPCounts takes player playingPlayer returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(playingPlayer)
        local string duelStats = PVP_WINS_COLOR + I2S(ps.getPVPWins()) + COLOR_END_TAG + SLASH + PVP_LOSSES_COLOR + I2S(ps.getPVPLosses()) + COLOR_END_TAG

        // Set the PVP stats
        call SetColumnRowValue(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], DUELS_COLUMN_INDEX, duelStats)
    endfunction

    function UpdateMultiboardPlayerLeaves takes player playingPlayer returns nothing
        // Set the player name
        call SetColumnRowValueAndColor(PlayerMultiboardLookup[GetPlayerId(playingPlayer)], PLAYER_COLUMN_INDEX, GetPlayerName(playingPlayer), LEAVER_COLOR)
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

        // Increment the amount of players that we have added to the multiboard to know how to save them for lookup in the future
        set GameMultiboardCurrentPlayerCount = GameMultiboardCurrentPlayerCount + 1

        // Save where this player is in the multiboard for lookup in the future
        set PlayerMultiboardLookup[playerId] = GameMultiboardCurrentPlayerCount

        // Set the player hero icon
        call SetColumnIconValue(GameMultiboardCurrentPlayerCount, HERO_ICON_COLUMN_INDEX, BlzGetAbilityIcon(GetUnitTypeId(playerHero)))

        // Set the player name
        call SetColumnRowValue(GameMultiboardCurrentPlayerCount, PLAYER_COLUMN_INDEX, GetPlayerNameColour(playingPlayer))

        // Set the PVP stats
        call UpdateMultiboardPVPCounts(playingPlayer)

        // Set the player items
        call UpdatePlayerItems(playingPlayer)

        // Spacer
        call SetColumnRowValue(GameMultiboardCurrentPlayerCount, SPACER_COLUMN_INDEX, "")

        // Set the player abilities
        call UpdatePlayerAbilities(playingPlayer)

        // Cleanup
        set playingPlayer = null
        set playerHero = null
    endfunction

    private function ValidPlayerFilter takes nothing returns boolean
        return GetPlayerId(GetFilterPlayer()) < 8
    endfunction

    private function InitializeDefaultValues takes force playersOrComputersForce returns nothing
        // Create the actual multiboard. Initialize the row/column size with a title and hide it
        set GameMultiboard = CreateMultiboard()
        
        call MultiboardSetRowCount(GameMultiboard, 1 + CountPlayersInForceBJ(playersOrComputersForce)) // Header row + player count
        call MultiboardSetColumnCount(GameMultiboard, MULTIBOARD_COLUMN_COUNT)
        call MultiboardSetTitleText(GameMultiboard, INITIAL_BOARD_NAME)
        call MultiboardDisplay(GameMultiboard, false)

        // Initialize header data
        call SetColumnRowValueAndColor(0, HERO_ICON_COLUMN_INDEX, "", HEADER_COLOR)
        call SetColumnRowValueAndColor(0, PLAYER_COLUMN_INDEX, "Player", HEADER_COLOR)
        call SetColumnRowValueAndColor(0, DUELS_COLUMN_INDEX, "Duels", HEADER_COLOR)
        
        // Item columns
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX, "Items", HEADER_COLOR, 8.5)
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX + 1, "", HEADER_COLOR, .2)
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX + 2, "", HEADER_COLOR, .2)
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX + 3, "", HEADER_COLOR, .2)
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX + 4, "", HEADER_COLOR, .2)
        call SetColumnRowValueAndColorAndWidth(0, ITEM_START_COLUMN_INDEX + 5, "", HEADER_COLOR, .2)

        // Spacer
        call SetColumnRowValueAndColor(0, SPACER_COLUMN_INDEX, "", HEADER_COLOR)

        // Ability columns
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX, "Abilities", HEADER_COLOR, 5.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 1, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 2, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 3, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 4, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 5, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 6, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 7, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 8, "", HEADER_COLOR, 1.)
        call SetColumnRowValueAndColorAndWidth(0, ABILITY_START_COLUMN_INDEX + 9, "", HEADER_COLOR, 1.)

        call MultiboardDisplay(GameMultiboard, true)
    endfunction
    
    function InitializeMultiboard takes nothing returns nothing
        local force playersOrComputersForce = GetPlayersMatching(Condition(function ValidPlayerFilter))

        set INITIAL_BOARD_NAME = "|cff2ff1ffCustom Hero Survival - |r |cffadff2f" + GetMapVersionName(CURRENT_GAME_VERSION) + "|r"

        // Initialize column sizes
        call SetupColumnWidths()

        // Fill the board with basic values
        call InitializeDefaultValues(playersOrComputersForce)

        // Populate the rows with actual player data
        call ForForce(playersOrComputersForce, function AddPlayerToMultiboard)

        // Cleanup
        call DestroyForce(playersOrComputersForce)
        set playersOrComputersForce = null
    endfunction

endlibrary
