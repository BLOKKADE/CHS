globals

    group AbilTranquilityGroup = CreateGroup()
    conditionfunc TranquilityBoolexpr = null
    
    unit GLOB_TRANQUILITY_U = null
    real GLOB_TRANQUILITY_HEAL = 0
endglobals

function TranquilityStartBoolexpr takes nothing returns boolean
    if GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitEnemy(GetFilterUnit(), GetOwningPlayer(GLOB_TRANQUILITY_U)) == false then
        call HealUnit(GLOB_TRANQUILITY_U,GetFilterUnit(),GLOB_TRANQUILITY_HEAL)
        call DisplayTextToPlayer(GetLocalPlayer(),0,0,"HEAL")
    endif
    
    return false
endfunction


function TranquilityTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local real duration = LoadReal(HT,i,2) 
    local real heal = LoadReal(HT,i,3)
    local real per = LoadReal(HT,i,4)
    local real area = LoadReal(HT,i,5)
    
    
    if duration <= 0 then 
        call DestroyTimer(t)
        call FlushChildHashtable(HT,i)
    else 
        set GLOB_TRANQUILITY_U = u1
        set GLOB_TRANQUILITY_HEAL = heal
        call GroupEnumUnitsInRange(AbilTranquilityGroup,GetUnitX(u1),GetUnitY(u1), area,TranquilityBoolexpr )
        call SaveReal(HT,i,2,duration-per)
    endif
    

    
    set u1 = null
    set t = null
endfunction




function TranquilityStart takes unit u1, real heal, real per, real duration, real area returns nothing 
    local timer t = CreateTimer()
    local integer i = GetHandleId(t)

    call SaveUnitHandle(HT,i,1,u1)
    call SaveReal(HT,i,2, duration )
    call SaveReal(HT,i,3, heal )
    call SaveReal(HT,i,4, per )    
    call SaveReal(HT,i,5, area ) 
    
    call AddSpecialEffectTargetTimer("Abilities\\Spells\\NightElf\\Tranquility\\Tranquility.mdl",u1,"head",duration)

    call TimerStart(t,per,true,function TranquilityTimer)
    
    set t = null
endfunction