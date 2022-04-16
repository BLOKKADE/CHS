library HatsFrame initializer init uses PlayerTracking, IdLibrary, FrameInit, MathRound

    globals 
        private framehandle MainHatFrameHandle 
        private hashtable HatButtonEventHandles
        private trigger HatButtonEventTrigger

        // Specifications about the rows/columns
        private integer MaxColumnCount = 4
        private integer CurrentColumnCount = 0
        private integer CurrentHatIndex = 0
        private integer CurrentRowIndex = 0

        // The X,Y coordinate for the top left of the main frame
        private real MainFrameTopLeftX = 0.622190
        private real MainFrameTopLeftY = 0.415688

        // Specifications for a button
        private real ButtonWidth = 0.025
        private real ButtonSpacing = 0.005
        private real MainFrameMargin = 0.014

        // Mapping between the icon and the hat model
        private string array HatIndexes

        // Very temporary variables because interfaces suck in vjass
        private boolean HasRequirementTemp
        private string HasRequirementNameTemp
    endglobals 

    public function TryToWearHat takes integer hatIndex, player p, boolean showMessage returns nothing
        local integer heroPlayerId = GetPlayerId(p) + 1
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local HatRequirements hr = HatRequirements.forHatIndex(hatIndex)

        // Check if the hat can even be worn
        if (hr != 0 and not hr.checkHatRequirements(ps)) then
            call DisplayTimedTextToPlayer(p,0,0,5,"You do not have the required achievements for this hat")
            set hatIndex = 0
        endif

        // Remove whatever the hero is currently wearing
        if (ps.getCurrentHatEffect() != null) then
            call BlzSetSpecialEffectScale(ps.getCurrentHatEffect(), 0)
            call ps.setCurrentHatEffect(null)
        endif

        // Wear the hat if it wasn't the same the hero was currently wearing
        if (ps.getHatIndex() != hatIndex and HatIndexes[hatIndex] != null) then
            if (showMessage) then
                call DisplayTimedTextToPlayer(p,0,0,5,"Please wait, loading hat..")
            endif

            call ps.setCurrentHatEffect(AddSpecialEffectTarget(HatIndexes[hatIndex], PlayerHeroes[heroPlayerId], "head"))
            call BlzSetSpecialEffectScale(ps.getCurrentHatEffect(), 3.0) // Current scaling is 300%. We can add customization to this per hat if needed
            call ps.setHatIndex(hatIndex)
        else
            // Player took the hat off
            call ps.setHatIndex(0)
        endif
    endfunction

    private function HatMouseEventActions takes nothing returns nothing
		local integer hatIndex = LoadInteger(HatButtonEventHandles, GetHandleId(BlzGetTriggerFrame()), 1)
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())
        local HatRequirements hr = HatRequirements.forHatIndex(hatIndex)

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            call BlzFrameSetEnable(BlzGetTriggerFrame(), false) 
            call BlzFrameSetEnable(BlzGetTriggerFrame(), true) 

            // Try to wear the hat
            call TryToWearHat(hatIndex, GetTriggerPlayer(), true)
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            // We are hijacking the tooltip window that we use for almost everything else in the game from FrameInit
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(TooltipTitleFrame, hr.getHatRequirementDescription(ps))
                call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(hr.getHatRequirementDescription(ps)))
                call BlzFrameSetVisible(Tooltip, true)
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_LEAVE then
            // Empty the text box
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(TooltipTextFrame, "")
                call BlzFrameSetVisible(Tooltip, false)
            endif
        endif
    endfunction

    private function GetTopLeftX takes integer hatIndex returns real
        local integer columnIndex = (hatIndex - 1) - (CurrentRowIndex * MaxColumnCount)

        return MainFrameTopLeftX + MainFrameMargin + (columnIndex * ButtonWidth) + (columnIndex * ButtonSpacing)
    endfunction

    private function GetTopLeftY takes nothing returns real
        return MainFrameTopLeftY - MainFrameMargin - (ButtonWidth * CurrentRowIndex) - (ButtonSpacing * CurrentRowIndex)
    endfunction

    private function CreateHatButton takes string iconPath, string hatModelPath returns nothing
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", MainHatFrameHandle, 0, 0) 
        local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "HatBackdrop", buttonFrameHandle, "", 1) 

        set CurrentHatIndex = CurrentHatIndex + 1

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(CurrentHatIndex), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX(CurrentHatIndex) + ButtonWidth, GetTopLeftY() - ButtonWidth) 

        // Apply the icon
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(HatButtonEventHandles, GetHandleId(buttonFrameHandle), 1, CurrentHatIndex)
        call BlzTriggerRegisterFrameEvent(HatButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(HatButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(HatButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)

        // Save the hat properties for this hat index
        set HatIndexes[CurrentHatIndex] = hatModelPath

        // Check if we need to go to the next row
        if (ModuloInteger(CurrentHatIndex, MaxColumnCount) == 0) then
            set CurrentRowIndex = CurrentRowIndex + 1
        endif

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    // An interface used to add different types of achievement checks
    private function interface HatRequirementCheck takes PlayerStats ps, integer requirement returns nothing

    private function BRAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer brWins = ps.getAPBRAllWins() + ps.getARBRAllWins() + ps.getDraftBRAllWins()

        set HasRequirementTemp = brWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " BR wins between |n all 3 game modes."

        if (HasRequirementTemp) then
            set HasRequirementNameTemp = HasRequirementNameTemp + "|cff00ff0d - Achieved!|r"
        else
            set HasRequirementNameTemp = HasRequirementNameTemp + "|cff7c0c2f - (" + I2S(brWins) + ") Not Achieved!|r"
        endif
    endfunction

    // Currently not being used, but proves how the interface works 
    private function PVPAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer pvpWins = ps.getAPPVPAllWins() + ps.getARPVPAllWins() + ps.getDraftPVPAllWins()

        set HasRequirementTemp = pvpWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " PVP wins between |n all 3 game modes."

        if (HasRequirementTemp) then
            set HasRequirementNameTemp = HasRequirementNameTemp + "|cff00ff0d - Achieved!|r"
        else
            set HasRequirementNameTemp = HasRequirementNameTemp + "|cff7c0c2f - (" + I2S(pvpWins) + ") Not Achieved!|r"
        endif
    endfunction

    struct HatRequirements
        private integer hatRequirementCheckCount

        // Have to define the size of the arrays. 10 seems like a good limit
        private HatRequirementCheck array hrcs[10]
        private integer array hrcrs[10]

        public static method forHatIndex takes integer hatIndex returns thistype
            return thistype(hatIndex)
        endmethod

        public method addHatRequirementCheck takes HatRequirementCheck hrc, integer requirement returns nothing
            set this.hrcs[this.hatRequirementCheckCount] = hrc
            set this.hrcrs[this.hatRequirementCheckCount] = requirement
            set this.hatRequirementCheckCount = this.hatRequirementCheckCount + 1
        endmethod

        public method checkHatRequirements takes PlayerStats ps returns boolean
            local integer i = 0
        
            loop
                exitwhen i >= hatRequirementCheckCount 

                // We gotta do some BS since interfaces can't return a value
                // Use a global variable to save the value of the requirement and to validate
                set HasRequirementTemp = false
                call this.hrcs[i].execute(ps, this.hrcrs[i])
                
                if (not HasRequirementTemp) then
                    return false
                endif

                set i = i + 1
            endloop

            return true
        endmethod

        public method getHatRequirementDescription takes PlayerStats ps returns string
            local integer i = 0
            local string description = "|cffd0ff00Achievement Requirements|r"

            loop
                exitwhen i >= hatRequirementCheckCount 

                // We gotta do some BS since interfaces can't return a value
                // Use a global variable to save the value of the requirement and to validate
                set HasRequirementNameTemp = null
                call this.hrcs[i].execute(ps, this.hrcrs[i])
                
                set description = description + "|n -"  + HasRequirementNameTemp

                set i = i + 1
            endloop

            return description
        endmethod
    endstruct

    private function init takes nothing returns nothing 
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY
        local HatRequirements currentHatRequirements

        set HatButtonEventHandles = InitHashtable()
        set HatButtonEventTrigger = CreateTrigger()
        set MainHatFrameHandle = BlzCreateFrame("CheckListBox", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 

        call TriggerAddAction(HatButtonEventTrigger, function HatMouseEventActions)

        // The order this is created in, is the order the buttons appear in the row(s)
        // Create the hat requirement directly under each CreateHatButton call that you want added to it
        // NOTE: The HatIndex and HatRequirements need to line up for everything to work
        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNCowboyHat.blp", "Rewards\\CowboyHat.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 2)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNChefHat.blp", "Rewards\\ChefsHat.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 4)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNBrownWizardhat.blp", "Rewards\\BrownWizardHat.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 8)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNOfficerHat.blp", "Rewards\\MilitaryHat.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 16)

        call CreateHatButton("ReplaceableTextures\\CommandButtonsDisabled\\BTNNerubianHeadwear.blp", "Rewards\\NerubianHeadwear.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 32)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNSpanishHelmet.blp", "Rewards\\SpanishHelmet2.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 64)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNBlueWizardHat.blp", "Rewards\\BlueWizardHat.mdx")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 128)

        call CreateHatButton("ReplaceableTextures\\CommandButtons\\BTNPirateHat.blp", "Rewards\\PirateHat.MDX")
        set currentHatRequirements = HatRequirements.create()
        call currentHatRequirements.addHatRequirementCheck(HatRequirementCheck.BRAllWinsCheck, 256)

        // Compute the main hat box based on how many hats there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameMargin) + (IMinBJ(MaxColumnCount, CurrentHatIndex) * ButtonWidth) + ((IMinBJ(MaxColumnCount, CurrentHatIndex) - 1) * ButtonSpacing)
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameMargin) - ((CurrentRowIndex + 1) * ButtonWidth) - (CurrentRowIndex * ButtonSpacing)

        // A sort of shitty check if we need to go back a row in the Y direction. This happens when the next hat would go on the next row, but there isn't another hat.
        if ((I2R(CurrentHatIndex) / MaxColumnCount) == (CurrentRowIndex)) then
            set mainFrameBottomRightY = mainFrameBottomRightY + ButtonWidth + ButtonSpacing
        endif

        call BlzFrameSetAbsPoint(MainHatFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(MainHatFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 
    endfunction 

endlibrary
    