globals
    group Area_group = CreateGroup()
    unit Sourse_unit = null
    real Dmg_ef = 0
    integer ABILGLOB = 0
    integer Attack_AbilId = 0 
    
    boolexpr array BoolArray
    boolean GLOB_LIFESTEAL = false
    integer GLOB_typeDmg = 0 
    
    unit Drain
endglobals



function DamageRealase takes nothing returns boolean
    if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Sourse_unit)) and GetWidgetLife(GetFilterUnit()) > 0.405 then
        set Attack_AbilId = ABILGLOB 
        set TypeDmg_b = 2
        call UnitDamageTarget(Sourse_unit,GetFilterUnit(),Dmg_ef,false,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_MAGIC,WEAPON_TYPE_WHOKNOWS)
    endif

    return false
endfunction

function AreaDamageTimer takes nothing returns nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit Sourse = LoadUnitHandle(HT,i,1)
    local real x1 = LoadReal(HT,i,2)
    local real y1 = LoadReal(HT,i,3)
    local real Dmg = LoadReal(HT,i,4)
    local real Area = LoadReal(HT,i,5)
    local integer AbilId = LoadInteger(HT,i,6)
    
    call DestroyTimer(t)
    call FlushChildHashtable(HT,i)
    
    set Sourse_unit = Sourse
    set Dmg_ef = Dmg
    set ABILGLOB = AbilId
    call GroupEnumUnitsInRange(Area_group,x1,y1,Area,BoolArray[0])    
    
    set t = null
    set Sourse = null
endfunction

function AreaDamage takes unit Sourse,real x1,real y1, real Dmg, real Area,integer AbilId returns nothing
    local timer t
    local integer i
    if Sourse != null then
        set t = CreateTimer()
        set i = GetHandleId(t)
        
        call SaveUnitHandle(HT,i,1,Sourse)
        call SaveReal(HT,i,2,x1)
        call SaveReal(HT,i,3,y1)
        call SaveReal(HT,i,4,Dmg)
        call SaveReal(HT,i,5,Area)
        call SaveInteger(HT,i,6,AbilId)
        call TimerStart(t,0,false,function AreaDamageTimer)
    endif
    
    set t = null
endfunction





function DamageRealasePhys takes nothing returns boolean
    if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Sourse_unit)) and GetWidgetLife(GetFilterUnit()) > 0.405 then
        set Attack_AbilId = ABILGLOB 
        set GLOB_typeDmg = 2
         call UnitDamageTarget(Sourse_unit,GetFilterUnit(),Dmg_ef,true,false,ATTACK_TYPE_NORMAL,DAMAGE_TYPE_NORMAL,WEAPON_TYPE_WHOKNOWS)
    endif

    return false
endfunction

function AreaDamageTimerPhys takes nothing returns nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit Sourse = LoadUnitHandle(HT,i,1)
    local real x1 = LoadReal(HT,i,2)
    local real y1 = LoadReal(HT,i,3)
    local real Dmg = LoadReal(HT,i,4)
    local real Area = LoadReal(HT,i,5)
    local integer AbilId = LoadInteger(HT,i,6)
    
    call DestroyTimer(t)
    call FlushChildHashtable(HT,i)
    
    set Sourse_unit = Sourse
    set Dmg_ef = Dmg
    set ABILGLOB = AbilId
    call GroupEnumUnitsInRange(Area_group,x1,y1,Area,BoolArray[103])    
    
    set t = null
    set Sourse = null
endfunction

function AreaDamagePhys takes unit Sourse,real x1,real y1, real Dmg, real Area,integer AbilId returns nothing
    local timer t
    local integer i
    if Sourse != null then
        set t = CreateTimer()
        set i = GetHandleId(t)
        
        call SaveUnitHandle(HT,i,1,Sourse)
        call SaveReal(HT,i,2,x1)
        call SaveReal(HT,i,3,y1)
        call SaveReal(HT,i,4,Dmg)
        call SaveReal(HT,i,5,Area)
        call SaveInteger(HT,i,6,AbilId)
        call TimerStart(t,0,false,function AreaDamageTimerPhys)
    endif
    
    set t = null
endfunction






function DrainRealase takes nothing returns boolean
    local real hp
    local real dmg
    if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Sourse_unit)) and GetWidgetLife(GetFilterUnit()) > 0.405 then

        set hp = GetWidgetLife(GetFilterUnit())
        set dmg = Dmg_ef
        if hp - 0.405 <= dmg then
            set dmg = hp
            call SetWidgetLife(GetFilterUnit(),1)
        else
            call SetWidgetLife(GetFilterUnit(),hp-dmg)
        endif
        
        if GLOB_LIFESTEAL then
            if IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) then
            
                call Vamp(Sourse_unit,GetFilterUnit(),dmg)
            else
                call Vamp(Sourse_unit,GetFilterUnit(),dmg/5)
            endif
        endif
        
        
    endif
    return false
    
endfunction

function AoeDrainAura takes unit u, real hp, real Area, boolean lifesteal returns nothing
    set Sourse_unit = u
    set Dmg_ef = hp
    set GLOB_LIFESTEAL = lifesteal
    call GroupEnumUnitsInRange(Area_group,GetUnitX(u),GetUnitY(u),Area,BoolArray[104])    
endfunction




function DrainRealase2 takes nothing returns boolean
    local real hp
    local real dmg
    if IsUnitEnemy(GetFilterUnit(),GetOwningPlayer(Sourse_unit)) and GetWidgetLife(GetFilterUnit()) > 0.405 then

        set hp = GetWidgetLife(GetFilterUnit())
        set dmg = Dmg_ef*hp/100
            
        if hp - 0.405 <= dmg then
                    set dmg = hp
            call SetWidgetLife(GetFilterUnit(),1)
        else
            call SetWidgetLife(GetFilterUnit(),hp-dmg)
        endif
        
        if GLOB_LIFESTEAL then
            if IsHeroUnitId(GetUnitTypeId(GetFilterUnit())) then
            
                call Vamp(Sourse_unit,GetFilterUnit(),dmg)
            else
                call Vamp(Sourse_unit,GetFilterUnit(),dmg/5)
            endif
        endif
        
        
    endif
    return false
    
endfunction

function AoeDrainAura2 takes unit u, real hp, real Area, boolean lifesteal returns nothing
    set Sourse_unit = u
    set Dmg_ef = hp
    set GLOB_LIFESTEAL = lifesteal
    call GroupEnumUnitsInRange(Area_group,GetUnitX(u),GetUnitY(u),Area,BoolArray[105])    
endfunction



function InitDamageArea takes nothing returns nothing


    set BoolArray[0] = Condition(function DamageRealase)
    set BoolArray[103] = Condition(function DamageRealasePhys)
    set BoolArray[104] = Condition(function DrainRealase)
    set BoolArray[105] = Condition(function DrainRealase2)
endfunction