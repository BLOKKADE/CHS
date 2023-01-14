library DivineBubble initializer init requires T32, AbilityCooldown, UnitItems, RemoveBuffs
    globals
        Table DivineBubbles
    endglobals

    function GetDivineBubbleStruct takes integer id returns DivineBubbleStruct
        return DivineBubbles[id]
    endfunction

    function IsUnitDivineBubbled takes unit u returns boolean
        return GetDivineBubbleStruct(GetHandleId(u)).enabled and GetDivineBubbleStruct(GetHandleId(u)) != 0
    endfunction

    struct DivineBubbleStruct extends array
        unit source
        effect fx
        integer endTick
        boolean enabled
    
        private method periodic takes nothing returns nothing
            call RemoveUnitBuffs(this.source, BUFFTYPE_NEGATIVE, false)
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real duration, integer abilId returns thistype
            local thistype this = thistype.setup()
            set this.source = source
            set this.fx = AddLocalizedSpecialEffectTarget( "RighteousGuard.mdx" , this.source , "origin" )
            call UnitAddAbility(this.source, 'A08C')
            set this.enabled = true
            call AbilStartCD(this.source, abilId, 50.0 - (1. * GetUnitAbilityLevel(this.source, abilId))) 
            set DivineBubbles[GetHandleId(this.source)] = this
            set this.endTick = T32_Tick + R2I(duration * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveUnitBuff(this.source, 'A08C')
            call DestroyEffect(this.fx)
            set DivineBubbles[GetHandleId(this.source)] = 0
            set this.fx = null
            set this.enabled = false
            set this.source = null
            //call BJDebugMsg("db end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    private function init takes nothing returns nothing
        set DivineBubbles = Table.create()
    endfunction
endlibrary