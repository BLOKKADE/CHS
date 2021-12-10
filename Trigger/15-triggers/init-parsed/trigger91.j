library trigger91 initializer init requires RandomShit

    function Trig_Player_Region_Initialization_Actions takes nothing returns nothing
        set udg_rects01[1]= udg_rect01
        set udg_rects01[2]= udg_rect02
        set udg_rects01[3]= udg_rect03
        set udg_rects01[4]= udg_rect04
        set udg_rects01[5]= udg_rect05
        set udg_rects01[6]= udg_rect06
        set udg_rects01[7]= udg_rect07
        set udg_rects01[8]= udg_rect08
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger91 = CreateTrigger()
        call TriggerAddAction(udg_trigger91,function Trig_Player_Region_Initialization_Actions)
    endfunction


endlibrary
