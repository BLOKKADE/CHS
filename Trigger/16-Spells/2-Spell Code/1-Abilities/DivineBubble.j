library DivineBubble initializer init requires T32, RandomShit
    globals
        Table DivineBubbles
    endglobals

    function GetDivineBubbleStruct takes integer id returns DivineBubbleStruct
        return DivineBubbles[id]
    endfunction

    function IsUnitDivineBubbled takes unit u returns boolean
        return GetDivineBubbleStruct(GetHandleId(u)).enabled
    endfunction

    struct DivineBubbleStruct extends array
        unit source
        effect fx
        integer endTick
        boolean enabled
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            call RemoveDebuff(this.source, 1)
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, real duration returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            set this.source = source
            set this.fx = AddSpecialEffectTarget( "RighteousGuard.mdx" , this.source , "origin" )
            call UnitAddAbility(this.source, 'A08C')
            set this.enabled = true
            call AbilStartCD(this.source,'A07S', 30.69 - (0.69 * GetUnitAbilityLevel(this.source, 'A07S'))) 
            set DivineBubbles[GetHandleId(this.source)] = this
            set this.endTick = T32_Tick + R2I(duration * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call UnitRemoveAbility(this.source, 'A08C')
            call UnitRemoveAbility(this.source, 'B01E')
            call DestroyEffect(this.fx)
            set this.fx = null
            set this.enabled = false
            set this.source = null
            //call BJDebugMsg("db end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    private function init takes nothing returns nothing
        set DivineBubbles = Table.create()
    endfunction
endlibrary