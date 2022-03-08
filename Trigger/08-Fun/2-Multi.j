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

        

        private method GetNewTarget takes real range returns boolean
            if this.caston == null then
                set this.caston = NewGroup()
                call GroupAddUnit(this.caston, this.target)
               // call BJDebugMsg("create group: " + I2S(GetHandleId(this.caston)))
            endif
            
            call RUH.reset().excludeGroup(this.caston)

            call RUH.EnumUnits(GetUnitX(this.caster), GetUnitY(this.caster), range, GetAbilityTargetType(this.abilId), GetOwningPlayer(this.caster))

            set this.target = RUH.GetRandomUnit(false)
            if this.target == null then
                //call BJDebugMsg("no valid enemy")
                return false
            else
                //call BJDebugMsg("valid enemy: " + GetUnitName(this.target) + ": " + I2S(GetHandleId(this.target)))
                call GroupAddUnit(this.caston, this.target)
                return true
            endif
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

        private method checkSpell takes nothing returns boolean
            if this.orderType == 1 and this.mono then
                //call BJDebugMsg("new trgt: " + GetUnitName(this.target) + " count: " + I2S(this.count))
                if not GetNewTarget(GetAbilityRange(this.caster, this.abilId)) then
                    //call BJDebugMsg("end")
                    return false
                endif
            endif

            if not AbilityChannel(this.caster, this.target, this.x, this.y, this.abilId, this.abilLevel) then
                call this.castSpell()
            endif

            return true
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.count > 0 then
                if this.checkSpell() then
                    set this.count = this.count - 1
                    set this.endTick = T32_Tick + MulticastInterval
                else
                    //call BJDebugMsg("stop")
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

        static method create takes unit caster, unit target, integer abilId, integer abilLvl, integer abilOrder, integer orderType, real x, real y, integer count returns thistype
            local thistype this = thistype.setup()

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
                call ReleaseGroup(this.caston)
                //call BJDebugMsg("release group" + I2S(GetHandleId(this.caston)))
                set this.caston = null
            endif
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct
endlibrary