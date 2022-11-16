library TempAbilSystem initializer init requires BuffLevel
    globals
        HashTable UnitTempAbilities
    endglobals

    function GetUnitTempAbilityStruct takes unit u, integer abilId returns TempAbil
        return UnitTempAbilities[GetHandleId(u)].integer[abilId]
    endfunction

    struct TempAbil extends array
        unit source
        boolean stop
        integer endTick
        integer abilId

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or this.stop or GetBuffLevel(this.source, this.abilId) == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit source, integer abilId, real duration returns thistype
            local thistype this 
            local TempAbil tempAbil = GetUnitTempAbilityStruct(source, abilId)

            if tempAbil == 0 then
                set this = thistype.setup()

                set this.abilId = abilId
                set this.stop = false
                set this.source = source

                call UnitAddAbility(this.source, this.abilId)
                call RegisterBuff(this.source, this.abilId)

                set UnitTempAbilities[GetHandleId(this.source)].integer[this.abilId] = this
                
                set this.endTick = T32_Tick + R2I(duration * 32)
                call this.startPeriodic()
                return this
            else
                set tempAbil.endTick = T32_Tick + R2I(duration * 32)
                return tempAbil
            endif
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveBuff(this.source, this.abilId)
            set UnitTempAbilities[GetHandleId(this.source)].integer[this.abilId] = 0
            set this.source = null
            set this.stop = true
            call this.recycle()
        endmethod

        implement Recycle
        implement T32x
    endstruct

    private function init takes nothing returns nothing
        set UnitTempAbilities = HashTable.create()
    endfunction
endlibrary
