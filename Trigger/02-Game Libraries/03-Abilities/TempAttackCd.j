library TempAttackCd initializer init
    globals
        HashTable AttackCdTargets
    endglobals

    function GetUniqueAttackCdStruct takes integer hid, integer abilId returns AttackCdStruct
        return AttackCdTargets[hid].integer[abilId]
    endfunction
    
    struct AttackCdStruct extends array
        unit source
        real reduction
        integer endTick
        integer buffLink

        private method disable takes nothing returns nothing
            call BlzSetUnitAttackCooldown(this.source, BlzGetUnitAttackCooldown(this.source, 0) - this.reduction, 0)
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (this.buffLink != 0 and GetUnitAbilityLevel(this.source, this.buffLink) == 0) or not UnitAlive(this.source) then
                call this.disable()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real reduction, real duration, integer buffLink returns thistype
            local thistype this = thistype.setup()

            set this.source = source
            set this.reduction = reduction

            if buffLink != 0 then
                set this.buffLink = buffLink
                set AttackCdTargets[GetHandleId(this.source)].integer[buffLink] = this
            endif
            call BlzSetUnitAttackCooldown(source, BlzGetUnitAttackCooldown(source, 0) + this.reduction, 0)

            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod

        static method createUnique takes unit source, real reduction, real duration, integer buffLink returns thistype
            local integer hid = GetHandleId(source)
            local thistype this = GetUniqueAttackCdStruct(hid, buffLink)

            if this == 0 then
                set this = AttackCdStruct.create(source, reduction, duration, buffLink)
            else
                set this.endTick = T32_Tick + R2I(duration * 32)
            endif

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if this.buffLink != 0 then
                set AttackCdTargets[GetHandleId(this.source)].integer[this.buffLink] = 0
            endif
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    private function init takes nothing returns nothing
        set AttackCdTargets = HashTable.create()
    endfunction
endlibrary
