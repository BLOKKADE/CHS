library SelectedUnits initializer init
    globals
        integer array SelectedUnitPid 
        unit array SelectedUnit
    endglobals


    function Trig_UpdateFrame_Actions takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        set SelectedUnitPid[pid] = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        set SelectedUnit[pid] = GetTriggerUnit()
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