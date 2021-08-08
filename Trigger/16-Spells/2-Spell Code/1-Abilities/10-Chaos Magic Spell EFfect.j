globals
    unit GLOB_AB_CH = null
    unit GLOB_TR_CH = null  
    real GLOB_X1_CH = 0
    real GLOB_Y1_CH = 0
    integer GLOB_LV_CH = 0
    integer GLOB_ID_CH = 0
    
endglobals

function GetRandomAbility1 takes nothing returns integer
    local integer I1 = GetRandomInt(0,AbilSRA1_count+AbilSRA2_count+AbilSRA3_count+2)

    if I1 <=  AbilSRA1_count then
        return AbilSpellRA1[I1]
    elseif I1  <= AbilSRA1_count + AbilSRA2_count + 1 then
        return AbilSpellRA2[I1-AbilSRA1_count-1]
    else
        return AbilSpellRA3[I1-AbilSRA1_count-AbilSRA2_count-2]
    endif

    return AbilSpellRA1[GetRandomInt(0,AbilSRA1_count) ] 
endfunction


function GetRandomAbility2 takes nothing returns integer
    local integer I1 = GetRandomInt(0,AbilSRA2_count+AbilSRA3_count+1)

    if I1 <=  AbilSRA2_count then
        return AbilSpellRA2[I1]
    else 
        return AbilSpellRA3[I1-AbilSRA2_count-1]
    endif

    return AbilSpellRA2[GetRandomInt(0,AbilSRA2_count) ] 
endfunction





function CastRandomSpell1Timer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    
    local unit u = LoadUnitHandle(HT,i,1)
    local integer sp = LoadInteger(HT,i,2)
    local integer lvl = LoadInteger(HT,i,3)
    local unit u2 = LoadUnitHandle(HT,i,4)
    local real x1 = LoadReal(HT,i,5)
    local real y1 = LoadReal(HT,i,6)

    local unit DummyU = CreateUnit(GetOwningPlayer(u),'h015',GetUnitX(u),GetUnitY(u),GetUnitFacing(u))
    local integer Type = LoadInteger(HT_AbilityData,sp,1) 
    local string  Order = LoadStr(HT_AbilityData,sp,2)
    local boolean CAST = false
    
    if GetUnitTypeId(u2) ==  'h00T' or GetUnitTypeId(u2) == 'h014' or GetUnitTypeId(u2) == 'h015' then
    
        set u2 = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u2 ) ) ]
    
    endif
    
    
    call UnitAddAbility(DummyU,sp) 
    call SetUnitAbilityLevel(DummyU,sp,lvl)
    call BlzSetAbilityRealLevelField(BlzGetUnitAbility(DummyU,sp),ConvertAbilityRealLevelField('aran'),lvl-1,9999999)


    call UnitApplyTimedLife(DummyU,  'BTLF', 21) 
    if Type == 1 then
       set CAST =  IssueTargetOrder(DummyU,Order,u2)  
        
        if CAST == false then
                set sp = GetRandomAbility2()
                call UnitAddAbility(DummyU,sp) 
                call SetUnitAbilityLevel(DummyU,sp,lvl)
                call BlzSetAbilityRealLevelField(BlzGetUnitAbility(DummyU,sp),ConvertAbilityRealLevelField('aran'),lvl-1,9999999)
                set  Type = LoadInteger(HT_AbilityData,sp,1) 
                set  Order = LoadStr(HT_AbilityData,sp,2)
        endif
       
       
    endif
    if Type == 2 then
        if u2 != null then
             set CAST =  IssuePointOrder(DummyU,Order,GetUnitX(u2),GetUnitY(u2))   
        else
             set CAST = IssuePointOrder(DummyU,Order,x1,y1)
        endif
    endif
    if Type == 3 then
        if u2 != null then
             call SetUnitX(DummyU,GetUnitX(u2))
             call SetUnitY(DummyU,GetUnitY(u2))
             set CAST =  IssueImmediateOrder(DummyU,Order)    
        else
             call SetUnitX(DummyU ,x1)
             call SetUnitY(DummyU,y1)
             set CAST = IssueImmediateOrder(DummyU,Order)
        endif
    endif
    
    
     if CAST == false then
         //call DisplayTextToPlayer(GetLocalPlayer(),0,0,GetObjectName(sp) + "ERROR: " + Order + " " + I2S(Type) )
     endif 
     
     call DestroyTimer(t)
     call FlushChildHashtable(HT,i)
    
    call SaveInteger(HT,GetHandleId(u),-4555101,lvl)
    
     set t = null
     set u = null
     set u2 = null
     set Order = null
     set DummyU = null
endfunction


