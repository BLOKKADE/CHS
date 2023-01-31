library SetupPlayerArenas initializer init requires RandomShit

    private function SetupPlayerArenasActions takes nothing returns nothing
        set PlayerArenaRects[0] = Rect(-4384.0, 2400.0, -2784.0, 4000.0)
        set PlayerArenaRects[1] = Rect(-800.0, 2400.0, 800.0, 4000.0)
        set PlayerArenaRects[2] = Rect(2784.0, 2400.0, 4384.0, 4000.0)
        set PlayerArenaRects[3] = Rect(2784.0, -1056.0, 4384.0, 544.0)
        set PlayerArenaRects[4] = Rect(2784.0, -4512.0, 4384.0, -2912.0)
        set PlayerArenaRects[5] = Rect(-800.0, -4512.0, 800.0, -2912.0)
        set PlayerArenaRects[6] = Rect(-4384.0, -4512.0, -2784.0, -2912.0)
        set PlayerArenaRects[7] = Rect(-4384.0, -1056.0, -2784.0, 544.0)

        set PlayerArenaRectCenters[0] = GetRectCenter(PlayerArenaRects[0])
        set PlayerArenaRectCenters[1] = GetRectCenter(PlayerArenaRects[1])
        set PlayerArenaRectCenters[2] = GetRectCenter(PlayerArenaRects[2])
        set PlayerArenaRectCenters[3] = GetRectCenter(PlayerArenaRects[3])
        set PlayerArenaRectCenters[4] = GetRectCenter(PlayerArenaRects[4])
        set PlayerArenaRectCenters[5] = GetRectCenter(PlayerArenaRects[5])
        set PlayerArenaRectCenters[6] = GetRectCenter(PlayerArenaRects[6])
        set PlayerArenaRectCenters[7] = GetRectCenter(PlayerArenaRects[7])
    endfunction

    private function init takes nothing returns nothing
        call TimerStart(CreateTimer(), 1, false, function SetupPlayerArenasActions)
    endfunction

endlibrary
