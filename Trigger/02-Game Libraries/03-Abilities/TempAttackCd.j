library TempAttackCd initializer init requires Alloc
    globals
        HashTable AttackCdTargets
    endglobals

    function GetUniqueAttackCdStruct takes integer hid, integer abilId returns AttackCdStruct
        return AttackCdTargets[hid].integer[abilId]
    endfunction

    struct AttackCdStruct extends array
        implement Alloc

        unit source
        real originalCd
        real adjustment
        boolean isMultiplicative
        integer endTick
        integer buffLink

        private method disable takes nothing returns nothing
            if this.isMultiplicative then
                call BlzSetUnitAttackCooldown(this.source, this.originalCd, 0)
            else
                call BlzSetUnitAttackCooldown(this.source, BlzGetUnitAttackCooldown(this.source, 0) - this.adjustment, 0)
            endif
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (this.buffLink != 0 and GetUnitAbilityLevel(this.source, this.buffLink) == 0) or not UnitAlive(this.source) then
                call this.disable()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        implement T32x

        static method create takes unit source, real adjustment, real duration, integer buffLink, boolean isMultiplicative returns thistype
            local thistype this = thistype.allocate()

            set this.source = source
            set this.originalCd = BlzGetUnitAttackCooldown(source, 0)
            set this.adjustment = adjustment
            set this.isMultiplicative = isMultiplicative

            if buffLink != 0 then
                set this.buffLink = buffLink
                set AttackCdTargets[GetHandleId(this.source)].integer[buffLink] = this
            endif

            if this.isMultiplicative then
                call BlzSetUnitAttackCooldown(source, this.originalCd * this.adjustment, 0)
            else
                call BlzSetUnitAttackCooldown(source, this.originalCd + this.adjustment, 0)
            endif

            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod

        static method createUnique takes unit source, real adjustment, real duration, integer buffLink, boolean isMultiplicative returns thistype
            local integer hid = GetHandleId(source)
            local thistype this = GetUniqueAttackCdStruct(hid, buffLink)

            if this == 0 then
                set this = AttackCdStruct.create(source, adjustment, duration, buffLink, isMultiplicative)
            else
                set this.endTick = T32_Tick + R2I(duration * 32)
                if this.isMultiplicative then
                    call BlzSetUnitAttackCooldown(source, this.originalCd * this.adjustment, 0)
                else
                    call BlzSetUnitAttackCooldown(source, this.originalCd + this.adjustment, 0)
                endif
            endif

            return this
        endmethod

        static method createCooldownIncrease takes unit source, real percent, real duration, integer buffLink returns thistype
            local real originalCd = BlzGetUnitAttackCooldown(source, 0)
            local real increase = originalCd * (percent / 100.0)
            return AttackCdStruct.create(source, increase, duration, buffLink, false)
        endmethod

        static method createDoubleCooldown takes unit source, real duration, integer buffLink returns thistype
            return AttackCdStruct.create(source, 2.0, duration, buffLink, true)
        endmethod

        method destroy takes nothing returns nothing
            if this.buffLink != 0 then
                set AttackCdTargets[GetHandleId(this.source)].integer[this.buffLink] = 0
            endif
            set this.source = null
            call this.deallocate()
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set AttackCdTargets = HashTable.create()
    endfunction
endlibrary
