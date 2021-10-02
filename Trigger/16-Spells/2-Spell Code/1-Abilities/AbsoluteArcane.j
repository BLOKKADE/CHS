library AbsoluteArcane requires CustomState, DivineBubble
    struct AbsoluteArcaneStruct extends array
        unit source
        unit target
        integer endTick
        real bonus
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or IsUnitDivineBubbled(this.target) or IsUnitSpellTargetCheck(this.target, GetOwningPlayer(this.source)) == false or GetUnitAbilityLevel(this.source, 'B01W') > 0  then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, unit target returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            set this.source = source
            set this.target = target
            set this.bonus = 0.5 * GetClassUnitSpell(this.source, Element_Arcane)
            if GetUnitMagicDmg(this.target) - this.bonus > 0 then
                call AddUnitMagicDmg(this.source, this.bonus)
                call AddUnitMagicDmg(this.target, 0 - this.bonus)
                call AbilStartCD(this.source, 'A0AB', 1)
            else
                set this.bonus = 0
            endif

            set this.endTick = T32_Tick + R2I(5 * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call AddUnitMagicDmg(this.source, 0 - this.bonus)
            call AddUnitMagicDmg(this.target, this.bonus)
            set this.source = null
            set this.target = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct
endlibrary