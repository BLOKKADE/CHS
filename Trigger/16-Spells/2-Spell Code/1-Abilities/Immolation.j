library Immolation initializer init requires ToggleAbility
    globals
        Table ImmolationTable
    endglobals

    function GetImmolationStruct takes integer id returns ImmolationStruct
        return ImmolationTable[id]
    endfunction

    struct ImmolationStruct extends array
        unit source
        integer level
        real area
        integer pid
        effect fx
        integer tick
        boolean enabled

        method enable takes nothing returns nothing
            set this.fx = AddSpecialEffectTarget("Abilities\\Spells\\NightElf\\Immolation\\ImmolationTarget.mdl", this.source, "origin")
            set this.enabled = true
            call BJDebugMsg("enabled")
            set this.level = GetUnitAbilityLevel(this.source, IMMOLATION_ABILITY_ID)
            set this.tick = T32_Tick + 32
            call ToggleAbility(this.source, IMMOLATION_ABILITY_ID, this.level)
            call this.startPeriodic()
        endmethod

        method disable takes nothing returns nothing
            call BJDebugMsg("disabled")
            call this.stopPeriodic()
            set this.enabled = false
            call ToggleAbility(this.source, IMMOLATION_ABILITY_ID, this.level)
            call DestroyEffect(this.fx)
        endmethod
        
        private method damage takes nothing returns nothing
            local unit p
            set this.level = GetUnitAbilityLevel(this.source, IMMOLATION_ABILITY_ID)
            call BJDebugMsg("dmg")
            call GroupClear(ENUM_GROUP)
            call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(this.source), GetUnitY(this.source), 245 + (5 * this.level), Player(pid), false, Target_Enemy)
            call SetUnitState(this.source, UNIT_STATE_MANA, GetUnitState(this.source, UNIT_STATE_MANA) - GetSpellValue(5, 1, this.level))
            loop
                set p = FirstOfGroup(ENUM_GROUP)
                exitwhen p == null
                set udg_NextDamageAbilitySource = IMMOLATION_ABILITY_ID
                call DestroyEffect(AddSpecialEffectTargetFix("Abilities\\Spells\\NightElf\\Immolation\\ImmolationDamage.mdl", p, "head"))
                call Damage.applyMagic(this.source, p, GetSpellValue(30, 12, this.level), DAMAGE_TYPE_MAGIC)
                call GroupRemoveUnit(ENUM_GROUP, p)
            endloop
        endmethod
    

        private method periodic takes nothing returns nothing
            if T32_Tick > this.tick and (not HasPlayerFinishedLevel(this.source, Player(pid))) then
                set this.tick = T32_Tick + 32
                call this.damage()
            endif
        endmethod 

        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
            //call BJDebugMsg("sl start")
            set this.source = source
            set this.pid = GetPlayerId(GetOwningPlayer(this.source))
            
            call this.enable()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.disable()
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function ToggleImmolation takes unit caster returns nothing
        local integer hid = GetHandleId(caster)
        if GetImmolationStruct(hid) == 0 then
            set ImmolationTable[hid] = ImmolationStruct.create(caster)
        else

            if GetImmolationStruct(hid).enabled then
                call GetImmolationStruct(hid).disable()
            else
                call GetImmolationStruct(hid).enable()
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set ImmolationTable = Table.create()
        call SetupToggleAbility(IMMOLATION_ABILITY_ID, "ReplaceableTextures\\CommandButtons\\BTNImmolationOff.blp")
    endfunction
endlibrary