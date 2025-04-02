library HeroBuff initializer init requires BuffLevel, RandomShit, TimeManipulation

    globals
        Table HbStruct
    endglobals

    function GetHbStruct takes integer id returns HeroBuffStruct
        return HbStruct[id]
    endfunction

    struct HeroBuffStruct extends array
        unit source
        integer endTick
        integer startTick
        integer bonus1
        integer bonus2
        boolean enabled

        private method periodic takes nothing returns nothing
            if this.enabled == false or T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, GetOwningPlayer(this.source)) or (not UnitAlive(this.source)) or (T32_Tick - this.startTick > 32 and GetUnitAbilityLevel(this.source, HERO_BUFF_ID) == 0) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        method resetBonus takes nothing returns nothing
            call AddUnitCustomState(this.source, BONUS_MAGICPOW, 0 - (this.bonus1))
            call AddUnitCustomState(this.source, BONUS_MAGICRES, 0 - (this.bonus2))
        endmethod

        method setBonus takes boolean reset, integer abilLevel, real duration, real heroLevel returns nothing
            if reset then
                call this.resetBonus()
            endif

            call ElemFuncStart(this.source, HERO_BUFF_ABILITY_ID)

            set this.bonus1 = R2I(0.75 * abilLevel*(1 + 0.009 * heroLevel))
            set this.bonus2 = R2I(1.2 * abilLevel*(1 + 0.009 * heroLevel))
            set this.endTick = T32_Tick + R2I(duration * 32)
            set this.startTick = T32_Tick
            
            call DummyInstantCast4(this.source,GetUnitX(this.source),GetUnitY(this.source),'A03T',"battleroar",(100 * abilLevel)*(1 + 0.009 * heroLevel),ABILITY_RLF_DAMAGE_INCREASE,(10 * abilLevel)*(1 + 0.009 * heroLevel),ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 ,duration,ABILITY_RLF_DURATION_HERO, duration,ABILITY_RLF_DURATION_NORMAL)
            call AddUnitCustomState(this.source, BONUS_MAGICPOW, this.bonus1)
            call AddUnitCustomState(this.source, BONUS_MAGICRES, this.bonus2)
        endmethod
    
        static method create takes unit source, integer abilLevel, integer heroLevel, real chronusLevel, real duration returns thistype
            local thistype this = thistype.setup()
            
            set this.source = source
            call this.setBonus(false, abilLevel, duration, heroLevel)
            

            set this.enabled = true
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.resetBonus()
            set HbStruct[GetHandleId(this.source)] = 0
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function HeroBuffCast takes unit u, integer abilLevel, integer heroLevel, real chronusLevel, real duration returns nothing
        if GetHbStruct(GetHandleId(u)) == 0 then
            set HbStruct[GetHandleId(u)] = HeroBuffStruct.create(u, abilLevel, heroLevel, chronusLevel, duration)
        else
            call GetHbStruct(GetHandleId(u)).setBonus(true, abilLevel, duration, heroLevel)
        endif
    endfunction

    private function init takes nothing returns nothing
        set HbStruct = Table.create()
    endfunction
endlibrary