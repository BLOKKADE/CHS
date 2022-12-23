library trigger78 initializer init requires RandomShit

    function Trig_Choose_Hero_Func002Func004C takes nothing returns boolean
        if((IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return true
        endif
        if((GetUnitTypeId(GetTriggerUnit())=='n00J'))then
            return true
        endif
        return false
    endfunction


    function Trig_Choose_Hero_Func002C takes nothing returns boolean
        if(not(PlayerHeroPicked[GetConvertedPlayerId(GetTriggerPlayer())]==false))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())==Player(8)))then
            return false
        endif
        if(not(RandomHeroMode==false))then
            return false
        endif
        if(not Trig_Choose_Hero_Func002Func004C())then
            return false
        endif
        return true
    endfunction


    function Trig_Choose_Hero_Conditions takes nothing returns boolean
        if(not Trig_Choose_Hero_Func002C())then
            return false
        endif
        return true
    endfunction


    function Trig_Choose_Hero_Func001C takes nothing returns boolean
        if(not(GetTriggerUnit()==ChooseHeroSelection[GetConvertedPlayerId(GetTriggerPlayer())]))then
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
            call ConditionalTriggerExecute(udg_PlayerHeroSelected)
        else
    
            call SetUnitAnimation(GetTriggerUnit(),"attack")
            call SetUnitAnimation(GetTriggerUnit(),"slam")
            call SetUnitAnimation(GetTriggerUnit(),"victory")
            call QueueUnitAnimationBJ(GetTriggerUnit(),"stand")
            call ForGroupBJ(GetUnitsOfPlayerAndTypeId(GetTriggerPlayer(),'n00E'),function Trig_Choose_Hero_Func001Func011A)
            call CreateNUnitsAtLoc(1,'n00E',GetTriggerPlayer(),GetUnitLoc(GetTriggerUnit()),bj_UNIT_FACING)
            set ChooseHeroSelection[GetConvertedPlayerId(GetTriggerPlayer())]= GetTriggerUnit()
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
