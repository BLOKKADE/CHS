library GruntsGrunt requires BuffLevel, RandomShit, TimeManipulation
    struct GruntsGruntStruct extends array
        unit source
        integer bonus
        integer endTick
    
        
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real chronus returns thistype
            local thistype this = thistype.setup()
            local real duration
            
            set this.source = source
            set this.bonus = 20 * GetHeroLevel(this.source)
            set duration = ((9.9 + (0.1 * GetHeroLevel(this.source))) * chronus)

            call RegisterLeveledBuff(this.source, 'A091')
            if GetBuffLevel(this.source, 'A091') == 1 then
                call UnitAddAbility(this.source, 'A091')
            endif
            call ElemFuncStart(this.source,GRUNT_UNIT_ID)
            call SetHeroStr(this.source,GetHeroStr(this.source,false)+ bonus,false)
            call BlzSetUnitBaseDamage(this.source,BlzGetUnitBaseDamage(this.source,0)+ bonus,0)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SetHeroStr(this.source,GetHeroStr(this.source,false)- bonus,false)
            call BlzSetUnitBaseDamage(this.source,BlzGetUnitBaseDamage(this.source,0)- bonus,0)
            call RemoveLeveledBuffs(this.source, 'A091')
            if GetBuffLevel(this.source, 'A091') == 0 then
                call UnitRemoveAbility(this.source, 'B01K')
            endif
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct
endlibrary