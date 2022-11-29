library FlimsyToken initializer init requires TempAbilSystem
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
    
        

        private method disable takes nothing returns nothing
            call BlzSetUnitAttackCooldown(this.source, BlzGetUnitAttackCooldown(this.source, 0) - this.reduction, 0)
        endmethod
    
        private method periodic takes nothing returns nothing
            if T32_Tick > this.endTick or GetUnitAbilityLevel(this.source, FLIMSY_TOKEN_BUFF_ID) == 0 or not UnitAlive(this.source) then
                call this.disable()
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
    
        static method create takes unit source returns thistype
            local thistype this = thistype.setup()

            set this.source = source
            set this.reduction = 0.6
            call BlzSetUnitAttackCooldown(source, BlzGetUnitAttackCooldown(source, 0) + this.reduction, 0)

            set this.endTick = T32_Tick + R2I(5 * 32)
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            set FlimsyTargets[GetHandleId(this.source)] = 0
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function FlimsyToken takes unit source, unit target returns nothing
        //call BJDebugMsg("flimsy: " + GetUnitName(target))
        call TempAbil.create(target, 'A09B', 5)
        if not IsUnitType(target, UNIT_TYPE_HERO) then
            if GetFlimsyStruct(GetHandleId(target)) == 0 then
                set FlimsyTargets[GetHandleId(target)] = FlimsyTokenStruct.create(target)
            else
                set GetFlimsyStruct(GetHandleId(target)).endTick = T32_Tick + R2I(5 * 32)
            endif
            
        endif
    endfunction

    private function init takes nothing returns nothing
        set FlimsyTargets = Table.create()
    endfunction
endlibrary