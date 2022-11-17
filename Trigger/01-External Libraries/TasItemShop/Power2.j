library Power2 

    globals
        private integer array data
    endglobals

    function GetPower2Value takes integer i returns integer
        return data[i]
    endfunction

    private module Init
        private static method onInit takes nothing returns nothing
            local integer index = 1
            local integer value = 1
            loop
                set data[index] = value
                set index = index + 1
                set value = value*2
                exitwhen index == 32
                // body
            endloop
        endmethod
    endmodule

    // Dummy struct that's only used for initialization purposes
    private struct S extends array
        implement Init
    endstruct

endlibrary
 