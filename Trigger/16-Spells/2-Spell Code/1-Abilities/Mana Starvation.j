library ManaStarvation requires DummyOrder, T32, UnitHelpers, NewBonus
    struct ManaStarvationStruct extends array
        integer sourceId
        unit source
        unit target
        integer manaLimit
        integer bonus
        integer damageBonus
        boolean finalStage
        integer beginTick
        integer endTick

        private method periodic takes nothing returns nothing
            local integer mana = R2I(GetUnitState(this.target, UNIT_STATE_MANA))
            local integer currentBonus = 0
            local integer tmpDmgBonus
            if this.finalStage == false and GetUnitAbilityLevel(this.target, MANA_STARVATION_NERF_BUFF_ID) > 0 and IsUnitTarget(this.target) then
                if mana > this.manaLimit then
                    //call BJDebugMsg("ms: " + I2S(this.bonus))
                    call SetUnitState(this.target, UNIT_STATE_MANA, this.manaLimit)
                else
                    //call BJDebugMsg("ms: " + I2S(this.bonus))
                    set this.manaLimit = mana
                endif
                set tmpDmgBonus = R2I((1 - (GetUnitState(this.target, UNIT_STATE_MANA) / GetUnitState(this.target, UNIT_STATE_MAX_MANA))) * BlzGetUnitBaseDamage(this.source, 0))
                if tmpDmgBonus != this.damageBonus then
                    call AddUnitBonus(this.source, BONUS_DAMAGE,tmpDmgBonus - this.damageBonus)
                    set this.damageBonus = tmpDmgBonus
                endif
            elseif this.finalStage == false and ((T32_Tick - this.beginTick > 32 and GetUnitAbilityLevel(this.target, MANA_STARVATION_NERF_BUFF_ID) == 0) or T32_Tick > this.endTick) then
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
            local thistype this = thistype.setup()

            set this.finalStage = false
            set this.source = source
            set this.sourceId = GetHandleId(source)
            set this.target = target
            set this.manaLimit = R2I(GetUnitState(target, UNIT_STATE_MANA))
            set this.damageBonus = 0

            set this.beginTick = T32_Tick
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.target = null
            call AddUnitBonus(this.source, BONUS_DAMAGE, 0 - this.damageBonus)
            set this.source = null
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
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