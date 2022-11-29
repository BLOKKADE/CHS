library SyncHelper

    globals
        public constant string SYNC_PREFIX = "S"
    endglobals
    
    private keyword INITS
    
    private struct Sync extends array
        static trigger Trigger = CreateTrigger()
        implement INITS
    endstruct
    
    function SyncString takes string s returns boolean
        return BlzSendSyncData(SYNC_PREFIX, s)
    endfunction
    
    function OnSyncString takes code func returns triggeraction
        return TriggerAddAction(Sync.Trigger, func)
    endfunction
    
    function RemoveSyncString takes triggeraction t returns nothing
        call TriggerRemoveAction(Sync.Trigger, t)
    endfunction
    
    private module INITS
        private static method onInit takes nothing returns nothing
            local integer i  = 0
            
            loop
                call BlzTriggerRegisterPlayerSyncEvent(.Trigger, Player(i), SYNC_PREFIX, false)
                set i = i + 1
                
                exitwhen i == bj_MAX_PLAYER_SLOTS
            endloop
        endmethod
    endmodule
endlibrary