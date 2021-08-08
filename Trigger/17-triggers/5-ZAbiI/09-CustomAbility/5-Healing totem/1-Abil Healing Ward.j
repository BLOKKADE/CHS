globals

    group AbilHealingWardGroup = CreateGroup()
    conditionfunc HealingWardBoolexpr = null
    
    unit GLOB_HEALING_WARD_U = null
    unit GLOB_HEALING_WARD_U2 = null
    real GLOB_HEALING_WARD_HEAL = 0
endglobals

function HealingWardStartBoolexpr takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GLOB_HEALING_WARD_U2)) == false then
        call DisplayTextToPlayer(GetLocalPlayer(),0,0,R2S(GLOB_HEALING_WARD_HEAL))
        call DestroyEffect( AddSpecialEffectTargetFix("Abilities\\Spells\\Undead\\VampiricAura\\VampiricAuraTarget.mdl", GetFilterUnit(), "chest"))
        call HealUnit(GLOB_HEALING_WARD_U,GetFilterUnit(),GLOB_HEALING_WARD_HEAL)
    endif
    
    return false
endfunction


function HealingWardStartTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local real heal = LoadReal(HT,i,3)
    local real area = LoadReal(HT,i,4)

    if u2 == null or GetWidgetLife(u2)  <= 0.405 then
        call DestroyTimer(t)
        call FlushChildHashtable(HT,i)

    else
        set GLOB_HEALING_WARD_U = u
        set GLOB_HEALING_WARD_U2 = u2
        set GLOB_HEALING_WARD_HEAL = heal
        call GroupEnumUnitsInRange(AbilHealingWardGroup,GetUnitX(u2),GetUnitY(u2), area,HealingWardBoolexpr )
    endif 

    set u = null
    set u2 = null
    set t =null
endfunction



function HealingWardStart takes unit u, real x, real y,real heal, real area, real time returns nothing
    local unit u2 = CreateUnit(GetOwningPlayer(u),'ohwd',x,y,0)
    local timer t = CreateTimer()
    call DisplayTextToPlayer(GetLocalPlayer(),0,0,R2S(x))
     call DisplayTextToPlayer(GetLocalPlayer(),0,0,R2S(y))   
    
    call SaveUnitHandle(HT,GetHandleId(t),1,u)
    call SaveUnitHandle(HT,GetHandleId(t),2,u2)
    call SaveReal(HT,GetHandleId(t),3,heal)
    call SaveReal(HT,GetHandleId(t),4,area)

    call TimerStart(t,1,true,function HealingWardStartTimer )
    call UnitApplyTimedLife(u2,'ohwd',time)
    

    set u2 = null
    set t = null
endfunction

