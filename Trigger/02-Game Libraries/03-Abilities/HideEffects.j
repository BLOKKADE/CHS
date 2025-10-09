library HideEffects requires T32, Alloc

    //Hides the effect if a player has disabled fx with -de
    function AddLocalizedSpecialEffect takes string modelName, real x, real y returns effect
        if not EffectVisible then
            set modelName = ""
        endif

        return AddSpecialEffect(modelName, x, y)
    endfunction

    //Hides the effect if a player has disabled fx with -de
    function AddLocalizedSpecialEffectTarget takes string modelName, unit u, string attachmentPointName returns effect
        if not EffectVisible then
            set modelName = ""
        endif

        return AddSpecialEffectTarget(modelName,u,attachmentPointName)
    endfunction

    struct TempFx extends array
        implement Alloc

        effect fx
        boolean skipDeath
        integer endTick

        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        implement T32x

        static method create takes effect fx, boolean skipDeath, real duration returns thistype
            local thistype this

            if fx != null then
                set this = thistype.allocate()
                set this.fx = fx
                set this.skipDeath = skipDeath
                set this.endTick = T32_Tick + R2I(duration * 32)

                call this.startPeriodic()
                return this
            else
                return 0
            endif
        endmethod

        static method point takes string modelName, real x, real y, real duration, boolean skipDeath returns thistype
            return TempFx.create(AddLocalizedSpecialEffect(modelName, x, y), skipDeath, duration)
        endmethod

        static method target takes string modelName, unit u, string attachmentPointName, real duration, boolean skipDeath returns thistype
            return TempFx.create(AddLocalizedSpecialEffectTarget(modelName,u,attachmentPointName), skipDeath, duration)
        endmethod
        
        method destroy takes nothing returns nothing
            if this.skipDeath then
                call BlzSetSpecialEffectX(this.fx, 0)
                call BlzSetSpecialEffectY(this.fx, 10000)
            endif

            call DestroyEffect(this.fx)
            set this.fx = null
            call this.deallocate()
        endmethod
    endstruct
endlibrary
