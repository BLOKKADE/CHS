library StructRecycleModule
    module Recycle

        private static integer instanceCount = 0
        private static thistype recycleInstance = 0
        private thistype recycleNext

        static method setup takes nothing returns thistype
            local thistype this

            if (recycleInstance == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycleInstance
                set recycleInstance = recycleInstance.recycleNext
            endif

            return this
        endmethod 
        
        method recycle takes nothing returns nothing
            set recycleNext = recycleInstance
            set recycleInstance = this
        endmethod
    endmodule
endlibrary