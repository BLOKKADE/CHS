library trigger81 initializer init requires RandomShit

    function Trig_Hero_Dies_After_Victory_Conditions takes nothing returns boolean
        if(not Trig_Hero_Dies_After_Victory_Func008C())then
            return false
        endif
        return true
    endfunction


    function Trig_Hero_Dies_After_Victory_Func004A takes nothing returns nothing
        call KillUnit(GetEnumUnit())
    endfunction


    function Trig_Hero_Dies_After_Victory_Func007Func007A takes nothing returns nothing
        call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
    endfunction


    function Trig_Hero_Dies_After_Victory_Actions takes nothing returns nothing
        set udg_integer06 =(udg_integer06 - 1)
        call DisplayTimedTextToForce(GetPlayersAll(),5.00,((GetPlayerNameColour(GetOwningPlayer(GetTriggerUnit()))+(" |cffffcc00has fallen at level " +(I2S(udg_integer02)+ "!|r")))))
        call DisableTrigger(udg_trigger16)
        call ForGroupBJ(GetUnitsOfPlayerAll(GetOwningPlayer(GetTriggerUnit())),function Trig_Hero_Dies_After_Victory_Func004A)
        call EnableTrigger(udg_trigger16)
        if(Trig_Hero_Dies_After_Victory_Func007C())then
            call DisableTrigger(udg_trigger116)
            call DisableTrigger(GetTriggeringTrigger())
            call DisableTrigger(udg_trigger107)
            call TriggerSleepAction(2)
            if(Trig_Hero_Dies_After_Victory_Func007Func006C())then
                call CustomVictoryBJ(udg_player01,true,true)
            else
                call CustomDefeatBJ(udg_player01,"Defeat!")
            endif
            call ForForce(udg_force02,function Trig_Hero_Dies_After_Victory_Func007Func007A)
        else
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger81 = CreateTrigger()
        call DisableTrigger(udg_trigger81)
        call TriggerRegisterAnyUnitEventBJ(udg_trigger81,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(udg_trigger81,Condition(function Trig_Hero_Dies_After_Victory_Conditions))
        call TriggerAddAction(udg_trigger81,function Trig_Hero_Dies_After_Victory_Actions)
    endfunction


endlibrary
