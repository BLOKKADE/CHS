library trigger122 initializer init requires RandomShit

    function Trig_Victory_Conditions takes nothing returns boolean
        if(not Trig_Victory_Func001C())then
            return false
        endif
        return true
    endfunction


    function Trig_Victory_Actions takes nothing returns nothing
        set udg_boolean11 = true
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(udg_trigger118)
        call DisableTrigger(udg_trigger80)
        if(Trig_Victory_Func006C())then
            call EnableTrigger(udg_trigger81)
        else
        endif
        call ConditionalTriggerExecute(udg_trigger119)
        call TriggerSleepAction(2)
        if(Trig_Victory_Func012C())then
            call DisplayTimedTextToForce(GetPlayersAll(),30,("|cffffcc00" +("You survived all levels! Congratulations!!")))
        else
            call DisplayTimedTextToForce(GetPlayersAll(),30,((GetPlayerNameColour(WinningPlayer)+ " |cffffcc00survived longer than all other players! Congratulations!!")))
        endif
        call EndThematicMusicBJ()
        call SetMusicVolumeBJ(0.00)
        call PlaySoundBJ(udg_sound05)
        call DisableTrigger(udg_trigger87)
        call TriggerSleepAction(2.00)
        call DisplayTimedTextToForce(GetPlayersAll(),26.00,"|cffffcc00Thank you for playing|r " + "|cff7bff00" + VERSION + "|r")
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger122 = CreateTrigger()
        call TriggerAddCondition(udg_trigger122,Condition(function Trig_Victory_Conditions))
        call TriggerAddAction(udg_trigger122,function Trig_Victory_Actions)
    endfunction


endlibrary
