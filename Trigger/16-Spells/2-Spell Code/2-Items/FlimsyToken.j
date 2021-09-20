library FlimsyToken initializer init requires BuffSystem
    globals
        Table FlimsyTargets
    endglobals

    function GetFlimsyStruct takes integer id returns FlimsyTokenStruct
        return FlimsyTargets[id]
    endfunction

    struct FlimsyTokenStruct extends array
        unit source
        real reduction
        integer endTick
    
        private static integer instanceCount = 0
        private static thistype recycle = 0
        private thistype recycleNext

        private method disable takes nothing returns nothing
            call BlzSetUnitAttackCooldown(this.source, BlzGetUnitAttackCooldown(this.source, 0) - this.reduction, 0)
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.source, 'B01Q') == 0 or not UnitAlive(this.source) then
                call this.disable()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this
    
            if (recycle == 0) then
                set instanceCount = instanceCount + 1
                set this = instanceCount
            else
                set this = recycle
                set recycle = recycle.recycleNext
            endif

            set this.source = source
            set this.reduction = 0.4
            call BlzSetUnitAttackCooldown(source, BlzGetUnitAttackCooldown(source, 0) + this.reduction, 0)

            set this.endTick = T32_Tick + R2I(5*32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set FlimsyTargets[GetHandleId(this.source)] = 0
            set this.source = null
            set recycleNext = recycle
            set recycle = this
        endmethod
    
        implement T32x
    endstruct

    function FlimsyToken takes unit source, unit target returns nothing
        //call BJDebugMsg("flimsy: " + GetUnitName(target))
        call SetBuff(target, 6, 5)
        if not IsUnitType(target, UNIT_TYPE_HERO) then
            if GetFlimsyStruct(GetHandleId(target)) == 0 then
                set FlimsyTargets[GetHandleId(target)] = FlimsyTokenStruct.create(target)
            else
                set GetFlimsyStruct(GetHandleId(target)).endTick = T32_Tick + R2I(5*32)
            endif
            
        endif
    endfunction

    private function init takes nothing returns nothing
        set FlimsyTargets = Table.create()
    endfunction
endlibrary