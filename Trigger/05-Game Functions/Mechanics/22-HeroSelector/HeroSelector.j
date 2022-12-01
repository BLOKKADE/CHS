library HeroSelector initializer init_function requires optional FrameLoader, OldInitialization
    //HeroSelector V1.6b
    //API
    //=====
    //HeroSelectorForcePick()
    //HeroSelectorForcePickPlayer(player p)
    //HeroSelectorForcePickRace(race r)
    //HeroSelectorForcePickTeam(integer teamNr)
    
    //HeroSelectorForceRandom()
    //HeroSelectorForceRandomRace(race r)
    //HeroSelectorForceRandomTeam(integer teamNr)
    
    //HeroSelectorDoPick(player p)
    //HeroSelectorDoRandom(player p)
    
    //HeroSelectorShow(boolean flag)
    //HeroSelectorShowForce(boolean flag, force f)
    //HeroSelectorShowRace(boolean flag, race r)
    //HeroSelectorShowPlayer(boolean flag, player p)
    //HeroSelectorShowTeam(boolean flag, integer teamNr)
    
    //HeroSelectorEnableBan(boolean flag)
    //HeroSelectorEnableBanRace
    //HeroSelectorEnableBanTeam
    //HeroSelectorEnableBanPlayer
    //HeroSelectorEnableBanForce
    
    //HeroSelectorEnablePick(boolean flag)
    //HeroSelectorEnablePickForce
    //HeroSelectorEnablePickPlayer
    //HeroSelectorEnablePickTeam
    //HeroSelectorEnablePickRace
    
    //HeroSelectorRollOption(player p, boolean includeRandomOnly, integer exculdedIndex, integer category) returns integer
    //HeroSelectorCounterChangeUnitCode(integer unitCode, integer add, player p)
    //HeroSelectorEnableButtonIndex(integer unitCode, integer buttonIndex)
    //HeroSelectorDisableButtonIndex(integer buttonIndex, integer teamNr)
    //HeroSelectorButtonRequirementDone(integer unitCode, player p) returns boolean
    //HeroSelectorDeselectButton(integer buttonIndex)
    
    //HeroSelectorAddUnit(integer unitCode, boolean onlyRandom)
    //HeroSelectorAddUnitCategory(integer unitCode, integer category)
    //HeroSelectorSetUnitCategory(integer unitCode, integer category)
    //HeroSelectorSetUnitReqPlayer(integer unitCode, player p)
    //HeroSelectorSetUnitReqRace(integer unitCode, race r)
    //HeroSelectorSetUnitReqForce(integer unitCode, force f)
    //HeroSelectorSetUnitReqTeam(integer unitCode, integer teamNr)
    //HeroSelectorSetUnitReqTechLevel(integer unitCode, integer techCode, integer techLevel)
    
    //HeroSelectorSetFrameText(framehandle frame, string text)
    //HeroSelectorSetFrameTextPlayer
    //HeroSelectorSetFrameTextForce
    //HeroSelectorSetFrameTextTeam
    //HeroSelectorSetFrameTextRace
    
    //HeroSelectorSetTitleText(string text)
    //HeroSelectorSetTitleTextRace
    //HeroSelectorSetTitleTextPlayer
    //HeroSelectorSetTitleTextForce
    //HeroSelectorSetTitleTextTeam
    
    //HeroSelectorSetBanButtonText
    //HeroSelectorSetBanButtonTextPlayer
    //HeroSelectorSetBanButtonTextRace
    //HeroSelectorSetBanButtonTextForce
    //HeroSelectorSetBanButtonTextTeam
    
    //HeroSelectorSetRandomButtonText
    //HeroSelectorSetRandomButtonTextPlayer
    //HeroSelectorSetRandomButtonTextForce
    //HeroSelectorSetRandomButtonTextTeam
    //HeroSelectorSetRandomButtonTextRace
    
    //HeroSelectorSetAcceptButtonText
    //HeroSelectorSetAcceptButtonTextPlayer
    //HeroSelectorSetAcceptButtonTextForce
    //HeroSelectorSetAcceptButtonTextTeam
    //HeroSelectorSetAcceptButtonTextRace
    
    //HeroSelectorAddCategory(string icon, string text) //should only be used before the category Buttons are created
    
    //HeroSelectorGetDisabledIcon(string iconPath)
    
    //HeroSelectorUpdate()
    
    //=====

    
    globals
        // Editor Variables
        integer Count
        unit HeroSelectorEventUnit
        integer HeroSelectorEventUnitCode
        player HeroSelectorEventPlayer
        boolean HeroSelectorEventIsRandom = false
        real HeroSelectorEvent = 0
        integer array HeroSelectorUnitCode
        integer array HeroSelectorRandomOnly
        integer array HeroSelectorCategory
        // Editor Variables

        //Setup
        //Box
        private string BoxFrameName            = "HeroSelectorRaceBox" //this is the background box being created
        private real BoxPosX                   = 0.2
        private real BoxPosY                   = 0.36
        private framepointtype BoxPosPoint     = FRAMEPOINT_CENTER
        private boolean AutoShow               = false //(true) shows the box and the Selection at 0.0 for all players
        //Unique Picks
        public integer UnitCount              = 8 //each hero is in total allowed to be picked this amount of times (includes random, repicking allows a hero again).
        public integer UnitCountPerTeam       = 8 //Each Team is allowed to pick this amount of each unitType
        private string  ToManyTooltip          = "OUTOFSTOCKTOOLTIP"
        //Ban
        private boolean DelayBanUntilPick      = false //(true) baning will not be applied instantly, instead it is applied when HeroSelectorEnablePick is called the next time.
        private boolean array PlayerHasBanned  // Track if the player has banned already. Need to manually check to prevent spamming the ban button
        integer PlayerBanCount                 = 0 // Keeps track of how many people have banned. We can then short circuit the ban timer if everyone has banned
        //Category
        private boolean CategoryAffectRandom   = true  //(false) random will not care about selected category
        private boolean CategoryMultiSelect    = false //(false) deselect other category when selecting one, (true) can selected multiple categories and all heroes having any of them are not filtered.
        private real CategorySize              = 0.02  //the size of the Category Button
        private real CategorySpaceX            = 0.0008 //space between 2 category Buttons, it is meant to need only one line of Categoryy Buttons.
        private integer CategoryFilteredAlpha  = 45     // Alpha value of Heroes being filtered by unselected categories
        private boolean CategoryAutoDetectHero = false // Will create and remove added Heroes to read and setup the Category for the primary Attribute Str(4) Agi(8) Int(16)
            //Icon path, tooltip Text (tries to localize)
        //Indicator
        private framehandle IndicatorSelected
        private framehandle IndicatorSelectedParent
        private string IndicatorPathPick       = "UI\\Feedback\\Autocast\\UI-ModalButtonOn.mdl" //this model is used by the indicator during picking
        private string IndicatorPathBan        = "war3mapImported\\HeroSelectorBan.mdl" //this model is used by the indicator during baning
        //Grid
        private real SpaceBetweenX             = 0.008 //space between 2 buttons in one row
        private real SpaceBetweenY             = 0.008 //space between 2 rows
        private integer ButtonColCount         = 8 //amount of buttons in one row
        private integer ButtonRowCount         = 7 //amount of rows
        
        private boolean ChainedButtons         = true //(true) connect to the previous button/ or row, (false) have a offset to the box topLeft in this moving a button has no effect on other buttons.
        //Button
        private real ButtonSize                = 0.036 //size of each button
        private boolean ButtonBlendAll         = false //(true) when a hero icon uses transparenzy
        private string EmptyButtonPath         = "UI\\Widgets\\EscMenu\\Human\\blank-background.blp"
        private boolean HideEmptyButtons       = true
        //Ban Button
        private string BanButtonTextPrefix     = "|cffcf2084" //Prefix Text for the Ban Button
        private string BanButtonText           = "CHAT_ACTION_BAN" //tries to get a Localized String
        private real BanButtonSizeX            = 0.13
        private real BanButtonSizeY            = 0.03
        private string BanTooltip              = "DISALLOWED"
        private boolean BanIgnoreRequirment    = true // (true) Ban is not restricted by Requirments
        //Accept Button
        private string AcceptButtonTextPrefix       = ""
        private string AcceptButtonText             = "ACCEPT"
        private real AcceptButtonSizeX              = 0.085
        private real AcceptButtonSizeY              = 0.03
        private boolean AcceptButtonIsShown         = true
        private framepointtype AcceptButtonAnchor   = FRAMEPOINT_BOTTOMRIGHT //places the Accept button with which Point to the bottom, with right he is at the left
        //Random Button
        private string RandomButtonTextPrefix       = ""
        private string RandomButtonText             = "RANDOM" //tries Localizing
        private real RandomButtonSizeX              = 0.085
        private real RandomButtonSizeY              = 0.03
        private boolean RandomButtonIsShown         = true
        private framepointtype RandomButtonAnchor   = FRAMEPOINT_BOTTOMLEFT
        private boolean RandomButtonPick            = true //(true) pressing the random button will pick the option. (false) pressing the random button will select a button, random only heroes can not be selected, but that does not matter. This weak random and randomonly should not be combined.
        //Tooltip
        private string TooltipPrefix                  = "|cffffcc00"
        private real TooltipOffsetX                   = 0
        private real TooltipOffsetY                   = 0
        private framepointtype TooltipPoint           = FRAMEPOINT_BOTTOM //pos the Tooltip with which Point
        private framepointtype TooltipRelativePoint   = FRAMEPOINT_TOP //pos the Tooltip to which Point of the Relative
        private boolean TooltipRelativIsBox           = false          //(true) use the box as anchor, (false) use the button as anchor
        private string TooltipRequires                = "QUESTCOMPONENTS"

        //System variables, Do not touch
        public integer HeroButtonCount        = ButtonRowCount*ButtonColCount
        private trigger CategoryClickTrigger   = CreateTrigger()
        private trigger AcceptButtonTrigger  = CreateTrigger()
        private trigger BanButtonTrigger      = CreateTrigger()
        private trigger RandomButtonTrigger  = CreateTrigger()
        private framehandle BanButton
        private framehandle AcceptButton
        private framehandle RandomButton
        private player array DelayBanPlayer
        private integer array DelayBanUnitCode
        private integer DelayBanCount = 0
        public framehandle array CategoryButton
        public framehandle array CategoryIconFrame
        public framehandle array CategoryIconPushedFrame        
        public framehandle array CategoryTooltipFrame
        public framehandle array CategoryTooltipFrameBox
        public string array CategoryText
        public string array CategoryTexture
        public string array CategoryTextureDisabled
        private integer array CategoryButtonValue
        public integer CategoryButtonCount = 0
        private integer array UsedTeamNr
        private integer UsedTeamNrCount = 0

        private integer ButtonHeroCount = 0        
        private integer array ButtonHeroUnitCode


        private integer array HeroTotalCount
        public integer array HeroCategory
        private integer array HeroRegType
        private player array HeroRegPlayer
        private force array HeroRegForce
        private integer array HeroRegNumber
        private integer array HeroRegNumber2
        private race array HeroRegRace

        private TableArray PlayerDraftOptions
        private boolean DraftEnabled = false

        private integer HeroCount = 0
        private integer array HeroUnitCode
        private integer array HeroButtonIndex


        public hashtable Hash = InitHashtable()
        framehandle HeroSelectorBox
        private framehandle HeroSelectorBoxSeperator
        private framehandle HeroSelectorBoxTitle

        private integer array HeroButtonUnitCode
        private integer HeroButtonUnitCodeCount = 0
        private framehandle array HeroButtonIcon
        private framehandle array HeroButtonIconPushed        
        private framehandle array HeroButtonIconDisabled
        private framehandle array HeroButtonTooltip
        private framehandle array HeroButtonTooltipBox
        private framehandle array HeroButtonFrame
        private trigger HeroButtonClickTrigger = CreateTrigger()

        private integer array PlayerSelectedButtonIndex
        private integer array PlayerSelectedCategory
        private integer array PlayerLastSelectedCategoryIndex

        private integer LastAction = 0
    endglobals

    private function AutoDetectCategory takes integer unitCode returns integer
        local integer value = 0
        local unit u
        local integer primaryAttribute
        if IsUnitIdType(unitCode, UNIT_TYPE_MELEE_ATTACKER) then
            set value = 1            
        elseif IsUnitIdType(unitCode, UNIT_TYPE_RANGED_ATTACKER) then
            set value = 2
        endif
        if CategoryAutoDetectHero and IsUnitIdType(unitCode, UNIT_TYPE_HERO) then
            set u = CreateUnit(Player(bj_PLAYER_NEUTRAL_EXTRA), unitCode, 0, 0, 270)
            set primaryAttribute = BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE)
            call RemoveUnit(u)
            set u = null

            if ConvertHeroAttribute(primaryAttribute) == HERO_ATTRIBUTE_STR then
                set value = value + 4
            elseif ConvertHeroAttribute(primaryAttribute) == HERO_ATTRIBUTE_AGI then
                set value = value + 8
            elseif ConvertHeroAttribute(primaryAttribute) == HERO_ATTRIBUTE_INT then 
                set value = value + 16
            endif
        endif
        return value
    endfunction

    private function GetBorderSize takes nothing returns real
        if GetPlayerRace(GetLocalPlayer()) == RACE_HUMAN then
            return 0.029
        elseif GetPlayerRace(GetLocalPlayer()) == RACE_ORC then
            return 0.029
        elseif GetPlayerRace(GetLocalPlayer()) == RACE_UNDEAD then
            return 0.035
        elseif GetPlayerRace(GetLocalPlayer()) == RACE_NIGHTELF then
            return 0.035
        elseif GetPlayerRace(GetLocalPlayer()) == RACE_DEMON then
            return 0.024
        else 
            return 0.0
        endif
    endfunction

    function HeroSelectorDestroy takes nothing returns nothing
        local integer buttonIndex = 1
        loop
            exitwhen buttonIndex > HeroButtonCount
            call BlzDestroyFrame(HeroButtonIcon[buttonIndex])
            call BlzDestroyFrame(HeroButtonIconDisabled[buttonIndex])
            call BlzDestroyFrame(HeroButtonFrame[buttonIndex])
            call BlzDestroyFrame(HeroButtonTooltip[buttonIndex])
            call BlzDestroyFrame(HeroButtonTooltipBox[buttonIndex])
            set HeroButtonTooltip[buttonIndex] = null
            set HeroButtonTooltipBox[buttonIndex] = null
            set HeroButtonFrame[buttonIndex] = null
            set HeroButtonIcon[buttonIndex] = null
            set buttonIndex = buttonIndex + 1
        endloop
        set buttonIndex = 1
        loop
            exitwhen buttonIndex > CategoryButtonCount
            call BlzDestroyFrame(CategoryButton[buttonIndex])
            call BlzDestroyFrame(CategoryIconFrame[buttonIndex])
            call BlzDestroyFrame(CategoryTooltipFrame[buttonIndex])
            call BlzDestroyFrame(CategoryTooltipFrameBox[buttonIndex])
            set CategoryButton[buttonIndex] = null
            set CategoryIconFrame[buttonIndex] = null
            set CategoryTooltipFrame[buttonIndex] = null
            set CategoryTooltipFrameBox[buttonIndex] = null
            set buttonIndex = buttonIndex + 1
        endloop

        call BlzDestroyFrame(HeroSelectorBox)
        call BlzDestroyFrame(HeroSelectorBoxSeperator)        
        call BlzDestroyFrame(HeroSelectorBoxTitle)
        call BlzDestroyFrame(BanButton)
        call BlzDestroyFrame(RandomButton)
        call BlzDestroyFrame(AcceptButton)
        call BlzDestroyFrame(IndicatorSelected)
        call BlzDestroyFrame(IndicatorSelectedParent)
        

        set HeroSelectorBox = null
        set HeroSelectorBoxTitle = null
        set HeroSelectorBoxSeperator = null
        set BanButton = null
        set RandomButton = null
        set AcceptButton = null
        set IndicatorSelected = null
        
        call DestroyTrigger(CategoryClickTrigger)
        call DestroyTrigger(BanButtonTrigger)
        call DestroyTrigger(RandomButtonTrigger)
        call DestroyTrigger(HeroButtonClickTrigger)

        set CategoryClickTrigger = null
        set BanButtonTrigger = null
        set RandomButtonTrigger = null
        set HeroButtonClickTrigger = null
        
    endfunction

    //=====
    //code start
    //=====

    function HeroSelectorGetDisabledIcon takes string icon returns string
        //ReplaceableTextures\CommandButtons\BTNHeroPaladin.tga -> ReplaceableTextures\CommandButtonsDisabled\DISBTNHeroPaladin.tga
        if SubString(icon, 34, 35) != "\\" then
            return icon
        endif //this string has not enough chars return it
        //string.len(icon) < 34 then return icon end //this string has not enough chars return it
        return SubString(icon, 0, 34) + "Disabled\\DIS" + SubString(icon, 35, StringLength(icon))
    endfunction

    function HeroSelectorAddCategory takes string icon, string text returns nothing
        //adds an data category construct
        set CategoryButtonCount = CategoryButtonCount + 1
        set CategoryText[CategoryButtonCount] = text
        set CategoryTexture[CategoryButtonCount] = icon
        set CategoryTextureDisabled[CategoryButtonCount] = HeroSelectorGetDisabledIcon(icon)
        if CategoryButtonCount > 1 then
            set CategoryButtonValue[CategoryButtonCount] = CategoryButtonValue[CategoryButtonCount - 1]*2
        else
            set CategoryButtonValue[CategoryButtonCount] = 1
        endif
    endfunction

    function HeroSelectorSetFrameText takes framehandle frame, string text returns nothing
        call BlzFrameSetText(frame, text)
    endfunction
    function HeroSelectorSetFrameTextPlayer takes framehandle frame, string text, player p returns nothing
        if GetLocalPlayer() == p then
            call BlzFrameSetText(frame, text)
        endif
    endfunction
    function HeroSelectorSetFrameTextTeam takes framehandle frame, string text, integer teamNr returns nothing
        if GetPlayerTeam(GetLocalPlayer()) == teamNr then
            call BlzFrameSetText(frame, text)
        endif
    endfunction
    function HeroSelectorSetFrameTextRace takes framehandle frame, string text, race r returns nothing
        if GetPlayerRace(GetLocalPlayer()) == r then
            call BlzFrameSetText(frame, text)
        endif
    endfunction
    function HeroSelectorSetFrameTextForce takes framehandle frame, string text, force f returns nothing
        if BlzForceHasPlayer(f, GetLocalPlayer()) then
            call BlzFrameSetText(frame, text)
        endif
    endfunction
    

    function HeroSelectorSetTitleText takes string text returns nothing
        call HeroSelectorSetFrameText(HeroSelectorBoxTitle, text)
    endfunction
    function HeroSelectorSetTitleTextPlayer takes string text, player who returns nothing
        call HeroSelectorSetFrameTextPlayer(HeroSelectorBoxTitle, text, who)
    endfunction
    function HeroSelectorSetTitleTextForce takes string text, force who returns nothing
        call HeroSelectorSetFrameTextForce(HeroSelectorBoxTitle, text, who)
    endfunction
    function HeroSelectorSetTitleTextTeam takes string text, integer who returns nothing
        call HeroSelectorSetFrameTextTeam(HeroSelectorBoxTitle, text, who)
    endfunction
    function HeroSelectorSetTitleTextRace takes string text, race who returns nothing
        call HeroSelectorSetFrameTextRace(HeroSelectorBoxTitle, text, who)
    endfunction

    function HeroSelectorSetBanButtonText takes string text returns nothing
        call HeroSelectorSetFrameText(BanButton, text)
    endfunction
    function HeroSelectorSetBanButtonTextPlayer takes string text, player who returns nothing
        call HeroSelectorSetFrameTextPlayer(BanButton, text, who)
    endfunction
    function HeroSelectorSetBanButtonTextForce takes string text, force who returns nothing
        call HeroSelectorSetFrameTextForce(BanButton, text, who)
    endfunction
    function HeroSelectorSetBanButtonTextTeam takes string text, integer who returns nothing
        call HeroSelectorSetFrameTextTeam(BanButton, text, who)
    endfunction
    function HeroSelectorSetBanButtonTextRace takes string text, race who returns nothing
        call HeroSelectorSetFrameTextRace(BanButton, text, who)
    endfunction
    
    function HeroSelectorSetRandomButtonText takes string text returns nothing
        call HeroSelectorSetFrameText(RandomButton, text)
    endfunction
    function HeroSelectorSetRandomButtonTextPlayer takes string text, player who returns nothing
        call HeroSelectorSetFrameTextPlayer(RandomButton, text, who)
    endfunction
    function HeroSelectorSetRandomButtonTextForce takes string text, force who returns nothing
        call HeroSelectorSetFrameTextForce(RandomButton, text, who)
    endfunction
    function HeroSelectorSetRandomButtonTextTeam takes string text, integer who returns nothing
        call HeroSelectorSetFrameTextTeam(RandomButton, text, who)
    endfunction
    function HeroSelectorSetRandomButtonTextRace takes string text, race who returns nothing
        call HeroSelectorSetFrameTextRace(RandomButton, text, who)
    endfunction
    
    function HeroSelectorSetAcceptButtonText takes string text returns nothing
        call HeroSelectorSetFrameText(AcceptButton, text)
    endfunction
    function HeroSelectorSetAcceptButtonTextPlayer takes string text, player who returns nothing
        call HeroSelectorSetFrameTextPlayer(AcceptButton, text, who)
    endfunction
    function HeroSelectorSetAcceptButtonTextForce takes string text, force who returns nothing
        call HeroSelectorSetFrameTextForce(AcceptButton, text, who)
    endfunction
    function HeroSelectorSetAcceptButtonTextTeam takes string text, integer who returns nothing
        call HeroSelectorSetFrameTextTeam(AcceptButton, text, who)
    endfunction
    function HeroSelectorSetAcceptButtonTextRace takes string text, race who returns nothing
        call HeroSelectorSetFrameTextRace(AcceptButton, text, who)
    endfunction

    function HeroSelectorSetUnitCategory takes integer unitCode, integer category returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroCategory[index] =  category
    endfunction

    function HeroSelectorAddUnitCategory takes integer unitCode, integer category returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroCategory[index] =  BlzBitOr(category, HeroCategory[index])
    endfunction

    function HeroSelectorDeselectButton takes integer buttonIndex returns nothing
        local integer playerIndex = 0
        if buttonIndex > 0 then
            if PlayerSelectedButtonIndex[GetPlayerId(GetLocalPlayer())] == buttonIndex then
                call BlzFrameSetVisible(IndicatorSelected, false)
            endif
            loop
                exitwhen playerIndex == GetBJMaxPlayers()
                if PlayerSelectedButtonIndex[playerIndex] == buttonIndex then
                set PlayerSelectedButtonIndex[playerIndex] = 0 
                endif
                set playerIndex = playerIndex + 1
            endloop
        else
            loop
                exitwhen playerIndex == GetBJMaxPlayers()
                set PlayerSelectedButtonIndex[playerIndex] = 0 
                set playerIndex = playerIndex + 1
            endloop
            call BlzFrameSetVisible(IndicatorSelected, false)
        endif
    endfunction

    function HeroSelectorSetUnitReqRace takes integer unitCode, race r returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroRegType[index] = 1
        set HeroRegRace[index] = r
    endfunction

    function HeroSelectorSetUnitReqForce takes integer unitCode, force f returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroRegType[index] = 4
        set HeroRegForce[index] = f
    endfunction

    function HeroSelectorSetUnitReqPlayer takes integer unitCode, player p returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroRegType[index] = 3
        set HeroRegPlayer[index] = p
    endfunction

    function HeroSelectorSetUnitReqTeam takes integer unitCode, integer teamNr returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroRegType[index] = 2
        set HeroRegNumber[index] = teamNr
    endfunction

    function HeroSelectorSetUnitReqTechLevel takes integer unitCode, integer techCode, integer techLevel returns nothing
        local integer index =  LoadInteger(Hash, unitCode, 0)
        set HeroRegType[index] = 5
        set HeroRegNumber[index] = techCode
        set HeroRegNumber2[index] = techLevel
    endfunction

    function HeroSelectorButtonRequirementDone takes integer unitCode, player p returns boolean
        //true when no requirement is set or the requirment call is successful
        local integer index =  LoadInteger(Hash, unitCode, 0)
        local integer playerId = GetPlayerId(p)

        if DraftEnabled and not PlayerDraftOptions[playerId].has(unitCode) then        
            return false
        endif

        if HeroRegType[index] == 0 then //no requirement
            return true
        elseif HeroRegType[index] == 1 and HeroRegRace[index] == GetPlayerRace(p) then
            return true
        elseif HeroRegType[index] == 2 and HeroRegNumber[index] == GetPlayerTeam(p) then
            return true
        elseif HeroRegType[index] == 3 and HeroRegPlayer[index] == p then
            return true
        elseif HeroRegType[index] == 4 and BlzForceHasPlayer(HeroRegForce[index], p) then
            return true
        elseif HeroRegType[index] == 5 and GetPlayerTechCount(p, HeroRegNumber[index], true) >= HeroRegNumber2[index] then        
            return true
        endif
        return false
    endfunction

    function HeroSelectorDisableButtonIndex takes integer buttonIndex, integer teamNr returns nothing
        local integer playerIndex = 0
        if buttonIndex > 0 then
    
            if teamNr == -1 or teamNr == GetPlayerTeam(GetLocalPlayer()) then
                call BlzFrameSetEnable(HeroButtonFrame[buttonIndex], false)
            endif
            if PlayerSelectedButtonIndex[GetPlayerId(GetLocalPlayer())] == buttonIndex then
                call BlzFrameSetVisible(IndicatorSelected, false)
            endif

            //deselect this Button from all players or the team
            loop
                exitwhen playerIndex == GetBJMaxPlayers()
                if (teamNr == -1 or teamNr == GetPlayerTeam(Player(playerIndex))) and PlayerSelectedButtonIndex[playerIndex] == buttonIndex then
                    set PlayerSelectedButtonIndex[playerIndex] = 0                
                endif
                set playerIndex = playerIndex + 1
            endloop
        endif
    endfunction

    function HeroSelectorEnableButtonIndex takes integer unitCode, integer buttonIndex returns nothing
        if buttonIndex > 0 then
            call BlzFrameSetEnable(HeroButtonFrame[buttonIndex], true and (BanIgnoreRequirment and BlzFrameIsVisible(BanButton) ) or HeroSelectorButtonRequirementDone(unitCode, GetLocalPlayer()))
        endif
    endfunction

    function HeroSelectorUpdateTooltip takes integer unitCode returns nothing
        local integer unitCodeIndex = LoadInteger(Hash, unitCode, 0)
        local integer buttonIndex = HeroButtonIndex[unitCodeIndex]
        local framehandle frame = HeroButtonTooltip[buttonIndex]
        local integer teamKey = StringHash("TeamCount"+I2S(GetPlayerTeam(GetLocalPlayer())))

        if HeroTotalCount[unitCodeIndex] > UnitCount then
            call BlzFrameSetText(frame, TooltipPrefix + GetObjectName(unitCode) + "\n|r(" + GetLocalizedString(BanTooltip) + ")")
        else
            if HeroTotalCount[unitCodeIndex] == UnitCount or LoadInteger(Hash, unitCode, teamKey) >= UnitCountPerTeam then
                call BlzFrameSetText(frame, TooltipPrefix + GetObjectName(unitCode) + "\n|r(" + GetLocalizedString(ToManyTooltip) + ")")
            elseif not HeroSelectorButtonRequirementDone(unitCode, GetLocalPlayer()) then
                call BlzFrameSetText(frame, TooltipPrefix + GetObjectName(unitCode) + "\n|r(Not available in your draft selection)")
            else
                call BlzFrameSetText(frame, TooltipPrefix + GetObjectName(unitCode))
            endif
        endif
    endfunction

    function HeroSelectorCounterChangeUnitCode takes integer unitCode, integer add, player p returns nothing
        local integer unitCodeIndex = LoadInteger(Hash, unitCode, 0)
        local integer buttonIndex = HeroButtonIndex[unitCodeIndex]
        local integer teamNr = GetPlayerTeam(p)
        local integer teamKey = StringHash("TeamCount"+I2S(teamNr))
        set HeroTotalCount[unitCodeIndex] = HeroTotalCount[unitCodeIndex] + add
        call SaveInteger(Hash, unitCode, teamKey, LoadInteger(Hash, unitCode, teamKey) + add)

        if HeroTotalCount[unitCodeIndex] >= UnitCount then
            //disable for all
            call HeroSelectorDisableButtonIndex(buttonIndex, -1)
        else
            //enable for all
            call HeroSelectorEnableButtonIndex(unitCode, buttonIndex)
            if LoadInteger(Hash, unitCode, teamKey) >= UnitCountPerTeam  then
                //disable for this team
                call HeroSelectorDisableButtonIndex(buttonIndex, teamNr)
            endif
        endif
        call HeroSelectorUpdateTooltip(unitCode)
    endfunction

    function HeroSelectorRollOption takes player p, boolean includeRandomOnly, integer exculdedIndex, integer category, boolean ignoreReqs returns integer
        local integer teamNr = GetPlayerTeam(p)
        local integer array options
        local integer optionCount = 0
        local integer teamKey = StringHash("TeamCount"+I2S(teamNr))
        local boolean allowed
        local integer index = 1
        local integer unitCode
        local integer unitCodeIndex
        loop
            exitwhen index > HeroCount
            set unitCode = HeroUnitCode[index]
            set unitCodeIndex = LoadInteger(Hash, unitCode, 0)
            set allowed = true
            //total limited reached?
            if HeroTotalCount[unitCodeIndex] >= UnitCount then
                set allowed = false
                //print(GetObjectName(unitCode))
                //print("rejected total limit")
            endif
            //team limited reached?
            if allowed and LoadInteger(Hash, unitCode, teamKey) >= UnitCountPerTeam  then
                //print(GetObjectName(unitCode))
                //print("rejected team limit")
                set allowed = false
            endif
            //allow randomOnly?
            if allowed and not includeRandomOnly and HeroButtonIndex[unitCodeIndex] == 0  then
                //print(GetObjectName(unitCode))
                //print("rejected random only")
                set allowed = false
            endif
            //this index is excluded? This can make sure you get another button.
            if allowed and HeroButtonIndex[unitCodeIndex] > 0 and HeroButtonIndex[unitCodeIndex] == exculdedIndex then
                //print(GetObjectName(unitCode))
                //print("rejected exclude")
                set allowed = false
            endif
            //fullfills the requirement?
            if not ignoreReqs and allowed and not HeroSelectorButtonRequirementDone(unitCode, p) then
                //print(GetObjectName(unitCode))
                //print("rejected requirement")
                set allowed = false
            endif
            //when having an given an category only allow options having that category atleast partly
            if allowed and category > 0 and BlzBitAnd(category, HeroCategory[unitCodeIndex]) == 0 then
                //print(GetObjectName(unitCode))
                //print("  rejected category", category, HeroSelector.UnitData[unitCode].Category)
                set allowed = false
            endif

            if allowed then
                set optionCount = optionCount + 1
                set options[optionCount] = unitCode
            endif
            set index = index + 1
        endloop
        //nothing is allwoed?
        if optionCount == 0 then
            return 0
        else
            return options[GetRandomInt(1, optionCount)]
        endif
    endfunction

    function HeroSelectorEnablePickDelayBanAction takes nothing returns nothing
        loop
            exitwhen DelayBanCount <= 0
            call HeroSelectorCounterChangeUnitCode(DelayBanUnitCode[DelayBanCount], UnitCount + 1, DelayBanPlayer[DelayBanCount])
            set DelayBanCount = DelayBanCount - 1
        endloop
    endfunction

    function HeroSelectorUpdate takes nothing returns nothing
        local integer buttonIndex = 1
        local integer unitCodeIndex
        local integer teamNr
        local integer teamIndex = 0
        local integer teamKey
        loop
            exitwhen buttonIndex > HeroButtonCount
            //have data for this button?
            if HeroButtonUnitCode[buttonIndex] > 0 then
                if HideEmptyButtons then
                    call BlzFrameSetVisible(HeroButtonFrame[buttonIndex], true)
                endif

                set unitCodeIndex = LoadInteger(Hash, HeroButtonUnitCode[buttonIndex],0)
                if HeroTotalCount[unitCodeIndex] >= UnitCount then
                    //disable for all
                    call HeroSelectorDisableButtonIndex(buttonIndex, -1)
                else
                    //enable for all
                    call HeroSelectorEnableButtonIndex(HeroButtonUnitCode[buttonIndex], buttonIndex)
                    set teamIndex = 0
                    loop
                        exitwhen teamIndex > UsedTeamNrCount
                        set teamNr = UsedTeamNr[teamIndex]
                        set teamKey = StringHash("TeamCount"+I2S(teamNr))
                        if LoadInteger(Hash, HeroButtonUnitCode[buttonIndex], teamKey) >= UnitCountPerTeam  then
                            //disable for this team
                            call HeroSelectorDisableButtonIndex(buttonIndex, teamNr)
                        endif
                        set teamIndex = teamIndex + 1                    
                    endloop
                endif
                call BlzFrameSetTexture(HeroButtonIcon[buttonIndex], BlzGetAbilityIcon(HeroButtonUnitCode[buttonIndex]), 0, ButtonBlendAll)
                call BlzFrameSetTexture(HeroButtonIconPushed[buttonIndex], BlzGetAbilityIcon(HeroButtonUnitCode[buttonIndex]), 0, ButtonBlendAll)
                call BlzFrameSetTexture(HeroButtonIconDisabled[buttonIndex], HeroSelectorGetDisabledIcon(BlzGetAbilityIcon(HeroButtonUnitCode[buttonIndex])), 0, ButtonBlendAll)

                //call BlzFrameSetText(HeroButtonTooltip[buttonIndex], TooltipPrefix + GetObjectName(HeroButtonUnitCode[buttonIndex]))
                call HeroSelectorUpdateTooltip(HeroButtonUnitCode[buttonIndex])
            else
                //no, make it unclickable and empty
                call BlzFrameSetEnable(HeroButtonFrame[buttonIndex], false)
                if HideEmptyButtons then
                    call BlzFrameSetVisible(HeroButtonFrame[buttonIndex], false)
                endif
                call BlzFrameSetTexture(HeroButtonIcon[buttonIndex], EmptyButtonPath, 0, true)
                call BlzFrameSetTexture(HeroButtonIconPushed[buttonIndex], EmptyButtonPath, 0, true)
                call BlzFrameSetTexture(HeroButtonIconDisabled[buttonIndex], EmptyButtonPath, 0, true)
            endif
            set buttonIndex = buttonIndex + 1
        endloop
    endfunction
    function HeroSelectorEnablePickAction takes boolean flag returns nothing
        call BlzFrameSetVisible(AcceptButton, true and AcceptButtonIsShown)
        call BlzFrameSetVisible(RandomButton, true and RandomButtonIsShown)
        call BlzFrameSetVisible(BanButton, false)
        call BlzFrameSetEnable(AcceptButton, flag)
        call BlzFrameSetEnable(RandomButton, flag)
        call BlzFrameSetModel(IndicatorSelected, IndicatorPathPick, 0)
        if flag then
            set LastAction = 1
        else
            set LastAction = 2
        endif
        if BanIgnoreRequirment then
            call HeroSelectorUpdate()
        endif
    endfunction

    function HeroSelectorEnablePick takes boolean flag returns nothing
        call HeroSelectorEnablePickDelayBanAction()
        call HeroSelectorEnablePickAction(flag)    
    endfunction

    function HeroSelectorEnablePickPlayer takes boolean flag, player p returns nothing
        call HeroSelectorEnablePickDelayBanAction()

        if GetLocalPlayer() == p then
            call HeroSelectorEnablePickAction(flag)
        endif
    endfunction

    function HeroSelectorEnablePickTeam takes boolean flag, integer teamNr returns nothing
        call HeroSelectorEnablePickDelayBanAction()

        if GetPlayerTeam(GetLocalPlayer()) == teamNr then
            call HeroSelectorEnablePickAction(flag)
        endif
    endfunction

    function HeroSelectorEnablePickRace takes boolean flag, race r returns nothing
        call HeroSelectorEnablePickDelayBanAction()

        if GetPlayerRace(GetLocalPlayer()) == r then
            call HeroSelectorEnablePickAction(flag)
        endif
    endfunction

    function HeroSelectorEnablePickForce takes boolean flag, force f returns nothing
        call HeroSelectorEnablePickDelayBanAction()

        if BlzForceHasPlayer(f, GetLocalPlayer()) then
            call HeroSelectorEnablePickAction(flag)
        endif
    endfunction

    function HeroSelectorEnableBanPlayerAction takes boolean flag returns nothing  
        call BlzFrameSetVisible(AcceptButton, false)
        call BlzFrameSetVisible(RandomButton, false)
        call BlzFrameSetVisible(BanButton, true)
        call BlzFrameSetEnable(BanButton, flag)
        call BlzFrameSetModel(IndicatorSelected, IndicatorPathBan, 0)
        if flag then
            set LastAction = 3
        else
            set LastAction = 4
        endif
        if BanIgnoreRequirment then
            call HeroSelectorUpdate()
        endif
    endfunction

    function HeroSelectorEnableBanPlayer takes boolean flag, player p returns nothing  
        if GetLocalPlayer() == p then
            call HeroSelectorEnableBanPlayerAction(flag)
        endif
    endfunction

    function HeroSelectorEnableBanForce takes boolean flag, force f returns nothing  
        if BlzForceHasPlayer(f, GetLocalPlayer()) then
            call HeroSelectorEnableBanPlayerAction(flag)
        endif
    endfunction

    function HeroSelectorEnableBanTeam takes boolean flag, integer teamNr returns nothing  
        if GetPlayerTeam(GetLocalPlayer()) == teamNr then
            call HeroSelectorEnableBanPlayerAction(flag)
        endif
    endfunction

    function HeroSelectorEnableBanRace takes boolean flag, race r returns nothing  
        if GetPlayerRace(GetLocalPlayer()) == r then
            call HeroSelectorEnableBanPlayerAction(flag)
        endif
    endfunction
    function HeroSelectorEnableBan takes boolean flag returns nothing  
        call HeroSelectorEnableBanPlayerAction(flag)
    endfunction

    function HeroSelectorframeLoseFocus takes framehandle frame returns nothing
        if BlzFrameGetEnable(frame) then
            call BlzFrameSetEnable(frame, false)
            call BlzFrameSetEnable(frame, true)
        endif
    endfunction


    function HeroSelectorShowFramePlayer takes framehandle frame, boolean flag, player p returns nothing
        if GetLocalPlayer() == p then
            call BlzFrameSetVisible(frame, flag)
        endif
    endfunction

    function HeroSelectorShowFrameForce takes framehandle frame, boolean flag, force f returns nothing
        if BlzForceHasPlayer(f, GetLocalPlayer()) then
            call BlzFrameSetVisible(frame, flag)
        endif
    endfunction

    function HeroSelectorShowFrameTeam takes framehandle frame, boolean flag, integer teamNr returns nothing
        if GetPlayerTeam(GetLocalPlayer()) == teamNr then
            call BlzFrameSetVisible(frame, flag)
        endif
    endfunction

    function HeroSelectorShowFrameRace takes framehandle frame, boolean flag, race r returns nothing
        if GetPlayerRace(GetLocalPlayer()) == r then
            call BlzFrameSetVisible(frame, flag)
        endif
    endfunction

    function HeroSelectorShowPlayer takes boolean flag, player who returns nothing
        call HeroSelectorShowFramePlayer(HeroSelectorBox, flag, who)
    endfunction

    function HeroSelectorShowTeam takes boolean flag, integer who returns nothing
        call HeroSelectorShowFrameTeam(HeroSelectorBox, flag, who)
    endfunction

    function HeroSelectorShowRace takes boolean flag, race who returns nothing
        call HeroSelectorShowFrameRace(HeroSelectorBox, flag, who)
    endfunction

    function HeroSelectorShowForce takes boolean flag, force who returns nothing
        call HeroSelectorShowFrameForce(HeroSelectorBox, flag, who)
    endfunction
    function HeroSelectorShow takes boolean flag returns nothing
        call BlzFrameSetVisible(HeroSelectorBox, flag)
    endfunction

    function HeroSelectorAddUnit takes integer unitCode, boolean onlyRandom returns nothing
        //no unitCode => empty field
        if unitCode == 0 then
            set ButtonHeroCount = ButtonHeroCount + 1
        else
            //Such an object Exist? not unique?
            if GetObjectName(unitCode) == "" or HaveSavedBoolean(Hash, unitCode, 0) then
                return
            endif
            
            set HeroCount = HeroCount + 1
            set HeroUnitCode[HeroCount] = unitCode
            
            call SaveBoolean(Hash, unitCode, 0, true)
            call SaveInteger(Hash, unitCode, 0, HeroCount)
            set HeroCategory[HeroCount] = AutoDetectCategory(unitCode)
            if not onlyRandom then
                set ButtonHeroCount = ButtonHeroCount + 1
                set HeroButtonIndex[HeroCount] = ButtonHeroCount
                set ButtonHeroUnitCode[ButtonHeroCount] = unitCode        
            endif
        endif
    endfunction

    function ApplyDraftSelectionForPlayer takes nothing returns nothing
        local integer playerIndex = GetPlayerId(GetEnumPlayer())
        local integer currentCount = 0
        local integer currentUnitId = 0

        set DraftEnabled = true

        // Select one of each type of hero
        set currentUnitId = HeroSelectorRollOption(GetEnumPlayer(), false, 0, 4, true)
        set PlayerDraftOptions[playerIndex][currentUnitId] = 1
        set currentUnitId = HeroSelectorRollOption(GetEnumPlayer(), false, 0, 8, true)
        set PlayerDraftOptions[playerIndex][currentUnitId] = 1
        set currentUnitId = HeroSelectorRollOption(GetEnumPlayer(), false, 0, 16, true)
        set PlayerDraftOptions[playerIndex][currentUnitId] = 1

        // Get 2 random heroes
        loop
            set currentUnitId = HeroSelectorRollOption(GetEnumPlayer(), false, 0, 0, true)

            if (not PlayerDraftOptions[playerIndex].has(currentUnitId)) then
                set currentCount = currentCount + 1
                set PlayerDraftOptions[playerIndex][currentUnitId] = 1
            endif

            exitwhen currentCount == 2
        endloop
    endfunction

    function ApplyDraftSelectionForPlayers takes nothing returns nothing
        call ForForce(GetPlayersAll(), function ApplyDraftSelectionForPlayer)
    endfunction

    function ApplySameDraftSelectionForPlayers takes nothing returns nothing
        local integer playerIndex = 0
        local integer currentCount = 0
        local integer randomUnit1 = 0
        local integer randomUnit2 = 0
        local integer tempUnitId = 0

        local Table draftHeroes = Table.create()

        // udg_player03 == Host player. It needs some player to prevent errors. Player doesn't actually matter here
        local integer strUnitId = HeroSelectorRollOption(udg_player03, false, 0, 4, true)
        local integer agiUnitId = HeroSelectorRollOption(udg_player03, false, 0, 8, true)
        local integer intUnitId = HeroSelectorRollOption(udg_player03, false, 0, 16, true)
        set draftHeroes[strUnitId] = 1
        set draftHeroes[agiUnitId] = 1
        set draftHeroes[intUnitId] = 1

        set DraftEnabled = true
        
        // Get 2 random heroes
        loop
            set tempUnitId = HeroSelectorRollOption(udg_player03, false, 0, 0, true)

            if (not draftHeroes.has(tempUnitId)) then
                set currentCount = currentCount + 1
                set draftHeroes[tempUnitId] = 1

                if (randomUnit1 == 0) then
                    set randomUnit1 = tempUnitId
                else
                    set randomUnit2 = tempUnitId
                endif
            endif

            exitwhen currentCount == 2
        endloop

        // Set the same draft options for every player
        loop
            set PlayerDraftOptions[playerIndex][strUnitId] = 1
            set PlayerDraftOptions[playerIndex][agiUnitId] = 1
            set PlayerDraftOptions[playerIndex][intUnitId] = 1
            set PlayerDraftOptions[playerIndex][randomUnit1] = 1
            set PlayerDraftOptions[playerIndex][randomUnit2] = 1

            set playerIndex = playerIndex + 1
            exitwhen playerIndex == 8
        endloop

        // Cleanup
        call draftHeroes.destroy()
    endfunction

    function HeroSelectorDoRandom takes player p returns nothing
        local integer category = 0
        local integer unitCode
        local unit u
        local location arenaLocation

        if CategoryAffectRandom then
            set category = PlayerSelectedCategory[GetPlayerId(p)]
        endif
        set unitCode = HeroSelectorRollOption(p, true, 0, category, false)
        if unitCode == 0 then
            return
        endif

        // Make sure they don't already have a hero
        if (PlayerHeroes[GetPlayerId(p) + 1] == null) then
            set arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(p)])
            set u = CreateUnitAtLoc(p, unitCode, arenaLocation, bj_UNIT_FACING)
            set PlayerHeroes[GetPlayerId(p) + 1] = u
            call GroupAddUnit(OnPeriodGroup, u)
    
            call HeroSelectorCounterChangeUnitCode(unitCode, 1, p)
    
            set HeroSelectorEventUnit = u
            set HeroSelectorEventIsRandom = true
            set HeroSelectorEventUnitCode = unitCode
            set HeroSelectorEventPlayer = p
            set HeroSelectorEvent = 0.0
            set HeroSelectorEvent = 1.0
            set HeroSelectorEvent = 0.0

            call RemoveLocation(arenaLocation)
            set arenaLocation = null
            set u = null
        endif
    endfunction

    function HeroSelectorDoPick takes player p returns boolean
        local integer unitCode
        local unit u
        //pick what currently is selected, returns true on success returns false when something went wrong,
        local integer buttonIndex = PlayerSelectedButtonIndex[GetPlayerId(p)]
        local location arenaLocation

        if buttonIndex <= 0 then
            return false
        endif //reject nothing selected
        set unitCode = HeroButtonUnitCode[buttonIndex]
        if not HeroSelectorButtonRequirementDone(unitCode, p) then
            return false
        endif //reject requirment not fullfilled

        // Make sure they don't already have a hero
        if (PlayerHeroes[GetPlayerId(p) + 1] == null) then
            set arenaLocation = GetRectCenter(PlayerArenaRects[GetConvertedPlayerId(p)])
            set u = CreateUnitAtLoc(p, unitCode, arenaLocation, bj_UNIT_FACING)
            set PlayerHeroes[GetPlayerId(p) + 1] = u
            call GroupAddUnit(OnPeriodGroup, u)
            
            call HeroSelectorCounterChangeUnitCode(unitCode, 1, p)

            set HeroSelectorEventUnit = u
            set HeroSelectorEventIsRandom = false
            set HeroSelectorEventUnitCode = unitCode
            set HeroSelectorEventPlayer = p
            set HeroSelectorEvent = 0.0
            set HeroSelectorEvent = 1.0
            set HeroSelectorEvent = 0.0

            call RemoveLocation(arenaLocation)
            set arenaLocation = null
            set u = null

            return true
        endif

        return false
    endfunction

    function HeroSelectorForceRandom takes nothing returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                call HeroSelectorDoRandom(p)
            endif
            set playerIndex = playerIndex + 1
        endloop
        set p = null
    endfunction

    function HeroSelectorForceRandomTeam takes integer who returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                if GetPlayerTeam(p) == who then
                    call HeroSelectorDoRandom(p)
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop
        set p = null
    endfunction

    function HeroSelectorForceRandomRace takes race who returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                if GetPlayerRace(p) == who then
                    call HeroSelectorDoRandom(p)
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop
        set p = null
    endfunction
    function HeroSelectorForcePick takes nothing returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                if not HeroSelectorDoPick(p) then
                    call HeroSelectorDoRandom(p) 
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop
    endfunction

    function HeroSelectorForcePickTeam takes integer who returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                if GetPlayerTeam(p) == who then
                    if not HeroSelectorDoPick(p) then
                        call HeroSelectorDoRandom(p) 
                    endif
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop
    endfunction

    function HeroSelectorForcePickRace takes race r returns nothing
        //this is a wrapper for doRandom allowing different dataTypes
        local player p
        local integer playerIndex = 0
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set p = Player(playerIndex)
            if GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING and p != Player(8) and p != Player(11) then
                if GetPlayerRace(p) == r then
                    if not HeroSelectorDoPick(p) then
                        call HeroSelectorDoRandom(p) 
                    endif
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop
    endfunction
    
    function HeroSelectorForcePickPlayer takes player p returns nothing
        if not HeroSelectorDoPick(p) then
            call HeroSelectorDoRandom(p) 
        endif
    endfunction

    function HeroSelectorActionPressHeroButton takes nothing returns nothing
        local framehandle fh = BlzGetTriggerFrame()
        local player p = GetTriggerPlayer()
        local integer buttonIndex = LoadInteger(Hash, GetHandleId(fh), 0)
        local integer unitCode = HeroButtonUnitCode[buttonIndex]
        set PlayerSelectedButtonIndex[GetPlayerId(p)] = buttonIndex

        call HeroSelectorframeLoseFocus(BlzGetTriggerFrame())

        if GetLocalPlayer() == p then
            call BlzFrameSetVisible(IndicatorSelected, true)
            
            call BlzFrameSetPoint(IndicatorSelected, FRAMEPOINT_TOPLEFT, fh, FRAMEPOINT_TOPLEFT, -0.001, 0.001)
            call BlzFrameSetPoint(IndicatorSelected, FRAMEPOINT_BOTTOMRIGHT, fh, FRAMEPOINT_BOTTOMRIGHT, -0.0012, -0.0016)
        endif

        set HeroSelectorEventUnit = null
        set HeroSelectorEventUnitCode = unitCode
        set HeroSelectorEventPlayer = p
        set HeroSelectorEvent = 0.0
        set HeroSelectorEvent = 2.0
        set HeroSelectorEvent = 0.0

        set fh = null
        set p = null
    endfunction

    function HeroSelectorActionRandomButton takes nothing returns nothing
        local player p = GetTriggerPlayer()
        local integer playerIndex = GetPlayerId(p)
        local integer unitCode
        local integer unitCodeIndex
        local integer buttonIndex
        call HeroSelectorframeLoseFocus(BlzGetTriggerFrame())
        if RandomButtonPick then
            call HeroSelectorDoRandom(p)
        else
            set unitCode = HeroSelectorRollOption(p, false, PlayerSelectedButtonIndex[playerIndex], PlayerSelectedCategory[playerIndex], false)
            if unitCode > 0 and GetLocalPlayer() == p then
                set unitCodeIndex = LoadInteger(Hash, unitCode, 0)
                set buttonIndex = HeroButtonIndex[unitCodeIndex]
                call BlzFrameClick(HeroButtonFrame[buttonIndex])
            endif
        endif
        set p = null
    endfunction

    function HeroSelectorActionAcceptButton takes nothing returns nothing
        call HeroSelectorframeLoseFocus(BlzGetTriggerFrame())
        call HeroSelectorDoPick(GetTriggerPlayer())
    endfunction

    function HeroSelectorActionBanButton takes nothing returns nothing
        local player p = GetTriggerPlayer()
        local integer playerIndex = GetPlayerId(p)
        local integer buttonIndex = PlayerSelectedButtonIndex[playerIndex]
        local integer unitCode = HeroButtonUnitCode[buttonIndex]

        if (not PlayerHasBanned[playerIndex]) then
            set PlayerHasBanned[playerIndex] = true
            
            call HeroSelectorframeLoseFocus(BlzGetTriggerFrame())
            if buttonIndex > 0 then
                if not DelayBanUntilPick then
                    call HeroSelectorCounterChangeUnitCode(unitCode, UnitCount + 1, p)
                else
                    set DelayBanCount = DelayBanCount + 1
                    set DelayBanPlayer[DelayBanCount] = p
                    set DelayBanUnitCode[DelayBanCount] = unitCode
                endif

                set HeroSelectorEventUnit = null
                set HeroSelectorEventUnitCode = unitCode
                set HeroSelectorEventPlayer = p
                set HeroSelectorEvent = 0.0
                set HeroSelectorEvent = 3.0
                set HeroSelectorEvent = 0.0
            endif

            set PlayerBanCount = PlayerBanCount + 1
        endif

        set p = null
    endfunction

    function HeroSelectorActionCategoryButton takes nothing returns nothing
        local integer buttonIndex
        local framehandle fh = BlzGetTriggerFrame()
        local integer categoryIndex = LoadInteger(Hash, GetHandleId(fh), 0)
        local integer lastCategoryIndex
        local player p = GetTriggerPlayer()
        local integer playerIndex = GetPlayerId(p)
        local integer unitCodeIndex
        call HeroSelectorframeLoseFocus(fh)
        //has this category already?
        if BlzBitAnd(PlayerSelectedCategory[playerIndex], CategoryButtonValue[categoryIndex]) != 0 then
            //yes, unable
            set PlayerSelectedCategory[playerIndex] = PlayerSelectedCategory[playerIndex] - CategoryButtonValue[categoryIndex]
            if GetLocalPlayer() == p then
                call BlzFrameSetTexture(CategoryIconFrame[categoryIndex], CategoryTextureDisabled[categoryIndex], 0, true)
                call BlzFrameSetTexture(CategoryIconPushedFrame[categoryIndex], CategoryTextureDisabled[categoryIndex], 0, true)
            endif

        else
            if not CategoryMultiSelect and PlayerSelectedCategory[playerIndex] != 0 then
                set lastCategoryIndex = PlayerLastSelectedCategoryIndex[playerIndex]
                call BlzFrameSetTexture(CategoryIconFrame[lastCategoryIndex], CategoryTextureDisabled[lastCategoryIndex], 0, true)
                call BlzFrameSetTexture(CategoryIconPushedFrame[lastCategoryIndex], CategoryTextureDisabled[lastCategoryIndex], 0, true)
                set PlayerSelectedCategory[playerIndex] = 0
            endif
            
            //no, enable
            set PlayerSelectedCategory[playerIndex] = PlayerSelectedCategory[playerIndex] + CategoryButtonValue[categoryIndex]
            if GetLocalPlayer() == p then
                call BlzFrameSetTexture(CategoryIconFrame[categoryIndex], CategoryTexture[categoryIndex], 0, true)
                call BlzFrameSetTexture(CategoryIconPushedFrame[categoryIndex], CategoryTexture[categoryIndex], 0, true)
                
            endif
            set PlayerLastSelectedCategoryIndex[playerIndex] = categoryIndex
        endif
        
        if GetLocalPlayer() == p then
            //update all buttons
            //buttons not having at least 1 selected category becomes partly transparent
            set buttonIndex = 1
            loop
                exitwhen buttonIndex > HeroButtonCount
                if HeroButtonUnitCode[buttonIndex] > 0 then
                    set unitCodeIndex = LoadInteger(Hash, HeroButtonUnitCode[buttonIndex],0)
                    if PlayerSelectedCategory[playerIndex] == 0 or BlzBitAnd(HeroCategory[unitCodeIndex], PlayerSelectedCategory[playerIndex]) > 0 then
                        call BlzFrameSetAlpha(HeroButtonFrame[buttonIndex], 255)
                    else
                        call BlzFrameSetAlpha(HeroButtonFrame[buttonIndex], CategoryFilteredAlpha)
                    endif
                endif
                set buttonIndex = buttonIndex + 1
            endloop
        endif
        set fh = null
        set p = null
    endfunction

    function HeroSelectorInit takes nothing returns nothing
        local boolean loaded = BlzLoadTOCFile("war3mapImported\\HeroSelector.toc") //ex/import also "HeroSelector.fdf"
        local integer buttonIndex
        local real titleSize = 0.015
        local real borderSize = GetBorderSize()
        local integer colCount = ButtonColCount
        local integer rowCount = ButtonRowCount
        local framehandle box = BlzCreateFrame(BoxFrameName, BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        local framehandle boxBottom = BlzCreateFrame("HeroSelectorRaceTopBox", box, 0, 0)
        local integer rowRemaining = colCount
        local real y = -borderSize - titleSize - 0.0125 - CategorySize
        local real x = borderSize
        
        set HeroSelectorBoxTitle = BlzCreateFrame("HeroSelectorTitle", box, 0, 0)
        set IndicatorSelectedParent = BlzCreateFrameByType("BUTTON", "MyHeroIndikatorParent", box, "", 0)
        call BlzFrameSetLevel(IndicatorSelectedParent, 9)
        set IndicatorSelected = BlzCreateFrameByType("SPRITE", "MyHeroIndikator", IndicatorSelectedParent, "", 0)
        set HeroSelectorBox = box   
        set HeroSelectorBoxSeperator = boxBottom
        call BlzFrameSetModel(IndicatorSelected, IndicatorPathPick, 0)
        call BlzFrameSetScale(IndicatorSelected, ButtonSize/0.036) //scale the model to the button size.

        call BlzFrameSetVisible(IndicatorSelected, false)
        call BlzFrameSetAbsPoint(box, BoxPosPoint, BoxPosX, BoxPosY)
        call BlzFrameSetSize(box, borderSize*2 + ButtonSize*colCount + SpaceBetweenX*(colCount-1), borderSize*2 + ButtonSize*rowCount + SpaceBetweenY*(rowCount - 1) + titleSize + CategorySize + 0.0145)
        call BlzFrameSetPoint(HeroSelectorBoxTitle, FRAMEPOINT_TOP, box, FRAMEPOINT_TOP, 0, -borderSize*0.6)
        call BlzFrameSetText(HeroSelectorBoxTitle, "Hero Selection")
        call BlzFrameSetTextAlignment(HeroSelectorBoxTitle, TEXT_JUSTIFY_MIDDLE, TEXT_JUSTIFY_CENTER)
        call BlzFrameSetSize(HeroSelectorBoxTitle, BlzFrameGetWidth(box) - borderSize*2, 0.03)


        // human UI size differs much, needs other numbers
        if GetPlayerRace(GetLocalPlayer()) == RACE_HUMAN then
            call BlzFrameSetPoint(boxBottom, FRAMEPOINT_TOPLEFT, box, FRAMEPOINT_TOPLEFT, borderSize*0.055, - 0.9*borderSize - titleSize - 0.003 -CategorySize)
            call BlzFrameSetPoint(boxBottom, FRAMEPOINT_TOPRIGHT, box, FRAMEPOINT_TOPRIGHT, -borderSize*0.055, - 0.9*borderSize - titleSize - 0.003 -CategorySize)
        else
            call BlzFrameSetPoint(boxBottom, FRAMEPOINT_TOPLEFT, box, FRAMEPOINT_TOPLEFT, borderSize*0.25, - 0.9*borderSize - titleSize - 0.003 -CategorySize)
            call BlzFrameSetPoint(boxBottom, FRAMEPOINT_TOPRIGHT, box, FRAMEPOINT_TOPRIGHT, -borderSize*0.25, - 0.9*borderSize - titleSize - 0.003 -CategorySize)
        endif
        call BlzFrameSetSize(boxBottom, 0.01, 0.1)
        
        if colCount*rowCount < ButtonHeroCount  then
            call BJDebugMsg("FieldCount:"+ I2S(colCount*rowCount) + "HeroCount" + I2S(ButtonHeroCount))
        endif
        
        set buttonIndex = 1
        loop
            exitwhen buttonIndex >  HeroButtonCount
            set HeroButtonFrame[buttonIndex] = BlzCreateFrame("HeroSelectorButton", box, 0, buttonIndex)
            set HeroButtonIcon[buttonIndex] = BlzGetFrameByName("HeroSelectorButtonIcon", buttonIndex)
            set HeroButtonIconPushed[buttonIndex] = BlzGetFrameByName("HeroSelectorButtonIconPushed", buttonIndex)
            set HeroButtonIconDisabled[buttonIndex] = BlzGetFrameByName("HeroSelectorButtonIconDisabled", buttonIndex)
            set HeroButtonUnitCode[buttonIndex] = ButtonHeroUnitCode[buttonIndex]
            call SaveInteger(Hash, GetHandleId(HeroButtonFrame[buttonIndex]), 0, buttonIndex)
            set HeroButtonTooltipBox[buttonIndex] = BlzCreateFrame("HeroSelectorTextBox", box, 0, buttonIndex)
            set HeroButtonTooltip[buttonIndex] = BlzCreateFrame("HeroSelectorText", HeroButtonTooltipBox[buttonIndex], 0, buttonIndex)
            call BlzFrameSetTooltip(HeroButtonFrame[buttonIndex], HeroButtonTooltipBox[buttonIndex])
            if not TooltipRelativIsBox then
                call BlzFrameSetPoint(HeroButtonTooltip[buttonIndex], TooltipPoint, HeroButtonFrame[buttonIndex], TooltipRelativePoint, TooltipOffsetX ,TooltipOffsetY)
            else
                call BlzFrameSetPoint(HeroButtonTooltip[buttonIndex], TooltipPoint, box, TooltipRelativePoint, TooltipOffsetX ,TooltipOffsetY)
            endif
            call BlzFrameSetPoint(HeroButtonTooltipBox[buttonIndex], FRAMEPOINT_BOTTOMLEFT, HeroButtonTooltip[buttonIndex], FRAMEPOINT_BOTTOMLEFT, -0.007, -0.007)
            call BlzFrameSetPoint(HeroButtonTooltipBox[buttonIndex], FRAMEPOINT_TOPRIGHT, HeroButtonTooltip[buttonIndex], FRAMEPOINT_TOPRIGHT, 0.007, 0.007)
            call BlzTriggerRegisterFrameEvent(HeroButtonClickTrigger, HeroButtonFrame[buttonIndex], FRAMEEVENT_CONTROL_CLICK)
            call BlzFrameSetSize(HeroButtonFrame[buttonIndex], ButtonSize, ButtonSize)


            if ChainedButtons then //buttons are connected to the previous one or the previous row
                if buttonIndex == 1 then
                    call BlzFrameSetPoint(HeroButtonFrame[buttonIndex], FRAMEPOINT_TOPLEFT, box, FRAMEPOINT_TOPLEFT, borderSize, y)
                elseif rowRemaining <= 0 then
                    call BlzFrameSetPoint(HeroButtonFrame[buttonIndex], FRAMEPOINT_TOPLEFT, HeroButtonFrame[buttonIndex - colCount], FRAMEPOINT_BOTTOMLEFT, 0, -SpaceBetweenY)
                    set rowRemaining = colCount
                else
                    call BlzFrameSetPoint(HeroButtonFrame[buttonIndex], FRAMEPOINT_LEFT, HeroButtonFrame[buttonIndex - 1], FRAMEPOINT_RIGHT, SpaceBetweenX, 0)
                endif
            else //buttons have an offset to the TopLeft of the box
                if rowRemaining <= 0 then
                    set x = borderSize
                    set rowRemaining = colCount
                    set y = y - SpaceBetweenY - ButtonSize
                elseif buttonIndex != 1 then
                    set x = x + ButtonSize + SpaceBetweenX
                endif
                call BlzFrameSetPoint(HeroButtonFrame[buttonIndex], FRAMEPOINT_TOPLEFT, box, FRAMEPOINT_TOPLEFT, x, y)
            endif
            set rowRemaining = rowRemaining - 1
            set buttonIndex = buttonIndex + 1
        endloop
        set y = -0.9*borderSize - titleSize - 0.0025
        set x = borderSize*0.65
        //create category buttons added before the box was created
        set buttonIndex = 1
        loop
            exitwhen buttonIndex > CategoryButtonCount
            set CategoryButton[buttonIndex] = BlzCreateFrame("HeroSelectorCategoryButton", box, 0, 0)
            set CategoryIconFrame[buttonIndex] = BlzGetFrameByName("HeroSelectorCategoryButtonIcon", 0)
            set CategoryIconPushedFrame[buttonIndex] = BlzGetFrameByName("HeroSelectorCategoryButtonIconPushed", 0)
            set CategoryTooltipFrameBox[buttonIndex] = BlzCreateFrame("HeroSelectorTextBox", box, 0, buttonIndex)
            set CategoryTooltipFrame[buttonIndex] = BlzCreateFrame("HeroSelectorText", CategoryTooltipFrameBox[buttonIndex], 0, buttonIndex)
            call BlzFrameSetText(CategoryTooltipFrame[buttonIndex], GetLocalizedString(CategoryText[buttonIndex]))
            
            call BlzFrameSetPoint(CategoryTooltipFrameBox[buttonIndex], FRAMEPOINT_BOTTOMLEFT, CategoryTooltipFrame[buttonIndex], FRAMEPOINT_BOTTOMLEFT, -0.007, -0.007)
            call BlzFrameSetPoint(CategoryTooltipFrameBox[buttonIndex], FRAMEPOINT_TOPRIGHT, CategoryTooltipFrame[buttonIndex], FRAMEPOINT_TOPRIGHT, 0.007, 0.007)
            call BlzFrameSetPoint(CategoryTooltipFrame[buttonIndex], FRAMEPOINT_BOTTOM, CategoryButton[buttonIndex], FRAMEPOINT_TOP, 0, 0)
            call BlzFrameSetTooltip(CategoryButton[buttonIndex], CategoryTooltipFrameBox[buttonIndex])
            call BlzFrameSetSize(CategoryButton[buttonIndex], CategorySize, CategorySize)
            call BlzFrameSetTexture(CategoryIconFrame[buttonIndex], CategoryTextureDisabled[buttonIndex], 0, true)
            call BlzFrameSetTexture(CategoryIconPushedFrame[buttonIndex], CategoryTextureDisabled[buttonIndex], 0, true)

            call BlzTriggerRegisterFrameEvent(CategoryClickTrigger, CategoryButton[buttonIndex], FRAMEEVENT_CONTROL_CLICK)
            if buttonIndex == 1 then
                call BlzFrameSetPoint(CategoryButton[buttonIndex], FRAMEPOINT_TOPLEFT, box, FRAMEPOINT_TOPLEFT, x, y)
            else
                call BlzFrameSetPoint(CategoryButton[buttonIndex], FRAMEPOINT_LEFT, CategoryButton[buttonIndex - 1], FRAMEPOINT_RIGHT, CategorySpaceX, 0)
            endif
            call SaveInteger(Hash, GetHandleId(CategoryButton[buttonIndex]), 0, buttonIndex)
            set buttonIndex = buttonIndex + 1
        endloop

        

        set AcceptButton = BlzCreateFrame("HeroSelectorTextButton", box, 0, 0)
        set RandomButton = BlzCreateFrame("HeroSelectorTextButton", box, 0, 1)
        set BanButton = BlzCreateFrame("HeroSelectorTextButton", box, 0, 2)

        
        call BlzTriggerRegisterFrameEvent(AcceptButtonTrigger, AcceptButton, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(RandomButtonTrigger, RandomButton, FRAMEEVENT_CONTROL_CLICK)
        call BlzTriggerRegisterFrameEvent(BanButtonTrigger, BanButton, FRAMEEVENT_CONTROL_CLICK)
        call BlzFrameSetSize(AcceptButton, AcceptButtonSizeX, AcceptButtonSizeY)
        call BlzFrameSetSize(RandomButton, RandomButtonSizeX, RandomButtonSizeY)
        call BlzFrameSetSize(BanButton, BanButtonSizeX, BanButtonSizeY)

        //OK, READY, ACCEPT
        call BlzFrameSetText(AcceptButton, AcceptButtonTextPrefix + GetLocalizedString(AcceptButtonText))
        call BlzFrameSetText(RandomButton, RandomButtonTextPrefix + GetLocalizedString(RandomButtonText))
        call BlzFrameSetText(BanButton, BanButtonTextPrefix + GetLocalizedString(BanButtonText))
        call BlzFrameSetPoint(AcceptButton, AcceptButtonAnchor, box, FRAMEPOINT_BOTTOM, 0, 0)
        call BlzFrameSetPoint(RandomButton, RandomButtonAnchor, box, FRAMEPOINT_BOTTOM, 0, 0)
        call BlzFrameSetPoint(BanButton, FRAMEPOINT_BOTTOM, box, FRAMEPOINT_BOTTOM, 0, 0)

        call BlzFrameSetVisible(BanButton, false)
        call BlzFrameSetVisible(AcceptButton, AcceptButtonIsShown)
        call BlzFrameSetVisible(RandomButton, RandomButtonIsShown)

        
        if not AutoShow then
            call BlzFrameSetVisible(box, false)
        endif

        call HeroSelectorUpdate()
        call ExecuteFunc("HeroInfoInit")

        // LastAction is used to Restore the current Pick/Bann Phase after Save&Load
        if LastAction == 1 then
            call HeroSelectorEnablePick(true)
        elseif LastAction == 2 then
            call HeroSelectorEnablePick(false)
        elseif LastAction == 3 then
            call HeroSelectorEnableBan(true)
        elseif LastAction == 4 then
            call HeroSelectorEnableBan(false)
        endif
    endfunction

    private function At0s takes nothing returns nothing
        local integer playerIndex = 0
        local integer teamIndexLoop
        local integer teamNr

        set PlayerDraftOptions = TableArray[8]

        //find all Teams in usage
        loop
            exitwhen playerIndex == GetBJMaxPlayers()
            set teamNr = GetPlayerTeam(Player(playerIndex))
            if teamNr != -1 then
                set teamIndexLoop = UsedTeamNrCount
                loop
                    exitwhen teamIndexLoop == 0
                    exitwhen UsedTeamNr[teamIndexLoop] == teamNr
                    set teamIndexLoop = teamIndexLoop - 1
                endloop
                if teamIndexLoop == 0 then
                    set UsedTeamNrCount = UsedTeamNrCount + 1
                    set UsedTeamNr[UsedTeamNrCount] = teamNr
                endif
            endif
            set playerIndex = playerIndex + 1
        endloop

        call DestroyTimer(GetExpiredTimer())
        call ExecuteFunc("HeroSelectorAction_InitHeroes")
        call HeroSelectorInit()
    endfunction
    private function init_function takes nothing returns nothing
        
        call TriggerAddAction(CategoryClickTrigger, function HeroSelectorActionCategoryButton)
        call TriggerAddAction(AcceptButtonTrigger, function HeroSelectorActionAcceptButton)
        call TriggerAddAction(RandomButtonTrigger, function HeroSelectorActionRandomButton)
        call TriggerAddAction(BanButtonTrigger, function HeroSelectorActionBanButton)
        call TriggerAddAction(HeroButtonClickTrigger, function HeroSelectorActionPressHeroButton)
        
        call TimerStart(CreateTimer(), 0, false, function At0s)
    endfunction

endlibrary