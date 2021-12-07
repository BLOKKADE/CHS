globals
    hashtable ShateHT = InitHashtable()
endglobals

function endTimerStone takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local unit u1 = LoadUnitHandle(HT,GetHandleId(t),1)
    local unit u2 = LoadUnitHandle(HT,GetHandleId(t),2)
    call UnitShareVision(u2,GetOwningPlayer(u1),false)
    call SaveBoolean(ShateHT,GetHandleId(u2),GetHandleId(u1),false)
    call FlushChildHashtable(HT,GetHandleId(t))
    call ReleaseTimer(t)
    set t = null
    set u1 = null
    set u2 = null
endfunction

function UsOrderU1 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield REALF returns boolean
    local boolean BL
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),PRIEST_1_UNIT_ID,x,y, Rad2Deg(Atan2(GetUnitY(u2)- y, GetUnitX(u2)- x))  )
    
    call UnitAddAbility(Caster1,idsp ) 
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)
    set BL = IssueTargetOrder(Caster1,ordstr,u2)
    call UnitApplyTimedLife(Caster1,'B000',6)
    set Caster1 = null
    return BL
endfunction




function stoneProtectA takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local boolean Bil = false
    
    call ReleaseTimer(t)
    call FlushChildHashtable(HT,i)

    if BlzGetUnitAbilityCooldownRemaining(u1,'A060') <= 0.001 and IsUnitEnemy(u2, GetOwningPlayer(u1)) then    
        
        if LoadBoolean(ShateHT,GetHandleId(u2),GetHandleId(u1)) == false and IsUnitVisible(u2,GetOwningPlayer(u1) ) == false then
            call UnitShareVision(u2,GetOwningPlayer(u1),true)
            set t = NewTimer()
            call SaveUnitHandle(HT,GetHandleId(t),1,u2)
            call SaveUnitHandle(HT,GetHandleId(t),2,u1)
            call TimerStart(t,3,false,function endTimerStone)
            call SaveBoolean(ShateHT,GetHandleId(u2),GetHandleId(u1),true)
            
        endif
        set Bil = UsOrderU1(u1,u2,GetUnitX(u1),GetUnitY(u1),'A061',"creepthunderbolt",200 * GetUnitAbilityLevel(u1,'A060'),ABILITY_RLF_DAMAGE_CTB1)

    endif



    if Bil == true then

        if IsHeroUnitId(GetUnitTypeId(u2)) then
            call AbilStartCD(u1,'A060',9)
        else
            call AbilStartCD(u1,'A060',0.9)
        endif
    else

    endif

    set u1 = null
    set u2 = null
    set t = null
endfunction

function stoneProtect takes unit u1, unit u2 returns nothing
    local timer t = NewTimer()
    local integer i = GetHandleId(t)
    
    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    
    call TimerStart(t,0,false,function stoneProtectA )
    
    set u1 = null
    set u2 = null
    set t = null
endfunction