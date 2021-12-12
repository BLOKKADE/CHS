library trigger118 initializer init requires RandomShit

    function Trig_Defeat_Conditions takes nothing returns boolean
        if(not(udg_integer06==0))then
            return false
        endif
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function Trig_Defeat_Func012A takes nothing returns nothing
        call CustomDefeatBJ(GetEnumPlayer(),"Defeat!")
    endfunction


    function Trig_Defeat_Actions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(udg_trigger106)
        call DisableTrigger(udg_trigger107)
        call CinematicFilterGenericBJ(2,BLEND_MODE_BLEND,"ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp",50.00,0.00,0.00,100,0,0,0,0)
        call DisplayTimedTextToForce(GetPlayersAll(),30,"|cffffcc00All heroes were slain and everyone was forced to admit defeat!|r")
        call EndThematicMusicBJ()
        call SetMusicVolumeBJ(0.00)
        call PlaySoundBJ(udg_sound06)
        call TriggerSleepAction(2.00)
        call DisplayTimedTextToForce(GetPlayersAll(),26.00,"|cffffcc00But thank you for playing!!|r")
        call TriggerSleepAction(5.00)
        call ForForce(udg_force02,function Trig_Defeat_Func012A)
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger118 = CreateTrigger()
        call TriggerAddCondition(udg_trigger118,Condition(function Trig_Defeat_Conditions))
        call TriggerAddAction(udg_trigger118,function Trig_Defeat_Actions)
    endfunction


endlibrary
