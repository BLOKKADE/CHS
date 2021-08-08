globals
 
   framehandle gameUI
   framehandle SkillFrame
   framehandle SkillFrame1
   framehandle SkillBoxTooltip
   framehandle array Ability
   framehandle array AbilitySC
   
  trigger SPEL_DFF = null
  
  framehandle ToolBoxSpels = null
 framehandle ToolBoxSpelsT = null
 
 integer  MaxSpell = 11

 boolean array ShowAbButton
 
 
   framehandle array SpellFR 
 framehandle array SpellUP 
 framehandle array SpellTT
 
 hashtable HtSpell = InitHashtable()
 endglobals




function SkillSysStart takes nothing returns nothing
local integer NumButton = LoadInteger(HtSpell ,GetHandleId(BlzGetTriggerFrame()),1)
local integer i_ck = 1
local integer PlID = GetPlayerId(GetTriggerPlayer())
local integer SpellId_1 = 0
local integer AbilLevel = 0
local integer ULT_ID = 0
local string  ToolTipS = ""
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

if NumButton == 36 then

    set i1 =  GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER)
    
    call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER,0)
    call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)  + i1*30)
	call ResourseRefresh(GetTriggerPlayer()) 
endif

if NumButton == 37 then

    set i1 =  GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)/30
    
    call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_GOLD)-i1*30  )
    call SetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(GetTriggerPlayer(),PLAYER_STATE_RESOURCE_LUMBER) + i1)
    call ResourseRefresh(GetTriggerPlayer()) 
endif

elseif  BlzGetTriggerFrameEvent()  ==FRAMEEVENT_MOUSE_UP then


elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_ENTER then

if NumButton == 0 then

     set ToolTipS="|cffff0000" + GetObjectName(GetUnitTypeId(udg_units01[PlID + 1])) + "|r\n" + GetClassification(GetUnitTypeId(udg_units01[PlID + 1])) + "\n" + LoadStr(HT_data, GetUnitTypeId(udg_units01[PlID + 1]), 2) + "\n\n"
     if IncomeMode != 2 then
        set ToolTipS=ToolTipS + "|cffd4954dIncome|r: " + I2S(Income[PlID]) + "\n"
    endif
	 set ToolTipS=ToolTipS + "|cff4d4dd4Hero attributes|r  \n"
     set ToolTipS=ToolTipS + "|cffe7544aStrength|r per level: " + R2S(BlzGetUnitRealField(udg_units01[PlID + 1], ConvertUnitRealField('ustp'))) + "\n"
     set ToolTipS=ToolTipS + "|cffd6e049Agility|r per level: " + R2S(BlzGetUnitRealField(udg_units01[PlID + 1], ConvertUnitRealField('uagp'))) + "\n"
     set ToolTipS=ToolTipS + "|cff4daed4Intelligence|r per level: " + R2S(BlzGetUnitRealField(udg_units01[PlID + 1], ConvertUnitRealField('uinp'))) + "\n"
     set ToolTipS=ToolTipS + "|cff51d44dBase hit point/mana regeneration|r - " + R2S(BlzGetUnitRealField(udg_units01[PlID + 1], ConvertUnitRealField('uhpr'))) + "/" + R2S(BlzGetUnitRealField(udg_units01[PlID + 1], ConvertUnitRealField('umpr'))) + "\n"
    if GetLocalPlayer() == GetTriggerPlayer() then
         call BlzFrameSetText(ToolBoxSpelsT, ToolTipS)
         call BlzFrameSetVisible(ToolBoxSpels, true)
    endif
endif

if NumButton == 100 then
	set SpellU=udg_units01[NumPlayerLast[PlID] + 1]
	set ToolTipS="|cffff0000" + GetObjectName(GetUnitTypeId(SpellU)) + "|r\n" + GetClassification(GetUnitTypeId(SpellU)) + "\n" + LoadStr(HT_data, GetUnitTypeId(SpellU), 2) + "\n\n"
    if IncomeMode != 2 then
        set ToolTipS=ToolTipS + "|cffd4954dIncome|r: " + I2S(Income[NumPlayerLast[PlID]])
    endif

	 if GetLocalPlayer() == GetTriggerPlayer() then
         call BlzFrameSetText(ToolBoxSpelsT, ToolTipS)
         call BlzFrameSetVisible(ToolBoxSpels, true)
    endif
endif



if NumButton > 100 and  NumButton <= 120 then
    set SpellU = udg_units01[NumPlayerLast[PlID]+1]
    set i3 =  GetInfoHeroSpell(SpellU ,NumButton-100) 
    set SpellCP[PlID] = i3
    set ToolTipS =   BlzGetAbilityTooltip(i3, GetUnitAbilityLevel(SpellU,i3)-1 )+"\n"
    set ToolTipS =ToolTipS +  GetClassification(i3 ) + "\n"
    set ToolTipS =ToolTipS +   BlzGetAbilityExtendedTooltip(i3, GetUnitAbilityLevel(SpellU,i3)-1 )
        
    if GetLocalPlayer() == GetTriggerPlayer() then	
         call BlzFrameSetText(ToolBoxSpelsT  , ToolTipS )
         call BlzFrameSetVisible(ToolBoxSpels  ,true )
    endif       
endif




elseif BlzGetTriggerFrameEvent() ==  FRAMEEVENT_MOUSE_LEAVE then

if GetLocalPlayer() == GetTriggerPlayer() then	
  call BlzFrameSetText(ToolBoxSpelsT  , ToolTipS)
    call BlzFrameSetVisible(ToolBoxSpels  ,false )
endif


