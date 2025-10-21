library Avatar initializer init requires NewBonus, RandomShit, RemoveBuffDelay

    globals
        Table AvatarBonus
    endglobals

    function GetAvatar takes integer id returns AvatarStruct
        return AvatarBonus[id]
    endfunction

    struct AvatarStruct extends array
        implement Alloc

        unit source
        integer endTick
        integer level
        boolean enabled
        integer damageBonus
        real armorBonus
        integer hpBonus
        integer scaleTick
        boolean shrinking

        private method periodic takes nothing returns nothing
            local real scale

            // Gradual scaling
            if not this.shrinking and this.scaleTick < 16 then
                set scale = 1.0 + 0.5 * (this.scaleTick / 16.0)
                call SetUnitScale(this.source, scale, scale, scale)
                set this.scaleTick = this.scaleTick + 1
            elseif this.shrinking and this.scaleTick > 0 then
                set scale = 1.0 + 0.5 * (this.scaleTick / 16.0)
                call SetUnitScale(this.source, scale, scale, scale)
                set this.scaleTick = this.scaleTick - 1
            endif

            // End condition
            if T32_Tick > this.endTick then
                set this.shrinking = true
                if this.scaleTick == 0 then
                    call this.stopPeriodic()
                    call this.destroy()
                endif
            endif
        endmethod

        implement T32x

        method removeBonuses takes nothing returns nothing
            call UnitRemoveAbility(this.source, 'A0AD')
            call AddUnitBonus(this.source, BONUS_DAMAGE, 0 - this.damageBonus)
            call BlzSetUnitArmor(this.source, BlzGetUnitArmor(this.source) - this.armorBonus)
            call SetUnitMaxHp(this.source, BlzGetUnitMaxHP(this.source) - this.hpBonus)
            call SetUnitScale(this.source, 1.0, 1.0, 1.0)
        endmethod

        method setBonuses takes integer level returns nothing
            set this.level = level
            set this.damageBonus = 0 - 50 + (80 * this.level)
            set this.armorBonus = 20 * this.level
            set this.hpBonus = 400 * this.level
        endmethod

        method updateBonuses takes nothing returns nothing
            call UnitAddAbility(this.source, 'A0AD')
            call AddUnitBonus(this.source, BONUS_DAMAGE, this.damageBonus)
            call BlzSetUnitArmor(this.source, BlzGetUnitArmor(this.source) + this.armorBonus)
            call SetUnitMaxHp(this.source, BlzGetUnitMaxHP(this.source) + this.hpBonus)
        endmethod

        static method create takes unit source, integer level returns thistype
            local thistype this = thistype.allocate()
            local real duration

            call RemoveBuffsDelayed(source, 1, 0.2)
            set this.source = source
            set this.level = level
            set this.damageBonus = 0 - 50 + (80 * level)
            set this.armorBonus = 20 * level
            set this.hpBonus = 400 * level

            call DestroyEffect(AddLocalizedSpecialEffect("Abilities\\Spells\\Human\\Avatar\\AvatarCaster.mdl", GetUnitX(this.source), GetUnitY(this.source)))

            call this.updateBonuses()
            set this.enabled = true
            set this.scaleTick = 0
            set this.shrinking = false

            // Duration scales from 3.1s at level 1 to 6s at level 30
            set duration = 3.1 + (level - 1) * (6.0 - 3.1) / 29
            set this.endTick = T32_Tick + R2I(duration * 32)

            call this.startPeriodic()
            return this
        endmethod

        method destroy takes nothing returns nothing
            call this.removeBonuses()
            set this.enabled = false
            set AvatarBonus[GetHandleId(this.source)] = 0
            set this.source = null
            call this.deallocate()
        endmethod
    endstruct

    function CastAvatar takes unit caster, integer level returns nothing
        local real duration = 3.1 + (level - 1) * (6.0 - 3.1) / 29
        if GetAvatar(GetHandleId(caster)) == 0 then
            set AvatarBonus[GetHandleId(caster)] = AvatarStruct.create(caster, level)
        else
            call GetAvatar(GetHandleId(caster)).removeBonuses()
            call GetAvatar(GetHandleId(caster)).setBonuses(level)
            call GetAvatar(GetHandleId(caster)).updateBonuses()
            set GetAvatar(GetHandleId(caster)).endTick = T32_Tick + R2I(duration * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AvatarBonus = Table.create()
    endfunction

endlibrary
