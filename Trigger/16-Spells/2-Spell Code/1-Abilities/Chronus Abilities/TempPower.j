library TempPower requires BuffLevel, RandomShit, TimeManipulation
    struct TempPowerStruct extends array
        unit source
        integer endTick
        integer bonus

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real duration returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            
            set this.source = source
            set this.bonus = R2I(40 * GetUnitAbilityLevel(this.source, 'A04E')*(1 + 0.02 * GetHeroLevel(this.source)))

            call SetHeroStr(this.source, GetHeroStr(this.source, false) + this.bonus, false)
            call SetHeroAgi(this.source, GetHeroAgi(this.source, false) + this.bonus, false)
            call SetHeroInt(this.source, GetHeroInt(this.source, false) + this.bonus, false)
            call ElemFuncStart(this.source,'A04E')
            call TimeManipulation(source, duration)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SetHeroStr(this.source, GetHeroStr(this.source, false) - this.bonus, false)
            call SetHeroAgi(this.source, GetHeroAgi(this.source, false) - this.bonus, false)
            call SetHeroInt(this.source, GetHeroInt(this.source, false) - this.bonus, false)
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct
endlibrary