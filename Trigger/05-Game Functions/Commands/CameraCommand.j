library CameraCommand initializer init uses Command, RandomShit

    globals
        integer array CamDistance
    endglobals

    private function SetCamDistance takes nothing returns nothing
        if CamDistance[(GetPlayerId(GetLocalPlayer()))] != 0 then
            call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, CamDistance[(GetPlayerId(GetLocalPlayer()))], 0.25)
        endif
    endfunction

    private function Camera takes Args args returns nothing
        local integer distance = S2I(args[1])
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())

        if (distance > 3000) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE, 3000.00,0.50)
            set CamDistance[pid] = 3000
            call ps.setCameraZoom(3000)
        elseif (distance < 1700) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1700.00,0.50)
            set CamDistance[pid] = 1700
            call ps.setCameraZoom(1700)
        else 
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,I2R(distance),0.50)
            set CamDistance[pid] = distance
            call ps.setCameraZoom(distance)
        endif
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.Camera).name("camera").handles("cam").handles("zoom").help("camera <distance>", "changes the distance of the camera")

        call TimerStart(NewTimer(), 0.25, true, function SetCamDistance)
	endfunction

endlibrary
