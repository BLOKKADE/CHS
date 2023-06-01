library ArcaneAbsorptionGauntlets initializer init requires TempAbilSystem, DummyOrder, Table, UnitHelpers, DummyActiveSpell

    globals
        Table AAGStruct
    endglobals

    function GetAAGStruct takes integer id returns ArcaneAbsorptionGauntlets
        return AAGStruct[id]
    endfunction

    struct ArcaneAbsorptionGauntlets extends array
        unit target
        integer abilId
        integer bonus
        integer startTick
        integer endTick

        private method disableBonus takes nothing returns nothing
            local integer level = GetUnitAbilityLevel(this.target, this.abilId) - 1
            call BlzSetUnitAbilityManaCost(this.target, this.abilId, level, BlzGetUnitAbilityManaCost(this.target, this.abilId, level) - this.bonus)
            call RemoveLeveledBuffs(this.target, 'B030')
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or (GetUnitAbilityLevel(this.target, 'B030') == 0 and T32_Tick > this.startTick + 32) then
                call this.disableBonus()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit target, integer abilId, integer bonus, real duration returns thistype
            local thistype this = thistype.setup()
            local integer level = GetUnitAbilityLevel(this.target, this.abilId) - 1

            set this.target = target
            set this.bonus = bonus
            set this.abilId = abilId
            call BlzSetUnitAbilityManaCost(this.target, this.abilId, level, BlzGetUnitAbilityManaCost(this.target, this.abilId, level) + this.bonus)
            call DummyOrder.create(this.target, GetUnitX(this.target), GetUnitY(this.target), GetUnitFacing(this.target), 2).addActiveAbility(ARCANE_ABSORPTION_GAUNTLETS_ABILITY_ID, 1, 852189).target(this.target).activate()
            call RegisterLeveledBuff(this.target, 'B030')

            set AAGStruct[GetHandleId(this.target)] = this

            set this.startTick = T32_Tick
            set this.endTick = T32_Tick + R2I(duration * 32)
            call this.startPeriodic()
            return this
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
                call BJDebugMsg("target: " + GetUnitName(p) + "heal: " + R2S(healAmount))
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) + healAmount)
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", p, "chest"))
            endif
            set i = i + 1
        endloop
    endfunction

    function ArcaneAbsorptionGauntletsActivate takes unit u, integer abilId, integer level, unit target returns nothing
        local real multiplier = 1
        local real mana = 0
        set abilId = CheckAssociatedSpell(u, abilId)
        set mana = BlzGetUnitAbilityManaCost(u, abilId, level - 1)

        if target != null and UnitHasItemType(target, 'I06I') then
            set multiplier = 2
        endif
        
        call Heal(u, mana * multiplier)
        call BJDebugMsg("original mana cost: " + R2S(mana) + " bonus mana cost: " + R2S(mana * multiplier))
        if GetMopStruct(GetHandleId(u)) == 0 then
            call ArcaneAbsorptionGauntlets.create(target, abilId, R2I(mana * multiplier), 10)
        else
            set GetAAGStruct(GetHandleId(u)).endTick = T32_Tick + R2I(10 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AAGStruct = Table.create()
    endfunction
endlibrary