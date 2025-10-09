library ManaStarvation requires DummyOrder, T32, UnitHelpers, NewBonus
    struct ManaStarvationStruct extends array
        implement Alloc
        
        integer sourceId
        unit source
        unit target
        integer manaLimit
        integer damageAmount
        integer beginTick
        integer endTick
        integer tick

        private method periodic takes nothing returns nothing
            local integer mana = R2I(GetUnitState(this.target, UNIT_STATE_MANA))
            set this.tick = this.tick + 1
            if GetUnitAbilityLevel(this.target, MANA_STARVATION_NERF_BUFF_ID) > 0 and IsUnitTarget(this.target) then
                if mana > this.manaLimit then
                    call SetUnitState(this.target, UNIT_STATE_MANA, this.manaLimit)
                    set this.damageAmount = this.damageAmount + (mana - this.manaLimit)
                else
                    set this.manaLimit = mana
                endif
            endif

            if this.tick > 32 then
                set this.tick = 0
                if this.damageAmount > 0 then
                    set udg_NextDamageAbilitySource = MANA_STARVATIO_ABILITY_ID
                    call Damage.applyMagic(this.source, this.target, this.damageAmount, false, DAMAGE_TYPE_MAGIC)
                    set this.damageAmount = 0
                endif
            endif

            if ((T32_Tick - this.beginTick > 32 and GetUnitAbilityLevel(this.target, MANA_STARVATION_NERF_BUFF_ID) == 0) or T32_Tick > this.endTick) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        implement T32x
    
        static method create takes unit source, unit target, real duration returns thistype
            local thistype this = thistype.allocate()

            set this.tick = 0
            set this.source = source
            set this.sourceId = GetHandleId(source)
            set this.target = target
            set this.manaLimit = R2I(GetUnitState(target, UNIT_STATE_MANA))
            set this.damageAmount = 0

            set this.beginTick = T32_Tick
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.target = null
            set this.source = null
            call this.deallocate()
        endmethod
    endstruct

    function CastManaStarvation takes unit caster, unit target, integer level returns nothing
        local real duration = 3.75 + (0.25 * level)
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility('A09N', 1, 852189)
        call dummy.setAbilityRealField('A09N', ABILITY_RLF_DURATION_HERO, duration)
        call dummy.setAbilityRealField('A09N', ABILITY_RLF_DURATION_NORMAL, duration)
        call dummy.target(target)
        call dummy.activate()
        call TempAbil.create(caster, 'A09R', duration + 8)
        call ManaStarvationStruct.create(caster, target, duration)
    endfunction
endlibrary