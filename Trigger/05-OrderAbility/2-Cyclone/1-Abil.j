globals
    group GLOB_gr = CreateGroup()
    boolexpr GLOB_boolCyclone
    unit GLOB_unitCyclone = null
    real GLOB_damageCyclone = 0
endglobals



function damageStartCyclone takes nothing returns boolean
    if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(GLOB_unitCyclone)) then
        call UnitDamageTarget(GLOB_unitCyclone,GetFilterUnit(),GLOB_damageCyclone,false,false,ATTACK_TYPE_MAGIC,DAMAGE_TYPE_LIGHTNING, WEAPON_TYPE_WHOKNOWS )
    endif
    return false
endfunction

function timerCyclone takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u = LoadUnitHandle(HT,GetHandleId(t),2)
    local unit caster = LoadUnitHandle(HT,GetHandleId(t),1)
    local group g = CreateGroup()
    
    if GetWidgetLife(u) > 0.45 then
        set GLOB_unitCyclone = caster
        set GLOB_damageCyclone = GetUnitAbilityLevel(caster,'A05X')*10
        call GroupEnumUnitsInRange(GLOB_gr,GetUnitX(u),GetUnitY(u),350,GLOB_boolCyclone )
    else
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
    endif
    
    
    set u = null
    set t = null
    call DestroyGroup(g)
    set g = null
    set caster = null
endfunction

function Trig_Abil_Conditions takes nothing returns boolean
    local real X1
    local real Y1
    local unit u
    local timer t
    
    if  GetSpellAbilityId() == 'A05X' then
       set X1 = GetSpellTargetX()
       set Y1 = GetSpellTargetY()
       
        set u= CreateUnit(GetOwningPlayer(GetTriggerUnit()),'h01K',X1,Y1,0)
        call UnitApplyTimedLife(u,'A041',10)
        
        set t = NewTimer()
        call SaveUnitHandle(HT,GetHandleId(t),1,GetTriggerUnit() )
        call SaveUnitHandle(HT,GetHandleId(t),2,u )
        call TimerStart(t,0.2,true,function timerCyclone )
        
        
        set u = null
        set t = null
    endif

    return false
endfunction



//===========================================================================
function InitTrig_Abil takes nothing returns nothing
    set gg_trg_Abil = CreateTrigger(  )
    set GLOB_boolCyclone = Condition(function damageStartCyclone)
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Abil, EVENT_PLAYER_UNIT_SPELL_CAST )
    call TriggerAddCondition( gg_trg_Abil, Condition( function Trig_Abil_Conditions ) )
endfunction

