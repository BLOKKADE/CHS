library SkeletonBrute requires AbilityCooldown

    struct SkeletonBruteStruct extends array
        implement Alloc
        
        unit source
        integer endTick
        effect fx

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        implement T32x
    
        static method create takes unit source returns thistype
            local thistype this = thistype.allocate()
            //call BJDebugMsg("sl start")
            set this.source = source
            set this.endTick = T32_Tick + R2I((1 + (0.01 * GetHeroLevel(this.source))) * 32)
            call UnitAddAbility(this.source, 'A0BB')
            set this.fx = AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\DivineShield\\DivineShieldTarget.mdl", this.source, "origin")
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call RemoveUnitBuff(this.source, 'A0BB')
            //call BlzSetSpecialEffectAlpha(this.fx, 0)
            call DestroyEffect(this.fx)
            set this.fx = null
            set this.source = null
            //call BJDebugMsg("sl end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            call this.deallocate()
        endmethod
    endstruct

    function SkeletonBrute takes unit u returns nothing
        call SkeletonBruteStruct.create(u)
        call AbilStartCD(u, 'A0BA', 10)
    endfunction
endlibrary