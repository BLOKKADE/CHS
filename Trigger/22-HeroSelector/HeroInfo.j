library HeroInfo initializer init_function requires GetObjectElement
    // 1.3
    //Plugin for  by Tasyen
    //This Creates a TextDisplay which displays the name and the Extended tooltip of selected units
    
    globals
        private framehandle TextDisplay
        private string DescHeroNamePrefix             = "|cffffcc00"   //added before the Units Name
        private string DescHeroNameSufix              = "|r"           //added after the units Name
        private real TextAreaSizeX                    = 0.2
        private real TextAreaSizeY                    = 0.35
        private real TextAreaOffsetX                  = 0.0
        private real TextAreaOffsetY                  = 0.0
        private framepointtype TextAreaPoint          = FRAMEPOINT_TOPLEFT //pos the Tooltip with which Point
        private framepointtype TextAreaRelativePoint  = FRAMEPOINT_TOPRIGHT //pos the Tooltip to which Point of the Relative
        private boolean TextAreaRelativeGame          = false //(false) relativ to box, (true) relativ to GameUI
    
        private integer MaxButtonCount                = 7
        private integer ButtonPerRow                  = 7
        private boolean DetectUnitSkills              = false // (true) creates a dummy (for neutral Passive) when selecting an option to find any skill this unitCode has on default and displays them in the preview
        private real ButtonSizeX                      = 0.03
        private real ButtonSizeY                      = 0.03
        private real ToolTipSize                      = 0.2 // how big is one line in the tooltip
        private boolean ToolTipFixedPos               = true // (true) All tooltip's starts over the first Buttons
        
        private framehandle array Buttons
        private framehandle array Icon
        private framehandle array IconOff
        private framehandle array IconPushed
        private framehandle array Tooltip
        private framehandle array TooltipBox
        private integer ButtonCurrentIndex = 0
    endglobals
    
    function HeroInfoDestroy takes nothing returns nothing
        call BlzDestroyFrame(TextDisplay)
        loop
            exitwhen MaxButtonCount <= 0
            call BlzDestroyFrame(Tooltip[MaxButtonCount])
            call BlzDestroyFrame(Icon[MaxButtonCount])
            call BlzDestroyFrame(IconPushed[MaxButtonCount])
            call BlzDestroyFrame(IconOff[MaxButtonCount])
            call BlzDestroyFrame(TooltipBox[MaxButtonCount])
            call BlzDestroyFrame(Buttons[MaxButtonCount])
            set  MaxButtonCount =  MaxButtonCount - 1
        endloop
        set TextDisplay = null
    endfunction
    
    function HeroInfoInitHeroData takes nothing returns nothing
        // get skill list from object editor:  hold shift then open the hero/unit skill field now copy paste the content
        call SaveStr(HeroSelector_Hash, 0, 'Hpal' , "AHhb,AHds,AHre,AHad")
        call SaveStr(HeroSelector_Hash, 0, 'Hmkg' , "AHtc,AHtb,AHbh,AHav")
        call SaveStr(HeroSelector_Hash, 0, 'Hamg' , "AHbz,AHab,AHwe,AHmt")
        call SaveStr(HeroSelector_Hash, 0, 'Hblm' , "AHfs,AHbn,AHdr,AHpx")
        call SaveStr(HeroSelector_Hash, 0, 'Obla' , "AOwk,AOcr,AOmi,AOww")
        call SaveStr(HeroSelector_Hash, 0, 'Ofar' , "AOfs,AOsf,AOcl,AOeq")
        call SaveStr(HeroSelector_Hash, 0, 'Otch' , "AOsh,AOae,AOre,AOws")
        call SaveStr(HeroSelector_Hash, 0, 'Oshd' , "AOhw,AOhx,AOsw,AOvd")
        call SaveStr(HeroSelector_Hash, 0, 'Udea' , "AUdc,AUdp,AUau,AUan")
        call SaveStr(HeroSelector_Hash, 0, 'Ulic' , "AUfn,AUfu,AUdr,AUdd")
        call SaveStr(HeroSelector_Hash, 0, 'Udre' , "AUav,AUsl,AUcs,AUin")
        call SaveStr(HeroSelector_Hash, 0, 'Ucrl' , "AUim,AUts,AUcb,AUls")
        call SaveStr(HeroSelector_Hash, 0, 'Ekee' , "AEer,AEfn,AEah,AEtq")
        call SaveStr(HeroSelector_Hash, 0, 'Emoo' , "AHfa,AEst,AEar,AEsf")
        call SaveStr(HeroSelector_Hash, 0, 'Edem' , "AEmb,AEim,AEev,AEme")
        call SaveStr(HeroSelector_Hash, 0, 'Ewar' , "AEbl,AEfk,AEsh,AEsv")
    endfunction
    
    
    function HeroInfoInit takes nothing returns nothing
        local integer col = 0
        local integer index = 0
        set TextDisplay = BlzCreateFrame("HeroSelectorTextArea", HeroSelectorBox, 0, 0)    
        call BlzFrameSetSize(TextDisplay , TextAreaSizeX, TextAreaSizeY)
        if not TextAreaRelativeGame then
            call BlzFrameSetPoint(TextDisplay, TextAreaPoint, HeroSelectorBox, TextAreaRelativePoint, TextAreaOffsetX, TextAreaOffsetY)
        else
            call BlzFrameSetPoint(TextDisplay, TextAreaPoint, BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), TextAreaRelativePoint, TextAreaOffsetX, TextAreaOffsetY)
        endif
    
        loop
            set index = index + 1
            exitwhen index > MaxButtonCount        
            set Buttons[index] = BlzCreateFrame("HeroSelectorButton", TextDisplay, 0, 0)
            set Icon[index] = BlzGetFrameByName("HeroSelectorButtonIcon", 0)
            set IconOff[index] = BlzGetFrameByName("HeroSelectorButtonIconDisabled", 0)
            set IconPushed[index] = BlzGetFrameByName("HeroSelectorButtonIconPushed", 0)
            set TooltipBox[index] = BlzCreateFrame("HeroSelectorTextBox", Buttons[index], 0, 0)
            set Tooltip[index] = BlzCreateFrame("HeroSelectorText", TooltipBox[index], 0, 0)
            call BlzFrameSetSize(Buttons[index], ButtonSizeX, ButtonSizeY)
            if ToolTipFixedPos then
                call BlzFrameSetPoint(Tooltip[index], FRAMEPOINT_BOTTOMLEFT, Buttons[1], FRAMEPOINT_TOPLEFT, 0, 0.007)
            else
                call BlzFrameSetPoint(Tooltip[index], FRAMEPOINT_BOTTOMLEFT, Buttons[index], FRAMEPOINT_TOPLEFT, 0, 0.007)
            endif
            call BlzFrameSetPoint(TooltipBox[index], FRAMEPOINT_BOTTOMLEFT, Tooltip[index], FRAMEPOINT_BOTTOMLEFT, -0.007, -0.007)
            call BlzFrameSetPoint(TooltipBox[index], FRAMEPOINT_TOPRIGHT, Tooltip[index], FRAMEPOINT_TOPRIGHT, 0.007, 0.007)
            call BlzFrameSetTooltip(Buttons[index], TooltipBox[index])
            call BlzFrameSetSize(Tooltip[index], ToolTipSize, 0)
    
            if index > 1 then
                set col = col + 1
                if col >= ButtonPerRow then
                    set col = 0
                    call BlzFrameSetPoint(Buttons[index], FRAMEPOINT_TOPLEFT, Buttons[index - ButtonPerRow], FRAMEPOINT_BOTTOMLEFT, 0.00, -0.004)
                else
                    call BlzFrameSetPoint(Buttons[index], FRAMEPOINT_TOPLEFT, Buttons[index - 1], FRAMEPOINT_TOPRIGHT, 0.004, 0)
                endif
            else
                call BlzFrameSetPoint(Buttons[index], FRAMEPOINT_TOPLEFT, TextDisplay, FRAMEPOINT_BOTTOMLEFT, 0.002, 0)
            endif
            
            call BlzFrameSetEnable(Buttons[index], false)
            call BlzFrameSetVisible(Buttons[index], false)
        endloop
    
        
    endfunction
    
    
    public function UpdateSkillPreivew takes string icon, string name, string text returns nothing
        set ButtonCurrentIndex = ButtonCurrentIndex + 1
        if ButtonCurrentIndex > MaxButtonCount then
            return
        endif
    
        call BlzFrameSetVisible(Buttons[ButtonCurrentIndex], true)
    
        call BlzFrameSetTexture(Icon[ButtonCurrentIndex], icon, 0, false)
        call BlzFrameSetTexture(IconPushed[ButtonCurrentIndex], icon, 0, false)
        //BlzFrameSetTexture(IconOff[ButtonCurrentIndex], HeroSelectorGetDisabledIcon(icon), 0, false)
        call BlzFrameSetTexture(IconOff[ButtonCurrentIndex], icon, 0, false)
    
        // x Size and no y Size makes it multiline text when the text does not fit into 1 line
    
        if text != null and name != null then
            call BlzFrameSetSize(Tooltip[ButtonCurrentIndex], ToolTipSize, 0)
            call BlzFrameSetText(Tooltip[ButtonCurrentIndex], name + "\n" + text)
        else
            // only the name, set frameSize to 0/0 to match the displayed text
            call BlzFrameSetSize(Tooltip[ButtonCurrentIndex], 0, 0)
            call BlzFrameSetText(Tooltip[ButtonCurrentIndex], name)
        endif
    endfunction
    
    public function ValidTooltip takes string text returns boolean
        if text == "Tool tip missing!" or text == "" or text == " " then
            return false
        endif
        return true
    endfunction
    
    public function abiFilter takes ability abi returns boolean
        // no skills markes as item skills
        if BlzGetAbilityBooleanField(abi, ABILITY_BF_ITEM_ABILITY) then
            return false
        endif
    
        if not ValidTooltip(BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_NORMAL, 0)) then
            return false
        endif
        return true
    endfunction
    
    function HeroInfoButtonSelected takes player p, integer unitCode returns nothing
        local unit dummyUnit 
        local integer startIndex
        local integer skillCode
        local string heroData
        local ability abi
        local integer abiIndex
        local string descriptionTemp = ""
        local string description = ""

        if DetectUnitSkills then
            set dummyUnit = CreateUnit(Player(GetPlayerNeutralPassive()), unitCode, 0, 0, 0)
        endif
    
        // Reset the global Buttons Index
        set ButtonCurrentIndex = 0
    
    
        if GetLocalPlayer() == p then
            call BlzFrameSetText(TextDisplay, DescHeroNamePrefix + GetObjectName(unitCode) + DescHeroNameSufix)

            set descriptionTemp = GetObjectelementsAsString(null, unitCode, false)
            if descriptionTemp != "" then
                set description = description + descriptionTemp + "|n"
            endif

            set descriptionTemp = LoadStr(HT_data, unitCode, 2)
            if descriptionTemp != "" and descriptionTemp != null then
                set description = description + descriptionTemp + "|n"
            endif

            set descriptionTemp = LoadStr(HT_data, unitCode, 3)
            if descriptionTemp != "" and descriptionTemp != null then
                set description = description + descriptionTemp
            endif

            
            call BlzFrameAddText(TextDisplay, description)
    
            /*if HaveSavedString(HeroSelector_Hash, 0, unitCode) then
                set heroData = LoadStr(HeroSelector_Hash, 0, unitCode)
                set startIndex = 0
                loop
                exitwhen startIndex + 3 >= StringLength(heroData)
                    set skillCode = S2A(SubString(heroData, startIndex, startIndex + 4))
                    
                    set startIndex = startIndex + 5
                    
                    // for hero skills show the learn text, "Tool tip missing!" is the default string
                    if ValidTooltip(BlzGetAbilityResearchExtendedTooltip(skillCode, 0)) then
                        call UpdateSkillPreivew(BlzGetAbilityIcon(skillCode), GetObjectName(skillCode), BlzGetAbilityResearchExtendedTooltip(skillCode, 0) )
                    elseif ValidTooltip(BlzGetAbilityExtendedTooltip(skillCode, 0)) then
                        // skills without a research text show the first Level
                        call UpdateSkillPreivew(BlzGetAbilityIcon(skillCode), GetObjectName(skillCode), BlzGetAbilityExtendedTooltip(skillCode, 0))
                    else
                        call UpdateSkillPreivew(BlzGetAbilityIcon(skillCode), GetObjectName(skillCode), null)
                    endif
                endloop
            endif*/
    
            /*if DetectUnitSkills then
                
                set abiIndex = 0
                loop
                    set abi = BlzGetUnitAbilityByIndex(dummyUnit, abiIndex)
                    if abi != null then
                        if abiFilter(abi) then
                            if ValidTooltip(BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_LEARN_EXTENDED, 0)) then
                                call UpdateSkillPreivew(BlzGetAbilityStringLevelField(abi, ABILITY_SLF_ICON_NORMAL, 0), BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_NORMAL, 0), BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_LEARN_EXTENDED, 0))
                            else
                                call UpdateSkillPreivew(BlzGetAbilityStringLevelField(abi, ABILITY_SLF_ICON_NORMAL, 0), BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_NORMAL, 0), BlzGetAbilityStringLevelField(abi, ABILITY_SLF_TOOLTIP_NORMAL_EXTENDED, 0))
                            endif
                        endif
                        set abiIndex = abiIndex + 1
                    else
                        exitwhen true
                    endif
                endloop
            endif*/
    
            loop
                set ButtonCurrentIndex = ButtonCurrentIndex + 1
                exitwhen ButtonCurrentIndex > MaxButtonCount
                call BlzFrameSetVisible(Buttons[ButtonCurrentIndex], false)
            endloop
        endif
    
        if DetectUnitSkills then
            call RemoveUnit(dummyUnit)
            set dummyUnit = null
        endif
        set abi = null
        set heroData = null
    endfunction
    
    
    private function init_function takes nothing returns nothing
        call HeroInfoInitHeroData()
        
    endfunction
endlibrary
    
    