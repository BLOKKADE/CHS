library LightningShield requires UnitHelpers, RandomShit, SpellFormula, TempAttackCd
    struct LightningShieldStruct extends array
        unit source
        unit target
        integer level
        integer pid
        effect fx
        integer tick
        integer endTick
        boolean enabled
        
        private method damage takes nothing returns nothing
            local unit p
            set this.level = GetUnitAbilityLevel(this.source, LIGHTNING_SHIELD_ABILITY_ID)
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(this.target), GetUnitY(this.target), 150 + (10 * this.level), Player(this.pid), false, Target_Enemy)
            //call BJDebugMsg("dmg: " + I2S(GetSpellValue(LIGHTNING_SHIELD_ABILITY_ID, 0, 20, 10, this.level)) + " grp: " + I2S(BlzGroupGetSize(ENUM_GROUP)))
            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                set udg_NextDamageAbilitySource = LIGHTNING_SHIELD_ABILITY_ID
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldBuff.mdl", p, "chest"))
                call Damage.applyMagic(this.source, p, GetSpellValue(20, 10, this.level), false, DAMAGE_TYPE_MAGIC)
                call TempAbil.create(p, LIGHTNING_SHIELD_DUMMY_ABILITY_ID, 5)
                if not IsUnitType(p, UNIT_TYPE_HERO) then // for creeps and summons
                    call AttackCdStruct.createUnique(p, 0.2, 5, LIGHTNING_SHIELD_DUMMY_ABILITY_ID)
                endif
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                set this.tick = T32_Tick + 32
                call this.damage()
            endif
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, unit target, integer level returns thistype
            local thistype this = thistype.setup()
            //call BJDebugMsg("sl start")
            set this.source = source
            set this.target = target
            set this.level = level
            set this.endTick = T32_Tick + (8 * 32)
            set this.tick = T32_Tick + 32
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            set this.fx = AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldTarget.mdl", this.target, "origin")

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

    function CastLightningShield takes unit caster, unit target, integer level returns nothing
        call LightningShieldStruct.create(caster, target, level)
    endfunction
endlibrary