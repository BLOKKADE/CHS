library VotingScreen initializer init requires IconFrames, VotingResults

    globals 
        // hastables for each type of vote. Stores the handleid of the framehandle to determine which type of vote it is
        private hashtable RoundButtonEventHandles
        private hashtable AbilityButtonEventHandles
        private hashtable HeroButtonEventHandles
        private hashtable IncomeButtonEventHandles
        private hashtable CheckboxEventHandles
        private integer ImmortalHandleId
        private integer PvpBettingHandleId
        private integer HeroBanningHandleId
        private integer SimultaneousDuelHandleId
        private integer TeamDuelHandleId
        private integer SubmitHandleId

        // Stores the selected and non-selected versions of every button
        private framehandle array SelectedButtonFrameHandles
        private framehandle array ButtonFrameHandles
        
        // Need to store the selected button for each type of vote to easily replace it with the unselected one
        private framehandle CurrentlySelectedRoundFrameHandle
        private framehandle CurrentlySelectedAbilityFrameHandle
        private framehandle CurrentlySelectedHeroFrameHandle
        private framehandle CurrentlySelectedIncomeFrameHandle

        // Description box handle
        private framehandle VoteDescriptionTextDisplay
        private framehandle VoteDescriptionDisplay

        // The only trigger that handles any vote being selected
        private trigger VoteEventTrigger

        // Specifications about the rows/columns
        private integer MaxColumnCount = 4
        private integer CurrentRowIndex = 0
        private integer CurrentColumnIndex = 0
        private integer TotalButtonCount = 0
        private integer TotalVotingTypeCount = 0

        // Specifications about the vote description box
        private real TextAreaWidth = 0.35

        // The X,Y coordinate for the top left of the main frame
        private real MainFrameTopLeftX = 0.02
        private real MainFrameTopLeftY = 0.51
        private real MainFrameMargin = 0.014

        // Specifications for a button
        private real ButtonWidth = 0.116
        private real ButtonHeight = 0.035
        private real ButtonSpacing = 0.005

        // Specifications for a checkbox
        private real CheckboxWidth = 0.025
        private real CheckboxTextWidth = 0.15
        private real CheckboxSpacing = 0.005

        // Specifications for a category text
        private real TextHeight = 0.016
        private real TextWidth = 0.25

        // Voting descriptions
        private string array VotingDescriptions
    endglobals 

    // Returns the index of the type of voting element
    private function GetIndex takes integer buttonType, integer handleId returns integer
        if (buttonType == 1) then
            return LoadInteger(RoundButtonEventHandles, handleId, 1) // Round
        elseif (buttonType == 2) then
            return LoadInteger(AbilityButtonEventHandles, handleId, 1) // Ability
        elseif (buttonType == 3) then
            return LoadInteger(HeroButtonEventHandles, handleId, 1) // Hero
        elseif (buttonType == 4) then
            return LoadInteger(IncomeButtonEventHandles, handleId, 1) // Income               
        elseif (buttonType == 5 or buttonType == 6 or buttonType == 7 or buttonType == 8 or buttonType == 9) then
            return LoadInteger(CheckboxEventHandles, handleId, 1) // Immortal, PVP betting, Hero banning, Simultaneous duels, Team duels
        endif

        return 0
    endfunction

    // Returns a flag for what type of button the framehandle is
    private function GetButtonType takes integer handleId returns integer
        if (LoadInteger(RoundButtonEventHandles, handleId, 1) != 0) then
            return 1 // Round
        elseif (LoadInteger(AbilityButtonEventHandles, handleId, 1) != 0) then
            return 2 // Ability
        elseif (LoadInteger(HeroButtonEventHandles, handleId, 1) != 0) then
            return 3 // Hero
        elseif (LoadInteger(IncomeButtonEventHandles, handleId, 1) != 0) then
            return 4 // Income 
        elseif (handleId == ImmortalHandleId) then
            return 5 // Immortal 
        elseif (handleId == PvpBettingHandleId) then
            return 6 // PVP betting 
        elseif (handleId == HeroBanningHandleId) then
            return 7 // Hero banning
        elseif (handleId == SimultaneousDuelHandleId) then
            return 8 // Simultaneous Duels
        elseif (handleId == TeamDuelHandleId) then
            return 9 // Team Duels
        endif

        return 0
    endfunction

    // Replaces the previously selected button with the unselected button
    private function ReplaceSelectedButton takes integer buttonType, integer index, framehandle currentlySelectedFrameHandle returns nothing
        local integer previousButtonToReplaceIndex

        // Need to deactivate then activate the button to fix it from being stuck
        call BlzFrameSetEnable(currentlySelectedFrameHandle, false)
		call BlzFrameSetEnable(currentlySelectedFrameHandle, true)

        // Hide the button that was just selected. We will replace it with the unselected version of it
        call BlzFrameSetVisible(currentlySelectedFrameHandle, false)

        // Depending on the type of button, find the unselected version of the button the was previously selected
        if (buttonType == 1) then // Round
            set previousButtonToReplaceIndex = LoadInteger(RoundButtonEventHandles, GetHandleId(CurrentlySelectedRoundFrameHandle), 1)
            call BlzFrameSetVisible(CurrentlySelectedRoundFrameHandle, false)
            set CurrentlySelectedRoundFrameHandle = SelectedButtonFrameHandles[index]
        elseif (buttonType == 2) then // Ability
            set previousButtonToReplaceIndex = LoadInteger(AbilityButtonEventHandles, GetHandleId(CurrentlySelectedAbilityFrameHandle), 1)
            call BlzFrameSetVisible(CurrentlySelectedAbilityFrameHandle, false)
            set CurrentlySelectedAbilityFrameHandle = SelectedButtonFrameHandles[index]
        elseif (buttonType == 3) then // Hero
            set previousButtonToReplaceIndex = LoadInteger(HeroButtonEventHandles, GetHandleId(CurrentlySelectedHeroFrameHandle), 1)
            call BlzFrameSetVisible(CurrentlySelectedHeroFrameHandle, false)
            set CurrentlySelectedHeroFrameHandle = SelectedButtonFrameHandles[index]
        elseif (buttonType == 4) then // Income       
            set previousButtonToReplaceIndex = LoadInteger(IncomeButtonEventHandles, GetHandleId(CurrentlySelectedIncomeFrameHandle), 1)
            call BlzFrameSetVisible(CurrentlySelectedIncomeFrameHandle, false)
            set CurrentlySelectedIncomeFrameHandle = SelectedButtonFrameHandles[index]                   
        endif

        // Show the unselected version of the previous button, and show the selected version of the selected button
        call BlzFrameSetVisible(ButtonFrameHandles[previousButtonToReplaceIndex], true)
        call BlzFrameSetVisible(SelectedButtonFrameHandles[index], true)
    endfunction

    // Sets the vote
    private function SetButtonVote takes PlayerVotes pv, integer buttonType, integer index returns nothing
        if (buttonType == 1) then // Round
            call pv.setRoundVote(index)
        elseif (buttonType == 2) then // Ability
            call pv.setAbilityVote(index - RoundButtonCount)
        elseif (buttonType == 3) then // Hero
            call pv.setHeroVote(index - RoundButtonCount - AbilityButtonCount)
        elseif (buttonType == 4) then // Income     
            call pv.setIncomeVote(index - RoundButtonCount - AbilityButtonCount - HeroButtonCount)
        endif
    endfunction

    private function SetCheckboxVote takes PlayerVotes pv, integer value, integer handleId returns nothing
        if (handleId == ImmortalHandleId) then // Immortal
            call pv.setImmortalVote(value)
        elseif (handleId == PvpBettingHandleId) then // PVP betting
            call pv.setPvpBettingVote(value)
        elseif (handleId == HeroBanningHandleId) then // Hero Banning
            call pv.setHeroBanningVote(value)
        elseif (handleId == SimultaneousDuelHandleId) then // Simultaneous Duels
            call pv.setSimultaneousDuelVote(value)
        elseif (handleId == TeamDuelHandleId) then // Team Duels
            call BJDebugMsg("duel vote value: " + I2S(value))
            call pv.setTeamDuelVote(value)
        endif
    endfunction

    private function VotingMouseEventActions takes nothing returns nothing
        local integer buttonType = GetButtonType(GetHandleId(BlzGetTriggerFrame()))
		local integer index = GetIndex(buttonType, GetHandleId(BlzGetTriggerFrame()))
        local PlayerVotes pv = PlayerVotes(GetPlayerId(GetTriggerPlayer()) + 1)

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            // Count how many people have actually voted. Can end the voting early if everyone votes
            if SubmitHandleId == GetHandleId(BlzGetTriggerFrame()) then
                if GetLocalPlayer() == GetTriggerPlayer() then
                    call BlzFrameSetVisible(MainVotingFrameHandle, false)
                endif

                // A legacy global variable that tracks how many people are done voting
                set udg_integer63 = udg_integer63 + 1
                call ConditionalTriggerExecute(udg_trigger77)

                // Show a message if the player needs to wait for other players
                if (udg_integer63 < PlayerCount) then
                    call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,5,"Please wait for other players to vote")
                endif

                return
            endif

            if GetLocalPlayer() == GetTriggerPlayer() then
                call ReplaceSelectedButton(buttonType, index, BlzGetTriggerFrame())
            endif

            call SetButtonVote(pv, buttonType, index)
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            // We are hijacking the tooltip window that we use for almost everything else in the game from IconFrames
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(VoteDescriptionTextDisplay, VotingDescriptions[index])
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
            // Empty the text box
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(VoteDescriptionTextDisplay, "")
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_CHECKED then
            call SetCheckboxVote(pv, 2, GetHandleId(BlzGetTriggerFrame()))
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_CHECKBOX_UNCHECKED then
            call SetCheckboxVote(pv, 1, GetHandleId(BlzGetTriggerFrame()))
        endif
    endfunction

    // Functions to get X,Y coordinates for a button
    private function GetTopLeftButtonX takes nothing returns real
        return MainFrameTopLeftX + MainFrameMargin + (CurrentColumnIndex * ButtonWidth) + (CurrentColumnIndex * ButtonSpacing)
    endfunction

    private function GetTopLeftButtonY takes nothing returns real
        return MainFrameTopLeftY - MainFrameMargin - (ButtonHeight * CurrentRowIndex) - (ButtonSpacing * CurrentRowIndex) - (TextHeight * TotalVotingTypeCount)
    endfunction
    
    // Functions to get X,Y coordinates for a checkbox
    private function GetTopLeftCheckboxX takes nothing returns real
        return MainFrameTopLeftX + MainFrameMargin + (CurrentColumnIndex * CheckboxTextWidth) + (CurrentColumnIndex * CheckboxWidth)
    endfunction

    private function GetTopLeftCheckboxY takes nothing returns real
        return MainFrameTopLeftY - MainFrameMargin - (ButtonHeight * CurrentRowIndex) - (CheckboxSpacing * CurrentRowIndex) - (TextHeight * TotalVotingTypeCount)
    endfunction

    // Start writing new UI on a new row
    private function GoToNextRow takes nothing returns nothing
        if (CurrentColumnIndex != 0 and TotalButtonCount != 0) then
            set CurrentRowIndex = CurrentRowIndex + 1
        endif

        // Reset back to the beginning
        set CurrentColumnIndex = 0
    endfunction

    // Creates Text for the new category
    private function CreateVotingButtonCategory takes string value returns nothing
        local framehandle votingCategoryFrameHandle = BlzCreateFrameByType("TEXT", "VotingTypeName", MainVotingFrameHandle, "", 0) 

        call GoToNextRow()

        call BlzFrameSetAbsPoint(votingCategoryFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftButtonX(), GetTopLeftButtonY()) 
        call BlzFrameSetAbsPoint(votingCategoryFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftButtonX() + TextWidth, GetTopLeftButtonY() - TextHeight) 
        call BlzFrameSetText(votingCategoryFrameHandle, value) 
        call BlzFrameSetEnable(votingCategoryFrameHandle, false) 
        call BlzFrameSetScale(votingCategoryFrameHandle, 1.5) 
        call BlzFrameSetTextAlignment(votingCategoryFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        set TotalVotingTypeCount = TotalVotingTypeCount + 1

        // Cleanup
        set votingCategoryFrameHandle = null
    endfunction

    private function CreateSubmitButton takes real bottomRightX, real bottomRightY returns nothing
        // First create the button
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", MainVotingFrameHandle, 0, 0) 

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, bottomRightX - ButtonWidth - MainFrameMargin, bottomRightY + ButtonHeight + MainFrameMargin) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, bottomRightX - MainFrameMargin, bottomRightY + MainFrameMargin) 
        call BlzFrameSetScale(buttonFrameHandle, 1.00) 
        call BlzFrameSetVisible(buttonFrameHandle, true)
        call BlzFrameSetText(buttonFrameHandle, "|cfffc0d21Submit|r") 

        // Save the handles of the buttons to look it up later for mouse events
        set SubmitHandleId = GetHandleId(buttonFrameHandle)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)

        // Cleanup
        set buttonFrameHandle = null
    endfunction

    private function CreateVotingButton takes string buttonText, string description, hashtable buttonEventHandles, boolean isSelectedByDefault returns framehandle
        // First create the button
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", MainVotingFrameHandle, 0, 0) 
        local framehandle selectedButtonFrameHandle = BlzCreateFrame("QuestButtonPushedBackdropTemplate", MainVotingFrameHandle, 0, 0) 
        local framehandle clickedButtonTextFrameHandle = BlzCreateFrameByType("TEXT", "ClickedButtonTextName", selectedButtonFrameHandle, "", 0) 

        // Keep a count of every button we make
        set TotalButtonCount = TotalButtonCount + 1

        set SelectedButtonFrameHandles[TotalButtonCount] = selectedButtonFrameHandle
        set ButtonFrameHandles[TotalButtonCount] = buttonFrameHandle

        // Need to put text over the selected button since it doesn't have text functionality
        call BlzFrameSetAbsPoint(clickedButtonTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftButtonX(), GetTopLeftButtonY()) 
        call BlzFrameSetAbsPoint(clickedButtonTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftButtonX() + ButtonWidth, GetTopLeftButtonY() - ButtonHeight - 0.002) 
        call BlzFrameSetText(clickedButtonTextFrameHandle, "|cffFA8037" + buttonText + "|r") 
        call BlzFrameSetEnable(clickedButtonTextFrameHandle, false) 
        call BlzFrameSetScale(clickedButtonTextFrameHandle, 1.45) 
        call BlzFrameSetTextAlignment(clickedButtonTextFrameHandle, TEXT_JUSTIFY_CENTER, TEXT_JUSTIFY_MIDDLE)

        // This type of button has functionality to set text in it
        call BlzFrameSetText(buttonFrameHandle, buttonText) 
            
        // Dimensions for the buttons
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftButtonX(), GetTopLeftButtonY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftButtonX() + ButtonWidth, GetTopLeftButtonY() - ButtonHeight) 
        call BlzFrameSetScale(buttonFrameHandle, 1.00) 
        call BlzFrameSetVisible(buttonFrameHandle, not isSelectedByDefault)

        call BlzFrameSetAbsPoint(selectedButtonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftButtonX(), GetTopLeftButtonY()) 
        call BlzFrameSetAbsPoint(selectedButtonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftButtonX() + ButtonWidth, GetTopLeftButtonY() - ButtonHeight) 
        call BlzFrameSetScale(selectedButtonFrameHandle, 1.00) 
        call BlzFrameSetVisible(selectedButtonFrameHandle, isSelectedByDefault)

        // Save the handles of the buttons to look it up later for mouse events
        call SaveInteger(buttonEventHandles, GetHandleId(buttonFrameHandle), 1, TotalButtonCount)
        call SaveInteger(buttonEventHandles, GetHandleId(selectedButtonFrameHandle), 1, TotalButtonCount)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

        // Make a pretty description
        set description = "|cffFA8037" + buttonText + "|r|n|n" + description

        // Save the description
        set VotingDescriptions[TotalButtonCount] = description

        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Check if we need to go to the next row
        if (CurrentColumnIndex == MaxColumnCount) then
            set CurrentRowIndex = CurrentRowIndex + 1
            set CurrentColumnIndex = 0
        endif

        // Cleanup
        set buttonFrameHandle = null
        set clickedButtonTextFrameHandle = null

        return selectedButtonFrameHandle
    endfunction
    
    private function CreateVotingCheckbox takes string checkboxText, string description, boolean preSelected returns integer
        // First create the checkbox
        local framehandle checkboxFrameHandle = BlzCreateFrame("QuestCheckBox", MainVotingFrameHandle, 0, 0) 
        local framehandle checkboxTextFrameHandle = BlzCreateFrameByType("TEXT", "CheckboxText", MainVotingFrameHandle, "", 0) 
        local integer checkboxFrameHandleId = GetHandleId(checkboxFrameHandle)
        
        // Keep a count of every button we make
        set TotalButtonCount = TotalButtonCount + 1

        // Dimensions for the button
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftCheckboxX(), GetTopLeftCheckboxY()) 
        call BlzFrameSetAbsPoint(checkboxFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftCheckboxX() + CheckboxWidth, GetTopLeftCheckboxY() - CheckboxWidth) 

        // Setup the checkbox text
        call BlzFrameSetAbsPoint(checkboxTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftCheckboxX() + 0.029, GetTopLeftCheckboxY() - 0.007) 
        call BlzFrameSetAbsPoint(checkboxTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftCheckboxX() + 0.029 + CheckboxTextWidth, GetTopLeftCheckboxY() - 0.014) 
        call BlzFrameSetText(checkboxTextFrameHandle, checkboxText) 
        call BlzFrameSetEnable(checkboxTextFrameHandle, false) 
        call BlzFrameSetScale(checkboxTextFrameHandle, 1.1) 
        call BlzFrameSetTextAlignment(checkboxTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(CheckboxEventHandles, GetHandleId(checkboxFrameHandle), 1, TotalButtonCount)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_CHECKED)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, checkboxFrameHandle, FRAMEEVENT_CHECKBOX_UNCHECKED)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(VoteEventTrigger, checkboxFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

        // Make a pretty description
        set description = "|cffFA8037" + checkboxText + "|r|n|n" + description

        // Save the description
        set VotingDescriptions[TotalButtonCount] = description

        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Check if we need to go to the next row
        if (CurrentColumnIndex == MaxColumnCount) then
            set CurrentRowIndex = CurrentRowIndex + 1
            set CurrentColumnIndex = 0
        endif

        // Cleanup
        set checkboxFrameHandle = null
        set checkboxTextFrameHandle = null

        return checkboxFrameHandleId
    endfunction

    private function CreateRoundButton takes string name, string description, boolean isSelectedByDefault returns nothing
        local framehandle buttonFrameHandle = CreateVotingButton(name, description, RoundButtonEventHandles, isSelectedByDefault)

        set RoundButtonCount = RoundButtonCount + 1

        if isSelectedByDefault then
            set CurrentlySelectedRoundFrameHandle = buttonFrameHandle
        endif

        // Cleanup
        set buttonFrameHandle = null
    endfunction

    private function CreateAbilityButton takes string name, string description, boolean isSelectedByDefault returns nothing
        local framehandle buttonFrameHandle = CreateVotingButton(name, description, AbilityButtonEventHandles, isSelectedByDefault)

        set AbilityButtonCount = AbilityButtonCount + 1

        if isSelectedByDefault then
            set CurrentlySelectedAbilityFrameHandle = buttonFrameHandle
        endif

        // Cleanup
        set buttonFrameHandle = null
    endfunction

    private function CreateHeroButton takes string name, string description, boolean isSelectedByDefault returns nothing
        local framehandle buttonFrameHandle = CreateVotingButton(name, description, HeroButtonEventHandles, isSelectedByDefault)

        set HeroButtonCount = HeroButtonCount + 1

        if isSelectedByDefault then
            set CurrentlySelectedHeroFrameHandle = buttonFrameHandle
        endif

        // Cleanup
        set buttonFrameHandle = null
    endfunction

    private function CreateIncomeButton takes string name, string description, boolean isSelectedByDefault returns nothing
        local framehandle buttonFrameHandle = CreateVotingButton(name, description, IncomeButtonEventHandles, isSelectedByDefault)

        set IncomeButtonCount = IncomeButtonCount + 1

        if isSelectedByDefault then
            set CurrentlySelectedIncomeFrameHandle = buttonFrameHandle
        endif

        // Cleanup
        set buttonFrameHandle = null
    endfunction

    private function init takes nothing returns nothing
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY

        set RoundButtonEventHandles = InitHashtable()
        set AbilityButtonEventHandles = InitHashtable()
        set HeroButtonEventHandles = InitHashtable()
        set IncomeButtonEventHandles = InitHashtable()
        set CheckboxEventHandles = InitHashtable()

        set VoteEventTrigger = CreateTrigger()

        // Create the main frame, hide it by default. All vote elements use this frame as the parent
        set MainVotingFrameHandle = BlzCreateFrame("CheckListBox", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetVisible(MainVotingFrameHandle, false)

        // All buttons use the same trigger. However everything has a unique id to handle later on
        call TriggerAddAction(VoteEventTrigger, function VotingMouseEventActions)

        // The order this is created in, is the order the buttons appear in the row(s)
        call CreateVotingButtonCategory("|cffD26EFARounds|r")
        call CreateRoundButton("50 rounds", "The game lasts 50 rounds with 10 rounds of PvP and a battle royale at the end. |n|nLasts around 60 minutes on average.", true)
        call CreateRoundButton("25 rounds", "The game lasts 25 rounds with 5 rounds of PvP and a battle royale at the end. |n|nLasts around 30 minutes on average.", false)

        call CreateVotingButtonCategory("|cffD26EFAAbilities|r")
        call CreateAbilityButton("Pick", "Every player can choose their abilities to learn from any of the ability shops.", false)
        call CreateAbilityButton("Random", "Every player can only buy a random ability from either of the Power Up Shops.", false)
        call CreateAbilityButton("Draft", "You get to choose between 5 spells each time.|nDraft spells refresh each time you buy one.|nEach spell only shows up once per game per player.", true)

        call CreateVotingButtonCategory("|cffD26EFAHeroes|r")
        call CreateHeroButton("Pick", "Every player can choose any hero.", false)
        call CreateHeroButton("Random", "Every player gets a random hero and 300 bonus starting gold.", false)
        call CreateHeroButton("Draft", "Every player gets 5 random heroes to choose from.", true)
        call CreateHeroButton("Same-Draft", "Every player gets the same 5 random heroes to choose from.", false)

        call CreateVotingButtonCategory("|cffD26EFAIncome|r")
        call CreateIncomeButton("Auto-Eco", "Pillage, Learnability, Holy Enlightenment and Midas Touch disabled. |nCreeps give more gold and experience after round 5. |nCreeps cannot be upgraded manually, instead it happens automatically starting from round 15.", true)
        call CreateIncomeButton("Individual", "All players can manually increase their income by buying creep upgrades. |nCreep upgrades only apply to creeps in your own arena.", false)
        call CreateIncomeButton("Global", "All players can manually increase their income by buying creep upgrades. |nCreep upgrades apply to creeps in your own arena and at 1/4th the power to all other player's creeps.", false)
        call CreateIncomeButton("Disabled", "Players can not buy creep upgrades or upgrade their end of round income in any way. Creeps gain no bonus power.", false)

        call CreateVotingButtonCategory("|cffD26EFAOther Options|r")
        set ImmortalHandleId = CreateVotingCheckbox("Immortal Mode", "Unlimited lives with immortal mode. Otherwise, you are given a few lives. Once you lose them all, you lose the game.", false)
        set PvpBettingHandleId = CreateVotingCheckbox("PVP Betting", "Enable bets during PVP matches.", false)
        set HeroBanningHandleId = CreateVotingCheckbox("Hero Banning", "Every player can ban a hero. |n|nApplies to every Hero selection mode.", false)
        call GoToNextRow()
        set SimultaneousDuelHandleId = CreateVotingCheckbox("Disable Simultaneous Duels", "PVP duels will run simultaneously instead of one by one. |n|nGames will run faster, but you won't be able to watch every duel. |n|nThis will also disable PVP betting.", true)
        set TeamDuelHandleId = CreateVotingCheckbox("Disable Team Duels", "There is a chance that a PVP duel will be a 2v2 PVP duel. |n|nWill only happen if there is an even amount of players in the game.", true)

        // Compute the main voting box based on how many buttons there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameMargin) + (IMinBJ(MaxColumnCount, TotalButtonCount) * ButtonWidth) + ((IMinBJ(MaxColumnCount, TotalButtonCount) - 1) * ButtonSpacing)
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameMargin) - ((CurrentRowIndex + 1) * ButtonHeight) - (CurrentRowIndex * ButtonSpacing) - (TextHeight * TotalVotingTypeCount)

        // Set the frame for the backdrop of the entire voting screen
        call BlzFrameSetAbsPoint(MainVotingFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(MainVotingFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 

        // Add the submit button to the bottom right of the voting screen
        call CreateSubmitButton(mainFrameBottomRightX, mainFrameBottomRightY)

        // Create the box for the descriptions 
        set VoteDescriptionDisplay = BlzCreateFrame("CheckListBox", MainVotingFrameHandle, 0, 0)
        call BlzFrameSetAbsPoint(VoteDescriptionDisplay, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(VoteDescriptionDisplay, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX + .1 + TextAreaWidth, mainFrameBottomRightY) 

        // Create the actual text element that shows the descriptions
        set VoteDescriptionTextDisplay = BlzCreateFrameByType("TEXT", "VoteDescriptionTextArea", MainVotingFrameHandle, "", 0)    
        call BlzFrameSetAbsPoint(VoteDescriptionTextDisplay, FRAMEPOINT_TOPLEFT, mainFrameBottomRightX + (1.3 * MainFrameMargin), MainFrameTopLeftY - (1.3 * MainFrameMargin)) 
        call BlzFrameSetAbsPoint(VoteDescriptionTextDisplay, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX + TextAreaWidth - .1, mainFrameBottomRightY + MainFrameMargin)
        call BlzFrameSetEnable(VoteDescriptionTextDisplay, false) 
        call BlzFrameSetScale(VoteDescriptionTextDisplay, 1.5) 
        call BlzFrameSetTextAlignment(VoteDescriptionTextDisplay, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT)
    endfunction

endlibrary
