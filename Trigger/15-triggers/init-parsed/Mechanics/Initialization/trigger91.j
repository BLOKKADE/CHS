library trigger91 initializer init requires RandomShit

    function Trig_Player_Region_Initialization_Actions takes nothing returns nothing
        set PlayerArenaRects[1]= udg_rect01
        set PlayerArenaRects[2]= udg_rect02
        set PlayerArenaRects[3]= udg_rect03
        set PlayerArenaRects[4]= udg_rect04
        set PlayerArenaRects[5]= udg_rect05
        set PlayerArenaRects[6]= udg_rect06
        set PlayerArenaRects[7]= udg_rect07
        set PlayerArenaRects[8]= udg_rect08
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger91 = CreateTrigger()
        call TriggerAddAction(udg_trigger91,function Trig_Player_Region_Initialization_Actions)
    endfunction


endlibrary
