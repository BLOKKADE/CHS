library SetupPlayerArenas initializer init requires RandomShit

    private function SetupPlayerArenasActions takes nothing returns nothing
        set PlayerArenaRects[1] = RectP1Arena
        set PlayerArenaRects[2] = RectP2Arena
        set PlayerArenaRects[3] = RectP3Arena
        set PlayerArenaRects[4] = RectP4Arena
        set PlayerArenaRects[5] = RectP5Arena
        set PlayerArenaRects[6] = RectP6Arena
        set PlayerArenaRects[7] = RectP7Arena
        set PlayerArenaRects[8] = RectP8Arena
    endfunction

    private function init takes nothing returns nothing
        set SetupPlayerArenasTrigger = CreateTrigger()
        call TriggerAddAction(SetupPlayerArenasTrigger, function SetupPlayerArenasActions)
    endfunction

endlibrary
