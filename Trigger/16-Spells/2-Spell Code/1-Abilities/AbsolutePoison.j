library AbsolutePoison initializer init requires CustomState, Table, EditAbilityInfo, RandomShit, DivineBubble

    globals
        HashTable PoisonAbilField
        Table PoisonBonus
        Table AbsolutePoisonTable
        constant real HpReduction = 0.12
    endglobals

    function GetAbsolutePoisonStruct takes unit u returns AbsolutePoisonStruct
        return AbsolutePoisonTable[GetHandleId(u)]
    endfunction

    struct AbsolutePoisonStruct extends array
        unit target
        unit source
        integer startTick
        integer endTick
        integer buffCount
        real reduction
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method countBuffs takes nothing returns real
            local integer count = 0
            local real regen = BlzGetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE)
            if GetUnitAbilityLevel(this.target, 'BNpa') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BNab') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BNhs') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BEsh') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BNdh') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'BNdh') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'B01J') > 0 then
                set count = count + 1
            endif

            if GetUnitAbilityLevel(this.target, 'B015') > 0 then
                set count = count + 1
            endif
            
            set this.buffCount = count
            return regen + this.reduction - ((count * 0.12) * regen)
        endmethod
    
        private method periodic takes nothing returns nothing
            local real hp = GetUnitState(this.target, UNIT_STATE_LIFE)
            local real currentBonus = this.countBuffs()
            if reduction != currentBonus then
                set this.reduction = currentBonus
                call BlzSetUnitRealField(this.target, UNIT_RF_HIT_POINTS_REGENERATION_RATE, currentBonus)
            endif
            if T32_Tick > this.endTick or (T32_Tick - this.startTick > 32 and this.buffCount == 0) or IsUnitDivineBubbled(this.target) or IsUnitSpellTargetCheck(this.target, GetOwningPlayer(this.source)) == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        static method create takes unit source, unit target returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif
            set this.target = target
            set this.source = source
            set this.reduction = 0
            set this.buffCount = 0

            set this.endTick = T32_Tick + R2I(30*32)   
            set this.startTick = T32_Tick
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set AbsolutePoisonTable[GetHandleId(this.target)] = 0
            set this.target = null
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function UpdateAbilityField takes unit u, integer abilId, abilityreallevelfield arlf, integer level, real bonus returns nothing
        call BJDebugMsg("uaf: " + R2S(bonus))
        if PoisonAbilField[GetHandleId(arlf)].real[level] == 0 then
            set PoisonAbilField[GetHandleId(arlf)].real[level] = BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), arlf, level - 1)
        endif
        call SetAbilityRealField(u, abilId, level, arlf, PoisonAbilField[GetHandleId(arlf)].real[level] * bonus)
        call BJDebugMsg(GetObjectName(abilId) + ": " + R2S(PoisonAbilField[GetHandleId(arlf)].real[level] * bonus) + ": " + R2S(BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilId), arlf, level - 1)))
    endfunction

    function PoisonSpellCast takes unit caster, unit target returns nothing
        if GetAbsolutePoisonStruct(target) == 0 then
            set AbsolutePoisonTable[GetHandleId(target)] = AbsolutePoisonStruct.create(caster, target)
        endif
    endfunction

    function AbsolutePoisonLearned takes unit u returns nothing
        local integer poisonLevel = GetUnitAbilityLevel(u, 'A0AC')
        local real bonus = 1 + ((poisonLevel * 0.01) * GetClassUnitSpell(u, Element_Poison))
        local integer abilId = 0
        local integer abilLevel = 0

        set PoisonBonus.real[GetHandleId(u)] = bonus
        call BJDebugMsg("hello?")
        //Shadow Strike
        set abilId = 'AEsh'
        set abilLevel = GetUnitAbilityLevel(u, abilId)
        if abilLevel > 0 then
            call UpdateAbilityField(u, abilId, ABILITY_RLF_DECAYING_DAMAGE, abilLevel, bonus)
            call UpdateAbilityField(u, abilId, ABILITY_RLF_INITIAL_DAMAGE_ESH5, abilLevel, bonus)
        endif

        //Acid Bomb
        set abilId = 'ANab'
        set abilLevel = GetUnitAbilityLevel(u, abilId)
        if abilLevel > 0 then
            call UpdateAbilityField(u, abilId, ABILITY_RLF_PRIMARY_DAMAGE, abilLevel, bonus)
            call UpdateAbilityField(u, abilId, ABILITY_RLF_SECONDARY_DAMAGE, abilLevel, bonus)
        endif

        //Acid Spray
        set abilId = 'ANhs'
        set abilLevel = GetUnitAbilityLevel(u, abilId)
        if abilLevel > 0 then
            call UpdateAbilityField(u, abilId, ABILITY_RLF_DAMAGE_AMOUNT_NCS1, abilLevel, bonus)
            call UpdateAbilityField(u, abilId, ABILITY_RLF_MAX_DAMAGE_NCS4, abilLevel, bonus)
        endif

        //Parasite
        set abilId = 'ANpa'
        set abilLevel = GetUnitAbilityLevel(u, abilId)
        if abilLevel > 0 then
            call UpdateAbilityField(u, abilId, ABILITY_RLF_DAMAGE_PER_SECOND_POI1, abilLevel, bonus)
        endif
        call BJDebugMsg("fin?")
    endfunction

    private function init takes nothing returns nothing
        set PoisonAbilField = HashTable.create()
        set PoisonBonus = Table.create()
        set AbsolutePoisonTable = Table.create()
    endfunction
endlibrary