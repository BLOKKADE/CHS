library Fog requires NewBonus, Utility, UnitHelpers
    struct Fog extends array
        unit source
        real x
        real y
        group trappedUnits
        integer pid
        integer endTick
        integer tick

        private method StopTrappedUnits takes nothing returns nothing
            local unit p
            local integer i = 0
            local real angle

            loop
                set p = BlzGroupUnitAt(this.trappedUnits, i)
                exitwhen p == null
                if GetUnitAbilityLevel(p, CLOUD_BUFF_ID) == 1 and CalculateDistance(this.x, GetUnitX(p), this.y, GetUnitY(p)) > 400 then
                    set angle = GetAngleToTargetPoint(this.x, GetUnitX(p), this.y, GetUnitY(p))
                    call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, GetUnitX(p), GetUnitY(p)))

                    call SetUnitX(p, CalcX(this.x, angle, 400))
                    call SetUnitY(p, CalcY(this.y, angle, 400))

                    call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, GetUnitX(p), GetUnitY(p)))
                endif
                set i = i + 1
            endloop

            set p = null
        endmethod

        private method updateTrappedUnits takes nothing returns nothing
            local unit p
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, this.x, this.y, 400, GetOwningPlayer(this.source), false, Target_Enemy)
            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                if GetUnitAbilityLevel(p, CLOUD_BUFF_ID) == 1 then
                    call GroupAddUnit(this.trappedUnits, p)
                endif
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop

            set p = null
        endmethod
    
        private method periodic takes nothing returns nothing
            call this.StopTrappedUnits()
            set this.tick = this.tick + 1
            if this.tick >= 16 then
                set this.tick = 0
                call this.updateTrappedUnits()
            endif
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, Player(this.pid)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        private method createDummy takes real duration returns nothing
            local DummyOrder dummy = DummyOrder.create(this.source, this.x, this.y, 0, duration)
            call dummy.addActiveAbility(FOG_DUMMY_ABILITY_ID, 1, 852473)
            call dummy.setAbilityRealField(FOG_DUMMY_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, duration)
            call dummy.point(this.x, this.y).activate()
        endmethod

        static method create takes unit source, real x, real y, real duration returns thistype
            local thistype this = thistype.setup()
            
            set this.source = source
            set this.endTick = T32_Tick + R2I(duration * 32)
            set this.trappedUnits = NewGroup()
            set this.pid = GetPlayerId(GetOwningPlayer(source))
            set this.x = x
            set this.y = y

            call this.createDummy(duration)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call GroupClear(this.trappedUnits)
            call ReleaseGroup(this.trappedUnits)
            set this.source = null
            set this.trappedUnits = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function CastFog takes unit caster, real targetX, real targetY, integer level returns nothing
        call Fog.create(caster, targetX, targetY, (5.6 + 0.4 * level))
    endfunction
endlibrary