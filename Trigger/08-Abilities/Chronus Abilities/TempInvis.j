library TempInvis requires BuffLevel, RandomShit, TimeManipulation
    struct TempInvisStruct extends array
        unit source
        integer endTick
    
        
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real duration returns thistype
            local thistype this = thistype.setup()
            
            set this.source = source

            call RegisterBuff(this.source, 'A03V')
            if GetBuffLevel(this.source, 'A03V') == 1 then
                call UnitAddAbility(this.source, 'A03V')
            endif
            call ElemFuncStart(this.source,TEMPORARY_INVISIBILITY_ABILITY_ID)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveBuff(this.source, 'A03V')
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct
endlibrary