library Multicast requires T32, RandomShit, AbilityChannel
    globals
        private integer MulticastInterval = 8
    endglobals

    struct Multicast extends array
        unit target
        unit caster
        group caston
        integer abilId
        integer abilLevel
        integer abilOrder
        integer orderType
        integer endTick
        integer count
        integer interval
        boolean mono
        real x
        real y

        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method GetNewTarget takes real range returns nothing
            if this.caston == null then
                set this.caston = CreateGroup()
                call GroupAddUnit(this.caston, this.target)
            endif
            
            call RUH.reset().excludeGroup(this.caston)
            
            if GetAbilityTargetType(this.abilId) == 1 then
                call RUH.checkAlly()
            endif

            call RUH.EnumUnits(GetUnitX(this.caster), GetUnitY(this.caster), range, GetOwningPlayer(this.caster))

            set this.target = RUH.GetRandomUnit(false)
            call GroupAddUnit(this.caston, this.target)
        endmethod

        private method castSpell takes nothing returns nothing
            local DummyOrder dummy = DummyOrder.create(this.caster, GetUnitX(this.caster), GetUnitY(this.caster), GetUnitFacing(this.caster), 9)
            call dummy.addActiveAbility(this.abilId, this.abilLevel, this.abilOrder)

            if this.orderType == 0 then
                call dummy.instant()
            elseif this.orderType == 1 then
                call dummy.target(this.target)
            else
                call dummy.point(this.x, this.y)
            endif

            call dummy.activate()
        endmethod

        private method checkSpell takes nothing returns nothing
            if this.orderType == 1 and this.mono then
                call GetNewTarget(GetAbilityRange(this.caster, this.abilId))
            endif
            if not AbilityChannel(this.caster, this.target, this.x, this.y, this.abilId, this.abilLevel) then
                call this.castSpell()
            endif
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.count > 0 then
                call this.checkSpell()
                set this.count = this.count - 1
                set this.endTick = T32_Tick + MulticastInterval
            endif
            
            if this.count == 0 or HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) or not UnitAlive(this.caster) then
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
            set this.caston = null
            set this.abilId = abilId
            set this.abilLevel = abilLvl
            set this.abilOrder = abilOrder
            set this.orderType = orderType

            if IsAbilityMono(abilId) then
                set this.mono = true
            else
                set this.mono = false
            endif

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

            if this.caston != null then
                call DestroyGroup(this.caston)
                set this.caston = null
            endif
            set recycleNext = recycle
            set recycle = this
        endmethod

        implement T32x
    endstruct
endlibrary