library ConversionHotkeys initializer init requires Table
    //detects hotkey presses
    
    globals
        //integer array PlayerHotkeys
        boolean array HoldCtrl
        //boolean array HotKeyMode
    endglobals

    private function CtrlDown takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if HoldCtrl[pid] == false then
            set HoldCtrl[pid] = true
        endif
    endfunction

    private function CtrlRelease takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        if HoldCtrl[pid] == true then
            set HoldCtrl[pid] = false
        endif
    endfunction

    private function ConvertLumber takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer lumber = 0
        set lumber =  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER,0)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)  + lumber * 30)
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function ConvertGold takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer gold = 0
        set gold =  GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)/30

        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) - gold*30  )
        call SetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) + gold)
        call ResourseRefresh(Player(pid)) 
    endfunction
    private function init takes nothing returns nothing
        local trigger trg3 = CreateTrigger()
        local trigger trg4 = CreateTrigger()
        local integer i = 0

        loop
            call BlzTriggerRegisterPlayerKeyEvent(trg3, Player(i), OSKEY_Q, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg4, Player(i), OSKEY_W, 2, true)
            set i = i + 1
            exitwhen i > 8
        endloop
        call TriggerAddAction(trg3, function ConvertLumber)
        call TriggerAddAction(trg4, function ConvertGold)
        set trg3 = null
        set trg4 = null
    endfunction
endlibrary