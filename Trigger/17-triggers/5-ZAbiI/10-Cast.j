function UsOrderUTimer51 takes unit u1, unit u2, real dmg returns nothing
    local real x = GetUnitX(u1)
    local real y = GetUnitY(u1)
    local boolean check = false
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, 0  )
    call UnitAddAbility(Caster1,'A07Y' ) 

    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,'A07Y'),ABILITY_RLF_DAMAGE_CTB1,0,dmg)
    set check  = IssueTargetOrder(Caster1,"thunderbolt",u2)
    
    call UnitApplyTimedLife(Caster1,'B000',3)
    set Caster1  = null
    set u1 = null
    set u2 = null
endfunction


function realaisFrostBolt takes nothing returns nothing 
    local timer t = GetExpiredTimer()
    local unit u1 = LoadUnitHandle(HT,GetHandleId(t),3)
    local unit u2 = LoadUnitHandle(HT,GetHandleId(t),4)    
    local integer count = LoadInteger(HT,GetHandleId(t),1)

    if count == 0 then
        call FlushChildHashtable(HT,GetHandleId(t))
        call DestroyTimer(t)
    else 
        set count = count - 1 
        call UsOrderUTimer51(u1,u2,LoadReal(HT,GetHandleId(t),2))   
        call SaveInteger(HT,GetHandleId(t),1,count)
    endif
    set t = null
    set u1 = null
    set u2 = null
endfunction

function UsFrostBolt takes unit u1, unit u2,real dmg, integer count returns nothing
    local timer t = CreateTimer()
    call SaveInteger(HT,GetHandleId(t),1,count)
    call SaveReal(HT,GetHandleId(t),2,dmg)
    call SaveUnitHandle(HT,GetHandleId(t),3,u1)
    call SaveUnitHandle(HT,GetHandleId(t),4,u2)
    call TimerStart(t,0.45,true,function realaisFrostBolt)
    set t = null
endfunction

function SandRefreshAbility takes unit hero, real time returns nothing
   local integer i1 = 0
   local integer SpellId = 0
   local real cur_time 
   loop
        exitwhen i1 > 10
        set SpellId = GetInfoHeroSpell(hero ,i1)
        if LoadBoolean(Elem,SpellId,4) then
            set cur_time = time*2
        else
            set cur_time = time
        endif 
        if BlzGetUnitAbilityCooldownRemaining(hero,SpellId)>0 then
            call BlzStartUnitAbilityCooldown(hero,SpellId,BlzGetUnitAbilityCooldownRemaining(hero,SpellId)-time )
            elseif  BlzGetUnitAbilityCooldownRemaining(hero,SpellId) <  time then
              call BlzEndUnitAbilityCooldown(hero,SpellId)
        endif
        set i1 = i1 + 1
    endloop
endfunction

function AbilityChannel takes nothing returns nothing
    local unit u = GLOB_AB_CH
    local unit u2 = GLOB_TR_CH
    local real x1 = GLOB_X1_CH
    local real y1 = GLOB_Y1_CH
    local integer lvl = GLOB_LV_CH
    local integer ID = 0 
    local integer id = GLOB_ID_CH
    local AbilityData A = 0 
   // local AbilityLvl = 0

    if GetUnitTypeId(u) ==  'h00T' or GetUnitTypeId(u) == 'h014' or GetUnitTypeId(u) == 'h015' then
        set u = udg_units01[GetConvertedPlayerId(GetOwningPlayer( u ) ) ]
    endif

    if id == 'A07U' then
        if u2 != null and u != u2 then
            set ID = GetRandomAbility1()
            call CastRandomSpell1(u,ID ,lvl,u2,0,0) 
            set ID = GetRandomAbility1()
            call CastRandomSpell1(u,ID ,lvl,u2,0,0)
        elseif x1 != 0 and y1 != 0 then
          set ID = GetRandomAbility2()
          call CastRandomSpell1(u,ID ,lvl,null,x1,y1)
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

    if id == 'A084' then
        call HolyLight(u,u2,lvl)
    endif
    
    if id == 'A00M' then
        call CastDeathPact(u,u2,lvl)
    endif

    if id == 'A085' then
        set A = AbilityDataOrTempAD(u,'A085',lvl)
        call HealingWaveStart(u,u2,4,A.GetParam1(),A.GetDamage1(),A.GetRange2())
        call A.MayByRemove() 
    endif 

    if id == 'A086' then
        set A = AbilityDataOrTempAD(u,'A086',lvl)
        
        if u2 == null then
            call HealingWardStart(u,x1,y1,A.GetParam1(),A.GetArea1(),A.GetDurationNormal1() )
        else
                    call HealingWardStart(u,x1,y1,A.GetParam1(),A.GetArea1(),A.GetDurationNormal1() )
         //   call HealingWardStart(u,GetUnitX(u2),GetUnitY(u2),A.GetParam1(),A.GetArea1(),A.GetDurationNormal1() )    
        endif
        
        call A.MayByRemove() 
    endif
    
    if id == 'A087' then
        set A = AbilityDataOrTempAD(u,'A087',lvl)
        call RejuvinationStart(u,u2,A.GetParam1(),A.GetParam2(),A.GetDurationHero1(),A.GetDurationNormal1())
        call A.MayByRemove() 
    endif
    

    if id == 'A089' then
        set A = AbilityDataOrTempAD(u,'A089',lvl)
        call TranquilityStart(u,A.GetParam1(),A.GetParam2(),A.GetDurationHero1(),A.GetArea1())
        call A.MayByRemove() 
    endif
    


    set u = null
    set u2 = null
endfunction



