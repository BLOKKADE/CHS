library UnitPanelInfo requires CustomState, RandomShit, RuneInit, Glory
	globals
		boolean isReforged

		framehandle unitInfo
		framehandle parent

		framehandle tooltipBox
		framehandle tooltipText

		framehandle array UnitPanels

		string array DataIcon
		string array DataDesc
		string array DataLabel
		string array CustomInfoT1

		framehandle array ButtonUI
		framehandle array ToolTipUI
		framehandle array ToolTextUI
		framehandle array IconUI
		framehandle array TextUI
		framehandle array TooltipTextUI   

		group gUI = CreateGroup()
		unit UnitInfoUnit = null

		string ToolTipA = ""
		unit array UnitArrayUpdate

		string array statColour
	endglobals

	/*function UnitInfoGetUnit takes player p returns unit
		call GroupEnumUnitsSelected(gUI, p, null)
		set UnitInfoUnit = FirstOfGroup(gUI)
		call GroupClear(gUI)
		return UnitInfoUnit
	endfunction*/

	function GameUIStandart takes nothing returns nothing 
		set parent = BlzCreateFrameByType("SIMPLEFRAME", "", unitInfo, "", 0) 
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconDamage", 0), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconDamage", 1), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconArmor", 2), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconRank", 3), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconFood", 4), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconGold", 5), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconHero", 6), parent)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconAlly", 7), parent)  
		call BlzFrameSetVisible(parent, false)
	endfunction

	function ExtraFieldInfo takes unit u returns string
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local string s = ""

		set s = s + "|cffb0e74aLives|r: " + I2S(Lives[pid]) + "\n"
		set s = s + "|cffe7694aIncome|r: " + I2S(Income[pid]) + "\n"
		set s = s + "|cff4aa8e7Glory per Round|r: " + I2S(R2I(GetPlayerGloryBonus(pid))) + "\n"
		set s = s + "|cff9b67faMovespeed|r: " + R2SW(GetUnitMoveSpeed(u), 1, 1) + "\n"
		set s = s + "|cffe7e44aPhysical Power|r: " + R2SW(100 + GetUnitPhysPow(u), 1, 1) + "\n"
		set s = s + "|cffda4ae7Rune Power|r: " + R2SW((100 + GetUnitPowerRune(u) + GetHeroLevel(u)) / 100, 1, 2) + "\n"
		set s = s + "|cff5ce74aLuck|r: +" + R2SW(((GetUnitLuck(u) - 1) * 100), 1, 1) + "%%\n"
		set s = s + "|cff6ac8ffAbsolute Slots|r: " + I2S(GetHeroMaxAbsoluteAbility(u) + 1)

		return s
	endfunction

	function PrimaryAttributeText takes unit u, integer stat returns nothing
		call BlzFrameSetText(TextUI[6 + stat], statColour[stat] + "*" + BlzFrameGetText(TextUI[6 + stat]) + "|r")
	endfunction

	function PrimaryAttributeDmg takes unit u, integer stat returns string
		if IsPrimaryStat(u, stat) then
			return "Each point increases attack damage by 1. (" + statColour[stat] + "+" + I2S(GetHeroStatBJ(stat, u, true)) + " total|r)\n"
		endif
		return ""
	endfunction

	function DmgInfo takes unit u returns string
		return "|cff5ce74aRange|r: "+ R2SW(BlzGetUnitWeaponRealField(u, UNIT_WEAPON_RF_ATTACK_RANGE, 0), 1, 1) +"\nThe amount of damage the unit's basic attack deals."
	endfunction

	function StrInfo takes unit u returns string
		local string s = PrimaryAttributeDmg(u, 0)
		local real gloryRegen = LoadReal(DataUnitHT, GetHandleId(u), 1000)
		set s = s + "Each point increases hit points by 26. (" + statColour[0] + "+" + I2S(GetHeroStr(u, true) * 26) + " total|r)\n" 
		set s = s + "Each point increases hit point regeneration by 0.075. (" + statColour[0] + "+" + R2SW(GetUnitBonusReal(u, BONUS_HEALTH_REGEN), 1, 1) + " total|r)\n"
		
		if gloryRegen > 0 then
			set s = s + statColour[0] + I2S(R2I(gloryRegen + (50 * GloryRegenLevel[GetHandleId(u)]))) + "|r of that is from glory HP regen.\n"
		endif
		
		return s + "Strength per level: " + statColour[0] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('ustp')) + GetStrengthLevelBonus(u)) + "|r"
	endfunction

	function AgiInfo takes unit u returns string
		local string s = PrimaryAttributeDmg(u, 1)
		set s = s + "Each point increases armor by 0.150. (" + statColour[1] + "+" + R2SW(GetHeroAgi(u, true) * 0.15, 1, 1) + " total|r)\n" 
		set s = s + "Each point increases attack speed by 1%%. (" + statColour[1] + "+" + R2SW(RMinBJ(GetHeroAgi(u, true), 400), 1, 1) + "%% total|r) (Max 400%%)\n"
		return s + "Agility per level: " + statColour[1] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('uagp')) + GetAgilityLevelBonus(u)) + "|r"
	endfunction

	function IntInfo takes unit u returns string
		local string s = PrimaryAttributeDmg(u, 2)
		set s = s + "Each point increases mana by 20.1. (" + statColour[2] + "+" + R2SW(GetHeroInt(u, true) * 20.1, 1, 1) + " total|r)\n" 
		set s = s + "Each point increases mana regeneration by 0.065. (" + statColour[2] + "+" + R2SW(BlzGetUnitRealField(u, ConvertUnitRealField('umpr'))  + (GetHeroInt(u, true) * 0.065), 1, 1) + " total|r)\n"
		return s + "Intelligence per level: " + statColour[2] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('uinp')) + GetIntelligenceLevelBonus(u)) + "|r"
	endfunction

	function UpdateTooltipText takes unit u returns nothing
		set CustomInfoT1[1] = R2S(100 * GetUnitRealEvade(u))

		if BlzGetUnitArmor(u) >= 0 and not BlzIsUnitInvulnerable(u) then
			set CustomInfoT1[2] = "Reduces physical damage taken by |cffb0e74a" + R2S(((((BlzGetUnitArmor(u)))* 0.06)/(1 + 0.06 *(BlzGetUnitArmor(u)))) * 100)
		elseif BlzIsUnitInvulnerable(u) then
			set CustomInfoT1[2] = "Reduces physical damage taken by |cff29f800100"
		else
			set CustomInfoT1[2] = "Increases physical damage taken by |cffe7544a" + R2S(((((BlzGetUnitArmor(u)))* 0.06)/(1 + 0.06 *(BlzGetUnitArmor(u)))) * 100)
		endif

		set CustomInfoT1[3] = R2S(GetUnitMagicDmg(u))
		set CustomInfoT1[4] = R2S( (1 - (50 / ( 50 + GetUnitMagicDef(u) ))) * 100 )
		set CustomInfoT1[5] = ExtraFieldInfo(u)
		set CustomInfoT1[6] = StrInfo(u)
		set CustomInfoT1[7] = AgiInfo(u)
		set CustomInfoT1[8] = IntInfo(u)
		set CustomInfoT1[9] = DmgInfo(u)
	endfunction

	function UpdateTextRelaese takes unit u returns nothing
		call BlzFrameSetText(TextUI[1], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 0)))
		call BlzFrameSetText(TextUI[2], R2SW(BlzGetUnitAttackCooldown(u, 0), 1, 2) + "/" + R2SW(BlzGetUnitRealField(u, UNIT_RF_CAST_POINT), 1, 2))
		call BlzFrameSetText(TextUI[3], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 2)))
		call BlzFrameSetText(TextUI[4], R2SW(GetUnitBlock(u), 1, 0))
		call BlzFrameSetText(TextUI[5], R2SW(GetUnitPvpBonus(u), 1, 1))
		call BlzFrameSetText(TextUI[9], R2SW(GetUnitMagicDmg(u), 1, 1))
		call BlzFrameSetText(TextUI[10], R2SW(GetUnitMagicDef(u), 1, 1))
		call BlzFrameSetText(TextUI[11], R2SW(GetUnitEvasion(u), 1, 1))

		if IsHeroUnitId(GetUnitTypeId(u)) then
			call BlzFrameSetText(TextUI[6], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6)))
			call BlzFrameSetText(TextUI[7], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6)))
			call BlzFrameSetText(TextUI[8], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6)))

			call PrimaryAttributeText(u, GetHeroPrimaryStat(u))

			call BlzFrameSetText(TextUI[12], "More")
		else
			call BlzFrameSetText(TextUI[6], "-")
			call BlzFrameSetText(TextUI[7], "-")
			call BlzFrameSetText(TextUI[8], "-")
			call BlzFrameSetText(TextUI[12], "-")
		endif
	endfunction

	function InitDataInfoPanel takes integer id, string label, string icon, string desc returns nothing
		set DataIcon[id] = icon
		set DataLabel[id] = label
		set DataDesc[id] = desc

		set ButtonUI[id] = BlzGetFrameByName("CustomUnitInfoButton" + I2S(id), 0)
		set ToolTipUI[id] = BlzCreateFrameByType("SIMPLEFRAME", "", ButtonUI[id], "", 0)
		set IconUI[id] = BlzGetFrameByName("CustomUnitInfoButtonIcon" + I2S(id), 0)
		set TextUI[id]  = BlzGetFrameByName("CustomUnitInfoButtonText" + I2S(id), 0)
		set TooltipTextUI[id] = BlzCreateFrame("CustomUnitInfoText", ToolTipUI[id], 0, 0)
		set ToolTextUI[id] = BlzCreateFrame("CustomUnitInfoText", ToolTipUI[id], 0, 0)
		call BlzFrameSetAbsPoint(TooltipTextUI[id], FRAMEPOINT_BOTTOMRIGHT, 0.79, 0.18)

		call BlzFrameSetVisible(ToolTipUI[id], false)  
		call BlzFrameSetTooltip(ButtonUI[id], ToolTipUI[id])

		call BlzFrameSetTexture(IconUI[id], DataIcon[id], 0, false)  
		call BlzFrameSetText(TextUI[id],"Test:" + I2S(id))        
	endfunction

	function GameUINewPanel takes nothing returns nothing
		local framehandle NewPanel = BlzCreateSimpleFrame("CustomUnitInfoPanel3x4", BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0), 0)
		call InitDataInfoPanel(1 , "Damage: " , "ReplaceableTextures\\CommandButtons\\BTNAttack.blp" , "")
		call InitDataInfoPanel(2 , "Attack cooldown: " , "ReplaceableTextures\\CommandButtons\\BTNHoldPosition.blp" , "Time between the unit's attacks / Time to start the effect of a spell.\nAbilities and items can affect these values making them inaccurate.")
		call InitDataInfoPanel(3 , "Armor: " , "ReplaceableTextures\\CommandButtons\\BTNStop.blp" , "")
		call InitDataInfoPanel(4 , "Block: " , "ReplaceableTextures\\CommandButtons\\BTNDefend.blp" , "Flat Damage reduction applied to all damage taken.")
		call InitDataInfoPanel(5 , "Pvp bonus: " , "BTNHUHoldPosition.blp" , "Increases damage dealt to enemy heroes\nReduces damage taken from enemy heroes. ")
		call InitDataInfoPanel(6 , "Strength: " , "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower" , "")
		call InitDataInfoPanel(7 , "Agility: " , "ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility" , "")
		call InitDataInfoPanel(8 , "Intelligence: " , "ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence" , "")
		call InitDataInfoPanel(9 , "Magic power: " , "ReplaceableTextures\\CommandButtons\\BTNControlMagic" , "Increases magic damage dealt by |cff4daed4")
		call InitDataInfoPanel(10 , "Magic protection: " , "ReplaceableTextures\\CommandButtons\\BTNRunedBracers.blp" , "Reduces magic damage taken by |cff51d44d")
		call InitDataInfoPanel(11 , "Evasion: " , "ReplaceableTextures\\CommandButtons\\BTNEvasion" , "Increases the chance to evade enemy attacks by |cffd6e049")
		call InitDataInfoPanel(12 , "" , "ReplaceableTextures\\CommandButtons\\BTNEngineeringUpgrade.blp", "")


		//     call InitDataInfoPanel(11, "Mp/s: ", "ReplaceableTextures\\CommandButtons\\BTNMagicalSentry","")
		//     call InitDataInfoPanel(12, "Evasion: ", "ReplaceableTextures\\CommandButtons\\BTNEvasion","")
		call BlzFrameSetParent(NewPanel, BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0))
	endfunction

	function update takes nothing returns nothing
		local integer currentFrame = 0
		local boolean VisibleFrame = false
		local integer localpid = GetPlayerId(GetLocalPlayer())

		call UpdateTextRelaese(selectedUnit[localpid])

		loop
			if BlzFrameIsVisible(ToolTipUI[currentFrame]) then
				call UpdateTooltipText(selectedUnit[localpid])
				set VisibleFrame = true
				set ToolTipA = DataLabel[currentFrame] + BlzFrameGetText(TextUI[currentFrame]) + "\n------------------------------\n" + DataDesc[currentFrame]
				if currentFrame == 3 then
					set ToolTipA = ToolTipA + CustomInfoT1[2] + "%%|r."
				elseif currentFrame == 1 then
					set ToolTipA = ToolTipA + CustomInfoT1[9]
				elseif currentFrame == 6 then
					set ToolTipA = ToolTipA + CustomInfoT1[6]
				elseif currentFrame == 7 then
					set ToolTipA = ToolTipA + CustomInfoT1[7]
				elseif currentFrame == 8 then
					set ToolTipA = ToolTipA + CustomInfoT1[8]
				elseif currentFrame == 9 then
					set ToolTipA = ToolTipA + CustomInfoT1[3] + "%%|r."
				elseif currentFrame == 10 then
					set ToolTipA = ToolTipA + CustomInfoT1[4] + "%%|r."
				elseif currentFrame == 11 then
					set ToolTipA = ToolTipA + CustomInfoT1[1] + "%%|r."
				elseif currentFrame == 12 then
					set ToolTipA = "More info\n------------------------------\n" + DataDesc[currentFrame]
					set ToolTipA = ToolTipA + CustomInfoT1[5]
				endif
				call BlzFrameSetText(tooltipText, ToolTipA)
			endif
			set currentFrame = currentFrame + 1
			exitwhen currentFrame > 12
		endloop

		call BlzFrameSetVisible(tooltipBox, VisibleFrame)
	endfunction

	function ToolTipStart takes nothing returns nothing
		call TimerStart(NewTimer(), 0.05, true, function update)

		set tooltipBox = BlzCreateFrame("BoxedText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
		set tooltipText = BlzCreateFrame("CustomUnitInfoText", tooltipBox, 0, 0)

		call BlzFrameSetAbsPoint(tooltipText, FRAMEPOINT_BOTTOMRIGHT, 0.79, 0.18)
		call BlzFrameSetSize(tooltipText, 0.275,0)
		call BlzFrameSetPoint(tooltipBox, FRAMEPOINT_TOPLEFT, tooltipText, FRAMEPOINT_TOPLEFT, - 0.01, 0.01)
		call BlzFrameSetPoint(tooltipBox, FRAMEPOINT_BOTTOMRIGHT, tooltipText, FRAMEPOINT_BOTTOMRIGHT, 0.005, - 0.01)
		call BlzFrameSetVisible(tooltipBox, false)
	endfunction


	function InitGameUI takes nothing returns nothing
		set statColour[0] = "|cffff6e6e"
		set statColour[1] = "|cffe4e74a"
		set statColour[2] = "|cff4ae7df"
		set isReforged = GetLocalizedString("REFORGED") != "REFORGED"      
		call BlzLoadTOCFile("war3mapImported\\UnitInfoPanels.toc")
		call BlzLoadTOCFile("war3mapimported\\BoxedText.toc")
		set unitInfo = BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)   
		call BlzGetFrameByName("InfoPanelIconValue", 0)
		call BlzGetFrameByName("InfoPanelIconValue", 2)
		call BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6)
		call BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6)
		call BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6)     
		call ToolTipStart()
		call GameUIStandart()     
		call GameUINewPanel()          
	endfunction
endlibrary