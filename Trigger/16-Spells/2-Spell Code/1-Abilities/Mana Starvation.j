library ManaStarvation requires DummyOrder, T32
    struct ManaStarvationStruct extends array
        integer sourceId
        unit source
        unit target
        integer manaLimit
        integer bonus
        boolean finalStage
        integer beginTick
        integer endTick
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            local integer mana = R2I(GetUnitState(this.target, UNIT_STATE_MANA))
            local integer currentBonus = 0
            if this.finalStage == false and GetUnitAbilityLevel(this.target, 'B01X') > 0 and IsUnitTarget(this.target) then
                if mana > this.manaLimit then
                    set currentBonus = R2I((mana - this.manaLimit) * 0.5)
                    set this.bonus = this.bonus + currentBonus
                    //call BJDebugMsg("ms: " + I2S(this.bonus))
                    call UnitAddAttackDamage(this.source, currentBonus)
                    call SetUnitState(this.target, UNIT_STATE_MANA, this.manaLimit)
                else
                    set currentBonus = R2I((this.manaLimit - mana) * 0.5)
                    set this.bonus = this.bonus + currentBonus
                    //call BJDebugMsg("ms: " + I2S(this.bonus))
                    call UnitAddAttackDamage(this.source, currentBonus)
                    set this.manaLimit = mana
                endif
            elseif this.finalStage == false and ((T32_Tick - this.beginTick > 32 and GetUnitAbilityLevel(this.target, 'B01X') == 0) or T32_Tick > this.endTick) then
                //call BJDebugMsg("final stage")
                set this.finalStage = true
                set this.endTick = T32_Tick + (8 * 32)
            endif

            if this.finalStage and T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, unit target, real duration returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.finalStage = false
            set this.source = source
            set this.sourceId = GetHandleId(source)
            set this.target = target
            set this.manaLimit = R2I(GetUnitState(target, UNIT_STATE_MANA))
            set this.bonus = 0

            set this.beginTick = T32_Tick
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.target = null
            call UnitAddAttackDamage(this.source, 0 - this.bonus)
            set this.source = null
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function CastManaStarvation takes unit caster, unit target, integer level returns nothing
        local real duration = 3.75 + (0.25 * level)
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility('A09N', 1, 852189)
        call dummy.setAbilityRealField('A09N', ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField('A09N', ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.target(target)
        call dummy.activate()
        call SetBuff(caster, 8, duration + 8)
        call ManaStarvationStruct.create(caster, target, duration)
    endfunction
endlibrary