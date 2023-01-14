library SetHostPlayer initializer init requires RandomShit

    private function SetHostPlayerActions takes nothing returns nothing
        local integer index = 0
        local player currentPlayer
        
        loop
            exitwhen index == 8

            set currentPlayer = Player(index)

            if (GetPlayerController(currentPlayer) == MAP_CONTROL_USER and GetPlayerSlotState(currentPlayer) == PLAYER_SLOT_STATE_PLAYING) then
                set HostPlayer = currentPlayer
                exitwhen true
            endif

            set index = index + 1
        endloop

        // Cleanup
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set SetHostPlayerTrigger = CreateTrigger()
        call TriggerAddAction(SetHostPlayerTrigger, function SetHostPlayerActions)
    endfunction

endlibrary
