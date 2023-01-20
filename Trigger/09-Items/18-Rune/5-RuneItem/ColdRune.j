library ColdRune initializer init requires AreaDamage, AllowCasting

    globals
        HashTable ColdRuneDmgBonus
        Table UnitColdRuneDmgBonus
    endglobals

    struct ColdRuneStruct extends array
        unit source
        integer damageTick
        integer endTick
        integer pid
        real damage
        effect auraFx
        real x
        real y
        group affectedUnits

        private method resetDamageBonus takes nothing returns nothing
            local integer i = 0
            local unit p = null
            local integer size = BlzGroupGetSize(this.affectedUnits)

            loop
                set p = BlzGroupUnitAt(affectedUnits, i)
                exitwhen i > size or p == null
                if not IsUnitInGroup(p, ENUM_GROUP) then
                    call GroupRemoveUnit(this.affectedUnits, p)
                    set UnitColdRuneDmgBonus.real[GetHandleId(p)] = UnitColdRuneDmgBonus.real[GetHandleId(p)] - ColdRuneDmgBonus[this].real[GetHandleId(p)]
                    set ColdRuneDmgBonus[this].real[GetHandleId(p)] = 0
                    // call BJDebugMsg("reset cr: " + I2S(this) + ": " + GetUnitName(p) + ", u: " + R2S(UnitColdRuneDmgBonus.real[GetHandleId(p)]) + ", crb: " + R2S(ColdRuneDmgBonus[this].real[GetHandleId(p)]))
                endif

                set i = i + 1
            endloop

            set p = null
        endmethod

        private method doDamage takes nothing returns nothing
            local unit p

            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, this.x, this.y, 350, Player(this.pid), false, Target_Enemy)

            // call BJDebugMsg("size: " + I2S(BlzGroupGetSize(this.affectedUnits)))
            if BlzGroupGetSize(this.affectedUnits) > 0 then
                call this.resetDamageBonus()
            endif

            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                call GroupAddUnit(affectedUnits, p)
                set udg_NextDamageAbilitySource = 'I0D9'
                set ColdRuneDmgBonus[this].real[GetHandleId(p)] = ColdRuneDmgBonus[this].real[GetHandleId(p)] + 0.1
                set UnitColdRuneDmgBonus.real[GetHandleId(p)] = UnitColdRuneDmgBonus.real[GetHandleId(p)] + 0.1
                // call BJDebugMsg("cr: " + I2S(this) + " add: " + GetUnitName(p) + ", u: " + R2S(UnitColdRuneDmgBonus.real[GetHandleId(p)]) + ", crb: " + R2S(ColdRuneDmgBonus[this].real[GetHandleId(p)]))
                call Damage.apply(this.source, p, this.damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, WEAPON_TYPE_WHOKNOWS)
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop
        endmethod

        private method periodic takes nothing returns nothing
                if T32_Tick > this.damageTick then
                    set this.damageTick = T32_Tick + 32
                    call this.doDamage()
                endif
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, Player(this.pid)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, real x, real y, real runePower returns thistype
            local thistype this = thistype.setup()
           // call BJDebugMsg("sl start")
            set this.source = source
            set this.endTick = T32_Tick + (10 * 32)
            set this.damageTick = T32_Tick
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.x = x
            set this.y = y
            set this.damage = 300 * runePower
            set this.auraFx = AddLocalizedSpecialEffect("war3mapImported\\WaterWaveAura_noTC.mdx", this.x, this.y)
            set this.affectedUnits = NewGroup()
            call BlzSetSpecialEffectScale(this.auraFx, 2.5)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            //call BJDebugMsg("sl end")

            call GroupClear(ENUM_GROUP)
            call this.resetDamageBonus()
            call ColdRuneDmgBonus[this].flush()

            call ReleaseGroup(this.affectedUnits)
            set this.affectedUnits = null

            call DestroyEffect(this.auraFx)
            set this.auraFx = null
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function UseColdRune takes nothing returns boolean
        call ColdRuneStruct.create(GLOB_RUNE_U, GetUnitX(GLOB_RUNE_U), GetUnitY(GLOB_RUNE_U), GLOB_RUNE_POWER)
        return false
    endfunction

    private function init takes nothing returns nothing
        set ColdRuneDmgBonus = HashTable.create()
        set UnitColdRuneDmgBonus = Table.create()
    endfunction
endlibrary