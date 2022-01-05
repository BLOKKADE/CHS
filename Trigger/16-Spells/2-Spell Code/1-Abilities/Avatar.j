library Avatar initializer init requires NewBonus, Utility

    globals
        Table AvatarBonus
    endglobals

    function GetAvatar takes integer id returns AvatarStruct
        return AvatarBonus[id]
    endfunction

    struct AvatarStruct extends array
        unit source
        integer endTick
        integer level
        boolean enabled
        integer damageBonus
        real armorBonus
        integer hpBonus
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        method removeBonuses takes nothing returns nothing
            call UnitRemoveAbility(this.source, 'A0AD')
            call AddUnitBonus(this.source, BONUS_DAMAGE, 0 - this.damageBonus)
            call BlzSetUnitArmor(this.source, BlzGetUnitArmor(this.source) - this.armorBonus)
            call BlzSetUnitMaxHP(this.source, BlzGetUnitMaxHP(this.source) - this.hpBonus)
        endmethod

        method setBonuses takes integer level returns nothing
            set this.level = level
            set this.damageBonus = 0 - 50 + (80 * this.level)
            set this.armorBonus = 20 * this.level
            set this.hpBonus = 400 * this.level
        endmethod
        
        method updateBonuses takes nothing returns nothing
            call UnitAddAbility(this.source, 'A0AD')
            call AddUnitBonus(this.source, BONUS_DAMAGE, this.damageBonus)
            call BlzSetUnitArmor(this.source, BlzGetUnitArmor(this.source) + this.armorBonus)
            call BlzSetUnitMaxHP(this.source, BlzGetUnitMaxHP(this.source) + this.hpBonus)
            call CalculateNewCurrentHP(this.source, this.hpBonus)
        endmethod
    
        static method create takes unit source, integer level returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            set this.source = source
            set this.level = level
            set this.damageBonus = 0 - 50 + (80 * level)
            set this.armorBonus = 20 * level
            set this.hpBonus = 400 * level
            call DestroyEffect(AddSpecialEffect("Abilities\\Spells\\Human\\Avatar\\AvatarCaster.mdl", GetUnitX(this.source), GetUnitY(this.source)))
            call this.updateBonuses()
            set this.enabled = true
            set this.endTick = T32_Tick + R2I(6.5 * 32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.removeBonuses()
            set this.enabled = false
            set AvatarBonus[GetHandleId(this.source)] = 0
            set this.source = null
            //call BJDebugMsg("db end")
            //call BJDebugMsg("ms end: " + I2S(this.bonus))
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function CastAvatar takes unit caster, integer level returns nothing
        if GetAvatar(GetHandleId(caster)) == 0 then
            //call BJDebugMsg("midas power:" + R2S(power) + " abilpower: " + R2S(abilPower) +" gold: " + I2S((499 + (26 * level))) + " total: " + I2S(R2I((499 + (26 * level)) * power)))
            set AvatarBonus[GetHandleId(caster)] = AvatarStruct.create(caster, level)
        else
            call GetAvatar(GetHandleId(caster)).removeBonuses()
            call GetAvatar(GetHandleId(caster)).setBonuses(level)
            call GetAvatar(GetHandleId(caster)).updateBonuses()
            set GetAvatar(GetHandleId(caster)).endTick = T32_Tick + R2I(6.5 * 32)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AvatarBonus = Table.create()
    endfunction
endlibrary