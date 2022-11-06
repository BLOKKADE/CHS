library trigger43 initializer init requires RandomShit

    function Trig_Hero_Dies_Battle_Royal_Func007C takes nothing returns boolean
        if(not(BrStarted==true))then
            return false
        endif
        if(not(IsUnitType(GetTriggerUnit(),UNIT_TYPE_HERO)==true))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(8)))then
            return false
        endif
        if(not(GetOwningPlayer(GetTriggerUnit())!=Player(11)))then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Battle_Royal_Conditions takes nothing returns boolean
        if(not Trig_Hero_Dies_Battle_Royal_Func007C())then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_Battle_Royal_Func004A takes nothing returns nothing
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


    function Trig_Hero_Dies_Battle_Royal_Actions takes nothing returns nothing
        call ForceAddPlayerSimple(GetOwningPlayer(GetTriggerUnit()),DefeatedPlayers)
        set PlayerCount =(PlayerCount - 1)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,("|cffffcc00" + GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit())) + " was defeated by |r" + GetPlayerNameColour(GetOwningPlayer(GetKillingUnit()))))
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_Battle_Royal_Func004A)
        call ShowDiscordFrames(GetOwningPlayer(GetTriggerUnit()), true)
        call ConditionalTriggerExecute(udg_trigger122)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger43 = CreateTrigger()
        call DisableTrigger(udg_trigger43)
        call TriggerRegisterAnyUnitEventBJ(udg_trigger43,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger43,Condition(function Trig_Hero_Dies_Battle_Royal_Conditions))
        call TriggerAddAction(udg_trigger43,function Trig_Hero_Dies_Battle_Royal_Actions)
    endfunction


endlibrary
