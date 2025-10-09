library RegionLeaveDetect initializer init requires KnockbackHelper

    globals
        Table RectLeaveDetectStructs
    endglobals

    function GetRectLeaveDetectStruct takes integer hid returns RectLeaveDetection
        return RectLeaveDetectStructs[hid]
    endfunction

    function StopRectLeaveDetection takes integer hid returns boolean
        if RectLeaveDetectStructs[hid] != 0 then
            call GetRectLeaveDetectStruct(hid).destroy()

            return true
        endif

        return false
    endfunction

    struct RectLeaveDetection extends array
        implement Alloc
        
        unit u
        integer hid
        rect r
        real lastValidX
        real lastValidY

        method periodic takes nothing returns nothing
            local real x = GetUnitX(this.u)
            local real y = GetUnitY(this.u)
            if not RectContainsCoords(r, x, y) then
                call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, x, y))
                call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, this.lastValidX, this.lastValidY))

                call SetUnitX(this.u, this.lastValidX)
                call SetUnitY(this.u, this.lastValidY)
                call AddTempKnockbackImmunity(this.u, 2)
            else
                set this.lastValidX = GetUnitX(this.u)
                set this.lastValidY = GetUnitY(this.u)
            endif
        endmethod

        implement T32x
        
        //Make sure this is only created once hero is in position
        static method create takes unit u, rect r returns thistype
            local thistype this = thistype.allocate()

            set this.u = u
            set this.r = r
            set this.hid = GetHandleId(this.u)
            set this.lastValidX = GetUnitX(this.u)
            set this.lastValidY = GetUnitY(this.u)

            call StopRectLeaveDetection(this.hid)
            set RectLeaveDetectStructs[this.hid] = this

            call this.startPeriodic()

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.stopPeriodic()

            set RectLeaveDetectStructs[GetHandleId(this.u)] = 0
            set this.u = null
            set this.r = null

            call this.deallocate()
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set RectLeaveDetectStructs = Table.create()
    endfunction
endlibrary
