library PoisonRune initializer init requires RandomShit

    globals
        Table PoisonRuneBonus
    endglobals

    struct PoisonRuneDuration extends array
        implement Alloc

        integer pid
        integer level
        integer endTick
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        implement T32x
    
        static method create takes integer pid, integer level returns thistype
            local thistype this = thistype.allocate()

            set this.pid = pid
            set this.level = level

            set this.endTick = T32_Tick + R2I(10 * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set PoisonRuneBonus[this.pid] = PoisonRuneBonus[this.pid] - this.level
            call this.deallocate()
        endmethod
    endstruct

    function PoisonRune takes nothing returns boolean
        local integer pid = GetPlayerId(GetOwningPlayer(GLOB_RUNE_U))
        local real power = GLOB_RUNE_POWER * 100
        local integer levels = R2I(power / 20) + 1

        set PoisonRuneBonus[pid] = PoisonRuneBonus[pid] + levels
        call PoisonRuneDuration.create(pid, levels)
        return false
    endfunction

    private function init takes nothing returns nothing
        set PoisonRuneBonus = Table.create()
    endfunction
endlibrary