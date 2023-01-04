library FishingRod initializer init requires TempAbilSystem
    globals
        Table HookedTargets
    endglobals

    function GetHookedStruct takes integer id returns FishingRodStruct
        return HookedTargets[id]
    endfunction

    struct FishingRodStruct extends array
        unit source
        unit target
        integer hookEndTick
        integer immuneEndTick

        private method teleportBack takes nothing returns nothing
            local real r = (bj_RADTODEG * GetAngleToTarget(this.source, this.target))
            call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, GetUnitX(this.target), GetUnitY(this.target)))
            
            call SetUnitX(this.target, CalcX(GetUnitX(this.source), r, 120))
            call SetUnitY(this.target, CalcY(GetUnitY(this.source), r, 120))

            call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, GetUnitX(this.target), GetUnitY(this.target)))
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick < this.hookEndTick and DistanceBetweenUnits(this.source, this.target) > 300 then
                call this.teleportBack()
            endif
            if T32_Tick > this.immuneEndTick or GetUnitAbilityLevel(this.target, 'A0DI') == 0 or (not UnitAlive(this.source)) or (not UnitAlive(this.target)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source, unit target returns thistype
            local thistype this = thistype.setup()

            set this.source = source
            set this.target = target
            set this.hookEndTick = T32_Tick + R2I(3 * 32)
            set this.immuneEndTick = T32_Tick + R2I(5 * 32)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set HookedTargets[GetHandleId(this.target)] = 0
            set this.source = null
            set this.target = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function FishingRod takes unit source, unit target returns nothing
        //call BJDebugMsg("Hooked: " + GetUnitName(target))
        call TempAbil.create(target, 'A0DI', 3)
        if GetHookedStruct(GetHandleId(target)) == 0 then
            set HookedTargets[GetHandleId(target)] = FishingRodStruct.create(source, target)
        endif
    endfunction

    private function init takes nothing returns nothing
        set HookedTargets = Table.create()
    endfunction
endlibrary