library trigger123 initializer init requires RandomShit

    function Trig_Camera_Command_Func001C takes nothing returns boolean
        if(not(SubStringBJ(StringCase(GetEventPlayerChatString(),false),2,7)=="camera"))then
            return false
        endif
        return true
    endfunction


    function Trig_Camera_Command_Func002C takes nothing returns boolean
        if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))>= 1650))then
            return false
        endif
        if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))<= 2800))then
            return false
        endif
        return true
    endfunction


    function Trig_Camera_Command_Func002Func001C takes nothing returns boolean
        if(not(S2I(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString())))> 2800))then
            return false
        endif
        return true
    endfunction


    function Trig_Camera_Command_Actions takes nothing returns nothing
        if(Trig_Camera_Command_Func001C())then
            set BettingPlayerCount = 9
        else
            set BettingPlayerCount = 6
        endif
        if(Trig_Camera_Command_Func002C())then
            call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,S2R(SubStringBJ(GetEventPlayerChatString(),BettingPlayerCount,StringLength(GetEventPlayerChatString()))),0.50)
        else
            if(Trig_Camera_Command_Func002Func001C())then
                call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,2800.00,0.50)
            else
                call SetCameraFieldForPlayer(GetTriggerPlayer(),CAMERA_FIELD_TARGET_DISTANCE,1650.00,0.50)
            endif
        endif
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger123 = CreateTrigger()
        call DisableTrigger(udg_trigger123)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(0),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(0),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(1),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(1),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(2),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(2),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(3),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(3),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(4),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(4),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(5),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(5),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(6),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(6),"-cam",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(7),"-camera ",false)
        call TriggerRegisterPlayerChatEvent(udg_trigger123,Player(7),"-cam",false)
        call TriggerAddAction(udg_trigger123,function Trig_Camera_Command_Actions)
    endfunction


endlibrary
