globals

    hashtable HT_timerSpell = InitHashtable()

endglobals




function USOrder4fieldTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local real x =  LoadReal(HT,i,3)
    local real y =  LoadReal(HT,i,4)
    local integer idsp =  LoadInteger(HT,i,5)
    local string ordstr =  LoadStr(HT,i,6)
    local real Field1 = LoadReal(HT,i,7)
    local abilityreallevelfield RealField1 = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
    local real Field2 = LoadReal(HT,i,9)
    local abilityreallevelfield RealField2 = ConvertAbilityRealLevelField(LoadInteger(HT,i,10))
    local real Field3 = LoadReal(HT,i,11)
    local abilityreallevelfield RealField3 = ConvertAbilityRealLevelField(LoadInteger(HT,i,12))
    local real Field4 = LoadReal(HT,i,13)
    local abilityreallevelfield RealField4 = ConvertAbilityRealLevelField(LoadInteger(HT,i,14))
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, 0  )
    
    call FlushChildHashtable(HT,i)
    call DestroyTimer(t)
    call UnitAddAbility(Caster1,idsp ) 


    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),RealField1,0,Field1)
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),RealField2,0,Field2)
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),RealField3,0,Field3)
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),RealField4,0,Field4)

    call IssueImmediateOrder( Caster1, ordstr )
    call UnitApplyTimedLife(Caster1,'B000',2)


    set Caster1  = null
    set t = null
    set u1 = null
endfunction



function USOrder4field takes unit u1, real x, real y,integer idsp, string ordstr, real Field1, abilityreallevelfield  RealField1, real Field2, abilityreallevelfield  RealField2,real Field3, abilityreallevelfield  RealField3,real Field4, abilityreallevelfield  RealField4 returns nothing

    local timer t = CreateTimer()
    local integer i = GetHandleId(t)
    call SaveUnitHandle(HT,i,1,u1)
    call SaveReal(HT,i,3,x)
    call SaveReal(HT,i,4,y)
    call SaveInteger(HT,i,5,idsp)
    call SaveStr(HT,i,6,ordstr)
    call SaveReal(HT,i,7,Field1)
    call SaveInteger(HT,i,8,GetHandleId(RealField1))
    call SaveReal(HT,i,9,Field2)
    call SaveInteger(HT,i,10,GetHandleId(RealField2))
    call SaveReal(HT,i,11,Field3)
    call SaveInteger(HT,i,12,GetHandleId(RealField3))
    
    call SaveReal(HT,i,13,Field4)
    call SaveInteger(HT,i,14,GetHandleId(RealField4))
    call TimerStart(t,0,false,function USOrder4fieldTimer)


    set u1 = null
    set t = null
endfunction

 function EndInvision takes nothing returns nothing
     local timer   startbattle = GetExpiredTimer()
     local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1) 
 
      call UnitRemoveAbility(Herou,'A03V')
 
    call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),1,null)
    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call DestroyTimer(startbattle)
    set startbattle = null
endfunction
 
function EndCheaterMagic takes nothing returns nothing
     local timer   startbattle = GetExpiredTimer()
     local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1) 
     call DestroyEffect(  LoadEffectHandle(HT_timerSpell,GetHandleId(startbattle),2)   ) 
 
    call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),2,null)
    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call UnitRemoveAbility(Herou, 'A08G')
    call UnitRemoveAbility(Herou, 'B01G')
    call DestroyTimer(startbattle)
    set startbattle = null
endfunction


function EndGodDefender takes nothing returns nothing
     local timer   startbattle = GetExpiredTimer()
     local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1) 
     call DestroyEffect(  LoadEffectHandle(HT_timerSpell,GetHandleId(startbattle),2)   ) 
 
    call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),3,null)
    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call DestroyTimer(startbattle)
    set startbattle = null
endfunction


