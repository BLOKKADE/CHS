library trigger151 initializer init requires RandomShit

    function Trig_Hero_Dies_Death_Match_PvP_Conditions takes nothing returns boolean
        if(not Trig_Hero_Dies_Death_Match_PvP_Func019C())then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Death_Match_PvP_Func008A takes nothing returns nothing
        local unit u = GetEnumUnit()
    
        if IsUnitType(u, UNIT_TYPE_HERO) then
            call RemoveItem(UnitItemInSlot(u, 0))
            call RemoveItem(UnitItemInSlot(u, 1))
            call RemoveItem(UnitItemInSlot(u, 2))
            call RemoveItem(UnitItemInSlot(u, 3))
            call RemoveItem(UnitItemInSlot(u, 4))
            call RemoveItem(UnitItemInSlot(u, 5))
    
            call RemoveHeroAbilities(u)
        endif
    
        call KillUnit(u)
        set u = null
    endfunction


    function Trig_Hero_Dies_Death_Match_PvP_Actions takes nothing returns nothing
        call StopSoundBJ(udg_sound13,false)
        call PlaySoundBJ(udg_sound13)
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),udg_force02)
        call SetCurrentlyFighting(GetOwningPlayer(GetTriggerUnit()), false)
        set udg_integer06 =(udg_integer06 - 1)
        call AllowSinglePlayerCommands()
        set udg_booleans02[GetConvertedPlayerId(GetOwningPlayer(GetTriggerUnit()))]= true
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+ "|cffC60000 was defeated!|r")))
        call DisableTrigger(udg_trigger16)
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Death_Match_PvP_Func008A)
        call EnableTrigger(udg_trigger16)
        if(Trig_Hero_Dies_Death_Match_PvP_Func011C())then
            call DialogSetMessageBJ(udg_dialog04,"Defeat!")
            call DialogDisplayBJ(true,udg_dialog04,GetOwningPlayer(GetTriggerUnit()))
        else
            call CustomDefeatBJ(GetOwningPlayer(GetTriggerUnit()),"Defeat!")
        endif
        set udg_integer30 = 1
        loop
            exitwhen udg_integer30 > 5
            call AddSpecialEffectLocBJ(GetUnitLoc(GetTriggerUnit()),"Objects\\Spawnmodels\\Human\\HumanLargeDeathExplode\\HumanLargeDeathExplode.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call AddSpecialEffectTargetUnitBJ("chest",GetTriggerUnit(),"Objects\\Spawnmodels\\Orc\\OrcLargeDeathExplode\\OrcLargeDeathExplode.mdl")
            call DestroyEffectBJ(GetLastCreatedEffectBJ())
            call TriggerSleepAction(0.10)
            set udg_integer30 = udg_integer30 + 1
        endloop
        call TriggerSleepAction(0.50)
        call StopSoundBJ(udg_sound13,true)
        call StopSoundBJ(udg_sound12,false)
        call PlaySoundBJ(udg_sound12)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger151 = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(udg_trigger151,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger151,Condition(function Trig_Hero_Dies_Death_Match_PvP_Conditions))
        call TriggerAddAction(udg_trigger151,function Trig_Hero_Dies_Death_Match_PvP_Actions)
    endfunction


endlibrary
