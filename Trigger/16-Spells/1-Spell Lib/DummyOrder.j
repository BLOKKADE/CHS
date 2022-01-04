library DummyOrder initializer Init requires TimerUtils, EditAbilityInfo, DummyRecycler, DummyId
 
    //============================================================================

    globals
        Table DummyInfo
        Table DummyAbilitySource
    endglobals

    function GetDummyOrder takes integer id returns DummyOrder
        return id
    endfunction

    function GetDummyOrderSource takes integer id returns unit
        return GetDummyOrder(id).source
    endfunction

    struct DummyOrder extends array
        unit dummy
        unit source
        integer pid
        //conditionfunc callback
        integer abil
        integer order
        integer endTick
        integer orderType
        boolean stopDummy
        boolean destroyDummy

        unit targetUnit

        real targetX
        real targetY
        
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        method stop takes nothing returns nothing
            set this.stopDummy = true
        endmethod
        
        /*
        method setOnHit takes conditionfunc callback, boolean disableDamage returns thistype
            set this.callback = callback
            set DummyInfo[GetUnitId(this.dummy)].boolean[2] = true
            set DummyInfo[GetUnitId(this.dummy)].boolean[3] = disableDamage
            return this
        endmethod

        method onHit takes unit target returns nothing
            if this.callback != null then
                call EvaluateUnitFunction(target, this.callback)
            endif
        endmethod
        */
        method instant takes nothing returns thistype
            set this.orderType = 1
            //call BJDebugMsg("dummy instant order")
            return this
        endmethod

        method target takes unit target returns thistype
            set this.orderType = 2
            set this.targetUnit = target
            //call BJDebugMsg("dummy target order")
            return this
        endmethod

        method point takes real targetX, real targetY returns thistype
            set this.orderType = 3
            set this.targetX = targetX
            set this.targetY = targetY
            //call BJDebugMsg("dummy point order")
            return this
        endmethod

        method setAbilityIntegerField takes integer abilityId, abilityintegerlevelfield field, integer value returns thistype
            call SetAbilityIntegerField(this.dummy, abilityId, GetUnitAbilityLevel(this.dummy, abilityId), field, value)
            //call BJDebugMsg("dummy set int field")
            return this
        endmethod 

        method setAbilityRealField takes integer abilityId, abilityreallevelfield field, real value returns thistype
            call SetAbilityRealField(this.dummy, abilityId, GetUnitAbilityLevel(this.dummy, abilityId), field, value)
            return this
        endmethod 

        method addActiveAbility takes integer abilityId, integer level, integer order returns thistype
            call UnitAddAbility(dummy, abilityId)
            call UnitMakeAbilityPermanent(this.dummy, true, abilityId)
            call SetUnitAbilityLevel(dummy, abilityId, level)
            set this.order = order
            set this.abil = abilityId
            set DummyAbilitySource[GetDummyId(this.dummy)] = abilityId

            //call BJDebugMsg("dummy added active")
            return this
        endmethod

        method addPassiveAbility takes integer abilityId, integer level returns thistype
            call UnitAddAbility(dummy, abilityId)
            call UnitMakeAbilityPermanent(this.dummy, true, abilityId)
            call SetUnitAbilityLevel(dummy, abilityId, level)
            
            //call BJDebugMsg("dummy added passive")
            return this
        endmethod

        method periodic takes nothing returns nothing
            if this.destroyDummy then
                if T32_Tick >= this.endTick then
                    call this.stopPeriodic()
                    call this.destroy()
                endif
            else
                if T32_Tick >= this.endTick or this.stopDummy or GetUnitCurrentOrder(this.dummy) == 0 then
                    set this.destroyDummy = true
                    set this.endTick = T32_Tick + (5 * 32)
                    call this.resetDummy()
                endif
            endif
        endmethod
        implement T32x

        method activate takes nothing returns boolean
            local trigger trg = CreateTrigger()
            local boolean success = false
            if this.orderType == 1 then //instant
                set success = IssueImmediateOrderById(this.dummy, this.order) 
            elseif this.orderType == 2 then //target
                if not IssueTargetOrderById(this.dummy, this.order, this.targetUnit) then
                    set success = IssueImmediateOrderById(this.dummy, this.order)
                else
                    set success = true
                endif
            elseif this.orderType == 3 then //point
                //call BJDebugMsg("dummy: " + GetUnitName(this.dummy) + "ordr: " + I2S(this.order) + " x: " + R2S(this.targetX) + " y: " + R2S(this.targetY))
                set success = IssuePointOrderById(this.dummy, this.order, this.targetX, this.targetY)
            endif
            //call BJDebugMsg("ordered dummy, started timer")
            set this.stopDummy = false
            call this.startPeriodic()
            return success
        endmethod

        /*
        method statBased takes nothing returns thistype
            set DummyInfo[GetUnitId(this.dummy)].boolean[1] = true
            return this
        endmethod
        */
        
        static method create takes unit source, real x, real y, real facing, real duration returns thistype
            local thistype this
            local player p = GetOwningPlayer(source)

            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.dummy = GetRecycledDummyAnyAngle(x, y, 0.) 
            call SetDummyId(this.dummy)
            call PauseUnit(this.dummy, false)
            call BlzSetUnitFacingEx(this.dummy, facing)
            set DummyInfo[GetDummyId(this.dummy)] = this
            call SetUnitOwner(this.dummy, p, true)
            set this.pid = GetPlayerId(p)
            set this.source = source
            set this.destroyDummy = false
            //set DummyInfo[GetUnitId(this.dummy)].boolean[1] = false
            set this.endTick = T32_Tick + R2I((duration * 32))
            //call BJDebugMsg("created dummy")
            return this
        endmethod

        method resetDummy takes nothing returns nothing
            set DummyInfo[GetHandleId(this.dummy)] = 0
            call IssueImmediateOrderById(this.dummy, 851972)
        endmethod
        
        method destroy takes nothing returns nothing
            //call UnitRemoveAbility(this.dummy, this.abil)

            
            //set DummyInfo[GetUnitId(this.dummy)].boolean[1] = false
            ///set DummyInfo[GetUnitId(this.dummy)].boolean[2] = false
            //set DummyInfo[GetUnitId(this.dummy)].boolean[3] = false

            call BlzSetUnitFacingEx(this.dummy, 0)
            call RecycleDummy(this.dummy) 
            //call RemoveUnit(this.dummy)
            //set this.callback = null
            set this.dummy = null
            set this.source = null
            set this.targetUnit = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    endstruct

    private function Init takes nothing returns nothing
        set DummyInfo = Table.create()
        set DummyAbilitySource = Table.create()
    endfunction
endlibrary