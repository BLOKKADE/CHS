library MagnetOscillation initializer init requires ToggleAbility
    globals
        Table MagnetOscTable
        Table MagnetOscHitTick
    endglobals

    function GetMagnetOscStruct takes integer id returns MagnetOscStruct
        return MagnetOscTable[id]
    endfunction

    struct MagnetOscStruct extends array
        unit source
        boolean enabled

        method enable takes nothing returns nothing
            set this.enabled = true
            call BJDebugMsg("enabled")
            call ToggleAbility(this.source, MAGNET_OSC_ABILITY_ID, GetUnitAbilityLevel(this.source, MAGNET_OSC_ABILITY_ID))
        endmethod

        method disable takes nothing returns nothing
            call BJDebugMsg("disabled")
            set this.enabled = false
            call ToggleAbility(this.source, MAGNET_OSC_ABILITY_ID, GetUnitAbilityLevel(this.source, MAGNET_OSC_ABILITY_ID))
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

    function ToggleMagnetOsc takes unit caster returns nothing
        local integer hid = GetHandleId(caster)
        if GetMagnetOscStruct(hid) == 0 then
            set MagnetOscTable[hid] = MagnetOscStruct.create(caster)
        else

            if GetMagnetOscStruct(hid).enabled then
                call GetMagnetOscStruct(hid).disable()
            else
                call GetMagnetOscStruct(hid).enable()
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set MagnetOscTable = Table.create()
        set MagnetOscHitTick = Table.create()
        call SetupToggleAbility(MAGNET_OSC_ABILITY_ID, "ReplaceableTextures\\CommandButtons\\BTN_CR_Push2.blp")
    endfunction
endlibrary