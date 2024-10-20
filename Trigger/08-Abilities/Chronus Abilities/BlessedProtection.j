library BlessedProtection requires BuffLevel, RandomShit, TimeManipulation
    struct BlessedProtectionStruct extends array
        unit source
        effect fx
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
            set this.fx = AddLocalizedSpecialEffectTarget("Soul Armor Divine_opt.mdx", this.source, "head")
            call RegisterLeveledBuff(this.source, 'A0AF')
            if GetBuffLevel(this.source, 'A0AF') == 1 then
                call UnitAddAbility(this.source, 'A0AF')
            endif
            call ElemFuncStart(this.source,BLESSED_PROTECTIO_ABILITY_ID)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveLeveledBuffs(this.source, 'A0AF')
            if GetBuffLevel(this.source, 'A0AF') == 0 then
                call UnitRemoveAbility(this.source, 'B025')
            endif
            call DestroyEffect(this.fx)
            set this.fx = null
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct
endlibrary