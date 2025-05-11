library AbilityMOdifiers initializer init requires TimerUtils

    globals
        Table UnitAbilityMod
    endglobals

    function GetUnitAbilMods takes unit source returns AbilityModifiers
        return UnitAbilityMod[GetHandleId(source)]
    endfunction

    function DestroyAbilMod takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local AbilityModifiers abilMods = GetTimerData(t)

        call abilMods.destroy()
        call ReleaseTimer(t)
        
        set t = null
    endfunction

    struct AbilityModifiers extends array
        implement Alloc

        unit source
        
        real RetaliationAuraBonus

        static method copy takes unit source, unit target returns thistype
            local AbilityModifiers targetAbilMod = AbilityModifiers.create(target)
            local AbilityModifiers sourceAbilMod = GetUnitAbilMods(source)

            set targetAbilMod.RetaliationAuraBonus = sourceAbilMod.RetaliationAuraBonus

            return targetAbilMod
        endmethod

        method reset takes nothing returns nothing
            set this.RetaliationAuraBonus = 0
        endmethod

        method destroyTimer takes real duration returns nothing
            call TimerStart(NewTimerEx(this), duration, false, function DestroyAbilMod)
        endmethod
    
        static method create takes unit source returns thistype
            local thistype this = thistype.allocate()
            
            set this.source = source
            set UnitAbilityMod[GetHandleId(source)] = this

            return this
        endmethod

        static method createOrGet takes unit source returns thistype
            if GetUnitAbilMods(source) != 0 then
                return GetUnitAbilMods(source)
            else
                return thistype.create(source)
            endif
        endmethod
        
        method destroy takes nothing returns nothing
            call this.reset()
            set this.source = null
            set UnitAbilityMod[GetHandleId(source)] = 0
            call this.deallocate()
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set UnitAbilityMod = Table.create()
    endfunction
endlibrary
