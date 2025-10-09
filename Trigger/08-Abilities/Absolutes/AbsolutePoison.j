library AbsolutePoison initializer init requires CustomState, Table, EditAbilityInfo, DivineBubble, HpRegen

    globals
        HashTable PoisonAbilField
        //Table PoisonBonus
        Table AbsolutePoisonTable
        constant real HpReduction = 0.20
        constant real maxPercent = 1.00
    endglobals

    function GetAbsolutePoisonStruct takes unit u returns AbsolutePoisonStruct
        return AbsolutePoisonTable[GetHandleId(u)]
    endfunction

    struct AbsolutePoisonStruct extends array
        implement Alloc
        
        unit target
        unit source
        integer startTick
        integer endTick
        integer buffCount
        real reduction

        private method countBuffs takes nothing returns real
            local integer count = 0
            local integer hid = GetHandleId(this.target)
            local real regen = GetUnitPositiveHpRegen(this.target)
            local real newRegen = 0

            if GetUnitAbilityLevel(this.target, PARASITE_BUFF_ID) > 0 then
                //call BJDebugMsg("parasite buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, ACID_BOMB_BUFF_ID) > 0 then
                //call BJDebugMsg("acid bomb buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BNhs') > 0 then
                //call BJDebugMsg("Healing spray buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, SHADOW_STRIKE_BUFF_ID) > 0 then
                //call BJDebugMsg("shadow strike buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, DRUNKEN_HAZE_BUFF_ID) > 0 then
                //call BJDebugMsg("drunken haze buff")
                set count = count + 2
            endif

            if GetUnitAbilityLevel(this.target, DISEASE_BUFF_ID) > 0 then
                //call BJDebugMsg("bapl buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'B01J') > 0 then
                //call BJDebugMsg("b01j buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, DECAYING_SCYTHE_BUFF_ID) > 0 then
                //call BJDebugMsg("decaying scythe buff")
                set count = count + 3
            endif

            if GetUnitAbilityLevel(this.target, POISON_NON_STACKING_CUSTOM_BUFF_ID) > 0 then
                //call BJDebugMsg("poison non stacking buff")
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.source, NULL_VOID_ORB_BUFF_ID) > 0 then
                //call BJDebugMsg("null void orb buff")
                set count = 0
            endif
            
            set this.buffCount = count

            //call BJDebugMsg("count: " + I2S(count))

            set newRegen = (RMinBJ(count * HpReduction, maxPercent) * regen)
            //set newRegen = (count * HpReduction) * regen

            return newRegen
        endmethod
    
        private method periodic takes nothing returns nothing
            local real hp = GetUnitState(this.target, UNIT_STATE_LIFE)
            local real currentBonus = this.countBuffs()
            //call BJDebugMsg("regen: " + R2SW(BlzGetUnitRealField(this.target, ConvertUnitRealField('uhpr')) + GetUnitBonusReal(this.target, BONUS_HEALTH_REGEN) + (GetHeroStr(this.target, true) * 0.075) + GetSpellValue(0, 5, GetUnitAbilityLevel(this.target, UNHOLY_AURA_ABILITY_ID)) + (GetUnitItemTypeCount(this.target, 'I04N') * 1500), 1, 1))
            if this.reduction != currentBonus then
                //call BJDebugMsg("ap old: " + R2S(this.reduction) + " new: " + R2S(currentBonus))
                //call BJDebugMsg("absolute poison: " + I2S(GetHandleId(this.target)) + " : " + GetUnitName(this.target))
                //call BJDebugMsg("old red:" + R2S(this.reduction) + " new red: " + R2S(currentBonus))
                call AddUnitCustomState(this.target, BONUS_NEGATIVEHPREGEN, 0 - this.reduction + currentBonus)
                //call AddUnitBonusReal(this.target, BONUS_HEALTH_REGEN, this.reduction)
                //call BlzSetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE) + this.reduction)
                set this.reduction = currentBonus
                //call AddUnitBonusReal(this.target, BONUS_HEALTH_REGEN, 0 - this.reduction)
                //call BlzSetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE) - this.reduction)
            endif
            if T32_Tick > this.endTick or (T32_Tick - this.startTick > 32 and this.buffCount == 0) or IsUnitDivineBubbled(this.target) or IsUnitSpellTargetCheck(this.target, GetOwningPlayer(this.source)) == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        implement T32x

        static method create takes unit source, unit target returns thistype
            local thistype this = thistype.allocate()
            set this.target = target
            set this.source = source
            set this.reduction = 0
            set this.buffCount = 0
            //call BJDebugMsg("create abs psn" + GetUnitName(this.target))

            set this.endTick = T32_Tick + R2I(30 * 32)   
            set this.startTick = T32_Tick
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set AbsolutePoisonTable[GetHandleId(this.target)] = 0
            //call BJDebugMsg("abs psn disable: " + GetUnitName(this.target))
            call AddUnitCustomState(this.target, BONUS_NEGATIVEHPREGEN, 0 - this.reduction)
            //call BlzSetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, BlzGetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE) + this.reduction)
            set this.target = null
            set this.source = null
            call this.deallocate()
        endmethod
    endstruct

    function UpdateAbilityField takes unit u, integer abilId, abilityreallevelfield arlf, integer level, real bonus returns nothing
        if PoisonAbilField[GetHandleId(arlf)].real[level] == 0 then
            set PoisonAbilField[GetHandleId(arlf)].real[level] = BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), arlf, level - 1)
        endif
        call SetAbilityRealField(u, abilId, level, arlf, PoisonAbilField[GetHandleId(arlf)].real[level] * bonus)
        //call BJDebugMsg(GetObjectName(abilId) + ": " + R2S(PoisonAbilField[GetHandleId(arlf)].real[level] * bonus) + ": " + R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), arlf, level - 1)))
    endfunction

    function PoisonSpellCast takes unit caster, unit target returns nothing
        if GetAbsolutePoisonStruct(target) == 0 then
            set AbsolutePoisonTable[GetHandleId(target)] = AbsolutePoisonStruct.create(caster, target)
        endif
    endfunction

    private function init takes nothing returns nothing
        set PoisonAbilField = HashTable.create()
        //set PoisonBonus = Table.create()
        set AbsolutePoisonTable = Table.create()
    endfunction
endlibrary