library GruntsGrunt requires BuffLevel, RandomShit
    struct GruntsGruntStruct extends array
        unit source
        integer bonus
        integer endTick
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real chronus returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            
            set this.source = source
            set this.bonus = 20 * GetHeroLevel(this.source)

            call RegisterBuff(this.source, 'A091')
            if GetBuffLevel(this.source, 'A091') == 1 then
                call UnitAddAbility(this.source, 'A091')
            endif
            call ElemFuncStart(this.source,'H01J')
            call SetHeroStr(this.source,GetHeroStr(this.source,false)+ bonus,false)
            call BlzSetUnitBaseDamage(this.source,BlzGetUnitBaseDamage(this.source,0)+ bonus,0)
            set this.endTick = T32_Tick + R2I(((9.9 + (0.1 * GetHeroLevel(this.source))) * chronus) * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SetHeroStr(this.source,GetHeroStr(this.source,false)- bonus,false)
            call BlzSetUnitBaseDamage(this.source,BlzGetUnitBaseDamage(this.source,0)- bonus,0)
            call RemoveBuff(this.source, 'A091')
            if GetBuffLevel(this.source, 'A091') == 0 then
                call UnitRemoveAbility(this.source, 'B01K')
            endif
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct
endlibrary