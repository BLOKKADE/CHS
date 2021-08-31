library UrsaBleed requires TimerUtils

    globals
        string FX_Bleed = "Abilities\\Spells\\Other\\Stampede\\StampedeMissileDeath.mdl"
    endglobals

    struct UrsaBleed extends array
        real dmg
        unit target
        unit caster
        boolean magic
        integer endTick
        integer limit

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.limit > 0 then
                if GetWidgetLife(this.target) > 0.405 then
                    if magic then
                        call UnitDamageTarget(this.caster, this.target, this.dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
                    else
                        set GLOB_typeDmg = 2
                        call UnitDamageTarget(this.caster, this.target, this.dmg, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
                    endif
                    call DestroyEffect(AddSpecialEffectTarget(FX_Bleed, this.target, "head"))
                endif

                set this.limit = this.limit - 1
                set this.endTick = T32_Tick + 32
            elseif this.limit == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit caster, unit target, real damage, boolean magic returns UrsaBleed
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.dmg = damage / 3
            set this.target = target
            set this.magic = magic
            set this.caster = caster
            set this.limit = 3

            call DestroyEffect(AddSpecialEffectTarget(FX_Bleed, this.target, "head"))

            set this.endTick = T32_Tick + 32
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.caster = null
            set this.target = null

            set recycleNext = recycle
            set recycle = this
        endmethod

        implement T32x
    endstruct

    function CastUrsaBleed takes unit caster, unit target, real damage, boolean magic returns nothing
        call UrsaBleed.create(caster, target, damage, magic)
    endfunction
endlibrary