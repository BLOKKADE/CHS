library Alloc /* v1.1.0 https://www.hiveworkshop.com/threads/324937/


    */uses /*

    */Table                 /*  https://www.hiveworkshop.com/threads/188084/

    */ErrorMessage /*  https://github.com/nestharus/JASS/blob/master/jass/Systems/ErrorMessage/main.j


    *///! novjass

    /*
        Written by AGD, based on MyPad's allocation algorithm

            A allocator module using a single global indexed stack. Allocated values are
            within the JASS_MAX_ARRAY_SIZE. No more need to worry about code bloats behind
            the module implementation as it generates the least code possible (6 lines of
            code in non-DEBUG), nor does it use an initialization function. This system
            also only uses ONE variable (for the whole map) for the hashtable.
    */
    |-----|
    | API |
    |-----|
    /*
      */module GlobalAlloc/*
            - Uses a single stack globally
      */module Alloc/*
            - Uses a unique stack per struct

          */
            static if DEBUG then
                readonly boolean allocated/* Is node allocated?
            endif

          */static method allocate takes nothing returns thistype/*
          */method deallocate takes nothing returns nothing/*

    *///! endnovjass

    /*===========================================================================*/

    globals
        private key stack
    endglobals

        private function AssertError takes boolean condition, string methodName, string structName, integer node, string message returns nothing
            static if DEBUG_MODE then
                static if LIBRARY_ErrorMessage then
                    call ThrowError(condition, SCOPE_PREFIX, methodName, structName, node, message)
                else
                    if condition then
                        call BJDebugMsg("[Library: " + SCOPE_PREFIX + "] [Struct: " + structName + "] [Method: " + methodName + "] [Instance: " + I2S(node) + "] : |cffff0000" + message + "|r")
                    endif
                endif
            endif
        endfunction

        public function IsAllocated takes integer typeId, integer node returns boolean
            return node > 0 and Table(stack)[typeId*JASS_MAX_ARRAY_SIZE + node] == 0
        endfunction

    public function Allocate takes integer typeId returns integer
        local integer offset = typeId*JASS_MAX_ARRAY_SIZE
        local integer node = Table(stack)[offset]
        local integer stackNext = Table(stack)[offset + node]
        static if DEBUG then
            call AssertError(typeId < 0, "allocate()", Table(stack).string[-typeId], 0, "Invalid struct ID (" + I2S(typeId) + ")")
        endif
        if stackNext == 0 then
            static if DEBUG then
                call AssertError(node == (JASS_MAX_ARRAY_SIZE - 1), "allocate()", Table(stack).string[-typeId], node, "Overflow")
            endif
            set node = node + 1
            set Table(stack)[offset] = node
        else
            set Table(stack)[offset] = stackNext
            set Table(stack)[offset + node] = 0
        endif
        return node
    endfunction
    public function Deallocate takes integer typeId, integer node returns nothing
        local integer offset = typeId*JASS_MAX_ARRAY_SIZE
        static if DEBUG then
            call AssertError(node == 0, "deallocate()", Table(stack).string[-typeId], 0, "Null node")
            call AssertError(Table(stack)[offset + node] > 0, "deallocate()", Table(stack).string[-typeId], node, "Double-free")
        endif
        set Table(stack)[offset + node] = Table(stack)[offset]
        set Table(stack)[offset] = node
    endfunction

    module Alloc
        static if DEBUG then
            method operator allocated takes nothing returns boolean
                return IsAllocated(thistype.typeid, this)
            endmethod
        endif
        static method allocate takes nothing returns thistype
            return Allocate(thistype.typeid)
        endmethod
        method deallocate takes nothing returns nothing
            call Deallocate(thistype.typeid, this)
        endmethod
        static if DEBUG then
            private static method onInit takes nothing returns nothing
                set Table(stack).string[-thistype.typeid] = "thistype"
            endmethod
        endif
    endmodule

    module GlobalAlloc
        static if DEBUG then
            method operator allocated takes nothing returns boolean
                return IsAllocated(0, this)
            endmethod
        endif
        static method allocate takes nothing returns thistype
            static if DEBUG then
                call AssertError(Table(stack)[0] == (JASS_MAX_ARRAY_SIZE - 1), "allocate()", "thistype", JASS_MAX_ARRAY_SIZE - 1, "Overflow")
            endif
            return Allocate(0)
        endmethod
        method deallocate takes nothing returns nothing
            static if DEBUG then
                call AssertError(this == 0, "deallocate()", "thistype", 0, "Null node")
                call AssertError(Table(stack)[this] > 0, "deallocate()", "thistype", this, "Double-free")
            endif
            call Deallocate(0, this)
        endmethod
    endmodule
endlibrary