library EnergyTrap requires UnitHelpers, RandomShit, SpellFormula, KnockbackHelper
    struct EnergyTrapStruct extends array
        unit source
        real x
        real y
        integer level
        unit target
        real scale
        integer pid
        effect fx
        integer tick
        integer sizeEndTick
        integer endTick
        
        private method damageAndPull takes nothing returns nothing
            local unit p

            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                set udg_NextDamageAbilitySource = ENERGY_TRAP_ABILITY_ID
                call MoveToPoint(this.source, p, GetUnitX(this.source), GetUnitY(this.source))
                if not IsKnockedBack(p) then
                    call Lightning.unitToUnit(this.source, p, 0., 0., true, 0.8, "LEAS", 0)
                endif
                call Damage.apply(this.source, p, GetSpellValue(50, 25, this.level), false, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick < this.sizeEndTick then
                set this.scale = this.scale + 0.1
                call BlzSetSpecialEffectScale(this.fx, this.scale)
            endif
            if T32_Tick > this.sizeEndTick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                call GroupClear(ENUM_GROUP)
                call EnumTargettableUnitsInRange(ENUM_GROUP, this.x, this.y, 250, Player(pid), true, Target_Enemy)
                if BlzGroupGetSize(ENUM_GROUP) > 0 then
                    call this.damageAndPull()
                    call this.stopPeriodic()
                    call this.destroy()
                endif
            endif
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, real x, real y, integer level returns thistype
            local thistype this = thistype.setup()
            //call BJDebugMsg("sl start")
            set this.source = source
            set this.x = x
            set this.y = y
            set this.level = level
            set this.target = null
            set this.scale = 0.1
            set this.endTick = T32_Tick + (6 * 32)
            set this.sizeEndTick = T32_Tick + 32
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.fx = AddSpecialEffect("war3mapImported\\RunicAura.mdx", this.x, this.y)
            call BlzSetSpecialEffectScale(this.fx, this.scale)
            call BlzSetSpecialEffectHeight(this.fx, 25)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            set this.target = null
            call DestroyEffect(this.fx)
            set this.fx = null
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function CastEnergyTrap takes unit caster, real targetX, real targetY, integer level returns nothing
        call EnergyTrapStruct.create(caster, targetX, targetY, level)
    endfunction
endlibrary