library MaskOfProtection initializer init requires CustomState

    globals
        Table MopStruct
    endglobals

    function GetMopStruct takes integer id returns MaskOfProtection
        return MopStruct[id]
    endfunction

    struct MaskOfProtection extends array
        unit source
        real armorBonus
        real magicResBonus
        integer endTick
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method disableBonus takes nothing returns nothing
            call BlzSetUnitArmor(this.source, BlzGetUnitArmor(this.source) - this.armorBonus)
            call AddUnitMagicDef(this.source, 0 - this.magicResBonus)
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.source, 'B01U') == 0 then
                call this.disableBonus()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this
            local real magicpower = GetUnitMagicDmg(source)
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.source = source
            set this.armorBonus = magicpower * 2
            call BlzSetUnitArmor(source, BlzGetUnitArmor(source) + this.armorBonus)

            set this.magicResBonus = magicpower * 0.3
            call AddUnitMagicDef(source, this.magicResBonus)

            set this.endTick = T32_Tick + R2I(7*32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set MopStruct[GetHandleId(this.source)] = 0
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function MaskOfProtectionCast takes unit u returns nothing
        if GetMopStruct(GetHandleId(u)) == 0 then
            set MopStruct[GetHandleId(u)] = MaskOfProtection.create(u)
        else
            set GetMopStruct(GetHandleId(u)).endTick = T32_Tick + R2I(7*32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set MopStruct = Table.create()
    endfunction
endlibrary