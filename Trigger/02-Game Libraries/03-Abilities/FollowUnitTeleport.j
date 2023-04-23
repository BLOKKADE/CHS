library FollowUnitTeleport initializer init requires Table
    globals
        Table FollowUnitData
    endglobals

    function GetFollowUnitStruct takes unit u returns FollowUnitStruct
        return FollowUnitData[GetHandleId(u)]
    endfunction

    struct FollowUnitStruct extends array
        unit follower
        unit target
        integer interval
        integer nextTick
        integer endTick
        boolean isRunning

        private method periodic takes nothing returns nothing
            if T32_Tick > this.nextTick then
                call SetUnitX(this.follower, GetUnitX(this.target))
                call SetUnitY(this.follower, GetUnitY(this.target))
                set this.nextTick = T32_Tick + this.interval
            endif
            if T32_Tick > this.endTick or (not UnitAlive(this.follower)) or (not UnitAlive(this.target)) or (not this.isRunning) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        static method create takes unit follower, unit target, real duration, real interval returns thistype
            local thistype this = thistype.setup()
            local FollowUnitStruct followStruct = GetFollowUnitStruct(follower)

            if followStruct != 0 and followStruct.isRunning then
                set followStruct.isRunning = false
            endif

            set this.follower = follower
            set this.target = target
            set this.isRunning = true
            set FollowUnitData[GetHandleId(this.follower)] = this
            
            set this.interval = R2I(interval * 32)
            set this.nextTick = T32_Tick + this.interval
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if FollowUnitData[GetHandleId(this.follower)] == this then
                set FollowUnitData[GetHandleId(this.follower)] = 0
            endif
            set this.follower = null
            set this.target = null
            set this.isRunning = false
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct

    private function init takes nothing returns nothing
        set FollowUnitData = Table.create()
    endfunction
endlibrary