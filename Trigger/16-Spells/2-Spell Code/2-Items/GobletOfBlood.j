library GobletOfBlood initializer init requires Utility
    globals
        Table GobletOfBloodHashTable
    endglobals

    function GetGobletStruct takes integer id returns GobletOfBloodStruct
        return GobletOfBloodHashTable[id]
    endfunction

    struct GobletOfBloodStruct extends array
        unit source
        integer hid
        integer hpBonus
        integer damageBonus
        integer endTick
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method update takes nothing returns nothing
            local integer hp = BlzGetUnitMaxHP(this.source)
            local integer damage = R2I(SpellData[hid].real[7])
            if this.hpBonus != damage then
                //call BJDebugMsg("set hp: " + I2S(damage))
                call BlzSetUnitMaxHP(this.source, damage)
                set this.hpBonus = damage
            endif

            if this.damageBonus != hp then
                //call BJDebugMsg("set dmg: " + I2S(hp))
                call BlzSetUnitBaseDamage(this.source, hp, 0)
                set this.damageBonus = hp
            endif
        endmethod

        private method stop takes nothing returns nothing
            call BlzSetUnitMaxHP(this.source, this.damageBonus)
            call CalculateNewCurrentHP(this.source, this.damageBonus - this.hpBonus)
            call BlzSetUnitBaseDamage(this.source, this.hpBonus, 0)
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.source, 'B026') == 0 or (not UnitAlive(this.source)) then
                call this.stop()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.source = source
            set this.hid = GetHandleId(source)
            set this.hpBonus = 0
            set this.damageBonus = 0
            call this.update()

            set this.endTick = T32_Tick + R2I(8 * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            set GobletOfBloodHashTable[hid] = 0
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function CastGobletOfBlood takes unit u returns nothing
        if GetGobletStruct(GetHandleId(u)) == 0 then
            set GobletOfBloodHashTable[GetHandleId(u)] = GobletOfBloodStruct.create(u)
        else
            set GetGobletStruct(GetHandleId(u)).endTick = T32_Tick + R2I(8 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set GobletOfBloodHashTable = Table.create()
    endfunction
endlibrary