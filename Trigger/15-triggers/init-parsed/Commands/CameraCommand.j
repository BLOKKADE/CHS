library CameraCommand initializer init uses Command, RandomShit

    private function Camera takes Args args returns nothing
        local integer distance = S2I(args[1])

        if (distance > 3000) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,2800.00,0.50)
        elseif (distance < 1700) then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1700.00,0.50)
        else 
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,I2R(distance),0.50)
        endif
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.Camera).name("camera").handles("cam").handles("zoom").help("camera <distance>", "changes the distance of the camera")
	endfunction

endlibrary
