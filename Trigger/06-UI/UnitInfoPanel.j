library UnitInfoPanel requires CustomState, RandomShit, RuneInit, Glory, LearnAbsolute, MathRound
	globals
		boolean isReforged

		private framehandle UnitInfoFrame
		private framehandle UnitInfoParentFrame

		private framehandle tooltipBox
		private framehandle tooltipText

		private string array DataIcon
		private string array DataDesc
		private string array DataLabel
		private string array CustomStateValue

		private framehandle array ButtonUI
		private framehandle array ToolTipUI
		private framehandle array ToolTextUI
		private framehandle array IconUI
		private framehandle array TextUI
		private framehandle array TooltipTextUI   

		private group gUI = CreateGroup()
		private unit UnitInfoUnit = null

		private string ToolTipA = ""
		private string array statColour
	endglobals

	function GameUIStandart takes nothing returns nothing 
		set UnitInfoParentFrame = BlzCreateFrameByType("SIMPLEFRAME", "", UnitInfoFrame, "", 0) 
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconDamage", 0), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconDamage", 1), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconArmor", 2), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconRank", 3), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconFood", 4), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconGold", 5), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconHero", 6), UnitInfoParentFrame)
		call BlzFrameSetParent(BlzGetFrameByName("SimpleInfoPanelIconAlly", 7), UnitInfoParentFrame)  
		call BlzFrameSetVisible(UnitInfoParentFrame, false)
	endfunction

	function ExtraFieldInfo takes unit u returns string
		local integer pid = GetPlayerId(GetOwningPlayer(u))
		local string s = ""

		set s = s + "|cffb0e74aLives|r: " + I2S(Lives[pid]) + "\n"
		set s = s + "|cffe7694aIncome|r: " + I2S(Income[pid]) + "\n"
		set s = s + "|cff4aa8e7Glory per Round|r: " + I2S(R2I(GetPlayerGloryBonus(pid))) + "\n"
		set s = s + "|cff9b67faMovespeed|r: " + R2SW(GetUnitMoveSpeed(u), 1, 1) + "\n"
		set s = s + "|cffda4ae7Rune Power|r: " + R2SW((100 + GetUnitCustomState(u, BONUS_RUNEPOW) + GetHeroLevel(u)) / 100, 1, 2) + "\n"
		set s = s + "|cff5ce74aLuck|r: +" + R2SW(((GetUnitCustomState(u, BONUS_LUCK) - 1) * 100), 1, 1) + "%%\n"
		set s = s + "|cff6ac8ffAbsolute Slots|r: " + I2S(GetHeroMaxAbsoluteAbility(u) + 1) + "\n"
		set s = s + "|cff6dc287Summon Upgrades|r: Dmg: " + I2S(SummonDamage[pid]) + "/Armor: " + I2S(SummonArmor[pid]) + "/HP: " + I2S(SummonHitPoints[pid]) + "\n"
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
		local real gloryRegen = GetUnitCustomState(u, BONUS_GLORYREGEN)
		set s = s + "Each point increases hit points by 16. (" + statColour[0] + "+" + I2S(GetHeroStr(u, true) * 16) + " total|r)\n" 
		set s = s + "Each point increases hit point regeneration by 0.075. (" + statColour[0] + "+" + R2SW(GetUnitTotalHpRegen(u), 1, 1) + " total|r)\n"
		
		if gloryRegen > 0 then
			set s = s + statColour[0] + I2S(R2I(gloryRegen)) + "|r of that is from glory HP regen.\n"
		endif
		
		return s + "Strength per level: " + statColour[0] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('ustp')) + GetStatLevelBonus(u, BONUS_STRENGTH)) + "|r"
	endfunction

	function AgiInfo takes unit u returns string
		local string s = PrimaryAttributeDmg(u, 1)
		set s = s + "Each point increases armor by 0.150. (" + statColour[1] + "+" + R2SW(GetHeroAgi(u, true) * 0.15, 1, 1) + " total|r)\n" 
		set s = s + "Each point increases attack speed by 1%%. (" + statColour[1] + "+" + R2SW(RMinBJ(GetHeroAgi(u, true), 400), 1, 1) + "%% total|r) (Max 400%%)\n"
		return s + "Agility per level: " + statColour[1] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('uagp')) + GetStatLevelBonus(u, BONUS_AGILITY)) + "|r"
	endfunction

	function IntInfo takes unit u returns string
		local string s = PrimaryAttributeDmg(u, 2)
		set s = s + "Each point increases mana by 20.1. (" + statColour[2] + "+" + R2SW(GetHeroInt(u, true) * 20.1, 1, 1) + " total|r)\n" 
		set s = s + "Each point increases mana regeneration by 0.195. (" + statColour[2] + "+" + R2SW(BlzGetUnitRealField(u, ConvertUnitRealField('umpr'))  + (GetUnitBonusReal(u, BONUS_MANA_REGEN)) + (GetHeroInt(u, true) * 0.065), 1, 1) + " total|r)\n"
		return s + "Intelligence per level: " + statColour[2] + R2S(BlzGetUnitRealField(u, ConvertUnitRealField('uinp')) + GetStatLevelBonus(u, BONUS_INTELLIGENCE)) + "|r"
	endfunction

	function MagicPhysInfo takes unit u returns string
		return "Increases magic damage dealt by |cff4daed4" + R2SW(GetUnitCustomState(u, BONUS_MAGICPOW), 1, 2) + "%|r\n" + "Increases physical damage dealt by |cffe7e44a" + R2SW(GetUnitCustomState(u, BONUS_PHYSPOW), 1, 2) + "%|r"
	endfunction

	function UpdateTooltipText takes unit u returns nothing
		set CustomStateValue[1] = R2S(100 * (1 - (50 /(50 + GetUnitCustomState(u, BONUS_EVASION)))))

		set CustomStateValue[2] = ""
		if BlzIsUnitInvulnerable(u) then
			set CustomStateValue[2] = "|cffff0000Invulnerable|r\n"
		endif
		if BlzGetUnitArmor(u) >= 0 then
			set CustomStateValue[2] = CustomStateValue[2] + "Reduces physical damage taken by |cffb0e74a" + R2S(((((BlzGetUnitArmor(u)))* 0.03)/(1 + 0.03 *(BlzGetUnitArmor(u)))) * 100)
		else
			set CustomStateValue[2] = CustomStateValue[2] + "Increases physical damage taken by |cffe7544a" + R2S(((((BlzGetUnitArmor(u)))* 0.03)/(1 + 0.03 *(BlzGetUnitArmor(u)))) * 100)
		endif

		set CustomStateValue[3] = MagicPhysInfo(u)
		set CustomStateValue[4] = R2S( (1 - (50 / ( 50 + GetUnitCustomState(u, BONUS_MAGICRES) ))) * 100 )
		set CustomStateValue[5] = ExtraFieldInfo(u)
		set CustomStateValue[6] = StrInfo(u)
		set CustomStateValue[7] = AgiInfo(u)
		set CustomStateValue[8] = IntInfo(u)
		set CustomStateValue[9] = DmgInfo(u)
		//set CustomStateValue[10] = "\n|cffb0e74aBase Attack cooldown:|r " + R2SW(GetUnitBaseAttackCooldown(u), 1, 2)
	endfunction

	function UpdateTextRelaese takes unit u returns nothing
		call BlzFrameSetText(TextUI[1], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 0)))
		call BlzFrameSetText(TextUI[2], R2SW(BlzGetUnitAttackCooldown(u, 0), 1, 2) + "/" + R2SW(BlzGetUnitRealField(u, UNIT_RF_CAST_POINT), 1, 2))
		if BlzIsUnitInvulnerable(u) then
			call BlzFrameSetText(TextUI[3], "|cffff0000" + R2SW(BlzGetUnitArmor(u), 1, 1) + "|r")
		else
			call BlzFrameSetText(TextUI[3], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 2)))
		endif
		call BlzFrameSetText(TextUI[4], R2SW(GetUnitCustomState(u, BONUS_BLOCK), 1, 0))
		call BlzFrameSetText(TextUI[5], R2SW(GetUnitCustomState(u, BONUS_PVP), 1, 1))
		call BlzFrameSetText(TextUI[9], I2S(MathRound_round(GetUnitCustomState(u, BONUS_MAGICPOW))) + "/" + I2S(MathRound_round(GetUnitCustomState(u, BONUS_PHYSPOW))))
		call BlzFrameSetText(TextUI[10], R2SW(GetUnitCustomState(u, BONUS_MAGICRES), 1, 1))
		call BlzFrameSetText(TextUI[11], R2SW(GetUnitCustomState(u, BONUS_EVASION), 1, 1))

		if IsHeroUnitId(GetUnitTypeId(u)) then
			call BlzFrameSetText(TextUI[6], I2S(GetHeroStr(u, true)))
			call BlzFrameSetText(TextUI[7], I2S(GetHeroAgi(u, true)))
			call BlzFrameSetText(TextUI[8], I2S(GetHeroInt(u, true)))

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
		call InitDataInfoPanel(2 , "Attack cooldown/cast time: " , "ReplaceableTextures\\CommandButtons\\BTNHoldPosition.blp" , "Time between the unit's attacks / Time to start the effect of a spell.\nAbilities and items can affect these values making them inaccurate.")
		call InitDataInfoPanel(3 , "Armor: " , "ReplaceableTextures\\CommandButtons\\BTNStop.blp" , "")
		call InitDataInfoPanel(4 , "Block: " , "ReplaceableTextures\\CommandButtons\\BTNDefend.blp" , "Flat Damage reduction applied to all damage taken.\nBlock is calculated before armor and magic protection.")
		call InitDataInfoPanel(5 , "Pvp bonus: " , "BTNHUHoldPosition.blp" , "Increases damage dealt to enemy heroes and their summons.\nReduces damage taken from enemy heroes and their summons. ")
		call InitDataInfoPanel(6 , "Strength: " , "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower" , "")
		call InitDataInfoPanel(7 , "Agility: " , "ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility" , "")
		call InitDataInfoPanel(8 , "Intelligence: " , "ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence" , "")
		call InitDataInfoPanel(9 , "Magic power/Phys power: " , "ReplaceableTextures\\CommandButtons\\BTNControlMagic" , "")
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

		call UpdateTextRelaese(SelectedUnit[localpid])

		loop
			if BlzFrameIsVisible(ToolTipUI[currentFrame]) then
				call UpdateTooltipText(SelectedUnit[localpid])
				set VisibleFrame = true
				if currentFrame == 6  then
					set ToolTipA = DataLabel[currentFrame] + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6))
				elseif currentFrame == 7 then
					set ToolTipA = DataLabel[currentFrame] + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6))
				elseif currentFrame == 8 then
					set ToolTipA = DataLabel[currentFrame] + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6))
				else
					set ToolTipA = DataLabel[currentFrame] + BlzFrameGetText(TextUI[currentFrame])
				endif
				set ToolTipA = ToolTipA + "\n------------------------------\n" + DataDesc[currentFrame]
				if currentFrame == 1 then
					set ToolTipA = ToolTipA + CustomStateValue[9]
				/*elseif currentFrame == 2 then
					set ToolTipA = ToolTipA + CustomStateValue[10]*/
				elseif currentFrame == 3 then
					set ToolTipA = ToolTipA + CustomStateValue[2] + "%%|r."
				elseif currentFrame == 6 then
					set ToolTipA = ToolTipA + CustomStateValue[6]
				elseif currentFrame == 7 then
					set ToolTipA = ToolTipA + CustomStateValue[7]
				elseif currentFrame == 8 then
					set ToolTipA = ToolTipA + CustomStateValue[8]
				elseif currentFrame == 9 then
					set ToolTipA = ToolTipA + CustomStateValue[3]
				elseif currentFrame == 10 then
					set ToolTipA = ToolTipA + CustomStateValue[4] + "%%|r."
				elseif currentFrame == 11 then
					set ToolTipA = ToolTipA + CustomStateValue[1] + "%%|r."
				elseif currentFrame == 12 then
					set ToolTipA = "More info\n------------------------------\n" + DataDesc[currentFrame]
					set ToolTipA = ToolTipA + CustomStateValue[5]
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
		call BlzChangeMinimapTerrainTex("minimap.blp")
		call BlzLoadTOCFile("war3mapImported\\UnitInfoPanels.toc")
		call BlzLoadTOCFile("war3mapimported\\BoxedText.toc")
		set UnitInfoFrame = BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0)   
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