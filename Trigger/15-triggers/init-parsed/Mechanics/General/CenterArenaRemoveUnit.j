library CenterArenaRemoveUnit initializer init requires RandomShit, IdLibrary

    private function CenterArenaRemoveUnitActions takes nothing returns boolean
        local unit u = GetTriggerUnit()

        if (not IsUnitExcluded(u)) then
            call DeleteUnit(u)
        endif

        // Cleanup
        set u = null
        
        return false
    endfunction

    private function init takes nothing returns nothing
        set CenterArenaRemoveUnitTrigger = CreateTrigger()
        call TriggerRegisterEnterRectSimple(CenterArenaRemoveUnitTrigger, RectMidArena)
        call TriggerAddCondition(CenterArenaRemoveUnitTrigger, Condition(function CenterArenaRemoveUnitActions))
    endfunction

endlibrary
