library Reincarnation requires RemoveBuffs, DummyOrder, T32
    struct Reincarnate extends array
        unit source
        real newHp
        integer tick
        integer endTick

        private method regenerate takes nothing returns nothing
            call SetUnitState(this.source, UNIT_STATE_LIFE, newHp)
        endmethod

        private method periodic takes nothing returns nothing
            call this.regenerate()
            if T32_Tick > this.tick then
                set this.tick = T32_Tick + 32
                call TempFx.point("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(this.source), GetUnitY(this.source), 3, true)
            endif
            if T32_Tick > this.endTick then
                call TempFx.point("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(this.source), GetUnitY(this.source), 3, true)
                call SetUnitState(this.source, UNIT_STATE_LIFE, newHp)
                call UnitRemoveAbility(this.source, 'A0EP')
                call RemoveUnitBuffs(this.source, BUFFTYPE_BOTH, false)
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        static method start takes unit source, real delay, real newHp returns thistype
            local thistype this = thistype.setup()
            set this.source = source

            set this.newHp = newHp
            call SetUnitState(this.source, UNIT_STATE_LIFE, newHp)
            set this.endTick = T32_Tick + R2I(delay * 32)
            set this.tick  = T32_Tick + 32

            call TempFx.point("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", GetUnitX(this.source), GetUnitY(this.source), 3, true)

            call UnitAddAbility(this.source, 'A0EP')
            call DummyOrder.create(source, GetUnitX(this.source), GetUnitY(this.source), GetUnitFacing(this.source), delay).addActiveAbility('A0EN', 1, 852095).setAbilityRealField('A0EN', ABILITY_RLF_DURATION_NORMAL, delay).setAbilityRealField('A0EN', ABILITY_RLF_DURATION_HERO, delay).target(this.source).activate()
            call this.startPeriodic()

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct
endlibrary
