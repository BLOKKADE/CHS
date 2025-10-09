library AbsoluteArcane requires CustomState, DivineBubble
    
    struct AbsoluteArcaneStruct extends array
        implement Alloc
        
        unit source
        unit target
        integer endTick
        real bonus
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or IsUnitDivineBubbled(this.target) or IsUnitSpellTargetCheck(this.target, GetOwningPlayer(this.source)) == false or GetUnitAbilityLevel(this.source, NULL_VOID_ORB_BUFF_ID) > 0  then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 

        implement T32x

        static method create takes unit source, unit target returns thistype
            local thistype this = thistype.allocate()
            set this.source = source
            set this.target = target
            if IsUnitType(this.target, UNIT_TYPE_HERO) then
                set this.bonus = 0.5 * GetUnitElementCount(this.source, Element_Arcane)
            else
                set this.bonus = 0.05 * GetUnitElementCount(this.source, Element_Arcane)
            endif
            if GetUnitCustomState(this.target, BONUS_MAGICPOW) - this.bonus > 0 then
                call AddUnitCustomState(this.source, BONUS_MAGICPOW, this.bonus)
                call AddUnitCustomState(this.target, BONUS_MAGICPOW, 0 - this.bonus)
            else
                set this.bonus = 0
            endif

            set this.endTick = T32_Tick + R2I(10*32)   
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call AddUnitCustomState(this.source, BONUS_MAGICPOW, 0 - this.bonus)
            call AddUnitCustomState(this.target, BONUS_MAGICPOW, this.bonus)
            set this.source = null
            set this.target = null
            call this.deallocate()
        endmethod
    endstruct

    function AbsoluteArcaneDrain takes unit caster returns nothing
        local unit p = null
        call GroupClear(ENUM_GROUP)

        call GroupEnumUnitsInArea(ENUM_GROUP, GetUnitX(caster), GetUnitY(caster), 400, null)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            if IsUnitEnemy(p, GetOwningPlayer(caster)) and IsUnitSpellTargetCheck(p, GetOwningPlayer(caster)) then
                call AbsoluteArcaneStruct.create(caster, p)
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary