library ItemHolder requires Table

    globals
        private Table data
    endglobals

    public function get takes item i returns unit
        return data.unit[GetHandleId(i)]
    endfunction

    private function gain takes nothing returns nothing
        set data.unit[GetHandleId(GetManipulatedItem())] = GetTriggerUnit()
    endfunction

    private function lose takes nothing returns nothing
        set data.unit[GetHandleId(GetManipulatedItem())] = null
    endfunction

    private module Init
        private static method onInit takes nothing returns nothing
            // Initialization process here..
            local trigger t
            set data = Table.create()
            set t = CreateTrigger()
            call TriggerAddAction(t, function gain)
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_PICKUP_ITEM)

            set t = CreateTrigger()
            call TriggerAddAction(t, function lose)
            call TriggerRegisterAnyUnitEventBJ(t, EVENT_PLAYER_UNIT_DROP_ITEM)
        endmethod
    endmodule

    // Dummy struct that's only used for initialization purposes
    private struct S extends array
        implement Init
    endstruct

endlibrary

