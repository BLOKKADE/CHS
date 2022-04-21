library AchievementsFrame initializer init uses PlayerTracking, IdLibrary, FrameInit, MathRound, Table, PetFollow

    globals 
        // hastables for each type of achievement. It's how we determine what type of achievement it is when a button is selected
        private hashtable HatButtonEventHandles
        private hashtable PetButtonEventHandles

        // The only trigger that handles any button being selected
        private trigger AchievementButtonEventTrigger

        // Specifications about the rows/columns
        private integer MaxColumnCount = 5
        private integer CurrentRowIndex = 0
        private integer CurrentColumnIndex = 0
        private integer TotalAchievementCount = 0
        private integer TotalAchievementTypeCount = 0

        // The X,Y coordinate for the top left of the main frame
        private real MainFrameTopLeftX = 0.04
        private real MainFrameTopLeftY = 0.527
        private real MainFrameMargin = 0.014

        // Specifications for a button
        private real ButtonWidth = 0.025
        private real ButtonSpacing = 0.005

        // Specifications for a achievement text
        private real TextHeight = 0.016
        private real TextWidth = 0.12

        // Mapping between the achievement index and it's hat/pet
        private string array HatIndexes
        private PetSpecification array PetIndexes
        private constant integer PetSwapInterval = 30

        // Very temporary variables because interfaces suck in vjass
        private boolean HasRequirementTemp
        private string HasRequirementNameTemp
        private integer RequirementCurrentTemp
    endglobals 

    public function TryToWearHat takes integer hatIndex, player p, boolean showMessage returns nothing
        local integer heroPlayerId = GetPlayerId(p) + 1
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local Requirements hr = Requirements.forIndex(hatIndex)

        // Player didn't have a hat saved in their code, couldn't find the hat somehow, possibly a broken code, or someone cheating
        if (hr == 0) then
            return
        endif

        // Check if the hat can even be worn
        if (not hr.checkRequirements(ps)) then
            call DisplayTimedTextToPlayer(p,0,0,5,"You do not have the required achievements for this hat.")
            
            // If the player doesn't have a hat out, set their hat index to 0 to be safe
            if (ps.getCurrentHatEffect() == null) then
                call ps.setHatIndex(0)
            endif

            return
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
            call BlzSetSpecialEffectScale(ps.getCurrentHatEffect(), 2.0) // Current scaling is 200%. We can add customization to this per hat if needed
            call ps.setHatIndex(hatIndex)
        else
            // Player took the hat off
            call ps.setHatIndex(0)
        endif
    endfunction

    public function TryToSummonPet takes integer petIndex, player p, boolean showMessage returns nothing
        local integer heroPlayerId = GetPlayerId(p) + 1
        local PlayerStats ps = PlayerStats.forPlayer(p)
        local Requirements hr = Requirements.forIndex(petIndex)
        local PetSpecification psn = PetIndexes[petIndex]

        // Player didn't have a pet saved in their code, couldn't find the pet somehow, possibly a broken code, or someone cheating
        if (hr == 0) then
            return
        endif

        // Check if the pet can even be summoned
        if (not hr.checkRequirements(ps)) then
            call DisplayTimedTextToPlayer(p,0,0,5,"You do not have the required achievements for this pet.")

            // If the player doesn't have a pet out, set their pet index to 0 to be safe
            if (ps.getPet() == null) then
                call ps.setPetIndex(0)
            endif

            return            
        endif

        // Don't allow the player to swap pets so often
        if (ps.getPetLastSwappedAt() != 0 and (ps.getPetLastSwappedAt() + PetSwapInterval > (T32_Tick / 32))) then
            call DisplayTimedTextToPlayer(p,0,0,5,"You can swap out your pet every " + I2S(PetSwapInterval) + " seconds. " + I2S(ps.getPetLastSwappedAt() + PetSwapInterval - (T32_Tick / 32)) + " seconds remaining.")
            return
        endif

        call ps.setPetLastSwappedAt(T32_Tick / 32)

        // Summon the pet if it wasn't already the current pet
        if ((ps.getPetIndex() != petIndex or ps.getPet() == null) and psn != 0) then
            call ps.setPet(null)
            call ps.setPet(CreateUnit(p, PET_BASE_UNIT_ID, GetUnitX(PlayerHeroes[heroPlayerId]), GetUnitY(PlayerHeroes[heroPlayerId]), 0))
            call ps.setPetIndex(petIndex)

            // Modifying the pet. Not all default models are equal in size or need to fly, so adjustment is needed
            call BlzSetUnitSkin(ps.getPet(), psn.getUnitId())
            call SetUnitScale(ps.getPet(), psn.getScaling(), psn.getScaling(), psn.getScaling())

            if (psn.getFlyHeight() != -1.0) then
                // Add then remove the crow form ability. Will allow the unit to fly
                call UnitAddAbility(ps.getPet(), 'Amrf')
                call UnitRemoveAbility(ps.getPet(), 'Amrf')
                call SetUnitFlyHeight(ps.getPet(), psn.getFlyHeight(), 0.)
            endif

            // Tell the pet to follow the hero
            call IssueTargetOrder(ps.getPet(), "move", PlayerHeroes[heroPlayerId])
        else
            // Player removed the pet
            call ps.setPet(null)
            call ps.setPetIndex(0)
        endif
    endfunction

    // Returns the index of the type of achievement
    private function GetIndex takes integer handleId returns integer
        if (LoadInteger(HatButtonEventHandles, handleId, 1) != 0) then
            return LoadInteger(HatButtonEventHandles, handleId, 1)
        else 
            return LoadInteger(PetButtonEventHandles, handleId, 1)
        endif
    endfunction

    // Returns a flag for what type of achievement the framehandle is
    private function GetAchievementType takes integer handleId returns integer
        if (LoadInteger(HatButtonEventHandles, handleId, 1) != 0) then
            return 1 // Hat
        else 
            return 2 // Pet
        endif
    endfunction

    private function HatMouseEventActions takes nothing returns nothing
		local integer index = GetIndex(GetHandleId(BlzGetTriggerFrame()))
        local integer achievementType = GetAchievementType(GetHandleId(BlzGetTriggerFrame()))
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())
        local Requirements hr = Requirements.forIndex(index)

        if BlzGetTriggerFrameEvent() == FRAMEEVENT_CONTROL_CLICK then
            call BlzFrameSetEnable(BlzGetTriggerFrame(), false) 
            call BlzFrameSetEnable(BlzGetTriggerFrame(), true) 

            // Is hat
            if (achievementType == 1) then
                call TryToWearHat(index, GetTriggerPlayer(), true)
            // Is pet
            else // achievementType == 2
                call TryToSummonPet(index, GetTriggerPlayer(), true)
            endif
        elseif BlzGetTriggerFrameEvent() == FRAMEEVENT_MOUSE_ENTER then
            // We are hijacking the tooltip window that we use for almost everything else in the game from FrameInit
            if GetLocalPlayer() == GetTriggerPlayer() then	
                call BlzFrameSetText(TooltipTitleFrame, hr.getRequirementDescription(ps))
                call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(hr.getRequirementDescription(ps)))
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

    private function GetTopLeftX takes nothing returns real
        return MainFrameTopLeftX + MainFrameMargin + (CurrentColumnIndex * ButtonWidth) + (CurrentColumnIndex * ButtonSpacing)
    endfunction

    private function GetTopLeftY takes nothing returns real
        return MainFrameTopLeftY - MainFrameMargin - (ButtonWidth * CurrentRowIndex) - (ButtonSpacing * CurrentRowIndex) - (TextHeight * TotalAchievementTypeCount)
    endfunction
    
    private function HasExtraRow takes nothing returns boolean
        return (I2R(TotalAchievementCount) / MaxColumnCount) == CurrentRowIndex
    endfunction

    private function GoToNextRow takes nothing returns nothing
        if (CurrentColumnIndex != 0 and TotalAchievementCount != 0) then
            set CurrentRowIndex = CurrentRowIndex + 1
        endif

        // Reset back to the beginning
        set CurrentColumnIndex = 0
    endfunction

    private function CreateAchievementText takes string value returns nothing
        local framehandle achievementTextFrameHandle = BlzCreateFrameByType("TEXT", "AchievementName", MainAchievementFrameHandle, "", 0) 

        call GoToNextRow()

        call BlzFrameSetAbsPoint(achievementTextFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(achievementTextFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + TextWidth, GetTopLeftY() - TextHeight) 
        call BlzFrameSetText(achievementTextFrameHandle, value) 
        call BlzFrameSetEnable(achievementTextFrameHandle, false) 
        call BlzFrameSetScale(achievementTextFrameHandle, 1.00) 
        call BlzFrameSetTextAlignment(achievementTextFrameHandle, TEXT_JUSTIFY_TOP, TEXT_JUSTIFY_LEFT) 

        set TotalAchievementTypeCount = TotalAchievementTypeCount + 1

        // Cleanup
        set achievementTextFrameHandle = null
    endfunction

    private function CreateAchievementButton takes string iconPath, hashtable buttonEventHandles returns nothing
        local framehandle buttonFrameHandle = BlzCreateFrame("ScriptDialogButton", MainAchievementFrameHandle, 0, 0) 
        local framehandle buttonBackdropFrameHandle = BlzCreateFrameByType("BACKDROP", "Backdrop", buttonFrameHandle, "", 1) 

        // Keep a count of every icon we make
        set TotalAchievementCount = TotalAchievementCount + 1

        // Dimensions for the button
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_TOPLEFT, GetTopLeftX(), GetTopLeftY()) 
        call BlzFrameSetAbsPoint(buttonFrameHandle, FRAMEPOINT_BOTTOMRIGHT, GetTopLeftX() + ButtonWidth, GetTopLeftY() - ButtonWidth) 

        // Apply the icon
        call BlzFrameSetAllPoints(buttonBackdropFrameHandle, buttonFrameHandle) 
        call BlzFrameSetTexture(buttonBackdropFrameHandle, iconPath, 0, true) 

        // Save the handle of this button to look it up later for mouse events
        call SaveInteger(buttonEventHandles, GetHandleId(buttonFrameHandle), 1, TotalAchievementCount)
        call BlzTriggerRegisterFrameEvent(AchievementButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(AchievementButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_ENTER)
        call BlzTriggerRegisterFrameEvent(AchievementButtonEventTrigger, buttonFrameHandle, FRAMEEVENT_MOUSE_LEAVE)
        
        set CurrentColumnIndex = CurrentColumnIndex + 1

        // Check if we need to go to the next row
        if (CurrentColumnIndex == MaxColumnCount) then
            set CurrentRowIndex = CurrentRowIndex + 1
            set CurrentColumnIndex = 0
        endif

        // Cleanup
        set buttonFrameHandle = null
        set buttonBackdropFrameHandle = null
    endfunction

    private function CreateHatAchievementButton takes string iconPath, string hatModelPath returns nothing
        call CreateAchievementButton(iconPath, HatButtonEventHandles)

        // Save the properties for this hat index
        set HatIndexes[TotalAchievementCount] = hatModelPath
    endfunction
    
    private function CreatePetAchievementButton takes string iconPath, PetSpecification petSpecification returns nothing
        call CreateAchievementButton(iconPath, PetButtonEventHandles)

        // Save the properties for this pet index
        set PetIndexes[TotalAchievementCount] = petSpecification
    endfunction

    // An interface used to add different types of achievement checks
    private function interface RequirementCheck takes PlayerStats ps, integer requirement returns nothing

    private function BRAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer brWins = ps.getAPBRAllWins() + ps.getARBRAllWins() + ps.getDraftBRAllWins()

        set RequirementCurrentTemp = brWins
        set HasRequirementTemp = brWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " BR wins between |n all 3 game modes."
    endfunction

    private function PVPAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer pvpWins = ps.getAPPVPAllWins() + ps.getARPVPAllWins() + ps.getDraftPVPAllWins()

        set RequirementCurrentTemp = pvpWins
        set HasRequirementTemp = pvpWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " PVP wins between |n all 3 game modes."
    endfunction

    private function APPVPAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer pvpWins = ps.getAPPVPAllWins()

        set RequirementCurrentTemp = pvpWins
        set HasRequirementTemp = pvpWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " PVP wins in the |n AP game mode."
    endfunction

    private function ARPVPAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer pvpWins = ps.getARPVPAllWins()

        set RequirementCurrentTemp = pvpWins
        set HasRequirementTemp = pvpWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " PVP wins in the |n AR game mode."
    endfunction

    private function DraftPVPAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer pvpWins = ps.getDraftPVPAllWins()

        set RequirementCurrentTemp = pvpWins
        set HasRequirementTemp = pvpWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " PVP wins in the |n Draft game mode."
    endfunction

    private function APBRAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer brWins = ps.getAPBRAllWins()

        set RequirementCurrentTemp = brWins
        set HasRequirementTemp = brWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " BR wins in the |n AP game mode."
    endfunction

    private function ARBRAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer brWins = ps.getARBRAllWins()

        set RequirementCurrentTemp = brWins
        set HasRequirementTemp = brWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " BR wins in the |n AR game mode."
    endfunction

    private function DraftBRAllWinsCheck takes PlayerStats ps, integer requirement returns nothing
        local integer brWins = ps.getDraftBRAllWins()

        set RequirementCurrentTemp = brWins
        set HasRequirementTemp = brWins >= requirement
        set HasRequirementNameTemp = "Must achieve a total of " + I2S(requirement) + " BR wins in the |n Draft game mode."
    endfunction

    struct Requirements
        private integer RequirementCheckCount
        private string Name

        // Have to define the size of the arrays. 10 seems like a good limit
        private RequirementCheck array Rcs[10] // The requirement checks
        private integer array Rcrs[10] // The values for the requirement checks

        public static method create takes string name returns thistype
            local thistype this = thistype.allocate()
            set this.Name = name
            return this
        endmethod

        public static method forIndex takes integer index returns thistype
            return thistype(index)
        endmethod

        public method addRequirementCheck takes RequirementCheck hrc, integer requirement returns nothing
            set this.Rcs[this.RequirementCheckCount] = hrc
            set this.Rcrs[this.RequirementCheckCount] = requirement
            set this.RequirementCheckCount = this.RequirementCheckCount + 1
        endmethod

        public method checkRequirements takes PlayerStats ps returns boolean
            local integer i = 0
        
            loop
                exitwhen i >= RequirementCheckCount 

                // We gotta do some BS since interfaces can't return a value
                // Use a global variable to save the value of the requirement and to validate
                set HasRequirementTemp = false
                call this.Rcs[i].execute(ps, this.Rcrs[i])
                
                if (not HasRequirementTemp) then
                    return false
                endif

                set i = i + 1
            endloop

            return true
        endmethod

        public method getRequirementDescription takes PlayerStats ps returns string
            local integer i = 0
            local string description = this.Name + "|n|n|cffd0ff00Achievement Requirements|r"

            loop
                exitwhen i >= RequirementCheckCount 

                // We gotta do some BS since interfaces can't return a value
                // Use a global variable to save the value of the requirement and to validate
                call this.Rcs[i].execute(ps, this.Rcrs[i])
                
                set description = description + "|n -"  + HasRequirementNameTemp

                if (HasRequirementTemp) then
                    set description = description + "|cff00ff0d - (" + I2S(RequirementCurrentTemp) + ") Achieved!|r"
                else
                    set description = description + "|cff7c0c2f - (" + I2S(RequirementCurrentTemp) + "/" + I2S(this.Rcrs[i]) + ") Not Achieved!|r"
                endif

                set i = i + 1
            endloop

            return description
        endmethod
    endstruct

    struct PetSpecification
        private real FlyHeight
        private real Scaling
        private integer UnitId

        public static method create takes integer unitId, real scaling, real flyHeight returns thistype
            local thistype this = thistype.allocate()
            set this.UnitId = unitId
            set this.Scaling = scaling
            set this.FlyHeight = flyHeight
            return this
        endmethod

        public method getFlyHeight takes nothing returns real 
            return this.FlyHeight
        endmethod

        public method getScaling takes nothing returns real 
            return this.Scaling
        endmethod

        public method getUnitId takes nothing returns integer 
            return this.UnitId
        endmethod
    endstruct

    private function init takes nothing returns nothing 
        local real mainFrameBottomRightX
        local real mainFrameBottomRightY
        local Requirements currentRequirements
        local PetSpecification currentPet

        set HatButtonEventHandles = InitHashtable()
        set PetButtonEventHandles = InitHashtable()
        set AchievementButtonEventTrigger = CreateTrigger()

        // Create the main frame, hide it by default. All achievement buttons use this frame as the parent
        set MainAchievementFrameHandle = BlzCreateFrame("CheckListBox", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0) 
        call BlzFrameSetVisible(MainAchievementFrameHandle, false)

        // All achievements use the same trigger. However everything has a unique id to handle later on
        call TriggerAddAction(AchievementButtonEventTrigger, function HatMouseEventActions)

        // The order this is created in, is the order the buttons appear in the row(s)
        // Create the requirement directly under each CreateHatAchievementButton call that you want added to it
        // NOTE: An achievement can have mutliple requirements!
        call CreateAchievementText("|cff9205a1Hats|r")

        // --- All BR wins        
        // Blue Wizard Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNBlueWizardHat.blp", "Rewards\\BlueWizardHat.mdx")
        set currentRequirements = Requirements.create("|cff174795Blue Wizard Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 2)

        // Cowboy Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNCowboyHat.blp", "Rewards\\CowboyHat.mdx")
        set currentRequirements = Requirements.create("|cff955217Cowboy Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 4)

        // Military Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNOfficerHat.blp", "Rewards\\MilitaryHat.mdx")
        set currentRequirements = Requirements.create("|cff0d6933Military Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 8)

        // Spanish Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSpanishHelmet.blp", "Rewards\\SpanishHelmet2.mdx")
        set currentRequirements = Requirements.create("|cff95172eSpanish Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 16)

        // Nerubian Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtonsDisabled\\BTNNerubianHeadwear.blp", "Rewards\\NerubianHeadwear.mdx")
        set currentRequirements = Requirements.create("|cff751795Nerubian Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 32)

        // Pirate Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNPirateHat.blp", "Rewards\\PirateHat.MDX")
        set currentRequirements = Requirements.create("|cff951717Pirate Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 64)

        // Brown Wizard Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNBrownWizardhat.blp", "Rewards\\BrownWizardHat.mdx")
        set currentRequirements = Requirements.create("|cffba6f25Brown Wizard Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 128)

        // Top Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNTophat.blp", "Rewards\\Tophat.mdx")
        set currentRequirements = Requirements.create("|cff6e3500Top Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.BRAllWinsCheck, 256)

        // Chef Hat
        call CreateHatAchievementButton("ReplaceableTextures\\CommandButtons\\BTNChefHat.blp", "Rewards\\ChefsHat.mdx")
        set currentRequirements = Requirements.create("|cffb7bbc2Chef Hat|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APBRAllWinsCheck, 100)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARBRAllWinsCheck, 100)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftBRAllWinsCheck, 100)

        // --- All BR wins

        // Here we switch to pet achievements
        call CreateAchievementText("|cffae9a00Pets|r")

        // --- All PVP kills pets
        // Penguin Pet
        set currentPet = PetSpecification.create('npng', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNPenguin.blp", currentPet)
        set currentRequirements = Requirements.create("|cff6a95e1Penguin Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 35)

        // Frog Pet
        set currentPet = PetSpecification.create('nfro', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNHex.blp", currentPet)
        set currentRequirements = Requirements.create("|cff2be747Frog Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 75)

        // Chicken Pet
        set currentPet = PetSpecification.create('nech', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNCritterChicken.blp", currentPet)
        set currentRequirements = Requirements.create("|cffb468c5Chicken Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 175)

        // Seal Pet
        set currentPet = PetSpecification.create('nsea', 1.3, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSeal.blp", currentPet)
        set currentRequirements = Requirements.create("|cff2ae0c8Seal Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 350)

        // Rabbit Pet
        set currentPet = PetSpecification.create('necr', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNCritterRabbit.blp", currentPet)
        set currentRequirements = Requirements.create("|cffffffffRabbit Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 500)

        // Wolf Pet
        set currentPet = PetSpecification.create('ndog', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNWolf.blp", currentPet)
        set currentRequirements = Requirements.create("|cff887c7cWolf Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 650)
  
        // Stag Pet
        set currentPet = PetSpecification.create('nder', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNStag.blp", currentPet)
        set currentRequirements = Requirements.create("|cffbe61b7Stag Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 800)
        
        // Skink Pet
        set currentPet = PetSpecification.create('nskk', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSkink.blp", currentPet)
        set currentRequirements = Requirements.create("|cffe0d537Skink Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 950)

        // Dune Worm Pet
        set currentPet = PetSpecification.create('ndwm', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNDuneWorm.blp", currentPet)
        set currentRequirements = Requirements.create("|cffad7a58Dune Worm Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 1100)

        // Albatross Pet
        set currentPet = PetSpecification.create('nalb', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNAlbatross.blp", currentPet)
        set currentRequirements = Requirements.create("|cff45d3ddAlbatross Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 1250)

        // Crab Pet
        set currentPet = PetSpecification.create('ncrb', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSpinyCrab.blp", currentPet)
        set currentRequirements = Requirements.create("|cffb93a3aCrab Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.PVPAllWinsCheck, 1400)

        // Racoon Pet
        set currentPet = PetSpecification.create('nrac', 1.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNRacoon.blp", currentPet)
        set currentRequirements = Requirements.create("|cff796354Racoon Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 500)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 500)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 500)
        // --- All PVP kills pets

        call GoToNextRow()

        // --- AP PVP kills pets
        // Black Dragon Pet
        set currentPet = PetSpecification.create('nbdr', 0.6, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNBlackDragon.blp", currentPet)
        set currentRequirements = Requirements.create("|cff6e2121Black Dragon Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 175)

        // Red Dragon Pet
        set currentPet = PetSpecification.create('nrdk', 0.60, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNRedDragon.blp", currentPet)
        set currentRequirements = Requirements.create("|cffd72919Red Dragon Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 350)

        // Azure Dragon Pet
        set currentPet = PetSpecification.create('nadw', 0.6, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNAzureDragon.blp", currentPet)
        set currentRequirements = Requirements.create("|cff2ae0c8Azure Dragon Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 525)

        // Frost Wyrm Pet
        set currentPet = PetSpecification.create('ufro', 0.4, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNFrostWyrm.blp", currentPet)
        set currentRequirements = Requirements.create("|cff2b1cffFrost Wyrm Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 700)
        // --- AP PVP kills pets

        call GoToNextRow()

        // --- AR PVP kills pets
        // Wind Serpent Pet
        set currentPet = PetSpecification.create('nwgs', 0.4, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNWindSerpent.blp", currentPet)
        set currentRequirements = Requirements.create("|cff68a5c5Wind Serpent Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 175)

        // Spirit Wyvern Pet
        set currentPet = PetSpecification.create('oswy', 0.6, 140)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSpiritWyvern.blp", currentPet)
        set currentRequirements = Requirements.create("|cff10f0fbSpirit Wyvern Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 350)

        // Gargoyle Pet
        set currentPet = PetSpecification.create('ugar', 0.6, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNGargoyle.blp", currentPet)
        set currentRequirements = Requirements.create("|cff4a648bGargoyle Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 525)

        // Snowy Owl Pet
        set currentPet = PetSpecification.create('nsno', 1.2, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSnowOwl.blp", currentPet)
        set currentRequirements = Requirements.create("|cffffffffSnow Owl Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 700)
        // --- AR PVP kills pets

        call GoToNextRow()

        // --- Draft PVP kills pets
        // Sea Turtle Pet
        set currentPet = PetSpecification.create('nhyc', 0.4, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSeaTurtleRed.blp", currentPet)
        set currentRequirements = Requirements.create("|cff94241bSea Turtle Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 175)

        // Nerubian Spider Pet
        set currentPet = PetSpecification.create('nspd', 0.5, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNNerubian.blp", currentPet)
        set currentRequirements = Requirements.create("|cff256e2aNerubian Spider Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 350)

        // Flying Sheep Pet
        set currentPet = PetSpecification.create('nshf', 1.2, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNSheep.blp", currentPet)
        set currentRequirements = Requirements.create("|cfffffca5Flying Sheep Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 525)

        // Obsidian Pet
        set currentPet = PetSpecification.create('uobs', 0.4, 140.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNObsidianStatue.blp", currentPet)
        set currentRequirements = Requirements.create("|cff9c0000Obsidian Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 700)        
        // --- Draft PVP kills pets

        call GoToNextRow()

        // --- Combination Pets
        // Razorback Pet
        set currentPet = PetSpecification.create('nspp', 0.9, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNRazorback.blp", currentPet)
        set currentRequirements = Requirements.create("|cff847304Razorback Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APBRAllWinsCheck, 3)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARBRAllWinsCheck, 3)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftBRAllWinsCheck, 3)
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 15)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 15)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 15)

        // Riderless Horse Pet
        set currentPet = PetSpecification.create('hrdh', 0.7, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNRiderlessHorse.blp", currentPet)
        set currentRequirements = Requirements.create("|cffa96545Riderless Horse Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APBRAllWinsCheck, 15)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARBRAllWinsCheck, 15)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftBRAllWinsCheck, 15)
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 75)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 75)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 75)

        // Hydra Pet
        set currentPet = PetSpecification.create('nhyh', 0.4, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNGreenHydra.blp", currentPet)
        set currentRequirements = Requirements.create("|cff2aa8bfHydra Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APBRAllWinsCheck, 50)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARBRAllWinsCheck, 50)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftBRAllWinsCheck, 50)
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 275)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 275)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 275)

        // Night Elf Battle Cruiser Pet
        set currentPet = PetSpecification.create('ebsh', 0.35, -1.0)
        call CreatePetAchievementButton("ReplaceableTextures\\CommandButtons\\BTNNightElfBattleCruiser.blp", currentPet)
        set currentRequirements = Requirements.create("|cff847304Night Elf Battle Cruiser Pet|r")
        call currentRequirements.addRequirementCheck(RequirementCheck.APBRAllWinsCheck, 115)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARBRAllWinsCheck, 115)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftBRAllWinsCheck, 115)
        call currentRequirements.addRequirementCheck(RequirementCheck.APPVPAllWinsCheck, 500)
        call currentRequirements.addRequirementCheck(RequirementCheck.ARPVPAllWinsCheck, 500)
        call currentRequirements.addRequirementCheck(RequirementCheck.DraftPVPAllWinsCheck, 500)
        // --- Combination Pets

        // Compute the main achievement box based on how many achievements there are and the column restrictions
        set mainFrameBottomRightX = MainFrameTopLeftX + (2 * MainFrameMargin) + (IMinBJ(MaxColumnCount, TotalAchievementCount) * ButtonWidth) + ((IMinBJ(MaxColumnCount, TotalAchievementCount) - 1) * ButtonSpacing)
        set mainFrameBottomRightY = MainFrameTopLeftY - (2 * MainFrameMargin) - ((CurrentRowIndex + 1) * ButtonWidth) - (CurrentRowIndex * ButtonSpacing) - (TextHeight * TotalAchievementTypeCount)

        // A sort of shitty check if we need to go back a row in the Y direction. This happens when the next achievement would go on the next row, but there isn't another achievement.
        if (HasExtraRow()) then
            set mainFrameBottomRightY = mainFrameBottomRightY + ButtonWidth + ButtonSpacing
        endif

        call BlzFrameSetAbsPoint(MainAchievementFrameHandle, FRAMEPOINT_TOPLEFT, MainFrameTopLeftX, MainFrameTopLeftY) 
        call BlzFrameSetAbsPoint(MainAchievementFrameHandle, FRAMEPOINT_BOTTOMRIGHT, mainFrameBottomRightX, mainFrameBottomRightY) 
    endfunction 

endlibrary
    