function EndState takes nothing returns nothing
     local timer   startbattle = GetExpiredTimer()
     local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1) 
     local integer r4 = LoadInteger(HT_timerSpell,GetHandleId(startbattle),2)  
     
     
            call SetHeroStr(Herou,GetHeroStr(Herou,false)-(r4),false)
            call SetHeroAgi(Herou,GetHeroAgi(Herou,false)-(r4),false)
            call SetHeroInt(Herou,GetHeroInt(Herou,false)-(r4),false) 

    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call DestroyTimer(startbattle)
    set startbattle = null
endfunction


function EndStateGrunt takes nothing returns nothing
     local timer   startbattle = GetExpiredTimer()
     local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1) 
     local integer r4 = LoadInteger(HT_timerSpell,GetHandleId(startbattle),2)  
     
            call BlzSetUnitBaseDamage(Herou,BlzGetUnitBaseDamage(Herou,0)-R2I(r4),0)
            call SetHeroStr(Herou,GetHeroStr(Herou,false)-(r4),false)

    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call DestroyTimer(startbattle)
    set startbattle = null
endfunction


function FunctionTimerSpell takes nothing returns nothing
    local timer   startbattle = GetExpiredTimer()
    local timer  NewTimer = null
    local timer  OldTimer = null
    local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1)
    local boolean urn = LoadBoolean(HT_timerSpell, GetHandleId(startbattle), 4)
    local integer pid = GetPlayerId(GetOwningPlayer(Herou))
    local real r1 = 0
    local real r2 = 0
    local real r3 = 1 + (0.05*I2R(GetUnitAbilityLevel(Herou,'A03Y')))
    local real r4 = 0
    local real r5 = 0
    local integer i = 0
    local integer i1 = 0
    local unit U = null
    
    if GetPlayerSlotState(Player(pid)) == PLAYER_SLOT_STATE_LEFT and ModeNoDeath == false then
		call SetUnitInvulnerable(Herou, false)
		call KillUnit(Herou)
        return
	endif
    
    set r2 = GetHeroLevel(Herou)
    
    set r1 = GetUnitAbilityLevel(Herou,'A03Q')
    if r1 > 0 then
        call ElemFuncStart(Herou,'A03Q')
        call USOrder4field(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03T',"battleroar",(100*r1)*(1+0.009*r2),ABILITY_RLF_DAMAGE_INCREASE,(10*r1)*(1+0.009*r2),ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 ,(7+(r2*0.09))*r3,ABILITY_RLF_DURATION_HERO,(7+(r2*0.09))*r3,ABILITY_RLF_DURATION_NORMAL)
    endif
 
    set r1 = GetUnitAbilityLevel(Herou,'A03U')    
    if r1 > 0 then
                call ElemFuncStart(Herou,'A03U')
        if LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),1) == null then
            set NewTimer = CreateTimer()
            call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),1,NewTimer)
            call SaveUnitHandle(HT_timerSpell,GetHandleId(NewTimer),1,Herou)
            call UnitAddAbility(Herou,'A03V')
            call TimerStart(NewTimer,(1.8 + (0.2*r1))*r3 ,false,function EndInvision)
        else
               set NewTimer = LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),1)
              call TimerStart(NewTimer,(1.8 + (0.2*r1))*r3 ,false,function EndInvision)
        endif  
    endif
    
    
    set r1 = GetUnitAbilityLevel(Herou,'A04E')    
    if r1 > 0 then
            call ElemFuncStart(Herou,'A04E')
            set OldTimer = LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),'A04E')
            
            if TimerGetRemaining(OldTimer) > 0 then
                call TimerStart(OldTimer,0,false,function EndState)
            endif
            set OldTimer = null
            
            set NewTimer = CreateTimer()    
            call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),'A04E',NewTimer)
            call SaveUnitHandle(HT_timerSpell,GetHandleId(NewTimer),1,Herou)
            set r4 = 40*r1*(1+0.02*r2) 
            call SaveInteger(HT_timerSpell,GetHandleId(NewTimer),2,R2I(r4))
            call SetHeroStr(Herou,GetHeroStr(Herou,false)+R2I(r4),false)
            call SetHeroAgi(Herou,GetHeroAgi(Herou,false)+R2I(r4),false)
            call SetHeroInt(Herou,GetHeroInt(Herou,false)+R2I(r4),false)
            call TimerStart(NewTimer,(8+ (0.02*r2))*r3 ,false,function EndState)


    endif
    
    set r1 = GetUnitAbilityLevel(Herou,'A04K')    
    if r1 > 0 and urn == false then
        call ElemFuncStart(Herou,'A04K')
        set r4 = 50*(r2+3)*(r2+4)-110  
        set r5 =  GetHeroXP(Herou)

    if GetUnitAbilityLevel(Herou,'Asal') > 0 then   
        call AddHeroXP(Herou,   R2I((r4-r5)*(r1 * 1.5))/200  , true) 
    else
        call AddHeroXP(Herou,   R2I((r4-r5)*(r1 * 1.5))/100  , true) 
    endif
    
    endif

   

    set r1 = GetUnitAbilityLevel(Herou,'A040')    
    if r1 > 0 then
        call ElemFuncStart(Herou,'A040')
        if LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),2) == null then
            set NewTimer = CreateTimer()
            call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),2,NewTimer)
            call SaveUnitHandle(HT_timerSpell,GetHandleId(NewTimer),1,Herou)
            call SaveEffectHandle(HT_timerSpell,GetHandleId(NewTimer),2, AddSpecialEffectTarget( "Objects\\InventoryItems\\tome\\tome.mdl", Herou ,"overhead"  )   )
            call TimerStart(NewTimer,(2.75 + (0.25*r1))*r3 ,false,function EndCheaterMagic)
            call UnitAddAbility(Herou, 'A08G')
        else
              set NewTimer = LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),2)
              call TimerStart(NewTimer,(2.75 + (0.25*r1))*r3 ,false,function EndCheaterMagic)
              call UnitAddAbility(Herou, 'A08G')
        endif     
    endif
    
    set r1 = GetUnitAbilityLevel(Herou,'A045')    
    if r1 > 0 then
        call ElemFuncStart(Herou,'A045')
        if LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),3) == null then
            set NewTimer = CreateTimer()
            call SaveTimerHandle(HT_timerSpell,GetHandleId(Herou),3,NewTimer)
            call SaveUnitHandle(HT_timerSpell,GetHandleId(NewTimer),1,Herou)
            call SaveEffectHandle(HT_timerSpell,GetHandleId(NewTimer),2, AddSpecialEffectTarget( "Soul Armor Divine_opt.mdx", Herou ,"head"  )   )
            call TimerStart(NewTimer,(2.70 + (0.3*r1))*r3 ,false,function EndGodDefender)
        else
              set NewTimer = LoadTimerHandle(HT_timerSpell,GetHandleId(Herou),3)
            call TimerStart(NewTimer,(2.70 + (0.3*r1))*r3 ,false,function EndGodDefender)
        endif     
    endif
    
    set r1 = GetUnitAbilityLevel(Herou,'A06Z')    
    if r1 > 0 then
        call ElemFuncStart(Herou,'A06Z')
        call CreateRandomRune(-60+10*r1,GetRandomReal(-100,100)+GetUnitX(Herou) ,GetRandomReal(-100,100)+GetUnitY(Herou)   ,Herou)
        call CreateRandomRune(-60+10*r1,GetRandomReal(-100,100)+GetUnitX(Herou) ,GetRandomReal(-100,100)+GetUnitY(Herou)   ,Herou)
        call CreateRandomRune(-60+10*r1,GetRandomReal(-100,100)+GetUnitX(Herou) ,GetRandomReal(-100,100)+GetUnitY(Herou)   ,Herou)   
    endif
    
    set i1 = UnitHasItemI( Herou,'I08L' )
    set i = 0
        call ElemFuncStart(Herou,'I08L')
    if  i1 > 0 then
        loop 
            exitwhen i >= R2I(i1)
            call CreateRandomRune(0,GetRandomReal(-100,100)+GetUnitX(Herou) ,GetRandomReal(-100,100)+GetUnitY(Herou)   ,Herou)
            set i = i + 1
        endloop
    endif
    
    if GetUnitTypeId(Herou) == 'H01J' then
            call ElemFuncStart(Herou,'H01J')
            set NewTimer = CreateTimer()  
            set r4 = 20*GetHeroLevel(Herou) 
            call SetHeroStr(Herou,GetHeroStr(Herou,false)+R2I(r4),false)
            call BlzSetUnitBaseDamage(Herou,BlzGetUnitBaseDamage(Herou,0)+R2I(r4),0)
            call SaveUnitHandle(HT_timerSpell,GetHandleId(NewTimer),1,Herou)
            call SaveInteger(HT_timerSpell,GetHandleId(NewTimer),2,R2I(r4))
            call TimerStart(NewTimer,8+0.05 ,false,function EndStateGrunt)
    endif
    
    
    if UnitHasItemS(Herou,'I07O') then
        call ElemFuncStart(Herou,'I07O')
        set U = CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
        call UnitApplyTimedLife(U,'A041',90)
        set U =  CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
                call UnitApplyTimedLife(U,'A041',90)
        set U =  CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
                call UnitApplyTimedLife(U,'A041',90)
        set U =  CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
                call UnitApplyTimedLife(U,'A041',90)
        
    endif
    
    
    
    
    set r1 = GetUnitAbilityLevel(Herou,'A041')   
    if r1 > 0 then
        call ElemFuncStart(Herou,'A041')
       set U = CreateUnit( GetOwningPlayer(Herou),'h01A',GetUnitX(Herou)+40*CosBJ(-30+GetUnitFacing(Herou)),GetUnitY(Herou)+40*SinBJ(-30+GetUnitFacing(Herou)),GetUnitFacing(Herou) )
       call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)-500+R2I((r1*10000)*(1+(r2*0.038) )) )
       call BlzSetUnitBaseDamage(U, BlzGetUnitBaseDamage(U,0) -10 + R2I((r1*100)*(1+(r2*0.038)) ),0)
       call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
       call UnitApplyTimedLife(U,'A041',8 + (r2*0.09))
       call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",U,"head"))

       set U = CreateUnit( GetOwningPlayer(Herou),'h01A',GetUnitX(Herou)+40*CosBJ(30+GetUnitFacing(Herou)),GetUnitY(Herou)+40*SinBJ(30+GetUnitFacing(Herou)),GetUnitFacing(Herou) )
       call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)-500+R2I((r1*10000)*(1+(r2*0.038) )) )
       call BlzSetUnitBaseDamage(U, BlzGetUnitBaseDamage(U,0) -10 + R2I((r1*100)*(1+(r2*0.038)) ),0)
       call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
       call UnitApplyTimedLife(U,'A041',8 + (r2*0.09))
       call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",U,"head"))
             
    endif

     set i1 = UnitHasItemI( Herou,'I06I' )
     if  i1 > 0 then
         call ElemFuncStart(Herou,'I06I')
         call SetUnitState(Herou, UNIT_STATE_MANA, GetUnitState(Herou, UNIT_STATE_MANA)-35000*i1  )
    endif
    
    
    
    set i1 = UnitHasItemI( Herou,'I07G' )
    if  i1 > 0 then
         call ElemFuncStart(Herou,'I07G')
         call BlzSetUnitArmor(Herou,BlzGetUnitArmor(Herou)+i1*20*NumberOfUnit[pid] )
         call AddUnitBlock(Herou,i1*20*NumberOfUnit[pid])
         call SaveInteger(HT,GetHandleId(Herou),54001,LoadInteger(HT,GetHandleId(Herou),54001)+i1*20*NumberOfUnit[pid] ) 
    endif
    

     set i1 = UnitHasItemI( Herou,'I06J' )
     if  i1 > 0 then
         call ElemFuncStart(Herou,'I06J')
         call SetPlayerTechResearchedSwap( 'R000', ( i1 + GetPlayerTechCountSimple('R000', GetOwningPlayer(Herou)) ), GetOwningPlayer(Herou) )
         call SetPlayerTechResearchedSwap( 'R001', ( i1 + GetPlayerTechCountSimple('R001', GetOwningPlayer(Herou)) ), GetOwningPlayer(Herou) )    
         call SetPlayerTechResearchedSwap( 'R002', ( i1 + GetPlayerTechCountSimple('R002', GetOwningPlayer(Herou)) ), GetOwningPlayer(Herou) )
             
    endif 

 
        
    if GetUnitTypeId(Herou) == 'H019' then
        call ElemFuncStart(Herou,'H019')
        call USOrder4field(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03Z',"stomp",55*r2,ABILITY_RLF_DAMAGE_INCREASE,1800,ABILITY_RLF_SPECIFIC_TARGET_DAMAGE_HTC2 ,1+(r2*0.04),ABILITY_RLF_DURATION_HERO,2+(r2*0.08),ABILITY_RLF_DURATION_NORMAL)
    endif
        
    set r1 = GetUnitAbilityLevel(Herou,'A03X')    
    if r1 > 0 then
        call ElemFuncStart(Herou,'A03X')
      call USOrder4field(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03W',"battleroar",(10*r1)*(1+0.02*r2),ABILITY_RLF_LIFE_REGENERATION_RATE,(10*r1)*(1+0.02*r2),ABILITY_RLF_MANA_REGEN ,(8+(r2*0.2))*r3,ABILITY_RLF_DURATION_HERO,(8+(r2*0.2))*r3,ABILITY_RLF_DURATION_NORMAL)

    endif
    
    
    set r1 = GetUnitAbilityLevel(Herou,'A042')    
    if r1 > 0 then
              call ElemFuncStart(Herou,'A042')
      call USOrder4field(Herou,GetUnitX(Herou),GetUnitY(Herou),'A043',"howlofterror",0,ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1,(10*r1)*(1+0.02*r2),ABILITY_RLF_DAMAGE_HBZ2 ,(8+(r2*0.09))*r3,ABILITY_RLF_DURATION_HERO,(8+(r2*0.09))*r3,ABILITY_RLF_DURATION_NORMAL)
    endif
  
    call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
    call DestroyTimer(startbattle)
    set U = null
    set startbattle = null
    set NewTimer = null
endfunction

    function FixAbilityU takes unit u returns nothing
    local integer i1 = 0

    set i1 = LoadInteger(HT,GetHandleId(u),54021)
    
    if i1 != 0 then 
        call SetHeroStr(u,GetHeroStr(u,false)-i1,false)
        call SetHeroAgi(u,GetHeroAgi(u,false)-i1,false)
        call SetHeroInt(u,GetHeroInt(u,false)-i1,false)
        call SaveInteger(HT,GetHandleId(u),54021,0)
    endif

    endfunction

    function StartFunctionSpell takes unit Hero, integer i1 returns nothing
        local timer startbattle = CreateTimer()
        
        if i1 != 6 then
            call FixAbilityU (Hero)
        endif    
        
        if i1 == 6 then
            call SaveBoolean(HT_timerSpell,GetHandleId(startbattle),4,true)
        endif

        if i1 == 2 then
            call TimerStart(startbattle,4.53 +GetRandomReal(0,.01),false,function FunctionTimerSpell )
            call SaveUnitHandle(HT_timerSpell,GetHandleId(startbattle),1,Hero)     
        else
            call TimerStart(startbattle,0.05,false,function FunctionTimerSpell )
            call SaveUnitHandle(HT_timerSpell,GetHandleId(startbattle),1,Hero)        
        endif
        set  startbattle = null
        //	call DisplayTextToPlayer(GetLocalPlayer(),0,0,"yea"+I2S(i1) )
    endfunction

