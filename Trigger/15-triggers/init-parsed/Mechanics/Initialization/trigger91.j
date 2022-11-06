library trigger91 initializer init requires RandomShit

    function Trig_Player_Region_Initialization_Actions takes nothing returns nothing
        set PlayerArenaRects[1]= RectP1Arena
        set PlayerArenaRects[2]= RectP2Arena
        set PlayerArenaRects[3]= RectP3Arena
        set PlayerArenaRects[4]= RectP4Arena
        set PlayerArenaRects[5]= RectP5Arena
        set PlayerArenaRects[6]= RectP6Arena
        set PlayerArenaRects[7]= RectP7Arena
        set PlayerArenaRects[8]= RectP8Arena
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger91 = CreateTrigger()
        call TriggerAddAction(udg_trigger91,function Trig_Player_Region_Initialization_Actions)
    endfunction


endlibrary
