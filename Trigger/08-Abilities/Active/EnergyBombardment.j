library EnergyBombardment requires Utility, AbilityCooldown

    function EnergyBombardmentFilter takes RandomUnitHelper ruh, unit u returns boolean
        return DistanceBetweenUnits(ruh.filterInfo.source, u) > GetUnitTrueRange(ruh.filterInfo.source, 0) + (BlzGetUnitCollisionSize(u) / 2)
    endfunction

    struct EnergyBombardmentStruct extends array
        unit source
        integer level
        real dmgMult
        real cd
        player p
        integer tick
        integer endTick
        real currentAcd

        private method setFields takes nothing returns nothing
            //call BJDebugMsg("eb update field")
            set this.level = GetUnitAbilityLevel(this.source, ENERGY_BOMBARDMENT_ABILITY_ID)
            set dmgMult = 0.25 + (0.025 * this.level)
            set this.currentAcd = BlzGetUnitAttackCooldown(this.source, 0)
            set this.cd = this.currentAcd * (4.4 - (0.08 * this.level))
        endmethod
        
        private method damage takes nothing returns nothing
            local unit target

            call RUH.reset().doHeroPriority().checkMagicImmune().addFilter(RandomUnitFilter.EnergyBombardmentFilter, RandomUnitHelperFilterInfo.create(this.source, 0, 0, null, 0)).EnumUnits(GetUnitX(this.source), GetUnitY(this.source), 600, Target_Enemy, this.p)

            set target = RUH.GetRandomUnit(false)
            if target != null then
                //call BJDebugMsg("dist: " + R2S(DistanceBetweenUnits(this.source, target)) + ", max: " + R2S(GetUnitTrueRange(this.source, 0) + (BlzGetUnitCollisionSize(target) / 2)))
                call DummyOrder.create(this.source, GetUnitX(this.source), GetUnitY(this.source), GetUnitFacing(this.source), 3).addActiveAbility('A0DP', 1, 852662).setAbilityRealField('A0DP', ABILITY_RLF_PRIMARY_DAMAGE, GetUnitDamage(this.source, 0) * dmgMult).target(target).activate()
                call AbilStartCD(this.source, ENERGY_BOMBARDMENT_ABILITY_ID, this.cd)
                set this.tick = 0
                set target = null
            else
                set this.tick = T32_Tick + 16
            endif
        endmethod
    

        private method periodic takes nothing returns nothing
            if (BlzGetUnitAbilityCooldownRemaining(this.source, ENERGY_BOMBARDMENT_ABILITY_ID) == 0 and T32_Tick > this.tick) and (not HasPlayerFinishedLevel(this.source, this.p)) then
                if this.level != GetUnitAbilityLevel(this.source, ENERGY_BOMBARDMENT_ABILITY_ID) or this.currentAcd != BlzGetUnitAttackCooldown(this.source, 0) then
                    call this.setFields()
                endif
                call this.damage()
            endif
            if GetUnitAbilityLevel(this.source, ENERGY_BOMBARDMENT_ABILITY_ID) == 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
           // call BJDebugMsg("eb start")
            set this.source = source
            set this.tick = 0
            set this.level = 0
            set this.currentAcd = BlzGetUnitAttackCooldown(this.source, 0)
            set this.p = GetOwningPlayer(this.source)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.source = null
            set this.p = null
            //call BJDebugMsg("eb end")
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function LearnEnergyBombardment takes unit caster returns nothing
        call EnergyBombardmentStruct.create(caster)
    endfunction
endlibrary