library CheaterMagic requires BuffLevel, RandomShit, TimeManipulation
    struct CheaterMagicStruct extends array
        implement Alloc

        unit source
        integer endTick

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        implement T32x
    
        static method create takes unit source, real duration returns thistype
            local thistype this = thistype.allocate()
            
            set this.source = source

            call RegisterLeveledBuff(this.source, 'A08G')
            if GetBuffLevel(this.source, 'A08G') == 1 then
                call UnitAddAbility(this.source, 'A08G')
            endif
            call ElemFuncStart(this.source,CHEATER_MAGIC_ABILITY_ID)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveLeveledBuffs(this.source, 'A08G')
            if GetBuffLevel(this.source, 'A08G') == 0 then
                call UnitRemoveAbility(this.source, CHEATER_MAGIC_BUFF_ID)
            endif
            set this.source = null
            call this.deallocate()
        endmethod
    endstruct
endlibrary