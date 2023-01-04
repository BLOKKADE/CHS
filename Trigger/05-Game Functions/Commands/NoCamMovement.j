library NoCamMovementCommand initializer init requires Command
    //===========================================================================
    globals
        boolean array CamMoveDisabled
    endglobals

    function NoCamMovement takes Args args returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set CamMoveDisabled[pid] = not CamMoveDisabled[pid]
        if CamMoveDisabled[pid] then
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccffdde31Automatic Camera movement & hero selection disabled.|r")
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccfcaff85You can pan the camera to your hero by pressing spacebar.|r")
        else
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 10, "|ccf61fd31Automatic Camera movement & hero selection enabled.|r")
        endif
    endfunction
    
    //===========================================================================
    private function init takes nothing returns nothing
        call Command.create(CommandHandler.NoCamMovement).name("NoCameraMovement").handles("NoCameraMovement").handles("ncm").handles("nocameramovement").help("NoCameraMovement", "Toggles camera movement and hero selection on or off.")
    endfunction
endlibrary