library LightningShield
    struct LightningShieldStruct extends array
        unit source
        unit target
        integer level
        integer pid
        effect fx
        integer tick
        boolean enabled
        
        private method damage takes nothing returns nothing
            local unit p
            set this.level = GetUnitAbilityLevel(this.source, IMMOLATION_ABILITY_ID)
            call BJDebugMsg("dmg")
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(this.target), GetUnitY(this.target), 150 + (10 * this.level), Player(this.pid), false, Target_Enemy)

            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                set udg_NextDamageAbilitySource = LIGHTNING_SHIELD_ABILITY_ID
                call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\Orc\\LightningShield\\LightningShieldBuff.mdl", p, "origin"))
                call Damage.applySpell(this.source, p, GetSpellValue(LIGHTNING_SHIELD_ABILITY_ID, 0, 20, 10, this.level), DAMAGE_TYPE_MAGIC)
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                set this.tick = T32_Tick + 32
                call this.damage()
            endif
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.target, LIGHTNING_SHIELD_BUFF_ID) == 0 then
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
            set this.fx = AddSpecialEffectTarget("Abilities\Spells\Orc\LightningShield\LightningShieldTarget.mdl", this.target, "origin")

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call DestroyEffect(this.fx)
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function CastLightningShield takes unit caster, unit target, integer level returns nothing
        call LightningShieldStruct.create(this.caster, this.target, this.level)
    endfunction
endlibrary