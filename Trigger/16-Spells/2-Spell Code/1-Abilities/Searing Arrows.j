library SearingArrows initializer init requires ToggleAbility
    globals
        Table SearingArrowsTable
    endglobals

    function GetSearingArrowsStruct takes integer id returns SearingArrowsStruct
        return SearingArrowsTable[id]
    endfunction

    struct SearingArrowsStruct extends array
        unit source
        boolean enabled

        method enable takes nothing returns nothing
            set this.enabled = true
            call BJDebugMsg("enabled")
            call ToggleAbility(this.source, SEARING_ARROWS_ABILITY_ID, GetUnitAbilityLevel(this.source, SEARING_ARROWS_ABILITY_ID))
            call this.startPeriodic()
        endmethod

        method disable takes nothing returns nothing
            call BJDebugMsg("disabled")
            call this.stopPeriodic()
            set this.enabled = false
            call ToggleAbility(this.source, SEARING_ARROWS_ABILITY_ID, GetUnitAbilityLevel(this.source, SEARING_ARROWS_ABILITY_ID))
        endmethod

        private method periodic takes nothing returns nothing
            if GetUnitAbilityLevel(this.source, SEARING_ARROWS_ABILITY_ID) == 0 or IsAbilityEnabled(this.source, SEARING_ARROWS_ABILITY_ID) == false then
                call this.disable()
            endif
        endmethod 

        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
            //call BJDebugMsg("sl start")
            set this.source = source
            
            call this.enable()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    function ToggleSearingArrows takes unit caster returns nothing
        local integer hid = GetHandleId(caster)
        if GetSearingArrowsStruct(hid) == 0 then
            set SearingArrowsTable[hid] = SearingArrowsStruct.create(caster)
        else

            if GetSearingArrowsStruct(hid).enabled then
                call GetSearingArrowsStruct(hid).disable()
            else
                call GetSearingArrowsStruct(hid).enable()
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set SearingArrowsTable = Table.create()
        call SetupToggleAbility(SEARING_ARROWS_ABILITY_ID, "ReplaceableTextures\\CommandButtons\\TNStrengthOfTheMoon.blp")
    endfunction
endlibrary