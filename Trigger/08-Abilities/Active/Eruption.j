library Eruption requires UnitHelpers, RandomShit, SpellFormula
    struct EruptionStruct extends array
        unit source
        integer level
        integer pid
        integer maxUnits
        effect fx
        integer tick
        integer endTick
        real x
        real y
        
        private method damage takes nothing returns nothing
            local unit p
            local integer i = 0
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, this.x, this.y, 600, Player(this.pid), false, Target_Enemy)
            //call BJDebugMsg("sldmg")
            //call BJDebugMsg("dmg: " + I2S(GetSpellValue(50, 10, this.level)) + " grp: " + I2S(BlzGroupGetSize(ENUM_GROUP)))
            loop
                set p = BlzGroupUnitAt(ENUM_GROUP, GetRandomInt(0, BlzGroupGetSize(ENUM_GROUP)))
                exitwhen i == maxUnits
                if p != null and GetUnitAbilityLevel(p, ERUPTION_IMMUNE_BUFF_ID) == 0 then
                    set udg_NextDamageAbilitySource = ERUPTION_ABILITY_ID
                    //call BJDebugMsg("DMG: " + I2S(GetHandleId(p)))
                    call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIfb\\AIfbSpecialArt.mdl", p, "chest"))
                    call Damage.applyMagic(this.source, p, GetSpellValue(50, 10, this.level), false, DAMAGE_TYPE_MAGIC)
                    call DummyOrder.create(this.source, GetUnitX(p), GetUnitY(p), GetUnitFacing(p), 2).addActiveAbility(STUN_ABILITY_ID, 1, 852095).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, 0.5).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_HERO, 0.5).target(p).activate()
                    call TempAbil.create(p, ERUPTION_IMMUNE_ABILITY_ID, 1)
                    call GroupRemoveUnit(ENUM_GROUP, p)
                endif
                set i = i + 1
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                set this.tick = T32_Tick + 16
                call this.damage()
            endif
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, real x, real y, integer level returns thistype
            local thistype this = thistype.setup()
           // call BJDebugMsg("sl start")
            set this.source = source
            set this.endTick = T32_Tick + (12 * 32)
            set this.tick = T32_Tick + 16
            set this.level = level
            set this.x = x
            set this.y = y
            set this.maxUnits = 3
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.fx = AddLocalizedSpecialEffect("Abilities\\Spells\\Orc\\EarthQuake\\EarthQuakeTarget.mdl", this.x, this.y)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            //call BJDebugMsg("sl end")
            call DestroyEffect(this.fx)
            set this.fx = null
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function CastEruption takes unit caster, real x, real y, integer level returns nothing
        call EruptionStruct.create(caster, x, y, level)
    endfunction
endlibrary