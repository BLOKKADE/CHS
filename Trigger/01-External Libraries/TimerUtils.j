library TimerUtilsEx requires optional Table
    /*************************************************
    *
    *   TimerUtilsEx
    *   v2.1.0.2
    *   By Vexorian, Bribe & Magtheridon96
    *
    *   Original version by Vexorian.
    *
    *   Flavors:
    *       Hashtable:
    *           - RAM:              Minimal
    *           - TimerData:        Slow
    *
    *       Array:
    *           - RAM:              Maximal
    *           - TimerData:        Fast
    *
    *   All the functions have O(1) complexity.
    *   The Array version is the fastest, but the hashtable
    *   version is the safest. The Array version is still
    *   quite safe though, and I would recommend using it.
    *   The system is much slower in debug mode.
    *
    *   Optional Requirement:
    *       - Table by Bribe
    *           - hiveworkshop.com/forums/showthread.php?t=188084
    *
    *   API:
    *   ----
    *       - function NewTimer takes nothing returns timer
    *           - Returns a new timer from the stack.
    *       - function NewTimerEx takes integer i returns timer
    *           - Returns a new timer from the stack and attaches a value to it.
    *       - function ReleaseTimer takes timer t returns integer
    *           - Throws a timer back into the stack. Also returns timer data.
    *       - function SetTimerData takes timer t, integer value returns nothing
    *           - Attaches a value to a timer.
    *       - function GetTimerData takes timer t returns integer
    *           - Returns the attached value.
    *
    *************************************************/
    // Configuration
    globals
        // Use hashtable, or fast array?
        private constant boolean USE_HASH = false
        // Max Number of Timers Held in Stack
        private constant integer QUANTITY = 256
    endglobals
    
    globals
        private timer array tT
        private integer tN = 0
    endglobals
    
    private module Init
        private static method onInit takes nothing returns nothing
            static if not USE_HASH then
                local integer i = QUANTITY
                loop
                    set i = i - 1
                    set tT[i] = CreateTimer()
                    exitwhen i == 0
                endloop
                
                set tN = QUANTITY
            elseif LIBRARY_Table then
                set tb = Table.create()
            endif
        endmethod
    endmodule
    
    // JassHelper doesn't support static ifs for globals.
    private struct Data extends array
        static if not USE_HASH then
            static integer array data
        endif
        static if LIBRARY_Table then
            static Table tb = 0
        else
            static hashtable ht = InitHashtable()
        endif
        implement Init
    endstruct
    
    // Double free protection
    private function ValidTimer takes integer i returns boolean
        static if LIBRARY_Table then
            return Data.tb.boolean[-i]
        else
            return LoadBoolean(Data.ht, i, 1)
        endif
    endfunction
    
    private function Get takes integer id returns integer
        static if DEBUG then
            if not ValidTimer(id) then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "[TimerUtils]Error: Tried to get data from invalid timer.")
            endif
        endif
        static if USE_HASH then
            static if LIBRARY_Table then
                return Data.tb[id]
            else
                return LoadInteger(Data.ht, id, 0)
            endif
        else
            return Data.data[id - 0x100000]
        endif
    endfunction
    
    private function Set takes integer id, integer data returns nothing
        static if DEBUG then
            if not ValidTimer(id) then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "[TimerUtils]Error: Tried to attach data to invalid timer.")
            endif
        endif
        static if USE_HASH then
            static if LIBRARY_Table then
                set Data.tb[id] = data
            else
                call SaveInteger(Data.ht, id, 0, data)
            endif
        else
            set Data.data[id - 0x100000] = data
        endif
    endfunction
    
    function SetTimerData takes timer t, integer data returns nothing
        call Set(GetHandleId(t), data)
    endfunction
    
    function GetTimerData takes timer t returns integer
        return Get(GetHandleId(t))
    endfunction
    
    function NewTimerEx takes integer data returns timer
        local integer id
        if tN == 0 then
            static if USE_HASH then
                set tT[0] = CreateTimer()
            else
                static if DEBUG then
                    call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "[TimerUtils]Error: No Timers In The Stack! You must increase 'QUANTITY'")
                endif
                return null
            endif
        else
            set tN = tN - 1
        endif
        static if DEBUG then
            call BJDebugMsg("NewTimerEx: " + I2S(tN) + " timers left in the stack.")
        endif
        set id = GetHandleId(tT[tN])
        static if LIBRARY_Table then
            set Data.tb.boolean[-id] = true
        else
            call SaveBoolean(Data.ht, id, 1, true)
        endif
        call Set(id, data)
        return tT[tN]
    endfunction
    
    function NewTimer takes nothing returns timer
        return NewTimerEx(0)
    endfunction
    
    function ReleaseTimer takes timer t returns integer
        local integer id = GetHandleId(t)
        local integer data = 0
        
        // Pause the timer just in case.
        call PauseTimer(t)
        
        // Make sure the timer is valid.
        if ValidTimer(id) then
            // Get the timer's data.
            set data = Get(id)
            
            // Unmark handle id as a valid timer.
            static if LIBRARY_Table then
                call Data.tb.boolean.remove(-id)
            else
                call RemoveSavedBoolean(Data.ht, id, 1)
            endif
            
            //If it's not run in USE_HASH mode, this next block is useless.
            static if USE_HASH then
            
                //At least clear hash memory while it's in the recycle stack.
                static if LIBRARY_Table then
                    call Data.tb.remove(id)
                else
                    call RemoveSavedInteger(Data.ht, id, 0)
                endif
                
                // If the recycle limit is reached
                if tN == QUANTITY then
                    // then we destroy the timer.
                    call DestroyTimer(t)
                    return data
                endif
            endif
            
            //Recycle the timer.
            set tT[tN] = t
            set tN = tN + 1
            
        //Tried to pass a bad timer.
        else
            static if DEBUG then
                call DisplayTimedTextToPlayer(GetLocalPlayer(), 0, 0, 60, "[TimerUtils]Error: Tried to release non-active timer!")
            endif
        endif
        
        
        //Return Timer Data.
        return data
    endfunction

endlibrary

library TimerUtils requires TimerUtilsEx
endlibrary