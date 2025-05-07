library MartialTheft initializer init requires NewBonus, Utility

    globals
        Table MartialTheftBonusStruct
    endglobals

    function GetMartialTheftStruct takes integer id returns MartialTheftStruct
        return MartialTheftBonusStruct[id]
    endfunction

    struct MartialTheftStruct extends array
        implement Alloc
        
        unit source
        unit target
        integer bonus
        integer pid
        boolean enabled
        integer endTick
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, Player(this.pid)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        implement T32x

        method resetBonus takes unit target, integer amount returns nothing
            call AddUnitBonus(this.target, BONUS_DAMAGE, this.bonus)
            call AddUnitBonus(this.source, BONUS_DAMAGE, R2I(amount - this.bonus))
            set this.bonus = amount
            set this.target = target
            call AddUnitBonus(this.target, BONUS_DAMAGE, 0 - this.bonus)
        endmethod
    
        static method create takes unit source, unit target, integer amount returns thistype
            local thistype this = thistype.allocate()
            
            set this.source = source
            set this.enabled = true
            set this.endTick = T32_Tick + R2I(5 * 32)  
            set this.pid = GetPlayerId(GetOwningPlayer(source))
            call UnitAddAbility(this.source, 'A086')
            
            call this.resetBonus(target, amount)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set this.enabled = false
            call this.resetBonus(this.target, 0)
            set MartialTheftBonusStruct[GetHandleId(this.source)] = 0
            call UnitRemoveAbility(this.source, 'A086')
            set this.source = null
            set this.target = null
            //call BJDebugMsg("ba end")
            call this.deallocate()
        endmethod
    endstruct

    function CastMartialTheft takes unit caster, unit target, integer level returns nothing
        local integer hid = GetHandleId(caster)
        local integer dmgStolen = R2I(GetUnitDamage(target, 0) * (0.01 + (0.01 * level)))
        local integer currentBonus = GetMartialTheftStruct(hid).bonus

        if GetMartialTheftStruct(hid).enabled then
            if dmgStolen >= currentBonus then
                set GetMartialTheftStruct(hid).endTick = T32_Tick + R2I(5 * 32)
                call GetMartialTheftStruct(hid).resetBonus(target, dmgStolen)
            endif
        else
            set MartialTheftBonusStruct[hid] = MartialTheftStruct.create(caster, target, dmgStolen)
        endif
    endfunction

    private function init takes nothing returns nothing
        set MartialTheftBonusStruct = Table.create()
    endfunction
endlibrary