function CastRandomSpell1 takes unit u, integer sp, integer lvl, unit u2, real x1,real y1 returns nothing
    local timer t = CreateTimer()
    local integer i = GetHandleId(t)
    
    call SaveUnitHandle(HT,i,1,u)
    call SaveInteger(HT,i,2,sp)
    call SaveInteger(HT,i,3,lvl)
    call SaveUnitHandle(HT,i,4,u2)
    call SaveReal(HT,i,5,x1)
    call SaveReal(HT,i,6,y1)

 
    call TimerStart(t,0,false,function CastRandomSpell1Timer)

    set t = null
    set u = null
    set u2 = null 
    
endfunction

function AbilityChannel takes nothing returns nothing
    local unit u = GLOB_AB_CH
    local unit u2 = GLOB_TR_CH
    local real x1 = GLOB_X1_CH
    local real y1 = GLOB_Y1_CH
    local integer lvl = GLOB_LV_CH
    local integer ID = 0 
    local integer id = GLOB_ID_CH

    if GetUnitTypeId(u) ==  'h00T' or GetUnitTypeId(u) == 'h014' or GetUnitTypeId(u) == 'h015' then
        set u = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u ) ) ]
    endif

    if id == 'A07U' then
        if u2 != null and u != u2 then
            set ID = GetRandomAbility1()
            call CastRandomSpell1(u,ID ,lvl,u2,0,0) 
        elseif x1 != 0 and y1 != 0 then
          set ID = GetRandomAbility2()
          call CastRandomSpell1(u,ID ,lvl,null,x1,y1)
        endif
    endif

    if id == 'A07X' then
        call  UsFrostBolt(u,u2,120*GetUnitAbilityLevel(u,'A07X')*(1+0.25*R2I(GetClassUnitSpell(u,7))) ,GetClassUnitSpell(u,9))
    endif

    if id == 'A083' then
        call SandRefreshAbility(u,1.75 + 0.25*I2R(GetUnitAbilityLevel(u,'A083')))
    endif
    
    if id == 'A08A' then
        //remove last breath
        if GetUnitAbilityLevel(u2, 'A08B') > 0 and IsUnitEnemy(u2, GetOwningPlayer(u)) then
            call UnitRemoveAbility(u2, 'A08B')
            call UnitRemoveAbility(u2, 'B01D')
        endif
        
        if GetUnitAbilityLevel(u2, 'A08G') > 0 and IsUnitEnemy(u2, GetOwningPlayer(u)) then
            call UnitRemoveAbility(u2, 'A08G')
            call UnitRemoveAbility(u2, 'B01G')
        endif
    endif
    
    if id == 'A08E' then
        call Purge(u, u2)
        
    endif

    set u = null
    set u2 = null
endfunction







function Trig_Chaos_Magic_Spell_EFfect_Actions takes nothing returns nothing
local unit u = GetTriggerUnit()
local unit u2 = GetSpellTargetUnit()
local real x1 = GetSpellTargetX()
local real y1 = GetSpellTargetY()
local integer ID = 0 


  
call AbilityChanelCst(u,u2,x1,y1,GetSpellAbilityId())
  




if Trig_Disable_Abilities_Func001C() == false and  BlzGetAbilityCooldown(GetSpellAbilityId(),GetUnitAbilityLevel(GetTriggerUnit(),GetSpellAbilityId() )-1 ) > 0 then

if GetUnitAbilityLevel(u,'A04L') > 0 then

if u2 != null and u != u2 then
    set ID = GetRandomAbility1()
    call ElemFuncStart(u,'A04L' )
    call CreateTextTagTimerColor(  "CHAOS MAGIC "+GetObjectName(ID),1,GetUnitX(u),GetUnitY(u),50,1,122,50,255)
    call CastRandomSpell1(u,ID ,GetUnitAbilityLevel(u,'A04L'),u2,0,0) 

elseif x1 != 0 and y1 != 0 then
    call ElemFuncStart(u,'A04L' )
      set ID = GetRandomAbility2()
       call CreateTextTagTimerColor(  "CHAOS MAGIC  "+GetObjectName(ID),1,GetUnitX(u),GetUnitY(u),50,1,122,50,255)

  call CastRandomSpell1(u,ID ,GetUnitAbilityLevel(u,'A04L'),null,x1,y1)

endif
     



endif
endif



set u = null
set u2 = null



endfunction


//===========================================================================
function InitTrig_Chaos_Magic_Spell_EFfect takes nothing returns nothing
    set gg_trg_Chaos_Magic_Spell_EFfect = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Chaos_Magic_Spell_EFfect, EVENT_PLAYER_UNIT_SPELL_EFFECT)
    call TriggerAddAction( gg_trg_Chaos_Magic_Spell_EFfect, function Trig_Chaos_Magic_Spell_EFfect_Actions )
    call InitArcaneTalant()
endfunction

