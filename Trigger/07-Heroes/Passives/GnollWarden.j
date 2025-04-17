library GnollWarden initializer init requires FxCooldown, HideEffects
    globals
        HashTable GnollWardenPassive

        private constant integer GNOLL_WARDEN_PASSIVE_DURATION = 3

        constant integer GNOLL_WARDEN_PASSIVE_HP = 1
        constant integer GNOLL_WARDEN_PASSIVE_LIMIT = 2
        constant integer GNOLL_WARDEN_PASSIVE_INTERVAL = 3
        constant integer GNOLL_WARDEN_PASSIVE_CURRENT = 4
    endglobals

    function SetGnollWardenPassive takes unit source, integer id, real value returns nothing
        set GnollWardenPassive[GetHandleId(source)].real[id] = value
    endfunction

    function GetGnollWardenPassiveInfo takes unit source, integer id returns real
        return GnollWardenPassive[GetHandleId(source)].real[id]
    endfunction

    struct GnollWardenStruct extends array
        unit source
        integer pid
        real amount
        integer nextTick
        integer endTick

        private method heal takes nothing returns nothing
            call SetWidgetLife(this.source, GetWidgetLife(this.source) + amount)
            if not IsFxOnCooldownSet(GetHandleId(this.source), GNOLL_WARDEN_UNIT_ID, 1) then
                call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", this.source, "origin"))
            endif
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.nextTick then
                set this.nextTick = T32_Tick + R2I(GetGnollWardenPassiveInfo(this.source, GNOLL_WARDEN_PASSIVE_INTERVAL) * 32)
                call this.heal()
            endif
            if T32_Tick > this.endTick or (not UnitAlive(this.source)) or CurrentlyFighting[this.pid] == false then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod 
    
        static method create takes unit source, real fullDamage returns thistype
            local thistype this = thistype.setup()
            
            set this.source = source
            set this.pid = GetPlayerId(GetOwningPlayer(source))
            set this.amount = fullDamage * GetGnollWardenPassiveInfo(this.source, GNOLL_WARDEN_PASSIVE_HP)
            set this.nextTick = T32_Tick + R2I(GetGnollWardenPassiveInfo(this.source, GNOLL_WARDEN_PASSIVE_INTERVAL) * 32)
            set this.endTick = T32_Tick + GNOLL_WARDEN_PASSIVE_DURATION * 32

            call SetGnollWardenPassive(this.source, GNOLL_WARDEN_PASSIVE_CURRENT, GetGnollWardenPassiveInfo(this.source, GNOLL_WARDEN_PASSIVE_CURRENT) + 1)

            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            call SetGnollWardenPassive(this.source, GNOLL_WARDEN_PASSIVE_CURRENT, GetGnollWardenPassiveInfo(this.source, GNOLL_WARDEN_PASSIVE_CURRENT) - 1)
            set this.source = null
            call this.recycle()
        endmethod
    
        implement T32x
        implement Recycle
    endstruct

    function ActivateGnollWardenPassive takes unit source, real damage returns nothing
        local real limit = GetGnollWardenPassiveInfo(source, GNOLL_WARDEN_PASSIVE_LIMIT)
        local real count = GetGnollWardenPassiveInfo(source, GNOLL_WARDEN_PASSIVE_CURRENT)

        if count >= limit then
            call BlzStartUnitAbilityCooldown(source, 'A0EM', 1.0)
        else
            if BlzGetUnitAbilityCooldownRemaining(source, 'A0EM') == 0 then
                call GnollWardenStruct.create(source, damage)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set GnollWardenPassive = HashTable.create()
    endfunction
endlibrary