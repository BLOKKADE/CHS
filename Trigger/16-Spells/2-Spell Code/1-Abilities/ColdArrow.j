library ColdArrows initializer init requires ToggleAbility
    globals
        Table ColdArrowsTable
    endglobals

    function GetColdArrowsStruct takes integer id returns ColdArrowsStruct
        return ColdArrowsTable[id]
    endfunction

    struct ColdArrowsStruct extends array
        unit source
        boolean enabled

        method enable takes nothing returns nothing
            set this.enabled = true
            //call BJDebugMsg("enabled")
            call ToggleAbility(this.source, COLD_ARROWS_ABILITY_ID, GetUnitAbilityLevel(this.source, COLD_ARROWS_ABILITY_ID))
        endmethod

        method disable takes nothing returns nothing
            //call BJDebugMsg("disabled")
            set this.enabled = false
            call ToggleAbility(this.source, COLD_ARROWS_ABILITY_ID, GetUnitAbilityLevel(this.source, COLD_ARROWS_ABILITY_ID))
        endmethod

        static method create takes unit source returns thistype
            local thistype this = thistype.setup()
            //call BJDebugMsg("sl start")
            set this.source = source
            
            call this.enable()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call this.disable()
            call this.recycle()
        endmethod
        
        implement Recycle
    endstruct

    function ToggleColdArrows takes unit caster returns nothing
        local integer hid = GetHandleId(caster)
        if GetColdArrowsStruct(hid) == 0 then
            set ColdArrowsTable[hid] = ColdArrowsStruct.create(caster)
        else

            if GetColdArrowsStruct(hid).enabled then
                call GetColdArrowsStruct(hid).disable()
            else
                call GetColdArrowsStruct(hid).enable()
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set ColdArrowsTable = Table.create()
        call SetupToggleAbility(COLD_ARROWS_ABILITY_ID, "ReplaceableTextures\\CommandButtons\\BTNMoonArrow.blp")
    endfunction
endlibrary