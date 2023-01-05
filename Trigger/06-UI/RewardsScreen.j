library RewardsScreen initializer init requires PlayerTracking, IconFrames

    globals
        // Rewards static titles
        private constant string REWARDS_DESCRIPTION                     = "|cfffbff00After each round you survive, your hero will permanently gain the selected stats above|r"
        private constant string REWARDS_TITLE                           = "|cff2ff1ffChoose your reward!|r"

        // The X,Y coordinate for the top left of the main frame
        private constant real MAIN_FRAME_TOP_LEFT_X                     = 0.14
        private constant real MAIN_FRAME_TOP_LEFT_Y                     = 0.56
        private constant real MAIN_FRAME_X_MARGIN                       = 0.03
        private constant real MAIN_FRAME_Y_TOP_MARGIN                   = 0.027
        private constant real MAIN_FRAME_Y_BOTTOM_MARGIN                = 0.025
        private constant real TITLE_HEIGHT                              = 0.03

        // Specifications for a icon
        private constant real ICON_WIDTH                                = 0.016
        private constant real ICON_SPACING                              = 0.003
        private constant real CATEGORY_SPACING                          = 0.01

        // Specifications for a button
        private real ButtonWidth                                        = 0.116
        private real ButtonHeight                                       = 0.035
        private real ButtonSpacing                                      = 0.005

        // Column indexes
        private constant integer REWARDS_COUNT                          = 12
        private constant integer OFFENSIVE_STAT_1_INDEX                 = 0
        private constant integer OFFENSIVE_STAT_2_INDEX                 = 1
        private constant integer OFFENSIVE_STAT_3_INDEX                 = 2
        private constant integer OFFENSIVE_STAT_4_INDEX                 = 3
        private constant integer DEFENSIVE_STAT_1_INDEX                 = 4
        private constant integer DEFENSIVE_STAT_2_INDEX                 = 5
        private constant integer DEFENSIVE_STAT_3_INDEX                 = 6
        private constant integer DEFENSIVE_STAT_4_INDEX                 = 7
        private constant integer UTILITY_STAT_1_INDEX                   = 8
        private constant integer UTILITY_STAT_2_INDEX                   = 9
        private constant integer UTILITY_STAT_3_INDEX                   = 10
        private constant integer UTILITY_STAT_4_INDEX                   = 11

        // Reward icons
        private constant string OFFENSIVE_STAT_1_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string OFFENSIVE_STAT_2_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string OFFENSIVE_STAT_3_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string OFFENSIVE_STAT_4_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string DEFENSIVE_STAT_1_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string DEFENSIVE_STAT_2_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string DEFENSIVE_STAT_3_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string DEFENSIVE_STAT_4_ICON                   = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string UTILITY_STAT_1_ICON                     = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string UTILITY_STAT_2_ICON                     = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string UTILITY_STAT_3_ICON                     = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"
        private constant string UTILITY_STAT_4_ICON                     = "ReplaceableTextures\\CommandButtons\\BTNSelectHeroOff.blp"

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.012
        private constant real TEXT_WIDTH                                = 0.2

        // Colors
        private constant string COLOR_END_TAG                           = "|r"
        private constant string OFFENSIVE_COLOR                         = "|cffff2a2a"
        private constant string DEFENSIVE_COLOR                         = "|cff1eff00"
        private constant string UTILITY_COLOR                           = "|cff4f95ff"

        private integer CurrentCategoryIndex
        private integer CurrentIconIndex
        private integer CurrentRowIndex

        // The only trigger that handles hovering over icons
        private trigger IconEventTrigger

        // Save relavant information for each framehandle
        private hashtable IconEventHandles
        
        // Tooltip information
        private framehandle RewardsTooltipFrame
		private framehandle RewardsTooltipTitleFrame
		private framehandle RewardsTooltipTextFrame
        private integer SubmitHandleId
        private integer ResetHandleId

        private string array RewardTitles
        private string array RewardDescriptions
        private integer array PlayerRewardSelection
        private framehandle array RewardSelectionFramehandles
    endglobals

    private function GetTopLeftX takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + (CurrentCategoryIndex * CATEGORY_SPACING) + (CurrentCategoryIndex * (2 * ICON_WIDTH)) + (CurrentCategoryIndex * ICON_SPACING)

        // First column of rewards
        if (CurrentIconIndex == 1 or CurrentIconIndex == 3) then
            return value + ICON_WIDTH + ICON_SPACING
        endif

        return value
    endfunction

    private function GetTopLeftY takes nothing returns real
        local real value = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN

        // Header row
        if (CurrentRowIndex == 0) then
            return value
        endif

        set value = value - TEXT_HEIGHT

        // Second row of rewards
        if (CurrentIconIndex == 1 or CurrentIconIndex == 3) then
            return value - ICON_WIDTH - ICON_SPACING
        endif

        // TODO Add functionality for multiple rows of reward groups?

        return value
    endfunction

    private function CreateRewardIcon takes string iconPath, integer rewardIndex returns nothing
        local framehandle submitButtonFrameHandle
        local framehandle buttonBackdropFrameHandle
        local framehandle buttonCountFrameHandle
        local framehandle buttonCountBackdropFrameHandle
        local integer buttonHandleId
        local integer backdropHandleId

        // Create the icons frames and save them for later
        set submitButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        set buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", submitButtonFrameHandle, "", 1)
        set buttonHandleId = GetHandleId(submitButtonFrameHandle)
        set backdropHandleId = GetHandleId(buttonBackdropFrameHandle)

        // Reward count for the button. Save the framehandle for later to easily update the value
        set buttonCountBackdropFrameHandle = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set buttonCountFrameHandle = BlzGetFrameByName("TooltipTextTitle", 0)
        call BlzFrameSetLevel(buttonCountBackdropFrameHandle, 2) // To have it appear above the button
        call BlzFrameSetText(buttonCountFrameHandle, "0")
        call BlzFrameSetPoint(buttonCountBackdropFrameHandle, FRAMEPOINT_TOPLEFT, buttonCountBackdropFrameHandle, FRAMEPOINT_BOTTOMRIGHT, -0.01, 0.01)
        call BlzFrameSetSize(buttonCountBackdropFrameHandle, 0.05, 0.020)

        set RewardSelectionFramehandles[rewardIndex] = buttonCountFrameHandle

        // Dimensions for the button
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ICON_WIDTH, GetTopLeftY() - ICON_WIDTH) 

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(IconEventHandles, buttonHandleId, 1, rewardIndex)

        // Register with the single trigger about hovering over the icon
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        
        // Apply the icon
        call BlzFrameSetVisible(submitButtonFrameHandle, true)
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, submitButtonFrameHandle) 

        // Cleanup
        set submitButtonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateCategoryText takes string value returns nothing
        local framehandle playerNameTextFrameHandle = BlzCreateFrameByType("TEXT", "RewardsText", RewardsFrameHandle, "", 0) 

        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY())
        call BlzFrameSetAbsPoint(playerNameTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TEXT_WIDTH, GetTopLeftY() - TEXT_HEIGHT) 
        call BlzFrameSetEnable(playerNameTextFrameHandle, false) 
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.0) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_CENTER) 
        call BlzFrameSetText(playerNameTextFrameHandle, value) 

        // Cleanup
        set playerNameTextFrameHandle = null
    endfunction

    private function RewardsMouseEventActions takes nothing returns nothing
        local framehandle currentFrameHandle = BlzGetTriggerFrame()
        local player triggerPlayer = GetTriggerPlayer()
        local integer triggerPlayerId = GetPlayerId(triggerPlayer)
        local integer handleId = GetHandleId(currentFrameHandle)
        local integer rewardIndex = LoadInteger(IconEventHandles, handleId, 1)
        local real tooltipWidth = 0.29 // Default used by almost everything
        local string tooltipDescription
        local string tooltipName

        if (BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK) then
            if (GetLocalPlayer() == triggerPlayer) then	
				call BlzFrameSetEnable(currentFrameHandle, false)
				call BlzFrameSetEnable(currentFrameHandle, true)
			endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            // Retrieve the cached information
            set tooltipName = RewardTitles[rewardIndex]
            set tooltipDescription = RewardDescriptions[rewardIndex]

            // Show the tooltip information if valid
            if (tooltipName != "") then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetText(RewardsTooltipTitleFrame, tooltipName)
                    call BlzFrameSetText(RewardsTooltipTextFrame, tooltipDescription)
                    call BlzFrameSetPoint(RewardsTooltipFrame, FRAMEPOINT_TOP, currentFrameHandle, FRAMEPOINT_BOTTOM, 0, 0)
                    call BlzFrameSetSize(RewardsTooltipFrame, tooltipWidth, GetTooltipSize(tooltipDescription))
                    call BlzFrameSetVisible(RewardsTooltipFrame, true)
                endif
            endif

        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE) then
            // Empty the text box
            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetText(RewardsTooltipTitleFrame, "")
                call BlzFrameSetText(RewardsTooltipTextFrame, "")
                call BlzFrameSetVisible(RewardsTooltipFrame, false)
            endif
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function FinalizeMainFrame takes nothing returns nothing
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY
        local framehandle titleFrameHandle
        local framehandle submitButtonFrameHandle
        local framehandle resetButtonFrameHandle

        // Compute the main rewards box
        // Width - Main frame margins, all categories and their widths
        set mainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + ((CurrentCategoryIndex - 1) * CATEGORY_SPACING) + (CurrentCategoryIndex * (2 * ICON_WIDTH)) + (CurrentCategoryIndex * ICON_SPACING) + MAIN_FRAME_X_MARGIN
        // Height - Main frame margins, category text and category icons and their spacings
        set mainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - TEXT_HEIGHT - (2 * ICON_WIDTH) - (ICON_SPACING) - ButtonHeight - MAIN_FRAME_Y_BOTTOM_MARGIN

        // Set the frame for the backdrop of the entire rewards
        call BlzFrameSetAbsPoint(RewardsFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X, MAIN_FRAME_TOP_LEFT_Y) 
        call BlzFrameSetAbsPoint(RewardsFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Create the rewards title
        set titleFrameHandle = BlzCreateFrameByType("GLUETEXTBUTTON", "RewardsTitle", RewardsFrameHandle, "ScriptDialogButton", 0) 
        call BlzFrameSetLevel(titleFrameHandle, 2) // To have it appear above the rewards
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.2, MAIN_FRAME_TOP_LEFT_Y + (TITLE_HEIGHT / 2)) 
        call BlzFrameSetAbsPoint(titleFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + (mainFrameBottomRightX - MAIN_FRAME_TOP_LEFT_X) * 0.8, MAIN_FRAME_TOP_LEFT_Y - TITLE_HEIGHT) 
        call BlzFrameSetEnable(titleFrameHandle, true) 
        call BlzFrameSetScale(titleFrameHandle, 1.2) 
        call BlzFrameSetText(titleFrameHandle, REWARDS_TITLE) 
