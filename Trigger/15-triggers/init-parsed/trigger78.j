library trigger78 initializer init requires RandomShit

    function Trig_Choose_Hero_Conditions takes nothing returns boolean
        if(not Trig_Choose_Hero_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Choose_Hero_Func001Func002A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Choose_Hero_Func001Func011A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Choose_Hero_Actions takes nothing returns nothing
        local string ToolTipS = ""
        if(Trig_Choose_Hero_Func001C())then
    
            if GetLocalPlayer() == GetTriggerPlayer() then
                call ClearTextMessages()
            endif
            call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(),'n00E'),function Trig_Choose_Hero_Func001Func002A)
            call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Abilities\\Spells\\Human\\HolyBolt\\HolyBoltSpecialArt.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            set udg_player02 = GetTriggerPlayer()
            call ConditionalTriggerExecute(udg_trigger79)
        else
    
            /*
            set ToolTipS = "|cffff0000" + GetObjectName(GetUnitTypeId( GetTriggerUnit() )) + "|r\n" + GetClassification(GetUnitTypeId( GetTriggerUnit() ))  + "\n" + LoadStr(HT_data,GetUnitTypeId( GetTriggerUnit() ),2 )   + "\n"
            set ToolTipS = ToolTipS + "|cff0000ffHero attributes|r  \n"
            set ToolTipS = ToolTipS + "Str per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('ustp')))+ "\n"
            set ToolTipS = ToolTipS + "Agi per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uagp')))+ "\n"
            set ToolTipS = ToolTipS + "Int per level - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uinp')))+ "\n"      
            set ToolTipS = ToolTipS + "Regeneration - " + R2S(BlzGetUnitRealField( GetTriggerUnit(),ConvertUnitRealField('uhpr')))+ "\n"
            set ToolTipS = ToolTipS + "Mana Regeneration - " + R2S(BlzGetUnitRealField(GetTriggerUnit(),ConvertUnitRealField('umpr')))+ "\n" 
            call DisplayTextToPlayer(GetTriggerPlayer(), 0,0, ToolTipS)
            */
    
    
            call SetUnitAnimation(GetTriggerUnit(),"attack")
            call SetUnitAnimation(GetTriggerUnit(),"slam")
            call SetUnitAnimation(GetTriggerUnit(),"victory")
            call QueueUnitAnimationBJ(GetTriggerUnit(),"stand")
            call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(),'n00E'),function Trig_Choose_Hero_Func001Func011A)
            call CreateNUnitsAtLoc(1,'n00E',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            set udg_units02[GetConvertedPlayerId(GetTriggerPlayer())]= GetTriggerUnit()
        endif
        set ToolTipS = null
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger78 = CreateTrigger()
        call DisableTrigger(udg_trigger78)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(0),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(1),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(2),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(3),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(4),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(5),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(6),true)
        call TriggerRegisterPlayerSelectionEventBJ(udg_trigger78,Player(7),true)
        call TriggerAddCondition(udg_trigger78,Condition(function Trig_Choose_Hero_Conditions))
        call TriggerAddAction(udg_trigger78,function Trig_Choose_Hero_Actions)
    endfunction


endlibrary
