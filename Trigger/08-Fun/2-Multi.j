library Multicast requires T32, RandomShit
    globals
        private integer MulticastInterval = 8
    endglobals

    struct Multicast extends array
        unit target
        unit caster
        integer abilId
        integer abilLevel
        integer abilOrder
        integer orderType
        integer endTick
        integer count
        integer interval
        real x
        real y

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method CastSpell takes nothing returns nothing
            local DummyOrder dummy = DummyOrder.create(this.caster, GetUnitX(this.caster), GetUnitY(this.caster), GetUnitFacing(this.caster), 9)
            call dummy.addActiveAbility(this.abilId, this.abilLevel, this.abilOrder)

            call AbilityChanelCst(this.caster, this.target,this.x, this.y, this.abilId)

            if this.orderType == 0 then
                call dummy.instant()
            elseif this.orderType == 1 then
                call dummy.target(this.target)
            else
                call dummy.point(this.x, this.y)
            endif

            call dummy.activate()
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.count > 0 then
                call this.CastSpell()
                set this.count = this.count - 1
                set this.endTick = T32_Tick + MulticastInterval
            elseif this.count == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        static method create takes unit caster, unit target, integer abilId, integer abilLvl, integer abilOrder, integer orderType, real x, real y, integer count returns thistype
            local thistype this

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.caster = caster
            set this.target = target

            set this.abilId = abilId
            set this.abilLevel = abilLevel
            set this.abilOrder = abilOrder
            set this.orderType = orderType

            set this.x = x
            set this.y = y
            
            set this.count = count
            set this.orderType = orderType

            set this.endTick = T32_Tick + MulticastInterval
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
endlibrary