library TempPower initializer init requires BuffLevel, RandomShit, TimeManipulation

    globals
        Table TpStruct
    endglobals

    function GetTpStruct takes integer id returns TempPowerStruct
        return TpStruct[id]
    endfunction

    struct TempPowerStruct extends array
        unit source
        integer endTick
        integer bonus

        
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or not UnitAlive(this.source) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real duration returns thistype
            local thistype this = thistype.setup()
            
            set this.source = source
            set this.bonus = R2I(40 * GetUnitAbilityLevel(this.source, TEMPORARY_POWER_ABILITY_ID)*(1 + 0.02 * GetHeroLevel(this.source)))

            call SetHeroStr(this.source, GetHeroStr(this.source, false) + this.bonus, false)
            call SetHeroAgi(this.source, GetHeroAgi(this.source, false) + this.bonus, false)
            call SetHeroInt(this.source, GetHeroInt(this.source, false) + this.bonus, false)
            call ElemFuncStart(this.source,TEMPORARY_POWER_ABILITY_ID)
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SetHeroStr(this.source, GetHeroStr(this.source, false) - this.bonus, false)
            call SetHeroAgi(this.source, GetHeroAgi(this.source, false) - this.bonus, false)
            call SetHeroInt(this.source, GetHeroInt(this.source, false) - this.bonus, false)
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function TempPowerCast takes unit u, real duration returns nothing
        if GetTpStruct(GetHandleId(u)) == 0 then
            set TpStruct[GetHandleId(u)] = TempPowerStruct.create(u, duration)
        else
            call GetTpStruct(GetHandleId(u)).destroy()
            set TpStruct[GetHandleId(u)] = TempPowerStruct.create(u, duration)
        endif
    endfunction

    private function init takes nothing returns nothing
        set TpStruct = Table.create()
    endfunction
endlibrary