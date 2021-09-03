globals 
    hashtable HT_SpellPlayer = InitHashtable()
endglobals


function LoadCountHeroSpell takes  unit u,integer list returns integer 
    return LoadInteger(HT_SpellPlayer,GetHandleId(u),-list)
endfunction
function SetInfoHeroSpell takes unit u, integer num, integer id returns nothing
    call SaveInteger(HT_SpellPlayer,GetHandleId(u),num,id)
    call SaveInteger(HT_SpellPlayer,GetHandleId(u),id,num)
endfunction





function SaveCountHeroSpell takes unit u,integer count,integer list returns nothing 
    call SaveInteger(HT_SpellPlayer,GetHandleId(u),-list,count)
endfunction
function RemoveInfoHeroSpell takes unit u, integer id returns nothing
    local integer num =LoadInteger(HT_SpellPlayer,GetHandleId(u),id)
    call SaveInteger(HT_SpellPlayer,GetHandleId(u),num,0)
    call SaveInteger(HT_SpellPlayer,GetHandleId(u),id,0)
endfunction

function AddSpellPlayerInfo takes integer id, unit u, integer list returns nothing
    local integer i1 = 1 + 10*list
    local integer Count =  LoadCountHeroSpell(u,list)
    local integer Current = 1
    local integer InfoId 
    local boolean HaveSpell = false
    loop
        set InfoId = GetInfoHeroSpell(u,i1)
        if  (InfoId == 0) and (Current == 0) then
           set Current = i1
        endif
        
        if id == InfoId then
           set HaveSpell = true
        endif
        
        set i1 = i1 + 1
    exitwhen  (i1 > 10+10*list) or  (HaveSpell)
    endloop
    if HaveSpell == false then
         set Count = Count + 1
         call SaveCountHeroSpell(u,Count,list)
         call SetInfoHeroSpell(u,Count+list*10,id)
    endif 

   //  call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(LoadCountHeroSpell(u) ))
endfunction

function  FuncEditParam takes integer iDs, unit GetU returns nothing
    local integer i1 = 0
    local integer i2 = 0
    local integer NumAbility
    
    call AddSpellPlayerInfo(iDs,GetU,0)
    
    call SetChanellOrder(GetU,iDs,GetInfoHeroSpell(GetU,iDs)  )
    
    if iDs == 'AEev' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10001) 
        call AddUnitEvasion(GetU ,   2*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10001,i1)
    endif
    
    if iDs == 'Acdb' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10002) 
        call AddUnitEvasion(GetU ,   1*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10002,i1)
    endif    

    if iDs == 'Assk' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10003) 
        call AddUnitBlock(GetU ,   50*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10003,i1)
    endif 
    
    if iDs == 'A05S' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10004) 
        call AddUnitMagicDef(GetU ,   3*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10004,i1)
        call SetPlayerAbilityAvailable(GetOwningPlayer(GetU), 'A05S', false)
        call SetPlayerAbilityAvailable(GetOwningPlayer(GetU), 'A05S', true)
    endif 

    if iDs == 'A06V' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10005) 
        call AddUnitLuck(GetU ,   0.01*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10005,i1)
    endif 
    

    
    if iDs == 'A05Z' or iDs == 'A05U' and GetUnitAbilityLevel(GetU,iDs) == 1 then
        call BlzStartUnitAbilityCooldown(GetU,iDs,60)
    endif
    
    
   if iDs == 'A02O' then     
     if LoadReal(HT, GetHandleId(GetU),1 ) == 0 then 
         call SaveReal(HT,GetHandleId(GetU),1, BlzGetUnitAttackCooldown(GetU,0)    )
     endif
     call SaveReal(HT,GetHandleId(GetU),'A02O', 0.02*I2R(GetUnitAbilityLevel(GetU,iDs))   )	
//     call BlzSetUnitAttackCooldown(GetU, 0.92 - (0.02*I2R(GetUnitAbilityLevel(GetU,iDs)) ),0  )
    endif
endfunction



function  FunResetAbility takes integer iDs, unit GetU returns nothing
    local integer i1 =0
    local integer i2 =0
    
    call RemoveInfoHeroSpell(GetU,iDs)
    
    if iDs == 'AEev' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10001) 
        call AddUnitEvasion(GetU ,   2*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10001,i1)
    endif
    
    if iDs == 'Acdb' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10002) 
        call AddUnitEvasion(GetU ,   I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10002,i1)
    endif 
    
    if iDs == 'Assk' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10003) 
        call AddUnitBlock(GetU ,   50*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10003,i1)
    endif 
    
    if iDs == 'A05S' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10004) 
        call AddUnitMagicDef(GetU ,   3*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10004,i1)
    endif 
    
    if iDs == 'A082' then
       	set i1 = GetUnitAbilityLevel(GetU,iDs)
    	set i2 = LoadInteger(HT,GetHandleId(GetU),-10005) 
        call AddUnitLuck(GetU ,   0.01*I2R(i1-i2)  )	
    	call SaveInteger(HT,GetHandleId(GetU),-10005,i1)
    endif 
    
    

   if iDs == 'A02O' then
     if LoadReal(HT, GetHandleId(GetU),1 ) != 0 then
     //   call BlzSetUnitAttackCooldown(GetU,LoadReal(HT, GetHandleId(GetU),1 ) ,0 ) 
     endif
   endif
endfunction

function FunctionStartUnit takes unit U returns nothing
    if LoadReal(HT, GetHandleId(U),1 ) == 0 then 
      call SaveReal(HT,GetHandleId(U),-1001, BlzGetUnitAttackCooldown(U,0)    )
      call SaveInteger(HT,GetHandleId(U),-1000,  BlzGetUnitIntegerField(U,UNIT_IF_PRIMARY_ATTRIBUTE)    )
    endif
endfunction









function Func_completeLevel takes unit u returns nothing
local player p = GetOwningPlayer(u)
local integer pid = GetPlayerId(p)
local integer i1 = 0 

set i1 = LoadInteger(HT,GetHandleId(u),54001)
if i1 != 0 then 
call BlzSetUnitArmor(u,BlzGetUnitArmor(u)-i1)
call AddUnitBlock(u,-i1)
call SaveInteger(HT,GetHandleId(u),54001,0)
set NumberOfUnit[pid] = 0
endif


set i1 = LoadInteger(HT,GetHandleId(u),54021)
if i1 != 0 then 

call SetHeroStr(u,GetHeroStr(u,false)-i1,false)
call SetHeroAgi(u,GetHeroAgi(u,false)-i1,false)
call SetHeroInt(u,GetHeroInt(u,false)-i1,false)
call SaveInteger(HT,GetHandleId(u),54021,0)
endif

set i1 = UnitHasItemI(u,'I07H') 
if i1 > 0 then
call AddUnitBlock(u,15*i1)
call AddUnitMagicDef(u,1*i1)

endif



set Glory[pid] = Glory[pid] + 200
call AdjustPlayerStateBJ( Income[pid],p,PLAYER_STATE_RESOURCE_GOLD)
call DisplayTextToPlayer(p,0,0,"|cffffff00Income:|r " + I2S(Income[pid]) )  





if Income[pid] == 0 then 
    call DisplayTextToPlayer(p,0,0,"You can increase your income in Power Ups Shop II")       
endif

endfunction









