globals
    boolean  isReforged
    
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
endglobals



    function UnitInfoGetUnit takes player p returns unit
        call GroupEnumUnitsSelected(gUI, p, null)
        set UnitInfoUnit = FirstOfGroup(gUI)
        call GroupClear(gUI)
        return UnitInfoUnit
    endfunction


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



function UpdateTextRelaese takes unit u returns nothing
   local string dmgT= "-"
   local integer Pid=  GetPlayerId(GetOwningPlayer(u))
	
   set dmgT=BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 0))
   call BlzFrameSetText(TextUI[1], dmgT)


   call BlzFrameSetText(TextUI[3], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconValue", 2)))
   call BlzFrameSetText(TextUI[4], R2SW(GetUnitBlock(u), 1, 0))
   call BlzFrameSetText(TextUI[2], R2S(BlzGetUnitAttackCooldown(u, 0)))
   call BlzFrameSetText(TextUI[5], I2S(R2I(GetUnitMoveSpeed(u))))
   call BlzFrameSetText(TextUI[9], R2SW(GetUnitMagicDmg(u), 1, 1))
   call BlzFrameSetText(TextUI[10], R2SW(GetUnitMagicDef(u), 1, 1))
   call BlzFrameSetText(TextUI[11], R2SW(GetUnitEvasion(u), 1, 1))
   set CustomInfoT1[1]=R2S(100 * GetUnitRealEvade(u))
   if BlzGetUnitArmor(u) >= 0 then
        set CustomInfoT1[2]= "Reduces physical damage taken by |cffb0e74a" + R2S(((((BlzGetUnitArmor(u)))*0.06)/(1+0.06*(BlzGetUnitArmor(u)))) * 100)
   else
   set CustomInfoT1[2]= "Increases physical damage taken by |cffe7544a" + R2S(((((BlzGetUnitArmor(u)))*0.06)/(1+0.06*(BlzGetUnitArmor(u)))) * 100)
   endif
   set CustomInfoT1[3]=R2S(GetUnitMagicDmg(u))
   set CustomInfoT1[4]=R2S( (1 - (50 / ( 50 + GetUnitMagicDef(u) ))) * 100 )
   
   if IsHeroUnitId(GetUnitTypeId(u)) then
      call BlzFrameSetText(TextUI[6], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6)))
      call BlzFrameSetText(TextUI[7], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6)))
      call BlzFrameSetText(TextUI[8], BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6)))
      
      
      if BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE) == 1 then
      call BlzFrameSetText(TextUI[6], "*" + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroStrengthValue", 6)))
      elseif BlzGetUnitIntegerField(u, UNIT_IF_PRIMARY_ATTRIBUTE) == 3 then
      call BlzFrameSetText(TextUI[7], "*" + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroAgilityValue", 6)))
      else
      call BlzFrameSetText(TextUI[8], "*" + BlzFrameGetText(BlzGetFrameByName("InfoPanelIconHeroIntellectValue", 6)))
      endif
         
      call BlzFrameSetText(TextUI[12], R2SW(GetUnitPvpBonus(u), 1, 1))
   else
      call BlzFrameSetText(TextUI[6], "-")
      call BlzFrameSetText(TextUI[7], "-")
      call BlzFrameSetText(TextUI[8], "-")
      call BlzFrameSetText(TextUI[12], "-")
   endif


   set dmgT=null
endfunction




function UpdateText takes nothing returns nothing 
local integer loopA = 0
local unit u = null

loop
   exitwhen loopA > 8
   set UnitArrayUpdate[loopA] = UnitInfoGetUnit(Player(loopA))
       
    call UpdateTextRelaese(UnitArrayUpdate[GetPlayerId(GetLocalPlayer())])

   
   set loopA = loopA + 1
endloop



endfunction

function InitDataInfoPanel takes integer id, string label, string icon, string desc returns nothing
        set DataIcon[id] = icon
        set DataLabel[id] = label
        set DataDesc[id] = desc
        
        set ButtonUI[id] = BlzGetFrameByName("CustomUnitInfoButton" + I2S(id), 0)
        set ToolTipUI[id] = BlzCreateFrameByType("SIMPLEFRAME", "", ButtonUI[id], "", 0)
        set IconUI[id] = BlzGetFrameByName("CustomUnitInfoButtonIcon" + I2S(id), 0)
        set TextUI[id]  = BlzGetFrameByName("CustomUnitInfoButtonText" + I2S(id), 0)
        set TooltipTextUI[id] =BlzCreateFrame("CustomUnitInfoText", ToolTipUI[id], 0, 0)
        set ToolTextUI[id] = BlzCreateFrame("CustomUnitInfoText", ToolTipUI[id], 0, 0)
        call BlzFrameSetAbsPoint(TooltipTextUI[id], FRAMEPOINT_BOTTOMRIGHT, 0.79, 0.18)

        call BlzFrameSetVisible(ToolTipUI[id], false)  
        call BlzFrameSetTooltip(ButtonUI[id], ToolTipUI[id])
        
        call BlzFrameSetTexture(IconUI[id], DataIcon[id], 0, false)  
        call BlzFrameSetText(TextUI[id],"Test:"+I2S(id))        
      
endfunction

function GameUINewPanel takes nothing returns nothing
        local framehandle NewPanel= BlzCreateSimpleFrame("CustomUnitInfoPanel3x4", BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0), 0)
        call InitDataInfoPanel(1 , "Damage: " , "ReplaceableTextures\\CommandButtons\\BTNAttack.blp" , "The amount of damage the unit's basic attack deals")
        call InitDataInfoPanel(2 , "Attack cooldown: " , "ReplaceableTextures\\CommandButtons\\BTNHoldPosition.blp" , "Time between the unit's attacks.\nNot an indicator of attack speed")
        call InitDataInfoPanel(3 , "Armor: " , "ReplaceableTextures\\CommandButtons\\BTNStop.blp" , "")
        call InitDataInfoPanel(4 , "Block: " , "ReplaceableTextures\\CommandButtons\\BTNDefend.blp" , "Damage reduction applied to all damage taken.")
        call InitDataInfoPanel(5 , "Movement speed: " , "ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed" , "Current movement speed. ")
        call InitDataInfoPanel(6 , "Strength: " , "ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower" , "Each point increases hit points by 26.\nEach point increases hit point regeneration by 0.075.")
        call InitDataInfoPanel(7 , "Agility: " , "ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility" , "Each point increases armor by 0.150.\nEach point increases attack speed by 0.01%.")
        call InitDataInfoPanel(8 , "Intelligence: " , "ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence" , "Each point increases mana by 20.1.\nEach point increases mana regeneration by 0.065.")
        call InitDataInfoPanel(9 , "Magic power: " , "ReplaceableTextures\\CommandButtons\\BTNControlMagic" , "Increases magic damage dealt by |cff4daed4")
        call InitDataInfoPanel(10 , "Magic protection: " , "ReplaceableTextures\\CommandButtons\\BTNRunedBracers.blp" , "Reduces magic damage taken by |cff51d44d")
        call InitDataInfoPanel(11 , "Evasion: " , "ReplaceableTextures\\CommandButtons\\BTNEvasion" , "Increases the chance to evade enemy attacks by |cffd6e049")
        call InitDataInfoPanel(12 , "Pvp bonus: " , "BTNHUHoldPosition.blp" , "Increases damage dealt to enemy heroes\nReduces damage taken from enemy heroes.")
        
        
   //     call InitDataInfoPanel(11, "Mp/s: ", "ReplaceableTextures\\CommandButtons\\BTNMagicalSentry","")
   //     call InitDataInfoPanel(12, "Evasion: ", "ReplaceableTextures\\CommandButtons\\BTNEvasion","")
        call BlzFrameSetParent(NewPanel, BlzGetFrameByName("SimpleInfoPanelUnitDetail", 0))
endfunction

function update takes nothing returns nothing
        local integer loopA= 0
        local boolean VisibleFrame= false
       
        call UpdateText()
       
       
        
       
        loop
         exitwhen loopA > 12
            if BlzFrameIsVisible(ToolTipUI[loopA]) then
               set VisibleFrame=true
               set ToolTipA=DataLabel[loopA] + BlzFrameGetText(TextUI[loopA]) + "\n------------------------------\n" + DataDesc[loopA]
	       if loopA == 3 then
                set ToolTipA=ToolTipA + CustomInfoT1[2] + "%%."
           elseif loopA == 9 then
                set ToolTipA=ToolTipA + CustomInfoT1[3] + "%%."
           elseif loopA == 10 then
                set ToolTipA=ToolTipA + CustomInfoT1[4] + "%%."
           elseif loopA == 11 then
		        set ToolTipA=ToolTipA + CustomInfoT1[1] + "%%."
	       endif
               call BlzFrameSetText(tooltipText, ToolTipA)
            endif
         set loopA=loopA + 1
        endloop

        call BlzFrameSetVisible(tooltipBox, VisibleFrame)
endfunction

function ToolTipStart takes nothing returns nothing
        call TimerStart(CreateTimer(), 0.05, true, function update)
        

  
        set tooltipBox = BlzCreateFrame("BoxedText", BlzGetOriginFrame(ORIGIN_FRAME_GAME_UI, 0), 0, 0)
        set tooltipText = BlzCreateFrame("CustomUnitInfoText", tooltipBox, 0, 0)
        call BlzFrameSetAbsPoint(tooltipText, FRAMEPOINT_BOTTOMRIGHT, 0.79, 0.18)
        call BlzFrameSetSize(tooltipText, 0.275,0)
        call BlzFrameSetPoint(tooltipBox, FRAMEPOINT_TOPLEFT, tooltipText, FRAMEPOINT_TOPLEFT, -0.01, 0.01)
        call BlzFrameSetPoint(tooltipBox, FRAMEPOINT_BOTTOMRIGHT, tooltipText, FRAMEPOINT_BOTTOMRIGHT, 0.005, -0.01)
        call BlzFrameSetVisible(tooltipBox, false)

endfunction


function InitGameUI takes nothing returns nothing
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