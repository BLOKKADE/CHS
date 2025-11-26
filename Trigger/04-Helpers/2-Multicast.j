library Multicast requires T32, RandomShit, AbilityChannel
    globals
        private integer MulticastInterval = 8
        private real MulticastManaCost = 0.5
    endglobals

    struct Multicast extends array
        implement Alloc

        unit target
        unit caster
        unit hero
        group caston
        integer abilId
        integer abilLevel
        integer abilOrder
        integer orderType
        integer endTick
        integer count
        integer interval
        boolean mono
        real manaCost
        real x
        real y

        private method GetNewTarget takes real range returns boolean
            if this.caston == null then
                set this.caston = NewGroup()
                call GroupAddUnit(this.caston, this.target)
            endif
            
            call RUH.reset().excludeGroup(this.caston)
            call RUH.EnumUnits(GetUnitX(this.caster), GetUnitY(this.caster), range, GetAbilityTargetType(this.abilId), GetOwningPlayer(this.caster))

            set this.target = RUH.GetRandomUnit(false)
            if this.target == null then
                return false
            else
                call GroupAddUnit(this.caston, this.target)
                return true
            endif
        endmethod

        private method castSpell takes nothing returns nothing
            local DummyOrder dummy = DummyOrder.create(this.caster, GetUnitX(this.caster), GetUnitY(this.caster), GetUnitFacing(this.caster), 9)
            call dummy.addActiveAbility(this.abilId, this.abilLevel, this.abilOrder)

            if this.orderType == Order_Instant then
                call dummy.instant()
            elseif this.orderType == Order_Target then
                call dummy.target(this.target)
            elseif this.orderType == Order_Point then
                call dummy.point(this.x, this.y)
            endif

            if dummy.activate() then
                call SetUnitState(this.caster, UNIT_STATE_MANA, GetUnitState(this.caster, UNIT_STATE_MANA) - this.manaCost)
            endif
        endmethod

        private method checkSpell takes nothing returns boolean
            if this.orderType == Order_Target and this.mono then
                if not GetNewTarget(GetAbilityRealField(this.caster, this.abilId, this.abilLevel, ABILITY_RLF_CAST_RANGE)) then
                    return false
                endif
            endif

            if this.hero == null then
                set this.hero = this.caster
            endif

            if not AbilityChannel(this.caster, this.hero, this.target, this.x, this.y, this.abilId, this.abilLevel) then
                if GetUnitState(this.caster, UNIT_STATE_MANA) > this.manaCost then
                    call this.castSpell()
                endif
            else
                call SetUnitState(this.caster, UNIT_STATE_MANA, GetUnitState(this.caster, UNIT_STATE_MANA) - this.manaCost)
            endif

            return true
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.count > 0 then
                if this.checkSpell() then
                    set this.count = this.count - 1
                    set this.endTick = T32_Tick + MulticastInterval
                else
                    call this.stopPeriodic()
                    call this.destroy()
                    return
                endif
            endif
            
            if this.count == 0 or HasPlayerFinishedLevel(caster, GetOwningPlayer(caster)) or (not UnitAlive(this.caster)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        implement T32x

        static method create takes unit caster, unit target, integer abilId, integer abilLvl, integer abilOrder, integer orderType, real x, real y, integer count returns thistype
            local thistype this = thistype.allocate()
            local integer pid = GetPlayerId(GetOwningPlayer(caster))

            set this.caster = caster
            set this.target = target

            if PlayerHeroes[pid] != null then
                set this.hero = PlayerHeroes[pid]
            else
                set this.hero = caster
            endif

            set this.caston = null
            set this.abilId = abilId
            set this.abilLevel = abilLvl
            set this.abilOrder = abilOrder
            set this.orderType = orderType
            set this.manaCost = BlzGetAbilityManaCost(this.abilId, this.abilLevel - 1) * MulticastManaCost

            if IsAbilityMono(abilId) then
                set this.mono = true
            else
                set this.mono = false
            endif

            set this.x = x
            set this.y = y
            set this.count = count

            set this.endTick = T32_Tick + MulticastInterval
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.caster = null
            set this.target = null
            set this.hero = null

            if this.caston != null then
                call ReleaseGroup(this.caston)
                set this.caston = null
            endif
            call this.deallocate()
        endmethod
    endstruct
endlibrary
