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
        set PlayerArenaRects[8] = Rect(-4384.0, 5100.0, -2852.0, 6600.0)
        set PlayerArenaRects[9] = Rect(-800.0, 5100.0, 740.0, 6600.0)
        set PlayerArenaRects[10] = Rect(2800.0, 5100.0, 4300.0, 6600.0)
        set PlayerArenaRects[11] = Rect(5500.0, 2400.0, 7000.0, 4000.0)
        set PlayerArenaRects[12] = Rect(5500.0, -1056.0, 7000.0, 500.0)
        set PlayerArenaRects[13] = Rect(5500.0, -4500.0, 7000.0, -3000.0)
        set PlayerArenaRects[14] = Rect(2800.0, -7200.0, 4300.0, -5700.0)
        set PlayerArenaRects[15] = Rect(-800.0, -7200.0, 750.0, -5700.0)
        set PlayerArenaRects[16] = Rect(-4384.0, -7200.0, -2784.0, -5700.0)
        set PlayerArenaRects[17] = Rect(-7000.0, -4500.0, -5500.0, -3000.0)
        set PlayerArenaRects[18] = Rect(-7000.0, -1000.0, -5500.0, 500.0)
        set PlayerArenaRects[19] = Rect(-7000.0, 2400.0, -5500.0, 4000.0)

        set PlayerArenaRectCenters[0] = GetRectCenter(PlayerArenaRects[0])
        set PlayerArenaRectCenters[1] = GetRectCenter(PlayerArenaRects[1])
        set PlayerArenaRectCenters[2] = GetRectCenter(PlayerArenaRects[2])
        set PlayerArenaRectCenters[3] = GetRectCenter(PlayerArenaRects[3])
        set PlayerArenaRectCenters[4] = GetRectCenter(PlayerArenaRects[4])
        set PlayerArenaRectCenters[5] = GetRectCenter(PlayerArenaRects[5])
        set PlayerArenaRectCenters[6] = GetRectCenter(PlayerArenaRects[6])
        set PlayerArenaRectCenters[7] = GetRectCenter(PlayerArenaRects[7])
        set PlayerArenaRectCenters[8] = GetRectCenter(PlayerArenaRects[8])
        set PlayerArenaRectCenters[9] = GetRectCenter(PlayerArenaRects[9])
        set PlayerArenaRectCenters[10] = GetRectCenter(PlayerArenaRects[10])
        set PlayerArenaRectCenters[11] = GetRectCenter(PlayerArenaRects[11])
        set PlayerArenaRectCenters[12] = GetRectCenter(PlayerArenaRects[12])
        set PlayerArenaRectCenters[13] = GetRectCenter(PlayerArenaRects[13])
        set PlayerArenaRectCenters[14] = GetRectCenter(PlayerArenaRects[14])
        set PlayerArenaRectCenters[15] = GetRectCenter(PlayerArenaRects[15])
        set PlayerArenaRectCenters[16] = GetRectCenter(PlayerArenaRects[16])
        set PlayerArenaRectCenters[17] = GetRectCenter(PlayerArenaRects[17])
        set PlayerArenaRectCenters[18] = GetRectCenter(PlayerArenaRects[18])
        set PlayerArenaRectCenters[19] = GetRectCenter(PlayerArenaRects[19])
    endfunction

    private function init takes nothing returns nothing
        set SetupPlayerArenasTrigger = CreateTrigger()
        call TriggerAddAction(SetupPlayerArenasTrigger, function SetupPlayerArenasActions)
    endfunction

endlibrary
