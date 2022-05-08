library AncientBlood initializer init requires BuffSystem, CustomState, Utility

    globals
        Table AncientBloodStacks
    endglobals

    struct AncientBloodStruct extends array
        unit source
        integer hid
        integer bonus
        integer endTick
        integer primary
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
            set this.primary = GetHeroPrimaryStat(source)

            set this.source = source
            set this.hid = GetHandleId(source)

            call RegisterBuff(this.source, 'A0CI')
            if GetUnitAbilityLevel(this.source, 'A0CI') == 0 then
                call UnitAddAbility(this.source, 'A0CI')
            endif

            if primary == Stat_Strength then
                set this.bonus = R2I(GetHeroStr(source, false) * 0.01)
                call AddUnitBonus(source, BONUS_STRENGTH, this.bonus)
            elseif primary == Stat_Agility then
                set this.bonus = R2I(GetHeroAgi(source, false) * 0.01)
                call AddUnitBonus(source, BONUS_AGILITY, this.bonus)
            elseif primary == Stat_Intelligence then
                set this.bonus = R2I(GetHeroInt(source, false) * 0.01)
                call AddUnitBonus(source, BONUS_INTELLIGENCE, this.bonus)
            endif
            
            set AncientBloodStacks[hid] = AncientBloodStacks[hid] + 1

            set this.endTick = T32_Tick + R2I(15 * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set AncientBloodStacks[hid] = AncientBloodStacks[hid] - 1
            call RemoveBuff(this.source, 'A0CI')
            if primary == Stat_Strength then
                call CheckHpForReduction(this.source, this.bonus)
                call AddUnitBonus(this.source, BONUS_STRENGTH, 0 - this.bonus)
            elseif primary == Stat_Agility then
                call AddUnitBonus(this.source, BONUS_AGILITY, 0 - this.bonus)
            elseif primary == Stat_Intelligence then
                call AddUnitBonus(this.source, BONUS_INTELLIGENCE, 0 - this.bonus)
            endif
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function ActivateAncientBlood takes unit target, integer level returns nothing
        if AncientBloodStacks.integer[GetHandleId(target)] < 20 + (6 * level) then
            call AncientBloodStruct.create(target)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AncientBloodStacks = Table.create()
    endfunction
endlibrary