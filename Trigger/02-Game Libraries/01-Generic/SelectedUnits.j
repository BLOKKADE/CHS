library SelectedUnits initializer init requires IconFrames

    globals
        integer array SelectedUnitPid 
        unit array SelectedUnit
    endglobals

    private function SelectedUnitsActions takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        set SelectedUnitPid[pid] = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        set SelectedUnit[pid] = GetTriggerUnit()

        call IconFrames_UpdateAbilityIcons(GetTriggerPlayer())
    endfunction

    private function init takes nothing returns nothing
        local trigger selectedUnitsTrigger = CreateTrigger()
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(0), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(1), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(2), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(3), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(4), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(5), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(6), true)
        call TriggerRegisterPlayerSelectionEventBJ(selectedUnitsTrigger, Player(7), true)
        call TriggerAddAction(selectedUnitsTrigger, function SelectedUnitsActions)
        set selectedUnitsTrigger = null
    endfunction

endlibrary