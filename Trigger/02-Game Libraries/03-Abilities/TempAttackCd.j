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
        real originalCd // Store original cooldown
        real adjustment // Can be additive (reduction) or multiplicative (multiplier)
        boolean isMultiplicative // Flag to switch between modes
        integer endTick
        integer buffLink

        private method disable takes nothing returns nothing
            if this.isMultiplicative then
                call BlzSetUnitAttackCooldown(this.source, this.originalCd, 0) // Revert to original for multiplicative
            else
                call BlzSetUnitAttackCooldown(this.source, BlzGetUnitAttackCooldown(this.source, 0) - this.adjustment, 0) // Revert additive
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
            set this.originalCd = BlzGetUnitAttackCooldown(source, 0) // Store original cooldown
            set this.adjustment = adjustment
            set this.isMultiplicative = isMultiplicative

            if buffLink != 0 then
                set this.buffLink = buffLink
                set AttackCdTargets[GetHandleId(this.source)].integer[buffLink] = this
            endif
            if this.isMultiplicative then
                call BlzSetUnitAttackCooldown(source, this.originalCd * this.adjustment, 0) // Apply multiplicative (e.g., 0.5 halves)
            else
                call BlzSetUnitAttackCooldown(source, this.originalCd + this.adjustment, 0) // Apply additive (e.g., 0.5 increases)
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
