library SetupPlayerArenas initializer init requires RandomShit

    private function SetupPlayerArenasActions takes nothing returns nothing
        set PlayerArenaRects[1] = Rect(-4384.0, 2400.0, -2784.0, 4000.0)
        set PlayerArenaRects[2] = Rect(-800.0, 2400.0, 800.0, 4000.0)
        set PlayerArenaRects[3] = Rect(2784.0, 2400.0, 4384.0, 4000.0)
        set PlayerArenaRects[4] = Rect(2784.0, -1056.0, 4384.0, 544.0)
        set PlayerArenaRects[5] = Rect(2784.0, -4512.0, 4384.0, -2912.0)
        set PlayerArenaRects[6] = Rect(-800.0, -4512.0, 800.0, -2912.0)
        set PlayerArenaRects[7] = Rect(-4384.0, -4512.0, -2784.0, -2912.0)
        set PlayerArenaRects[8] = Rect(-4384.0, -1056.0, -2784.0, 544.0)
    endfunction

    private function init takes nothing returns nothing
        set SetupPlayerArenasTrigger = CreateTrigger()
        call TriggerAddAction(SetupPlayerArenasTrigger, function SetupPlayerArenasActions)
    endfunction

endlibrary
