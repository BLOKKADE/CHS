library TempAbilSystem requires BuffLevel
    struct TempAbil extends array
        unit source
        boolean stop
        integer endTick
        integer abilId

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or this.stop or GetBuffLevel(this.source, this.abilId) == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit source, integer abilId, real duration returns thistype
            local thistype this = thistype.setup()

            set this.abilId = abilId
            set this.stop = false
            set this.source = source

            call UnitAddAbility(this.source, this.abilId)
            call RegisterBuff(this.source, this.abilId)
            
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveBuff(this.source, this.abilId)
            set this.source = null
            set this.stop = true
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct
endlibrary
