library PeriodicDamage initializer init requires DivineBubble, DamageEngine, HideEffects
    
    globals
        HashTable PeriodicCounter
    endglobals

    struct PeriodicDamage extends array
        implement Alloc

        real dmg
        unit target
        unit caster
        boolean magic
        integer endTick
        integer limit
        integer abilId
        integer limitAbilId
        string fx
        string attachPoint
        integer buffId
        integer interval
        real lifeDamage
        boolean allowRecursion
        integer pid

        private method damage takes boolean first returns nothing
            if GetWidgetLife(this.target) > 0.405 and (first or (this.buffId != 0 and GetUnitAbilityLevel(this.target, this.buffId) > 0) or this.buffId == 0) then
                if this.allowRecursion == false then
                    set udg_NextDamageType = DamageType_Onhit
                endif
                set udg_NextDamageAbilitySource = this.abilId

                if magic then
                    call Damage.applyMagic(this.caster, this.target, this.dmg + ((GetWidgetLife(this.target)* 0.01)* this.lifeDamage), false, DAMAGE_TYPE_MAGIC)
                else
                    //set GLOB_typeDmg = 2
                    call Damage.applyPhys(this.caster, this.target, this.dmg + ((GetWidgetLife(this.target)* 0.01)* this.lifeDamage), false, false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                endif
                if this.fx != null then
                    call DestroyEffect(AddLocalizedSpecialEffectTarget(this.fx, this.target, attachPoint))
                endif
            endif
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.limit > 0 then
                call this.damage(false)
                set this.limit = this.limit - 1
                set this.endTick = T32_Tick + interval
            endif
            
            if this.limit <= 0 or UnitAlive(this.target) == false or GetDivineBubbleStruct(GetHandleId(this.target)) != 0 or (this.magic and IsUnitMagicImmune(this.target)) then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  
        
        implement T32x

        method addFx takes string fx, string attachPoint returns thistype
            set this.fx = fx
            set this.attachPoint = attachPoint
            call DestroyEffect(AddLocalizedSpecialEffectTarget(fx, this.target, attachPoint))
            return this
        endmethod

        method addLimit takes integer abilId, integer max, real cd returns thistype
            local integer count = PeriodicCounter[this.pid].integer[abilId]
            set this.limitAbilId = abilId
            set PeriodicCounter[this.pid].integer[abilId] = count + 1
            if count >= max then  
                if GetUnitAbilityLevel(this.caster, abilId) > 0 then
                    call BlzStartUnitAbilityCooldown(this.caster, abilId, cd)
                else
                    set this.limit = 0
                endif
            endif
            return this
        endmethod

        method start takes nothing returns thistype
            call this.damage(true)
            call this.startPeriodic()

            return this
        endmethod

        static method create takes unit caster, unit target, real intervalDmg, boolean magic, real interval, real duration, real lifeDamage, boolean allowRecursion, integer buffId, integer abilId returns thistype
            local thistype this = thistype.allocate()
            
            set this.abilId = abilId
            set this.limitAbilId = 0
            set this.buffId = 0
            set this.fx = null
            set this.dmg = intervalDmg
            set this.target = target
            set this.magic = magic
            set this.caster = caster
            set this.limit = R2I(duration / interval)
            set this.interval = R2I(interval * 32)
            set this.endTick = T32_Tick + this.interval
            set this.lifeDamage = lifeDamage
            set this.allowRecursion = allowRecursion
            set this.pid = GetPlayerId(GetOwningPlayer(caster))
            if buffId != 0 then
                set this.buffId = buffId
            endif

            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if this.limitAbilId != 0 then
                set PeriodicCounter[this.pid].integer[this.limitAbilId] = PeriodicCounter[this.pid].integer[this.limitAbilId] - 1
            endif
            set this.caster = null
            set this.target = null

            call this.deallocate()
        endmethod
    endstruct

    private function init takes nothing returns nothing
        set PeriodicCounter = HashTable.create()
    endfunction
endlibrary