library HeroBuff requires BuffLevel, RandomShit, TimeManipulation
    struct HeroBuffStruct extends array
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
    
        static method create takes unit source, integer abilLevel, integer heroLevel, real chronusLevel, real duration returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            
            set this.source = source
            set this.bonus = R2I(3 * abilLevel*(1 + 0.009 * heroLevel))

            call AddUnitMagicDmg(this.source, this.bonus)
            call AddUnitMagicDef(this.source, this.bonus * 0.5)
            call ElemFuncStart(this.source,'A03Q')
            call USOrder4field(this.source,GetUnitX(this.source),GetUnitY(this.source),'A03T',"battleroar",(100 * abilLevel)*(1 + 0.009 * heroLevel),ABILITY_RLF_DAMAGE_INCREASE,(10 * abilLevel)*(1 + 0.009 * heroLevel),ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 ,duration * chronusLevel,ABILITY_RLF_DURATION_HERO, duration * chronusLevel,ABILITY_RLF_DURATION_NORMAL)
            call TimeManipulation(this.source, duration * chronusLevel)
            set this.endTick = T32_Tick + R2I((duration * chronusLevel) * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call AddUnitMagicDmg(this.source, 0 - this.bonus)
            call AddUnitMagicDef(this.source, 0 - (this.bonus * 0.5))
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct
endlibrary