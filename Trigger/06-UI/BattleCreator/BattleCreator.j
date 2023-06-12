library BattleCreator initializer init requires PlayerTracking, IconFrames, Utility, BattleCreatorManager

    globals
        // Static messages
        private constant string BATTLE_CREATOR_TITLE                    = "|cff2ff1ffBattle Creator - Customize Your BR Experience|r"

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.08
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.54
        private constant real MAIN_FRAME_X_MARGIN                       = 0.035
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.03
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.025
        private constant real TITLE_HEIGHT                              = 0.03

        // Specifications for a icon
        private constant real ICON_WIDTH                                = 0.015
        private constant real ICON_SPACING                              = 0.005
        private constant real CATEGORY_SPACING                          = 0.015

        // Specifications for a button
        private constant real BUTTON_WIDTH                              = 0.13
        private constant real BUTTON_HEIGHT                             = 0.03
        private constant real BUTTON_SPACING                            = 0.009

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.009
        private constant real TEXT_WIDTH                                = 0.1
        private constant real TEXT_SPACING                              = 0.014

        // Specifications for a checkbox
        private constant real CHECKBOX_WIDTH                             = 0.025
        private constant real CHECKBOX_TEXT_WIDTH                        = 0.15
        private constant real CHECKBOX_SPACING                           = 0.005

        // Colors
        private constant string COLOR_END_TAG                           = "|r"
        private constant string OBSERVERS_COLOR                         = "|cffff2af4"
        private constant string SOLO_COLOR                              = "|cffff8420"
        private constant string RANDOM_TEAM_COLOR                       = "|cffff9e20"
        private constant string TEAM_1_COLOR                            = "|cffff2a2a"
        private constant string TEAM_2_COLOR                            = "|cff5cff2a"
        private constant string TEAM_3_COLOR                            = "|cff00ccff"
        private constant string TEAM_4_COLOR                            = "|cffbcf520"

        // The only trigger that handles hovering over icons and clicking buttons
        private trigger EventTrigger

        private framehandle BattleCreatorTooltipFrame
		private framehandle BattleCreatorTooltipTitleFrame
		private framehandle BattleCreatorTooltipTextFrame

        // Framehandles that need to be referenced later
        private integer ObserverHandleId
        private integer SoloHandleId
        private integer RandomTeamHandleId
        private integer Team1HandleId
        private integer Team2HandleId
        private integer Team3HandleId
        private integer Team4HandleId

        private framehandle array PlayerSlotNameFramehandles
        private framehandle array PlayerSlotIconFramehandles
        private framehandle array PlayerSlotIconParentFramehandles

        private integer CurrentCategoryIndex
        private integer CurrentPlayerSlotIndex
        private integer CurrentRowIndex

        private real MainFrameBottomRightX
        private real MainFrameBottomRightY
        
        private Table HandleTitles
        private Table HandleDescriptions

        private framehandle CheckboxTextFrameHandle

        // Temp variables
        private force TempForce
        private integer PlayerSlotIndex
    endglobals

    private function TryMovePlayerToForce takes player p, force destinationForce returns boolean
        // Don't do anything if the player is already in the destination force
        if (IsPlayerInForce(p, destinationForce) or IsPlayerInForce(p, BRRandomTeam)) then
            return false
        endif

        call ForceRemovePlayer(BRObservers, p)
        call ForceRemovePlayer(BRSolo, p)
        call ForceRemovePlayer(BRTeam1, p)
        call ForceRemovePlayer(BRTeam2, p)
        call ForceRemovePlayer(BRTeam3, p)
        call ForceRemovePlayer(BRTeam4, p)

        call ForceAddPlayer(destinationForce, p)

        return true
    endfunction

    private function TryMovePlayerFromForceToForce takes player p, force sourceFource, force destinationForce returns boolean
        // Don't do anything if the player is already in the destination force
        if (IsPlayerInForce(p, destinationForce) or IsPlayerInForce(p, BRRandomTeam)) then
            return false
        endif

        call ForceRemovePlayer(sourceFource, p)
        call ForceAddPlayer(destinationForce, p)

        return true
    endfunction

    private function MoveEnumPlayerToObservers takes nothing returns nothing
        call TryMovePlayerFromForceToForce(GetEnumPlayer(), TempForce, BRObservers)
    endfunction

    private function UpdateRandomTeamVoteText takes nothing returns nothing
        call BlzFrameSetText(CheckboxTextFrameHandle, RANDOM_TEAM_COLOR + "Random Teams (" + I2S(CountPlayersInForceBJ(BRRandomTeam)) + "/" + I2S(BRRoundPlayerCount) + ")" + COLOR_END_TAG)
    endfunction

    private function ResetTeams takes nothing returns nothing
        set TempForce = BRSolo
        call ForForce(TempForce, function MoveEnumPlayerToObservers)
        set TempForce = BRTeam1
        call ForForce(TempForce, function MoveEnumPlayerToObservers)
        set TempForce = BRTeam2
        call ForForce(TempForce, function MoveEnumPlayerToObservers)
        set TempForce = BRTeam3
        call ForForce(TempForce, function MoveEnumPlayerToObservers)
        set TempForce = BRTeam4
        call ForForce(TempForce, function MoveEnumPlayerToObservers)
        set TempForce = null

        set BRRoundPlayerCount = CountPlayersInForceBJ(BRObservers) + CountPlayersInForceBJ(BRRandomTeam)

        call UpdateRandomTeamVoteText()
    endfunction

    private function GetTopLeftX takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN

        // BRObservers button in the left middle
        if (CurrentCategoryIndex == 0 and CurrentRowIndex == 0) then
            return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 - BUTTON_WIDTH / 2
        endif

        // BRSolo button in the right middle
        if (CurrentCategoryIndex == 1 and CurrentRowIndex == 0) then
            return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 2 + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 - BUTTON_WIDTH / 2
        endif

        // Observer player slots
        if (CurrentCategoryIndex == 0 and CurrentRowIndex == 1) then
            if (ModuloInteger(CurrentPlayerSlotIndex, 2) == 0) then
                return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 - TEXT_WIDTH - TEXT_SPACING / 2
            else
                return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 + TEXT_SPACING / 2
            endif
        endif

        // BRSolo player slots
        if (CurrentCategoryIndex == 1 and CurrentRowIndex == 1) then
            if (ModuloInteger(CurrentPlayerSlotIndex, 2) == 0) then
                return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 2 + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 - TEXT_WIDTH - TEXT_SPACING / 2
            else
                return MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 2 + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) / 4 + TEXT_SPACING / 2
            endif
        endif

        // Random teams checkbox
        if (CurrentCategoryIndex == 2 and CurrentRowIndex == 1) then
            return value
        endif

        return value + (CurrentCategoryIndex - 3) * CATEGORY_SPACING + (CurrentCategoryIndex - 3) * BUTTON_WIDTH
    endfunction

    private function GetTopLeftY takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN
        local integer relativePlayerSlotIndex

        // BRObservers button
        if ((CurrentCategoryIndex == 0 or CurrentCategoryIndex == 1) and CurrentRowIndex == 0) then
            return value
        endif

        // Observer player slots
        if (CurrentCategoryIndex == 0 and CurrentRowIndex == 1) then
            return value - BUTTON_HEIGHT - BUTTON_SPACING - (CurrentPlayerSlotIndex / 2) * TEXT_HEIGHT - (CurrentPlayerSlotIndex / 2) * TEXT_SPACING
        endif

        // BRSolo player slots
        if (CurrentCategoryIndex == 1 and CurrentRowIndex == 1) then
            return value - BUTTON_HEIGHT - BUTTON_SPACING - ((CurrentPlayerSlotIndex - 8) / 2) * TEXT_HEIGHT - ((CurrentPlayerSlotIndex - 8) / 2) * TEXT_SPACING
        endif

        set value = value - BUTTON_HEIGHT - BUTTON_SPACING - (4 * TEXT_HEIGHT) - (4 * TEXT_SPACING)

        // Random teams checkbox
        if (CurrentCategoryIndex == 2) then
            return value
        endif

        set value = value - CHECKBOX_WIDTH - CHECKBOX_SPACING

        // Team buttons
        if (CurrentRowIndex == 0) then
            return value
        endif

        set value = value - BUTTON_HEIGHT - BUTTON_SPACING

        set relativePlayerSlotIndex = CurrentPlayerSlotIndex - (8 * (CurrentCategoryIndex - 1))

        return value - (relativePlayerSlotIndex * TEXT_HEIGHT) - (relativePlayerSlotIndex * TEXT_SPACING)
    endfunction

    private function UpdateEnumPlayerSlot takes nothing returns nothing
        local player p = GetEnumPlayer()
        local integer playerId = GetPlayerId(p)
        local unit playerHero = PlayerHeroes[playerId]

        // Update the player hero icon
        call BlzFrameSetTexture(PlayerSlotIconFramehandles[PlayerSlotIndex], BlzGetAbilityIcon(GetUnitTypeId(playerHero)), 0, true)
        call BlzFrameSetVisible(PlayerSlotIconParentFramehandles[PlayerSlotIndex], true)

        set HandleDescriptions.string[GetHandleId(PlayerSlotIconParentFramehandles[PlayerSlotIndex])] = GetHeroTooltip(playerHero)
        set HandleTitles.string[GetHandleId(PlayerSlotIconParentFramehandles[PlayerSlotIndex])] = GetPlayerNameColour(p) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(playerHero))

        // Update the player name
        call BlzFrameSetText(PlayerSlotNameFramehandles[PlayerSlotIndex], GetPlayerNameColour(p))
        call BlzFrameSetVisible(PlayerSlotNameFramehandles[PlayerSlotIndex], true)

        // Cleanup
        set p = null
        set playerHero = null

        set PlayerSlotIndex = PlayerSlotIndex + 1
    endfunction

    private function CleanupRemainingSlots takes integer startIndex, integer endIndex returns nothing
        local integer playerSlotIndex = startIndex

        loop
            exitwhen playerSlotIndex > endIndex

            call BlzFrameSetVisible(PlayerSlotIconParentFramehandles[playerSlotIndex], false)
            call BlzFrameSetVisible(PlayerSlotNameFramehandles[playerSlotIndex], false)

            set playerSlotIndex = playerSlotIndex + 1
        endloop
    endfunction

    private function UpdatePlayerSlots takes nothing returns nothing
        set PlayerSlotIndex = 0
        set TempForce = BRObservers
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 7)

        set PlayerSlotIndex = 8
        set TempForce = BRSolo
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 15)

        set PlayerSlotIndex = 16
        set TempForce = BRTeam1
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 23)

        set PlayerSlotIndex = 24
        set TempForce = BRTeam2
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 31)

        set PlayerSlotIndex = 32
        set TempForce = BRTeam3
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 39)

        set PlayerSlotIndex = 40
        set TempForce = BRTeam4
        call ForForce(TempForce, function UpdateEnumPlayerSlot)
        call CleanupRemainingSlots(PlayerSlotIndex, 47)
    endfunction

    private function CreatePlayerForcePlayerSlotTextAndIcon takes integer currentPlayerSlotIndex returns nothing
        local real x = GetTopLeftX()
        local real y = GetTopLeftY()
        local framehandle battleIconParentFrameHandle
        local framehandle battleIconFrameHandle
        local framehandle playerNameTextFrameHandle
        local integer battleIconParentFrameHandleId

        // Create the icons frames and save them for later
        set battleIconParentFrameHandle = BlzCreateFrame("ScriptDialogButton", BattleCreatorFrameHandle, 0, 0) 
        set battleIconFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", battleIconParentFrameHandle, "", 1)

        set PlayerSlotIconParentFramehandles[currentPlayerSlotIndex] = battleIconParentFrameHandle
        set PlayerSlotIconFramehandles[currentPlayerSlotIndex] = battleIconFrameHandle

        // Dimensions for the button
        call BlzFrameSetAbsPoint(battleIconParentFrameHandle, FRAMEPOINT_TOPLEFT, x, y) 
        call BlzFrameSetAbsPoint(battleIconParentFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + ICON_WIDTH, y - ICON_WIDTH) 

        // Register with the single trigger about hovering over the icon
        call BlzTriggerRegisterFrameEvent(EventTrigger, battleIconParentFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(EventTrigger, battleIconParentFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        call BlzTriggerRegisterFrameEvent(EventTrigger, battleIconParentFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        
        // Apply the icon
        call BlzFrameSetVisible(battleIconParentFrameHandle, false)
        call BlzFrameSetAllPoints(battleIconFrameHandle, battleIconParentFrameHandle) 

        set playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "BattleCreatorText", BattleCreatorFrameHandle, "", 0) 

        set PlayerSlotNameFramehandles[currentPlayerSlotIndex] = playerNameTextFrameHandle

        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, x + ICON_WIDTH + ICON_SPACING, y - 0.004)
        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + ICON_WIDTH + ICON_SPACING + TEXT_WIDTH, y - TEXT_HEIGHT) 
        call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.2) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT) 
        call BlzFrameSetVisible(playerNameTextFrameHandle, false)

        // Cleanup
        set battleIconParentFrameHandle = null
        set battleIconFrameHandle = null
        set playerNameTextFrameHandle = null
    endfunction

    private function CreateCategoryButton takes string value, string title, string description returns integer
        // First create the button
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", BattleCreatorFrameHandle, 0, 0) 
        local integer frameHandleId = GetHandleId(buttonFrameHandle)

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + BUTTON_WIDTH, GetTopLeftY() - BUTTON_HEIGHT) 
        call BlzFrameSetScale(buttonFrameHandle, 1.00) 
        call BlzFrameSetVisible(buttonFrameHandle, true)
        call BlzFrameSetText(buttonFrameHandle, value) 

        call BlzTriggerRegisterFrameEvent(EventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(EventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        call BlzTriggerRegisterFrameEvent(EventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        set HandleDescriptions.string[frameHandleId] = description
        set HandleTitles.string[frameHandleId] = title

        // Cleanup
        set buttonFrameHandle = null

        return frameHandleId
    endfunction

    private function CreateCheckbox takes string checkboxText, string title, string description returns integer
        // First create the checkbox
        local framehandle checkboxFrameHandle = BlzCreateFrame("QuestCheckBox", BattleCreatorFrameHandle, 0, 0) 
        local integer checkboxFrameHandleId = GetHandleId(checkboxFrameHandle)

        set CheckboxTextFrameHandle = BlzCreateFrameByType("TEXT", "CheckboxText", BattleCreatorFrameHandle, "", 0) 

        // Dimensions for the button
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + CHECKBOX_WIDTH, GetTopLeftY() - CHECKBOX_WIDTH) 

        // Setup the checkbox text
        call BlzFrameSetAbsPoint(CheckboxTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX() + 0.029, GetTopLeftY() - 0.007) 
        call BlzFrameSetAbsPoint(CheckboxTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + 0.029 + CHECKBOX_TEXT_WIDTH, GetTopLeftY() - 0.014) 
        call BlzFrameSetText(CheckboxTextFrameHandle, checkboxText) 
        call BlzFrameSetEnable(CheckboxTextFrameHandle, false) 
        call BlzFrameSetScale(CheckboxTextFrameHandle, 1.2) 
        call BlzFrameSetTextAlignment(CheckboxTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        // Save the handle of this button to look it up later for mouse events
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_CHECKED)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_UNCHECKED)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

        set HandleDescriptions.string[checkboxFrameHandleId] = description
        set HandleTitles.string[checkboxFrameHandleId] = title

        // Cleanup
        set checkboxFrameHandle = null

        return checkboxFrameHandleId
    endfunction

    private function BattleCreatorMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local player triggerPlayer = GetTriggerPlayer()
        local integer handleId = GetHandleId(currentFrameHandle)
        local real tooltipWidth = 0.32
        local string tooltipDescription
        local string tooltipName
        local boolean change = false

        if (BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK) then
            if (GetLocalPlayer() == triggerPlayer) then	
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

            if (handleId == ObserverHandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRObservers)
            elseif (handleId == SoloHandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRSolo)
            elseif (handleId == Team1HandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam1)
            elseif (handleId == Team2HandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam2)
            elseif (handleId == Team3HandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam3)
            elseif (handleId == Team4HandleId) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam4)
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            set tooltipName = HandleTitles.string[handleId]
            set tooltipDescription = HandleDescriptions.string[handleId]

            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(BattleCreatorTooltipTitleFrame, tooltipName)
                call BlzFrameSetText(BattleCreatorTooltipTextFrame, tooltipDescription)
                call BlzFrameSetPoint(BattleCreatorTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_BOTTOM, 0, 0)
                call BlzFrameSetSize(BattleCreatorTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                call BlzFrameSetVisible(BattleCreatorTooltipFrame, true)
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE) then
            // Empty the text box
            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(BattleCreatorTooltipTitleFrame, "")
                call BlzFrameSetText(BattleCreatorTooltipTextFrame, "")
                call BlzFrameSetVisible(BattleCreatorTooltipFrame, false)
            endif

        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            set change = TryMovePlayerToForce(triggerPlayer, BRRandomTeam)
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_UNCHECKED then
            set change = TryMovePlayerToForce(triggerPlayer, BRObservers)
        endif

        if (change) then
            call UpdatePlayerSlots()
            call UpdateRandomTeamVoteText()
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function FinalizeMainFrame takes nothing returns nothing
        local framehandle titleFrameHandle

        // Set the frame for the backdrop of the entire battle creator
        call BlzFrameSetAbsPoint(BattleCreatorFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X, MAIN_FRAME_TOP_LEFT_Y) 
        call BlzFrameSetAbsPoint(BattleCreatorFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MainFrameBottomRightX, MainFrameBottomRightY) 

        // Create the battle creator title
        set titleFrameHandle = BlzCreateFrameByType("GLUETEXTBUTTON", "BattleCreatorTitle", BattleCreatorFrameHandle, "ScriptDialogButton", 0) 
        call BlzFrameSetLevel(titleFrameHandle, 2) // To have it appear above the battle creator
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.2, MAIN_FRAME_TOP_LEFT_Y + (TITLE_HEIGHT / 2)) 
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + (MainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.8, MAIN_FRAME_TOP_LEFT_Y - TITLE_HEIGHT) 
        call BlzFrameSetEnable(titleFrameHandle, false) 
        call BlzFrameSetScale(titleFrameHandle, 1.2) 
        call BlzFrameSetText(titleFrameHandle, BATTLE_CREATOR_TITLE) 

        // Cleanup
        set titleFrameHandle = null
    endfunction
    
    private function CreatePlayerForceSectionButton takes string categoryName, string title, string description returns integer
        local integer frameHandleId

        set CurrentRowIndex = 0
        set frameHandleId = CreateCategoryButton(categoryName, title, description)
        set CurrentRowIndex = 1

        return frameHandleId
    endfunction

    private function CreatePlayerForcePlayerSlot takes nothing returns nothing
        call CreatePlayerForcePlayerSlotTextAndIcon(CurrentPlayerSlotIndex)
        set CurrentPlayerSlotIndex = CurrentPlayerSlotIndex + 1
    endfunction

    private function CreatePlayerForcePlayerSlots takes nothing returns nothing
        local integer playerSlotIndex = 0

        loop
            exitwhen playerSlotIndex == 8

            call CreatePlayerForcePlayerSlot()

            set playerSlotIndex = playerSlotIndex + 1
        endloop
    endfunction

    private function CreatePlayerForceSections takes nothing returns nothing
        set CurrentCategoryIndex = 0
        set CurrentPlayerSlotIndex = 0

        // BRObservers
        set ObserverHandleId = CreatePlayerForceSectionButton(OBSERVERS_COLOR + "BRObservers" + COLOR_END_TAG, "Join the BRObservers", "Join the BRObservers. You won't be in the next fight.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // BRSolo
        set SoloHandleId = CreatePlayerForceSectionButton(SOLO_COLOR + "BRSolo" + COLOR_END_TAG, "Play BRSolo", "Fight alone in the next fight. Even if there are teams.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        set RandomTeamHandleId = CreateCheckbox(RANDOM_TEAM_COLOR + "Random Teams (0/0)" + COLOR_END_TAG, "Vote on Random Teams", "If majority vote, all players will be randomly assigned|nto teams. If not enough votes, voters will fight solo.|n")

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 1
        set Team1HandleId = CreatePlayerForceSectionButton(TEAM_1_COLOR + "Team 1" + COLOR_END_TAG, "Join a Team", "Join Team 1 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 2
        set Team2HandleId = CreatePlayerForceSectionButton(TEAM_2_COLOR + "Team 2" + COLOR_END_TAG, "Join a Team", "Join Team 2 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 3
        set Team3HandleId = CreatePlayerForceSectionButton(TEAM_3_COLOR + "Team 3" + COLOR_END_TAG, "Join a Team", "Join Team 3 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 4
        set Team4HandleId = CreatePlayerForceSectionButton(TEAM_4_COLOR + "Team 4" + COLOR_END_TAG, "Join a Team", "Join Team 4 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots
    endfunction

    private function InitializeBattleCreator takes nothing returns nothing
        // All buttons use the same trigger. However everything has a unique id to handle later on
        set EventTrigger = CreateTrigger()
        call TriggerAddAction(EventTrigger, function BattleCreatorMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set BattleCreatorFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetLevel(BattleCreatorFrameHandle, 1)
        call BlzFrameSetVisible(BattleCreatorFrameHandle, false) 
        
        // Create the primary tooltip window
        set BattleCreatorTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set BattleCreatorTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set BattleCreatorTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(BattleCreatorTooltipFrame, 3) // To have it appear above the battle creator
        call BlzFrameSetVisible(BattleCreatorTooltipFrame, false) 

        // Setup the battle creator section
        call CreatePlayerForceSections()

        // Finalize the main window
        call FinalizeMainFrame()
    endfunction

    private function init takes nothing returns nothing
        set HandleTitles = Table.create()
        set HandleDescriptions = Table.create()

        // Compute the main battle creator box
        // Width - Main frame margins, all categories and their widths
        set MainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + 4 * (BUTTON_WIDTH) + 3 * (CATEGORY_SPACING) + MAIN_FRAME_X_MARGIN
        // Height - Main frame margins, category text and category icons and their spacings
        set MainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - BUTTON_HEIGHT - BUTTON_SPACING - (4 * TEXT_HEIGHT) - (4 * TEXT_SPACING) - BUTTON_HEIGHT - BUTTON_SPACING - (8 * TEXT_HEIGHT) - (7 * TEXT_SPACING) - MAIN_FRAME_Y_BOTTOM_MARGIN

        call TimerStart(CreateTimer(), 10, false, function InitializeBattleCreator)
    endfunction

endlibrary