/*
        // Create the submit button
        set submitButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_TOPLEFT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + ButtonHeight) 
        call BlzFrameSetAbsPoint(submitButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + ButtonWidth, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetScale(submitButtonFrameHandle, 1.00) 
        call BlzFrameSetVisible(submitButtonFrameHandle, true)
        call BlzFrameSetText(submitButtonFrameHandle, "|cfffc0d21Submit|r") 
        set SubmitHandleId = GetHandleId(submitButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, submitButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Create the reset button
        set resetButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", RewardsFrameHandle, 0, 0) 
        call BlzFrameSetAbsPoint(resetButtonFrameHandle, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN - ButtonHeight, mainFrameBottomRightY + MAIN_FRAME_Y_TOP_MARGIN + ButtonHeight) 
        call BlzFrameSetAbsPoint(resetButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX - MAIN_FRAME_X_MARGIN, mainFrameBottomRightY + MAIN_FRAME_Y_BOTTOM_MARGIN) 
        call BlzFrameSetScale(resetButtonFrameHandle, 1.00) 
        call BlzFrameSetVisible(resetButtonFrameHandle, true)
        call BlzFrameSetText(resetButtonFrameHandle, "|cfffc0d21Reset|r") 
        set ResetHandleId = GetHandleId(resetButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(IconEventTrigger, resetButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
*/
        // Cleanup
        set submitButtonFrameHandle = null
        set resetButtonFrameHandle = null
        set titleFrameHandle = null
    endfunction
    
    private function CreateCategoryTitle takes string categoryTitle returns nothing
        set CurrentRowIndex = 0
        call CreateCategoryText(categoryTitle)
        set CurrentRowIndex = 1
    endfunction

    private function CreateCategoryReward takes string iconPath, integer rewardIndex returns nothing
        call CreateRewardIcon(iconPath, rewardIndex)
        set CurrentIconIndex = CurrentIconIndex + 1
    endfunction

    private function CreateCategories takes nothing returns nothing
        // Offensive rewards
        call CreateCategoryTitle("Offensive")
        call CreateCategoryReward(OFFENSIVE_STAT_1_ICON, OFFENSIVE_STAT_1_INDEX)
        call CreateCategoryReward(OFFENSIVE_STAT_2_ICON, OFFENSIVE_STAT_2_INDEX)
        call CreateCategoryReward(OFFENSIVE_STAT_3_ICON, OFFENSIVE_STAT_3_INDEX)
        call CreateCategoryReward(OFFENSIVE_STAT_4_ICON, OFFENSIVE_STAT_4_INDEX)

        set RewardTitles[OFFENSIVE_STAT_1_INDEX] = "Offensive Stat 1"
        set RewardTitles[OFFENSIVE_STAT_2_INDEX] = "Offensive Stat 2"
        set RewardTitles[OFFENSIVE_STAT_3_INDEX] = "Offensive Stat 3"
        set RewardTitles[OFFENSIVE_STAT_4_INDEX] = "Offensive Stat 4"
        set RewardDescriptions[OFFENSIVE_STAT_1_INDEX] = "Offensive Stat 1 Description"
        set RewardDescriptions[OFFENSIVE_STAT_2_INDEX] = "Offensive Stat 2 Description"
        set RewardDescriptions[OFFENSIVE_STAT_3_INDEX] = "Offensive Stat 3 Description"
        set RewardDescriptions[OFFENSIVE_STAT_4_INDEX] = "Offensive Stat 4 Description"

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Defensive rewards
        call CreateCategoryTitle("Defensive")
        call CreateCategoryReward(DEFENSIVE_STAT_1_ICON, DEFENSIVE_STAT_1_INDEX)
        call CreateCategoryReward(DEFENSIVE_STAT_2_ICON, DEFENSIVE_STAT_2_INDEX)
        call CreateCategoryReward(DEFENSIVE_STAT_3_ICON, DEFENSIVE_STAT_3_INDEX)
        call CreateCategoryReward(DEFENSIVE_STAT_4_ICON, DEFENSIVE_STAT_4_INDEX)

        set RewardTitles[DEFENSIVE_STAT_1_INDEX] = "Defensive Stat 1"
        set RewardTitles[DEFENSIVE_STAT_2_INDEX] = "Defensive Stat 2"
        set RewardTitles[DEFENSIVE_STAT_3_INDEX] = "Defensive Stat 3"
        set RewardTitles[DEFENSIVE_STAT_4_INDEX] = "Defensive Stat 4"
        set RewardDescriptions[DEFENSIVE_STAT_1_INDEX] = "Defensive Stat 1 Description"
        set RewardDescriptions[DEFENSIVE_STAT_2_INDEX] = "Defensive Stat 2 Description"
        set RewardDescriptions[DEFENSIVE_STAT_3_INDEX] = "Defensive Stat 3 Description"
        set RewardDescriptions[DEFENSIVE_STAT_4_INDEX] = "Defensive Stat 4 Description"

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Utility rewards
        call CreateCategoryTitle("Utility")
        call CreateCategoryReward(UTILITY_STAT_1_ICON, UTILITY_STAT_1_INDEX)
        call CreateCategoryReward(UTILITY_STAT_2_ICON, UTILITY_STAT_2_INDEX)
        call CreateCategoryReward(UTILITY_STAT_3_ICON, UTILITY_STAT_3_INDEX)
        call CreateCategoryReward(UTILITY_STAT_4_ICON, UTILITY_STAT_4_INDEX)

        set RewardTitles[UTILITY_STAT_1_INDEX] = "Utility Stat 1"
        set RewardTitles[UTILITY_STAT_2_INDEX] = "Utility Stat 2"
        set RewardTitles[UTILITY_STAT_3_INDEX] = "Utility Stat 3"
        set RewardTitles[UTILITY_STAT_4_INDEX] = "Utility Stat 4"
        set RewardDescriptions[UTILITY_STAT_1_INDEX] = "Utility Stat 1 Description"
        set RewardDescriptions[UTILITY_STAT_2_INDEX] = "Utility Stat 2 Description"
        set RewardDescriptions[UTILITY_STAT_3_INDEX] = "Utility Stat 3 Description"
        set RewardDescriptions[UTILITY_STAT_4_INDEX] = "Utility Stat 4 Description"

        set CurrentCategoryIndex = CurrentCategoryIndex + 1
    endfunction

    private function InitializeRewards takes nothing returns nothing
        set IconEventHandles = InitHashtable()

        // All buttons use the same trigger. However everything has a unique id to handle later on
        set IconEventTrigger = CreateTrigger()
        call TriggerAddAction(IconEventTrigger, function RewardsMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set RewardsFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetLevel(RewardsFrameHandle, 1)
        call BlzFrameSetVisible(RewardsFrameHandle, true) 

        // Create the primary tooltip window
        set RewardsTooltipFrame = BlzCreateFrame("TooltipText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set RewardsTooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
        set RewardsTooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        call BlzFrameSetLevel(RewardsTooltipFrame, 2) // To have it appear above the rewards
        call BlzFrameSetVisible(RewardsTooltipFrame, false) 

        // Setup the rewards section
        call CreateCategories()

        // Finalize the main window
        call FinalizeMainFrame()
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 0, false, function InitializeRewards)
    endfunction

endlibrary
