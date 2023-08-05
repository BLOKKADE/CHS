library BattleCreator initializer init requires PlayerTracking, Utility, BattleCreatorManager, IconFrames

    globals
        // Static messages
        private constant string BATTLE_CREATOR_TITLE                    = "|cff2ff1ffBattle Creator - Customize Your BR Experience|r"

        private constant string CLOSE_BUTTON_ICON                       = "ReplaceableTextures\\CommandButtons\\BTNuncheck.blp"

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
        private constant real CLOSE_ICON_WIDTH                          = 0.032

        // Specifications for a player name text
        private constant real TEXT_HEIGHT                               = 0.009
        private constant real TEXT_WIDTH                                = 0.1
        private constant real TEXT_SPACING                              = 0.014

        // Specifications for a checkbox
        private constant real CHECKBOX_WIDTH                            = 0.025
        private constant real CHECKBOX_TEXT_WIDTH                       = 0.15
        private constant real CHECKBOX_SPACING                          = 0.005
        private constant real MESSAGE_TEXT_WIDTH                        = 0.35

        // The only trigger that handles hovering over icons and clicking buttons
        private trigger EventTrigger

        private integer CloseHandleId

        private framehandle BattleCreatorTooltipFrame
		private framehandle BattleCreatorTooltipTitleFrame
		private framehandle BattleCreatorTooltipTextFrame

        private integer CurrentCategoryIndex
        private integer CurrentPlayerSlotIndex
        private integer CurrentRowIndex

        private real MainFrameBottomRightX
        private real MainFrameBottomRightY
    endglobals

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
        call BlzFrameSetScale(playerNameTextFrameHandle, 1.0) 
        call BlzFrameSetTextAlignment(playerNameTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_LEFT) 
        call BlzFrameSetVisible(playerNameTextFrameHandle, false)

        // Cleanup
        set battleIconParentFrameHandle = null
        set battleIconFrameHandle = null
        set playerNameTextFrameHandle = null
    endfunction

    private function CreateCategoryButton takes string value, string title, string description returns framehandle
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

        set BRHandleDescriptions.string[frameHandleId] = description
        set BRHandleTitles.string[frameHandleId] = title

        return buttonFrameHandle
    endfunction

    private function CreateCheckbox takes string checkboxText, string title, string description returns framehandle
        // First create the checkbox
        local real x = GetTopLeftX()
        local real y = GetTopLeftY()
        local framehandle checkboxFrameHandle = BlzCreateFrame("QuestCheckBox", BattleCreatorFrameHandle, 0, 0) 
        local integer checkboxFrameHandleId = GetHandleId(checkboxFrameHandle)

        set BRCheckboxTextFrameHandle = BlzCreateFrameByType("TEXT", "CheckboxText", BattleCreatorFrameHandle, "", 0) 
        set BRMessageTextFrameHandle = BlzCreateFrameByType("TEXT", "MessageText", BattleCreatorFrameHandle, "", 0) 

        // Dimensions for the button
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_TOPLEFT, x, y) 
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + CHECKBOX_WIDTH, y - CHECKBOX_WIDTH) 

        // Setup the checkbox text
        call BlzFrameSetAbsPoint(BRCheckboxTextFrameHandle, FRAMEPOINT_TOPLEFT, x + 0.029, y - 0.008) 
        call BlzFrameSetAbsPoint(BRCheckboxTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + 0.029 + CHECKBOX_TEXT_WIDTH, y - 0.015) 
        call BlzFrameSetText(BRCheckboxTextFrameHandle, checkboxText) 
        call BlzFrameSetEnable(BRCheckboxTextFrameHandle, false) 
        call BlzFrameSetScale(BRCheckboxTextFrameHandle, 1.2) 
        call BlzFrameSetTextAlignment(BRCheckboxTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        // Setup the message text
        call BlzFrameSetAbsPoint(BRMessageTextFrameHandle, FRAMEPOINT_TOPLEFT, x + 0.029 + CHECKBOX_TEXT_WIDTH, y - 0.008) 
        call BlzFrameSetAbsPoint(BRMessageTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, x + 0.029 + CHECKBOX_TEXT_WIDTH + MESSAGE_TEXT_WIDTH, y - 0.015) 
        call BlzFrameSetText(BRMessageTextFrameHandle, "") 
        call BlzFrameSetEnable(BRMessageTextFrameHandle, false) 
        call BlzFrameSetScale(BRMessageTextFrameHandle, 1.2) 
        call BlzFrameSetTextAlignment(BRMessageTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        // Save the handle of this button to look it up later for mouse events
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_CHECKED)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_UNCHECKED)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(EventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

        set BRHandleDescriptions.string[checkboxFrameHandleId] = description
        set BRHandleTitles.string[checkboxFrameHandleId] = title

        return checkboxFrameHandle
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

            if (handleId == CloseHandleId) then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetVisible(BattleCreatorFrameHandle, false) 
                    call PlayerStats.forPlayer(triggerPlayer).setHasBattleCreatorOpen(false)
                endif
            elseif (IsPlayerInForce(triggerPlayer, BRRandomTeam)) then
                if (GetLocalPlayer() == triggerPlayer) then	
                    call BlzFrameSetText(BRMessageTextFrameHandle, BR_MESSAGE_COLOR + "You must unselect from the Random Teams Vote first!" + BR_COLOR_END_TAG)
                    call BlzFrameSetVisible(BRMessageTextFrameHandle, true)
                endif
            elseif (handleId == GetHandleId(ObserverHandle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRObservers)
            elseif (handleId == GetHandleId(SoloHandle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRSolo)
            elseif (handleId == GetHandleId(Team1Handle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam1)
            elseif (handleId == GetHandleId(Team2Handle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam2)
            elseif (handleId == GetHandleId(Team3Handle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam3)
            elseif (handleId == GetHandleId(Team4Handle)) then
                set change = TryMovePlayerToForce(triggerPlayer, BRTeam4)
            endif
            
        elseif (BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER) then
            set tooltipName = BRHandleTitles.string[handleId]
            set tooltipDescription = BRHandleDescriptions.string[handleId]

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
            call ForceRemovePlayer(BRRandomTeam, triggerPlayer) // Force remove since it's the only way to leave this force
            set change = TryMovePlayerToForce(triggerPlayer, BRObservers)
        endif

        if (change) then
            if (GetLocalPlayer() == triggerPlayer) then	
                call BlzFrameSetVisible(BRMessageTextFrameHandle, false)
            endif

            call UpdateBRPlayerSlots()
            call UpdateRandomTeamVoteText()
        endif

        // Cleanup
        set currentFrameHandle = null
        set triggerPlayer = null
    endfunction

    private function FinalizeMainFrame takes nothing returns nothing
        local framehandle titleFrameHandle
        local framehandle closeButtonFrameHandle
        local framehandle closeIconButtonFrameHandle

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

        // Create the close button
        set closeButtonFrameHandle = BlzCreateFrame("ScriptDialogButton", BattleCreatorFrameHandle, 0, 0) 
        set closeIconButtonFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", closeButtonFrameHandle, "", 1)
        call BlzFrameSetPoint(closeButtonFrameHandle, FRAMEPOINT_TOPRIGHT, BattleCreatorFrameHandle, FRAMEPOINT_TOPRIGHT, -(CLOSE_ICON_WIDTH / 4), -(CLOSE_ICON_WIDTH / 4))
        call BlzFrameSetAllPoints(closeIconButtonFrameHandle, closeButtonFrameHandle) 
        call BlzFrameSetTexture(closeIconButtonFrameHandle, CLOSE_BUTTON_ICON, 0, true) 
        call BlzFrameSetSize(closeButtonFrameHandle, CLOSE_ICON_WIDTH, CLOSE_ICON_WIDTH)
        set CloseHandleId = GetHandleId(closeButtonFrameHandle)
        call BlzTriggerRegisterFrameEvent(EventTrigger, closeButtonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Cleanup
        set titleFrameHandle = null
        set closeButtonFrameHandle = null
        set closeIconButtonFrameHandle = null
    endfunction
    
    private function CreatePlayerForceSectionButton takes string categoryName, string title, string description returns framehandle
        local framehandle frameHandle

        set CurrentRowIndex = 0
        set frameHandle = CreateCategoryButton(categoryName, title, description)
        set CurrentRowIndex = 1

        return frameHandle
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

        // Observers
        set ObserverHandle = CreatePlayerForceSectionButton(BR_OBSERVERS_COLOR + "Observers" + BR_COLOR_END_TAG, "Join the Observers", "Join the Observers. You won't be in the next fight.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Solo
        set SoloHandle = CreatePlayerForceSectionButton(BR_SOLO_COLOR + "Solo" + BR_COLOR_END_TAG, "Play Solo", "Fight alone in the next fight. Even if there are teams.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        set RandomTeamHandle = CreateCheckbox(BR_RANDOM_TEAM_COLOR + "Random Teams (0/0)" + BR_COLOR_END_TAG, "Vote on Random Teams", "If majority vote, all players will be randomly assigned|nto teams. If not enough votes, voters will fight solo.|n")

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 1
        set Team1Handle = CreatePlayerForceSectionButton(BR_TEAM_1_COLOR + "Team 1" + BR_COLOR_END_TAG, "Join a Team", "Join Team 1 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 2
        set Team2Handle = CreatePlayerForceSectionButton(BR_TEAM_2_COLOR + "Team 2" + BR_COLOR_END_TAG, "Join a Team", "Join Team 2 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 3
        set Team3Handle = CreatePlayerForceSectionButton(BR_TEAM_3_COLOR + "Team 3" + BR_COLOR_END_TAG, "Join a Team", "Join Team 3 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots

        set CurrentCategoryIndex = CurrentCategoryIndex + 1

        // Team 4
        set Team4Handle = CreatePlayerForceSectionButton(BR_TEAM_4_COLOR + "Team 4" + BR_COLOR_END_TAG, "Join a Team", "Join Team 4 and fight together to defeat everyone else.|n")
        call CreatePlayerForcePlayerSlots() // Creates all 8 slots
    endfunction

    private function InitializeBattleCreator takes nothing returns nothing
        // All buttons use the same trigger. However everything has a unique id to handle later on
        set EventTrigger = CreateTrigger()
        call TriggerAddAction(EventTrigger, function BattleCreatorMouseEventActions)

        // Create the main frame. All elements use this frame as the parent
        set BattleCreatorFrameHandle = BlzCreateFrame("EscMenuBackdrop", BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0), 0, 0) 
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
        // Compute the main battle creator box
        // Width - Main frame margins, all categories and their widths
        set MainFrameBottomRightX = MAIN_FRAME_TOP_LEFT_X + MAIN_FRAME_X_MARGIN + 4 * (BUTTON_WIDTH) + 3 * (CATEGORY_SPACING) + MAIN_FRAME_X_MARGIN
        // Height - Main frame margins, category text and category icons and their spacings
        set MainFrameBottomRightY = MAIN_FRAME_TOP_LEFT_Y - MAIN_FRAME_Y_TOP_MARGIN - BUTTON_HEIGHT - BUTTON_SPACING - (4 * TEXT_HEIGHT) - (4 * TEXT_SPACING) - BUTTON_HEIGHT - BUTTON_SPACING - (8 * TEXT_HEIGHT) - (7 * TEXT_SPACING) - MAIN_FRAME_Y_BOTTOM_MARGIN

        call TimerStart(CreateTimer(), 4, false, function InitializeBattleCreator)
    endfunction

endlibrary