endif
	
	
endfunction







 
  function CreateIconWorld takes integer NumAb, string Icon, real x,real y,real size returns nothing
    local framehandle  TalantA
    local framehandle  TalantB = BlzCreateFrame("ScoreScreenBottomButtonTemplate", gameUI , 0, 0)
    //local framehandle GR
    //local framehandle TT
    local framehandle TT_text

    call BlzFrameSetSize(TalantB, size , size )
    call BlzFrameSetPoint(TalantB, FRAMEPOINT_TOPLEFT, gameUI, FRAMEPOINT_TOPLEFT , x, y)
    set TalantA = BlzCreateFrame("BNetPopupMenuBackdropTemplate", TalantB, 0, 0)
    call BlzFrameSetSize(TalantA , size , size )
    call BlzFrameSetTexture(TalantA , Icon , 1, true)
    call BlzFrameSetPoint(TalantA , FRAMEPOINT_CENTER, TalantB, FRAMEPOINT_CENTER, 0, 0)


    call BlzFrameSetVisible(TalantB ,false )
 

    set SpellFR[NumAb] = TalantA
    set SpellUP[NumAb] = TalantB
    //set SpellTT[NumAb] = TT
    call SaveInteger(HtSpell,GetHandleId(TalantB ),1, NumAb)
    call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_CONTROL_CLICK)
    call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_UP)
    call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_ENTER)
    call BlzTriggerRegisterFrameEvent(SPEL_DFF , TalantB , FRAMEEVENT_MOUSE_LEAVE)

endfunction


function Trig_ABIL_TAKE_Actions takes nothing returns nothing
 local integer I_i= 1
 local integer X___1= 0
 local integer Y___1= 0
 local real sizeAbil = 0.022
 

 
 call InitGameUI()
	call Init_Hero_data()
 set gameUI=BlzGetOriginFrame(ORIGIN_FRAME_WORLD_FRAME, 0)
  set SPEL_DFF=CreateTrigger()
  call TriggerAddAction(SPEL_DFF, function SkillSysStart)
  call CreateIconWorld(0 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.594 , - 0.39 , 0.036)

  call CreateIconWorld(36 , "ReplaceableTextures\\CommandButtons\\BTNChestOfGold.blp" , 0.43 + 0.025 , - 0.024 , 0.025)
   call BlzFrameSetVisible(SpellUP[36], true)
  call CreateIconWorld(37 , "ReplaceableTextures\\CommandButtons\\BTNBundleOfLumber.blp" , 0.43 + 0.05 , - 0.024 , 0.025)
   call BlzFrameSetVisible(SpellUP[37], true)



	
  call CreateIconWorld(100 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 , - sizeAbil , sizeAbil)

  call CreateIconWorld(101 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , -sizeAbil , sizeAbil)

  call CreateIconWorld(102 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2*sizeAbil , - sizeAbil  , sizeAbil)

  call CreateIconWorld(103 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3*sizeAbil , - sizeAbil  , sizeAbil)

  call CreateIconWorld(104 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4*sizeAbil , - sizeAbil  , sizeAbil)

  call CreateIconWorld(105 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5*sizeAbil , - sizeAbil  , sizeAbil)

  call CreateIconWorld(106 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 6*sizeAbil , - sizeAbil  , sizeAbil)

  call CreateIconWorld(107 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7*sizeAbil , - sizeAbil, sizeAbil)

  call CreateIconWorld(108 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8*sizeAbil , - sizeAbil , sizeAbil)

  call CreateIconWorld(109 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9*sizeAbil , - sizeAbil , sizeAbil)

  call CreateIconWorld(110 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10*sizeAbil , - sizeAbil , sizeAbil)


  call CreateIconWorld(111 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(112 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 2*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(113 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 3*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(114 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 4*sizeAbil , -2*sizeAbil , sizeAbil)

  call CreateIconWorld(115 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 5*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(116 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 +6*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(117 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 7*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(118 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 8*sizeAbil , -2*sizeAbil , sizeAbil)

  call CreateIconWorld(119 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 9*sizeAbil , - 2*sizeAbil , sizeAbil)

  call CreateIconWorld(120 , "ReplaceableTextures\\CommandButtons\\BTNSkillz.blp" , 0.04 + 10*sizeAbil , -2*sizeAbil , sizeAbil)
  
 

  set ToolBoxSpels=BlzCreateFrame("ListBoxWar3", gameUI, 0, 0)
  call BlzFrameSetSize(ToolBoxSpels, 0.3, 0.16)
  call BlzFrameSetPoint(ToolBoxSpels, FRAMEPOINT_TOPRIGHT, gameUI, FRAMEPOINT_TOPRIGHT, 0, - 0.02)
  set ToolBoxSpelsT=BlzCreateFrameByType("TEXT", "StandardInfoTextTemplate", ToolBoxSpels, "StandardTitleTextTemplate", 0)
  call BlzFrameSetPoint(ToolBoxSpelsT, FRAMEPOINT_TOPLEFT, ToolBoxSpels, FRAMEPOINT_TOPLEFT, 0.01, - 0.014)
  call BlzFrameSetSize(ToolBoxSpelsT, 0.28, 0.2)
  call BlzFrameSetText(ToolBoxSpelsT, "")
  call BlzFrameSetVisible(ToolBoxSpels, false)

endfunction

function Trig_Init_Actions takes nothing returns nothing






endfunction

//===========================================================================
function InitTrig_Init takes nothing returns nothing
    set gg_trg_Init = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_Init, 1.00 )
    call TriggerAddAction( gg_trg_Init, function Trig_ABIL_TAKE_Actions )

endfunction

