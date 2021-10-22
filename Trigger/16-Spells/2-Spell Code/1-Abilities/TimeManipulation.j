library TimeManipulation initializer init requires RandomShit
    globals
        HashTable TimeManipulationTable
    endglobals

    function ResetTimeManipulation takes unit u, integer startType returns nothing
        local integer hid = GetHandleId(u)
        set TimeManipulationTable[hid].real[0] = 0

        if startType != 6 then
            set TimeManipulationTable[hid].boolean[1] = true
            set TimeManipulationTable[hid].real[2] = 0
        endif
    endfunction

    function TimeManipulation takes unit u, real duration returns nothing
        set TimeManipulationTable[GetHandleId(u)].real[0] = RMaxBJ(TimeManipulationTable[GetHandleId(u)].real[0], duration)
    endfunction

    /*function TimerEnd takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer pid = GetTimerData(t)
        local integer hid = GetHandleId(udg_units01[pid+1])
        if TimeManipulationTable[hid].timer[3] == t then
            if not HasPlayerFinishedLevel(udg_units01[pid+1], Player(pid)) then
                call BJDebugMsg("set true")
                set TimeManipulationTable[hid].boolean[4] = true
            endif
            set TimeManipulationTable[hid].timer[3] = null
        endif
        call ReleaseTimer(t)
        set t = null
    endfunction*/

    function TimeManipulationStart takes unit source returns nothing
        local integer hid = GetHandleId(source)
            
        //call BJDebugMsg("spell longest: " + R2S(TimeManipulationTable[hid].real[0]) + " + 10")
        //call BJDebugMsg("count bonus: " + R2S((TimeManipulationTable[hid].real[2])) + ", unit: " + I2S(hid))
        set TimeManipulationTable[hid].real[0] = TimeManipulationTable[hid].real[0] + 6 + (TimeManipulationTable[hid].real[2] * (10 - ( 0.2 * GetUnitAbilityLevel(source, 'A0AS') )))
        call AbilStartCD(source, 'A0AS', TimeManipulationTable[hid].real[0])
        set TimeManipulationTable[hid].real[0] = 0  
    endfunction

    private function init takes nothing returns nothing
        set TimeManipulationTable = HashTable.create()
    endfunction 
endlibrary
