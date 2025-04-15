library ArcaneAbsorptionGauntlets initializer init requires TempAbilSystem, DummyOrder, Table, UnitHelpers, DummySpell

    globals
        Table AAGStruct
    endglobals

    function GetAAGStruct takes integer id returns ArcaneAbsorptionGauntlets
        return AAGStruct[id]
    endfunction

    struct ArcaneAbsorptionGauntlets extends array
        unit target
        integer abilId
        boolean stop
        integer bonus
        integer level
        integer startTick
        integer endTick

        private method disableBonus takes nothing returns nothing
            local integer level = GetUnitAbilityLevel(this.target, this.abilId) - 1
            call BlzSetUnitAbilityManaCost(this.target, this.abilId, level, BlzGetUnitAbilityManaCost(this.target, this.abilId, level) - this.bonus)
            call RemoveLeveledBuffs(this.target, ARCANE_ABSORPTION_GAUNTLETS_BUFF_ID)
        endmethod
    
        private method periodic takes nothing returns nothing
            local integer lvl = GetUnitAbilityLevel(target, GetOriginalSpellIfExists(target, abilId))
            if lvl > this.level then
                set this.level = lvl
                call BlzSetUnitAbilityManaCost(this.target, this.abilId, GetUnitAbilityLevel(this.target, this.abilId) - 1, BlzGetUnitAbilityManaCost(this.target, this.abilId, GetUnitAbilityLevel(this.target, this.abilId) - 1) + this.bonus)
            endif
            if T32_Tick > this.endTick or (GetUnitAbilityLevel(this.target, ARCANE_ABSORPTION_GAUNTLETS_BUFF_ID) == 0 and T32_Tick > this.startTick + 32) or this.stop then
                call this.disableBonus()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod

        static method create takes unit target, integer abilId, integer bonus, real duration returns thistype
            local thistype this = thistype.setup()
            local integer level = GetUnitAbilityLevel(target, abilId) - 1

            set this.target = target
            set this.bonus = bonus
            set this.abilId = abilId
            set this.stop = false
            set this.level = GetUnitAbilityLevel(target, GetOriginalSpellIfExists(target, abilId))
    
            call BlzSetUnitAbilityManaCost(this.target, this.abilId, level, BlzGetUnitAbilityManaCost(this.target, this.abilId, level) + this.bonus)
            call DummyOrder.create(this.target, GetUnitX(this.target), GetUnitY(this.target), GetUnitFacing(this.target), 2).addActiveAbility(ARCANE_ABSORPTION_GAUNTLETS_ABILITY_ID, 1, 852189).setAbilityDurationFields(ARCANE_ABSORPTION_GAUNTLETS_ABILITY_ID, 30).target(this.target).activate()
            call RegisterLeveledBuff(this.target, ARCANE_ABSORPTION_GAUNTLETS_BUFF_ID)

            set AAGStruct[GetHandleId(this.target)] = this

            set this.startTick = T32_Tick
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
        endmethod

        static method createOrExtend takes unit target, integer abilId, integer bonus, real duration returns thistype
            local thistype aag = GetAAGStruct(GetHandleId(target))
            if aag == 0 then
                return ArcaneAbsorptionGauntlets.create(target, abilId, bonus, duration)
            else
                return ArcaneAbsorptionGauntlets.create(target, abilId, bonus, duration)
            endif
        endmethod
        
        method destroy takes nothing returns nothing
            set AAGStruct[GetHandleId(this.target)] = 0
            set this.target = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    private function Heal takes unit u, real healAmount returns nothing
        local unit p
        local integer i = 0
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 900, GetOwningPlayer(u), true, Target_Enemy)
        //call BJDebugMsg("sldmg")
        //call BJDebugMsg("dmg: " + I2S(GetSpellValue(50, 10, this.level)) + " grp: " + I2S(BlzGroupGetSize(ENUM_GROUP)))
        loop
            set p = BlzGroupUnitAt(ENUM_GROUP, i)
            exitwhen p == null
            if UnitHasItemType(p, 'I06I') then
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) + healAmount)
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", p, "origin"))
            endif
            set i = i + 1
        endloop
    endfunction

    function ArcaneAbsorptionGauntletsActivate takes unit u, integer abilId, unit target returns nothing
        local real multiplier = 1
        local real mana = 0
        local integer level

        set level = GetUnitAbilityLevel(u, abilId)
        set mana = BlzGetUnitAbilityManaCost(u, abilId, level - 1)

        if target != null and UnitHasItemType(target, 'I06I') then
            set multiplier = 2
        endif
        
        call Heal(u, mana)

        call ArcaneAbsorptionGauntlets.createOrExtend(u, abilId, R2I(mana * multiplier), 30)
    endfunction

    private function init takes nothing returns nothing
        set AAGStruct = Table.create()
    endfunction
endlibrary