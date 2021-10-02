library FrameUpdate initializer init
    globals

        integer array NumPlayerLast 
        unit array selectedUnit
    endglobals


    function Trig_UpdateFrame_Actions takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        //if udg_units01[ GetPlayerId(GetOwningPlayer(GetTriggerUnit()))] != null then
        set NumPlayerLast[pid] = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        set selectedUnit[pid] = GetTriggerUnit()
        //endif
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(0), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(1), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(2), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(3), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(4), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(5), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(6), true )
        call TriggerRegisterPlayerSelectionEventBJ( trg, Player(7), true )
        call TriggerAddAction( trg, function Trig_UpdateFrame_Actions )
        set trg = null
    endfunction

endlibrary