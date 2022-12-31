library AllPlayersDead initializer init requires RandomShit

    private function AllPlayersDeadTriggerConditions takes nothing returns boolean
        return (PlayerCount == 0) and (IsTriggerEnabled(GetTriggeringTrigger()) == true)
    endfunction

    private function ShowDefeatScreenForPlayer takes nothing returns nothing
        call CustomDefeatBJ(GetEnumPlayer(), "Defeat!")
    endfunction

    private function AllPlayersDeadTriggerActions takes nothing returns nothing
        call DisableTrigger(GetTriggeringTrigger())
        call DisableTrigger(PlayerCompleteRoundMoveTrigger)
        call DisableTrigger(PlayerCompleteRoundTrigger)
        call CinematicFilterGenericBJ(2, BLEND_MODE_BLEND, "ReplaceableTextures\\CameraMasks\\DreamFilter_Mask.blp", 50.00, 0.00, 0.00, 100, 0, 0, 0, 0)
        call DisplayTimedTextToForce(GetPlayersAll(), 30, "|cffffcc00All heroes were slain and everyone was forced to admit defeat!|r")
        call EndThematicMusicBJ()
        call SetMusicVolumeBJ(0.00)
        call PlaySoundBJ(udg_sound06)
        call TriggerSleepAction(2.00)
        call DisplayTimedTextToForce(GetPlayersAll(), 26.00, "|cffffcc00But thank you for playing!!|r")
        call TriggerSleepAction(5.00)
        call ForForce(DefeatedPlayers, function ShowDefeatScreenForPlayer)
    endfunction

    private function init takes nothing returns nothing
        set AllPlayersDeadTrigger = CreateTrigger()
        call TriggerAddCondition(AllPlayersDeadTrigger, Condition(function AllPlayersDeadTriggerConditions))
        call TriggerAddAction(AllPlayersDeadTrigger, function AllPlayersDeadTriggerActions)
    endfunction

endlibrary
