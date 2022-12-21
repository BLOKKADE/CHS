library LastBreath initializer init requires AbilityCooldownBonusPerUse, AbilityCooldown
    globals
        Table LastBreaths
    endglobals

    function GetLastBreath takes integer id returns LastBreath
        return LastBreaths[id]
    endfunction

    struct LastBreath extends array
        unit source
        unit killer
        integer endTick
        player p

        private method kill takes nothing returns nothing
            set udg_NextDamageType = DamageType_Onhit
            call Damage.apply(this.killer, this.source, 999999999, false, false, ATTACK_TYPE_CHAOS, DAMAGE_TYPE_ENHANCED, WEAPON_TYPE_WHOKNOWS)
        endmethod
    
        private method periodic takes nothing returns nothing
            if GetUnitAbilityLevel(this.source, 'A08B') == 0 then
                call SetUnitState(source, UNIT_STATE_LIFE, 1)
                call this.stopPeriodic()
                call this.destroy()
            elseif T32_Tick > this.endTick or HasPlayerFinishedLevel(this.source, this.p) then
                call this.stopPeriodic()
                call this.destroy()
            else
                call SetUnitState(source, UNIT_STATE_LIFE, 1)
            endif
        endmethod  
    
        static method create takes unit source, unit killer, real duration returns thistype
            local thistype this = thistype.setup()
            local ability abil = BlzGetUnitAbility(source, LAST_BREATHS_ABILITY_ID)
            set this.source = source
            set this.killer = killer
            set this.p = GetOwningPlayer(this.source)

            call UnitAddAbility(this.source, 'A08B')
            call AbilStartCD(this.source, LAST_BREATHS_ABILITY_ID, 60 + GetAbilityCooldownBonus(abil))
            call SetAbilityCooldownBonus(abil, 5)
            set LastBreaths[GetHandleId(this.source)] = this

            set this.endTick = T32_Tick + R2I(duration * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call UnitRemoveAbility(this.source, 'A08B')
            call UnitRemoveAbility(this.source, 'B01D')

            set LastBreaths[GetHandleId(this.source)] = 0
            call this.kill()
            set this.source = null
            set this.killer = null
            set this.p = null
            //call BJDebugMsg("db end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function ActivateLastBreath takes unit u, unit killer, integer level returns nothing
        local integer hid = GetHandleId(u)
        set udg_LethalDamageHP = 1
        if GetLastBreath(hid) == 0 then
            call LastBreath.create(u, killer, 0.8 + (0.2 * level))
        else
            set GetLastBreath(hid).endTick = T32_Tick + R2I(32 * (0.8 + (0.2 * level)))
        endif
    endfunction

    private function init takes nothing returns nothing
        set LastBreaths = Table.create()
    endfunction
endlibrary
