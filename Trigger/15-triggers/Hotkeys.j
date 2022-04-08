library ConversionHotkeys initializer init requires Table, SellItems
    //detects hotkey presses
    
    globals
        //integer array PlayerHotkeys
        boolean array HoldCtrl
        Table HoldShiftStructTable
        //boolean array HotKeyMode
    endglobals

    
    function GetHoldShiftStruct takes integer pid returns HoldShiftStruct
        return HoldShiftStructTable[pid]
    endfunction

    struct HoldShiftStruct extends array
        integer pid
        integer endTick

        method update takes nothing returns nothing
            set this.endTick = T32_Tick + 12
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HoldCtrl[this.pid] == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes integer pid returns thistype
            local thistype this = thistype.setup()
            set this.pid = pid

            set this.endTick = T32_Tick + 12
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if HoldCtrl[this.pid] then
                set HoldCtrl[this.pid] = false
            endif
            set HoldShiftStructTable[this.pid] = 0
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    globals
        integer lastTick = 0
    endglobals

    private function CtrlDown takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        set HoldCtrl[pid] = true
        set lastTick = T32_Tick
        if GetHoldShiftStruct(pid) == 0 then
            set HoldShiftStructTable[pid] = HoldShiftStruct.create(pid)
        else
            call GetHoldShiftStruct(pid).update()
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
        set lumber = GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER,0)
        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)  + lumber * 30)
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function ConvertGold takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())
        local integer gold = 0
        set gold = GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD)/ 30

        call SetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD,GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_GOLD) - gold * 30  )
        call SetPlayerState(Player(pid), PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(Player(pid),PLAYER_STATE_RESOURCE_LUMBER) + gold)
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function SellAllItems takes nothing returns nothing
        local integer pid = GetPlayerId(GetTriggerPlayer())

        call SellItemsFromHero(PlayerHeroes[pid + 1])
        call ResourseRefresh(Player(pid)) 
    endfunction

    private function HotKeyInit takes nothing returns nothing
        local trigger trg1 = CreateTrigger()
        local trigger trg2 = CreateTrigger()
        local trigger trg3 = CreateTrigger()
        local trigger trg4 = CreateTrigger()
        local trigger trg5 = CreateTrigger()
        local integer i = 0
        set HoldShiftStructTable = Table.create()
        loop
            call BlzTriggerRegisterPlayerKeyEvent(trg3, Player(i), OSKEY_Q, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg4, Player(i), OSKEY_W, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg5, Player(i), OSKEY_E, 2, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg1, Player(i), OSKEY_LSHIFT, 1, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg2, Player(i), OSKEY_LSHIFT, 0, false)
            call BlzTriggerRegisterPlayerKeyEvent(trg1, Player(i), OSKEY_RSHIFT, 1, true)
            call BlzTriggerRegisterPlayerKeyEvent(trg2, Player(i), OSKEY_RSHIFT, 0, false)
            set i = i + 1
            exitwhen i > 8
        endloop
        call TriggerAddAction(trg3, function ConvertLumber)
        call TriggerAddAction(trg4, function ConvertGold)
        call TriggerAddAction(trg5, function SellAllItems)
        set trg3 = null
        set trg4 = null
        set trg5 = null
        call TriggerAddAction(trg1, function CtrlDown)
        call TriggerAddAction(trg2, function CtrlRelease)
        set trg1 = null
        set trg2 = null
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEvent(trg, 1., false)
        call TriggerAddAction(trg, function HotKeyInit)
        set trg = null
    endfunction
endlibrary