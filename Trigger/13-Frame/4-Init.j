library FrameInit initializer init requires RandomShit, CustomState, GetClass, ElementTexts, HeroLvlTable, UnitPanelInfo, RuneInit, HeroData
	globals
		framehandle gameUI
		framehandle SkillFrame
		framehandle SkillFrame1
		framehandle SkillBoxTooltip
		framehandle array Ability
		framehandle array AbilitySC

		trigger SPEL_DFF = null

		

		integer MaxSpell = 11

		boolean array ShowCreepAbilButton


		framehandle array SpellFR 
		framehandle array SpellUP 
		framehandle array SpellTT

		hashtable HtSpell = InitHashtable()

		framehandle Tooltip = null
		framehandle TooltipTitleFrame
		framehandle TooltipTextFrame
		constant real TooltipX = 0
		constant real TooltipY = 0.165
		real DEFAULT_SIZE = 0.020
		real LINE_SIZE = 0.012
		Table TooltipYSize
	endglobals

	function GoldConversionTooltip takes nothing returns string
		return "Convert |cff96fc77Lumber|r to |cfffcd277Gold|r (|cff77f3fcCtrl+Q|r)"
	endfunction

	function LumberConversionTooltip takes nothing returns string
		return "Convert |cfffcd277Gold|r to |cff96fc77Lumber|r (|cff77f3fcCtrl+W|r)"
	endfunction

	function GetTooltipSize takes string s returns real
		return (CountNewLines(s) * LINE_SIZE) + DEFAULT_SIZE
	endfunction

	function GetObjectTooltipSize takes integer objectId returns real
		return GetTooltipSize(BlzGetAbilityExtendedTooltip(objectId, 0))
	endfunction

	function SkillSysStart takes nothing returns nothing
		local integer NumButton = LoadInteger(HtSpell ,GetHandleId(BlzGetTriggerFrame()),1)
		local integer i_ck = 1
		local integer PlID = GetPlayerId(GetTriggerPlayer())
		local integer SpellId_1 = 0
		local integer AbilLevel = 0
		local integer ULT_ID = 0
		local string ToolTipS = ""
		local string temp = ""
		local boolean TypT = false
		local boolean en_d = true
		local integer i1
		local integer i2
		local integer i3
		local unit SpellU

		if BlzGetTriggerFrameEvent() ==  FRAMEEVENT_CONTROL_CLICK then
			
			if GetTriggerPlayer() == GetLocalPlayer() then
				call BlzFrameSetEnable(BlzGetTriggerFrame() , false)
				call BlzFrameSetEnable(BlzGetTriggerFrame() , true)
			endif

			//Convert to gold
			if NumButton == 36 then
				set i1 = GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)

				call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,0)
				call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)  + i1 * 30)
				call ResourseRefresh(GetTriggerPlayer()) 
			
				//Convert to lumber
			elseif NumButton == 37 then
				set i1 = GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)/ 30

				call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)- i1 * 30  )
				call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER) + i1)
				call ResourseRefresh(GetTriggerPlayer()) 
			endif
		elseif BlzGetTriggerFrameEvent()  ==FRAMEEVENT_MOUSE_UP then

		elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_ENTER then
			/*//Hero icon
			if NumButton == 0 then
				set SpellU = udg_units01[PlID + 1]
				set ToolTipS = GetClassification(SpellU, GetUnitTypeId(SpellU), false) + "|n"
				set temp = LoadStr(HT_data, GetUnitTypeId(SpellU), 2)
				if temp != "" and temp != null then
					set ToolTipS = ToolTipS + temp + "|n"
				endif
				
				set temp = LoadStr(HT_data, GetUnitTypeId(SpellU), 3)
				if temp != "" and temp != null then
					set ToolTipS = ToolTipS + temp + "|n"
				endif
				
				if IncomeMode != 2 then
					set ToolTipS = ToolTipS + "|cffd4954dIncome|r: " + I2S(Income[PlID]) + "|n"
				endif

				set ToolTipS = ToolTipS + "|cffc94dd4Absolute slots:|r " + I2S(GetHeroMaxAbsoluteAbility(SpellU) + 1) + "|n"
				set ToolTipS = ToolTipS + "|cff4d4dd4Hero attributes|r  |n"
				set ToolTipS = ToolTipS + "|cffe7544aStrength|r per level: " + R2S(BlzGetUnitRealField(SpellU, ConvertUnitRealField('ustp')) + GetStrengthLevelBonus(SpellU)) + "|n"
				set ToolTipS = ToolTipS + "|cffd6e049Agility|r per level: " + R2S(BlzGetUnitRealField(SpellU, ConvertUnitRealField('uagp')) + GetAgilityLevelBonus(SpellU)) + "|n"
				set ToolTipS = ToolTipS + "|cff4daed4Intelligence|r per level: " + R2S(BlzGetUnitRealField(SpellU, ConvertUnitRealField('uinp')) + GetIntelligenceLevelBonus(SpellU)) + "|n"
				set ToolTipS = ToolTipS + "|cff51d44dHit point/mana regeneration|r - " + R2S(BlzGetUnitRealField(SpellU, ConvertUnitRealField('uhpr')) + (GetHeroStr(SpellU, true) * 0.075)) + "/" + R2S(BlzGetUnitRealField(SpellU, ConvertUnitRealField('umpr'))  + (GetHeroInt(SpellU, true) * 0.065)) + "|n"
				if GetLocalPlayer() == GetTriggerPlayer() then
					call BlzFrameSetText(TooltipTitleFrame, "|cffff0000" + GetObjectName(GetUnitTypeId(SpellU)) + "|r")
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(ToolTipS))
					call BlzFrameSetVisible(Tooltip, true)
				endif */
			
				if NumButton == 2 then
					if GetLocalPlayer() == GetTriggerPlayer() then
						call BlzFrameSetText(TooltipTitleFrame, "|cfffce177Next level|r: " + RoundCreepTitle)
						set temp = RoundCreepInfo[PlID] + "|n|n|cfffce177Abilities|r: " + RoundAbilities
						call BlzFrameSetText(TooltipTextFrame, temp)
						call BlzFrameSetSize(Tooltip, 0.29, 0.12 + GetTooltipSize(RoundAbilities))
						call BlzFrameSetVisible(Tooltip, true)
					endif
					//Hero passive
				elseif NumButton == 36 then
					if GetLocalPlayer() == GetTriggerPlayer() then
						call BlzFrameSetText(TooltipTitleFrame, GoldConversionTooltip())
						call BlzFrameSetSize(Tooltip, 0.29, 0.02)
						call BlzFrameSetVisible(Tooltip, true)
					endif
				elseif NumButton == 37 then
					if GetLocalPlayer() == GetTriggerPlayer() then
						call BlzFrameSetText(TooltipTitleFrame, LumberConversionTooltip())
						call BlzFrameSetSize(Tooltip, 0.29, 0.02)
						call BlzFrameSetVisible(Tooltip, true)
					endif
				elseif NumButton == 38 then
					set SpellU = udg_units01[NumPlayerLast[PlID] + 1]
					set i1 = 1
					set ToolTipS = "|cffd0ff00Element Counts|r"

					loop
						set i2 = GetClassUnitSpell(SpellU, i1)

						// Don't include empty elements in the list
						if i2 > 0 then
							set ToolTipS = ToolTipS + "|n" + ClassAbil[i1] + " : " + I2S(i2)
						endif

						set i1 = i1 + 1
						exitwhen i1 > 13 // Based off the amount of elements in ClassAbil array. 2-InitDescription.j
					endloop

					if GetLocalPlayer() == GetTriggerPlayer() then
						call BlzFrameSetText(TooltipTitleFrame, ToolTipS)
						call BlzFrameSetSize(Tooltip, 0.125, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(Tooltip, true)
					endif
				elseif NumButton == 100 then
					set SpellU = udg_units01[NumPlayerLast[PlID] + 1]
					set temp = GetClassification(SpellU, GetUnitTypeId(SpellU), false)
					if temp != "" and temp != null then
						set ToolTipS = ToolTipS + temp + "|n"
					endif
					set temp = LoadStr(HT_data, GetUnitTypeId(SpellU), 2)
					if temp != "" and temp != null then
						set ToolTipS = ToolTipS + temp + "|n"
					endif

					set temp = LoadStr(HT_data, GetUnitTypeId(SpellU), 3)
					if temp != "" and temp != null then
						set ToolTipS = ToolTipS + temp
					endif

					set ToolTipS = ToolTipS + GetPassiveStr(SpellU)

					if IncomeMode != 2 then
						set ToolTipS = ToolTipS + "|n|n|cffd4954dIncome|r: " + I2S(Income[NumPlayerLast[PlID]])
					endif

					if GetTriggerPlayer() != GetOwningPlayer(SpellU) then
						set ToolTipS = ToolTipS + "|n|cfffaf61cGold|r: " + I2S(GetPlayerState(Player(NumPlayerLast[PlID]), PLAYER_STATE_RESOURCE_GOLD))
						set ToolTipS = ToolTipS + "|n|cff41e400Lumber|r: " + I2S(GetPlayerState(Player(NumPlayerLast[PlID]), PLAYER_STATE_RESOURCE_LUMBER))
						set ToolTipS = ToolTipS + "|n|cff8bfdfdGlory|r: " + I2S(R2I(Glory[NumPlayerLast[PlID]]))
					endif

					if GetLocalPlayer() == GetTriggerPlayer() then
						call BlzFrameSetText(TooltipTitleFrame,GetPlayerNameColour(GetOwningPlayer(SpellU)) + ": " + "|cffffa8a8" + GetObjectName(GetUnitTypeId(SpellU)))
						call BlzFrameSetText(TooltipTextFrame, ToolTipS)
						call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(ToolTipS))
						call BlzFrameSetVisible(Tooltip, true)
					endif

					//Hero abilities and absolutes
				elseif NumButton > 100 and NumButton <= 120 then
					if NumPlayerLast[PlID] != 11 then
						set SpellU = udg_units01[NumPlayerLast[PlID]+ 1]
						set i3 = GetInfoHeroSpell(SpellU ,NumButton - 100) 
						set SpellCP[PlID] = i3
						set temp = GetClassification(SpellU, i3, true)
						if temp != "" and temp != null then
							set ToolTipS = ToolTipS + temp + "|n"
						endif
						set ToolTipS = ToolTipS + BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1 )

						//Hero absolutes
						if NumButton > 110 and NumButton <= 120 then
							set i1 = GetAbsoluteElement(i3)
							set i2 = GetClassUnitSpell(SpellU, i1)
							set ToolTipS = ToolTipS + "|n|n|cffd0ff00Current|r " + ClassAbil[i1] + " |cffd0ff00count|r: " + I2S(i2)
						endif

						if GetLocalPlayer() == GetTriggerPlayer() then	
							call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1 ))
							call BlzFrameSetText(TooltipTextFrame, ToolTipS)
							call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(ToolTipS))
							call BlzFrameSetVisible(Tooltip, true)
						endif       
					else
						set SpellU = selectedUnit[PlID]
						set i3 = roundAbilities[NumButton - 100]
						set SpellCP[PlID] = i3
						set ToolTipS = BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1 )

						if GetLocalPlayer() == GetTriggerPlayer() then	
							call BlzFrameSetText(TooltipTitleFrame, BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3)- 1 ))
							call BlzFrameSetText(TooltipTextFrame, ToolTipS)
							call BlzFrameSetSize(Tooltip, 0.29, GetTooltipSize(ToolTipS))
							call BlzFrameSetVisible(Tooltip, true)
						endif       
					endif
				endif
			elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_LEAVE then

				if GetLocalPlayer() == GetTriggerPlayer() then	
					call BlzFrameSetText(TooltipTextFrame, ToolTipS)
					call BlzFrameSetVisible(Tooltip, false)
				endif
			endif

			set SpellU = null
		endfunction

		function CreateIconWorld takes integer NumAb, string Icon, real x,real y,real size returns nothing
			local framehandle TalantA
			local framehandle TalantB = BlzCreateFrame("ScoreScreenBottomButtonTemplate", gameUI , 0, 0)
			//local framehandle GR
			//local framehandle TT
			local framehandle TT_text

			call BlzChangeMinimapTerrainTex("minimap.blp")

			call BlzFrameSetSize(TalantB, size , size )
			call BlzFrameSetPoint(TalantB, FRAMEPOINT_TOPLEFT, gameUI, FRAMEPOINT_TOPLEFT , x, y)
			set TalantA = BlzCreateFrame("BNetPopupMenuBackdropTemplate", TalantB, 0, 0)
			call BlzFrameSetSize(TalantA , size , size )
			call BlzFrameSetTexture(TalantA , Icon , 1, true)
			call BlzFrameSetPoint(TalantA , FRAMEPOINT_CENTER, TalantB, FRAMEPOINT_CENTER, 0, 0)
			call BlzFrameSetVisible(TalantB ,false )

			set SpellFR[NumAb] = TalantA
			set SpellUP[NumAb] = TalantB

			call SaveInteger(HtSpell,GetHandleId(TalantB ),1, NumAb)
			call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_CONTROL_CLICK)
			call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_UP)
			call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_ENTER)
			call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_LEAVE)
		endfunction

		function Trig_ABIL_TAKE_Actions takes nothing returns nothing
			local integer I_i = 1
			local integer X___1 = 0
			local integer Y___1 = 0
			local real sizeAbil = 0.022

			call InitGameUI()
			set gameUI = BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
			set SPEL_DFF = CreateTrigger()
			call TriggerAddAction(SPEL_DFF, function SkillSysStart)
			call CreateIconWorld(2 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - 0.39 , 0.036)
			call BlzFrameSetTexture(SpellFR[2] , "ReplaceableTextures\\CommandButtons\\BTNSpell_Holy_SealOfWrath.blp" , 0, true)
			call CreateIconWorld(36 , "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" , 0.43 + 0.025 , - 0.024 , 0.025)
			call BlzFrameSetVisible(SpellUP[36], true)
			call CreateIconWorld(37 , "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" , 0.43 + 0.05 , - 0.024 , 0.025)
			call BlzFrameSetVisible(SpellUP[37], true)
			call CreateIconWorld(38 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - 2 * sizeAbil , sizeAbil)
			call BlzFrameSetTexture(SpellFR[38] , "ReplaceableTextures\\PassiveButtons\\PASElements.blp" , 0, true)
			call CreateIconWorld(100 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - sizeAbil , sizeAbil)
			call CreateIconWorld(101 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(102 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(103 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(104 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(105 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(106 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 6 * sizeAbil , - sizeAbil  , sizeAbil)
			call CreateIconWorld(107 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7 * sizeAbil , - sizeAbil, sizeAbil)
			call CreateIconWorld(108 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(109 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(110 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10 * sizeAbil , - sizeAbil , sizeAbil)
			call CreateIconWorld(111 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(112 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(113 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(114 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(115 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(116 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 6 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(117 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(118 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(119 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9 * sizeAbil , - 2 * sizeAbil , sizeAbil)
			call CreateIconWorld(120 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10 * sizeAbil , - 2 * sizeAbil , sizeAbil)

			set Tooltip = BlzCreateFrame("TooltipText", gameUI  , 0, 0)
			set TooltipTitleFrame = BlzGetFrameByName("TooltipTextTitle", 0)
			set TooltipTextFrame = BlzGetFrameByName("TooltipTextValue", 0)
        
			call BlzFrameSetSize(Tooltip, 0.29, 0.03)
			call BlzFrameSetPoint(Tooltip, FRAMEPOINT_BOTTOMRIGHT, gameUI, FRAMEPOINT_BOTTOMRIGHT, TooltipX, TooltipY)
			call BlzFrameSetVisible(Tooltip, false )   
		endfunction

		//===========================================================================
		private function init takes nothing returns nothing
			local integer i = 0
			local trigger trg = CreateTrigger()
			set TooltipYSize = Table.create()
			call TriggerRegisterTimerEventSingle( trg, 1.00 )
			call TriggerAddAction( trg, function Trig_ABIL_TAKE_Actions )
			/*
			loop
				set OpenedTooltip[i] = - 1
				set i = i + 1
				exitwhen i > 11
			endloop */
			set trg = null
		endfunction
	endlibrary