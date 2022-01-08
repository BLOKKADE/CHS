library PeriodicDamage initializer init requires RandomShit
    
    globals
        HashTable PeriodicCounter
    endglobals

    struct PeriodicDamage extends array
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

        private method damage takes nothing returns nothing
            if GetWidgetLife(this.target) > 0.405 and ((this.buffId != 0 and GetUnitAbilityLevel(this.target, this.buffId) > 0) or this.buffId == 0) then
                if this.allowRecursion == false then
                    set udg_NextDamageType = DamageType_Onhit
                endif
                set udg_NextDamageAbilitySource = this.abilId
                if magic then
                    call Damage.applySpell(this.caster, this.target, this.dmg + ((GetWidgetLife(this.target)* 0.01)* this.lifeDamage), DAMAGE_TYPE_MAGIC)
                else
                    //set GLOB_typeDmg = 2
                    call Damage.applyAttack(this.caster, this.target, this.dmg + ((GetWidgetLife(this.target)* 0.01)* this.lifeDamage), false, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
                endif
                if this.fx != null then
                    call DestroyEffect(AddSpecialEffectTargetFix(this.fx, this.target, attachPoint))
                endif
            endif
        endmethod

        private method periodic takes nothing returns nothing
            if T32_Tick >= this.endTick and this.limit > 0 then
                call this.damage()
                set this.limit = this.limit - 1
                set this.endTick = T32_Tick + interval
            endif
            
            if this.limit <= 0 or UnitAlive(this.target) == false or GetDivineBubbleStruct(GetHandleId(this.target)) != 0 then
                call this.stopPeriodic()
                call this.destroy()
            endif
        endmethod  

        method addFx takes string fx, string attachPoint returns thistype
            set this.fx = fx
            set this.attachPoint = attachPoint
            call DestroyEffect(AddSpecialEffectTargetFix(fx, this.target, attachPoint))
            return this
        endmethod

        method addLimit takes integer abilId, integer max, real cd returns thistype
            local integer count = PeriodicCounter[GetHandleId(this.caster)].integer[abilId]
            set this.limitAbilId = abilId
            set PeriodicCounter[GetHandleId(this.caster)].integer[abilId] = count + 1
            if count >= max then  
                if GetUnitAbilityLevel(this.caster, abilId) > 0 then
                    call BlzStartUnitAbilityCooldown(this.caster, abilId, cd)
                else
                    set this.limit = 0
                endif
            endif
            return this
        endmethod

        static method create takes unit caster, unit target, real intervalDmg, boolean magic, real interval, real duration, real lifeDamage, boolean allowRecursion, integer buffId, integer abilId returns thistype
            local thistype this = thistype.setup()
            
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
            call this.damage()
            if buffId != 0 then
                set this.buffId = buffId
            endif
            call this.startPeriodic()
            return this
        endmethod
        
        method destroy takes nothing returns nothing
            if this.limitAbilId != 0 then
                set PeriodicCounter[GetHandleId(this.caster)].integer[this.limitAbilId] = PeriodicCounter[GetHandleId(this.caster)].integer[this.limitAbilId] - 1
            endif
            set this.caster = null
            set this.target = null

            call this.recycle()
        endmethod

        implement T32x
        implement Recycle
    endstruct

    private function init takes nothing returns nothing
        set PeriodicCounter = HashTable.create()
    endfunction
    /*
    function peredioc_s takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u1 = LoadUnitHandle(HT,i,1)
        local unit u2 = LoadUnitHandle(HT,i,2)
        local real dmg1 = LoadReal(HT,i,3)
        local real dmg2 = LoadReal(HT,i,4)
        local real evary = LoadReal(HT,i,5)
        local real max = LoadReal(HT,i,6)
        local integer id = LoadInteger(HT,i,7)
        local boolean first = LoadBoolean(HT,i,8)
    

    
        if first==false then
            call SaveBoolean(HT,i,8,true)
            set TypeDmg_b = 2
            call UnitDamageTarget(u1,u2,dmg1 + GetWidgetLife(u2)* 0.01 * dmg2,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
            call TimerStart(t,evary,true,function peredioc_s)
            set u1 = null
            set u2 = null
            return
        endif
    
        if GetUnitAbilityLevel(u2,id) > 0 then
            set TypeDmg_b = 2
            call UnitDamageTarget(u1,u2,dmg1 + GetWidgetLife(u2)* 0.01 * dmg2,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)

        else
            call ReleaseTimer(t)
            call FlushChildHashtable(HT,i)
    
        endif
    
        set t = null
        set u1 = null
        set u2 = null
    endfunction
    */

    /*function LiquidFireEnvenomedWeapons takes unit u1,unit u2,real dmg1,real dmg2,real evary,real max,integer id,boolean first returns nothing
    /*local timer t = LoadTimerHandle(HT,GetHandleId(u2),id)
    local integer i
    if t == null then
        set t = NewTimer()
    endif
    
    set i = GetHandleId(t)
        
    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    call SaveReal(HT,i,3,dmg1)
    call SaveReal(HT,i,4,dmg2)
    call SaveReal(HT,i,5,evary)
    call SaveReal(HT,i,6,max)
    call SaveInteger(HT,i,7,id)
    if first then
        call TimerStart(t,0,false,function peredioc_s)
    endif

    set t = null */
endfunction */
endlibrary