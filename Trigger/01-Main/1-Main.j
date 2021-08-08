globals

    integer array SpellCP
    integer Global_i = 0
    unit Global_u = null
    


    boolean EffectVisible = true
     string LastBreathAnim = "Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl"

    unit GLOB_DEBUF = null

endglobals

function EndTextTagTimer takes nothing returns nothing
    local timer t  = GetExpiredTimer()
    local texttag tt = LoadTextTagHandle(HT_timerSpell,GetHandleId(t),1)
    
    call FlushChildHashtable(HT_timerSpell,GetHandleId(t))
    call DestroyTextTag(tt)
    call DestroyTimer(t)
    set t = null
    set tt = null
endfunction





function CreateTextTagTimer takes string Text, real Height, real x1, real y1,real z1, real time returns nothing
    local texttag tt = CreateTextTag()
    local timer t = CreateTimer()
    
    call SetTextTagText(tt,Text,Height* 0.023)
    call SetTextTagPos(tt,x1,y1,z1)
    call SetTextTagColor(tt,255,255,120,128)
    
    call SetTextTagVelocity(tt,0.01,0.04)
    
    call SaveTextTagHandle(HT_timerSpell,GetHandleId(t),1,tt)
    

    call TimerStart(t,time,false,function EndTextTagTimer)
    
    set tt =null
    set t  =null
endfunction

function CreateTextTagTimerColor takes string Text, real Height, real x1, real y1,real z1, real time,integer iR,integer iG,integer iB returns nothing
    local texttag tt = CreateTextTag()
    local timer t = CreateTimer()
    
    call SetTextTagText(tt,Text,Height* 0.023)
    call SetTextTagPos(tt,x1,y1,z1)
    call SetTextTagColor(tt,iR,iG,iB,128)
    
    call SetTextTagVelocity(tt,0.01,0.04)
    
    call SaveTextTagHandle(HT_timerSpell,GetHandleId(t),1,tt)
    

    call TimerStart(t,time,false,function EndTextTagTimer)
    
    set tt =null
    set t  =null
endfunction



function UnitHasItemS takes unit u, integer id returns boolean 

	if   GetItemTypeId(UnitItemInSlot( u,0)) == id then
	    return true
	endif
	if   GetItemTypeId(UnitItemInSlot( u,1)) == id then
	    return true
	endif
	if   GetItemTypeId(UnitItemInSlot( u,2)) == id then
	    return true
	endif
	if   GetItemTypeId(UnitItemInSlot( u,3)) == id then
	    return true
	endif
 	if   GetItemTypeId(UnitItemInSlot( u,4)) == id then
	    return true
	endif
	if   GetItemTypeId(UnitItemInSlot( u,5)) == id then
	    return true
	endif

	return false

endfunction


function UnitHasItemI takes unit u, integer id returns integer
	local integer i = 0
	if   GetItemTypeId(UnitItemInSlot( u,0)) == id then
	    set i = i + 1
	endif
	if   GetItemTypeId(UnitItemInSlot( u,1)) == id then
	    set i = i + 1
	endif
	if   GetItemTypeId(UnitItemInSlot( u,2)) == id then
	    set i = i + 1
	endif
	if   GetItemTypeId(UnitItemInSlot( u,3)) == id then
	    set i = i + 1
	endif
 	if   GetItemTypeId(UnitItemInSlot( u,4)) == id then
	    set i = i + 1
	endif
	if   GetItemTypeId(UnitItemInSlot( u,5)) == id then
	    set i = i + 1
	endif

	return i

endfunction


function EndHeroTempAgi takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer value = LoadInteger(HT,GetHandleId(t),1)
    local unit u = LoadUnitHandle(HT,GetHandleId(t),2)
    
    call SetHeroAgi(u,GetHeroAgi(u,false)-value,false)

    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t = null
    set u = null
endfunction

function AddHeroTempAgi takes unit u, integer value, real time returns nothing
    local timer t = CreateTimer()
    
    call SetHeroAgi(u,GetHeroAgi(u,false)+value,false)
    call SaveInteger(HT,GetHandleId(t),1,value)
    call SaveUnitHandle(HT,GetHandleId(t),2,u)
    call TimerStart(t,time,false,function EndHeroTempAgi)
    set t = null
endfunction




function UnitHasFullItems takes unit u returns boolean
    if UnitItemInSlot(u,0) != null and UnitItemInSlot(u,1) != null and UnitItemInSlot(u,2) != null and UnitItemInSlot(u,3) != null and UnitItemInSlot(u,4) != null and UnitItemInSlot(u,5) != null then
        return true
    endif
    return false
endfunction


function DebufEx takes nothing returns nothing
    local unit Un = GLOB_DEBUF
    call UnitRemoveAbility(Un,'Bclf')
    call UnitRemoveAbility(Un,'Bply')
    call UnitRemoveAbility(Un,'Bslo')
    call UnitRemoveAbility(Un,'BHbd')
    call UnitRemoveAbility(Un,'BHfs')
    call UnitRemoveAbility(Un,'BHbn')
    call UnitRemoveAbility(Un,'Bbof')
    call UnitRemoveAbility(Un,'Bliq')
    call UnitRemoveAbility(Un,'Bens')
    call UnitRemoveAbility(Un,'BOhx')
    call UnitRemoveAbility(Un,'BOeq')
    call UnitRemoveAbility(Un,'Bcri')
    call UnitRemoveAbility(Un,'Bweb')
    call UnitRemoveAbility(Un,'Bwea')
    call UnitRemoveAbility(Un,'Bfzr')
    call UnitRemoveAbility(Un,'Bapl')
    call UnitRemoveAbility(Un,'BUsl')
    call UnitRemoveAbility(Un,'BUdd')
    call UnitRemoveAbility(Un,'Bssd')
    call UnitRemoveAbility(Un,'Bspo')
    call UnitRemoveAbility(Un,'Bcor')
    call UnitRemoveAbility(Un,'Bfae')
    call UnitRemoveAbility(Un,'BEer')
    call UnitRemoveAbility(Un,'BEsh')
    call UnitRemoveAbility(Un,'Bpsd')
    call UnitRemoveAbility(Un,'Bpoi')
    call UnitRemoveAbility(Un,'BNba')
    call UnitRemoveAbility(Un,'BNdh')
    call UnitRemoveAbility(Un,'BNht')
    call UnitRemoveAbility(Un,'Basl')
    call UnitRemoveAbility(Un,'BNdo')
    call UnitRemoveAbility(Un,'BNbf')
    call UnitRemoveAbility(Un,'BNrd')
    call UnitRemoveAbility(Un,'BSTN')
    call UnitRemoveAbility(Un,'BNpm')
    call UnitRemoveAbility(Un,'BPpa')
    call UnitRemoveAbility(Un,'BNrd')
    call UnitRemoveAbility(Un,'BPSE')
    call UnitRemoveAbility(Un,'BSTN')
    call UnitRemoveAbility(Un,'BNsi')
    call UnitRemoveAbility(Un,'Bcsd')
    call UnitRemoveAbility(Un,'BHca')
    call UnitRemoveAbility(Un,'BNht')
    call UnitRemoveAbility(Un,'BCbf')
    call UnitRemoveAbility(Un,'Bfro')
    call UnitRemoveAbility(Un,'Blcb')
    call UnitRemoveAbility(Un,'BNso')
    call UnitRemoveAbility(Un,'BNab')
    call UnitRemoveAbility(Un,'BNic')
    call UnitRemoveAbility(Un,'BNvc')
    call UnitRemoveAbility(Un,'B00J')
    call UnitRemoveAbility(Un,'B00H')
    call UnitRemoveAbility(Un,'B001')
    call UnitRemoveAbility(Un,'B005')
    call UnitRemoveAbility(Un,'B00V')
    call UnitRemoveAbility(Un,'B017')
    call UnitRemoveAbility(Un,'A06L')
    call UnitRemoveAbility(Un,'A06P')
    call UnitRemoveAbility(Un,'A06R')
    call UnitRemoveAbility(Un,'B014')
    call UnitRemoveAbility(Un,'B015')
    call UnitRemoveAbility(Un,'B016')
    set Un = null
endfunction

function Debuf takes nothing returns nothing 
    local timer t = GetExpiredTimer()
    set GLOB_DEBUF = LoadUnitHandle(HT,GetHandleId(t),1)
    call DebufEx()
    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t =null
endfunction

function RemoveDebuff takes unit Un returns nothing
    local timer t = CreateTimer()
    set GLOB_DEBUF = Un
    call DebufEx()
    call SaveUnitHandle(HT,GetHandleId(t),1,Un)
    call TimerStart(t,0,false,function Debuf)
    set t = null        
endfunction


function UsOrderUTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local real x =  LoadReal(HT,i,3)
    local real y =  LoadReal(HT,i,4)
    local integer idsp =  LoadInteger(HT,i,5)
    local string ordstr =  LoadStr(HT,i,6)
    local real life_1 = LoadReal(HT,i,7)
    local abilityreallevelfield REALF = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, Rad2Deg(Atan2(GetUnitY(u2)-y, GetUnitX(u2)-x))  )
    call DestroyTimer(t)
    call FlushChildHashtable(HT,i)
    set t  = null
    call UnitAddAbility(Caster1,idsp ) 
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)
    call IssueTargetOrder(Caster1,ordstr,u2)
    call UnitApplyTimedLife(Caster1,'B000',6)
    set Caster1  = null
    set u1 = null
    set u2 = null
endfunction

function UsOrderU takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield  REALF returns nothing
    local timer t = CreateTimer()
    local integer i = GetHandleId(t)
    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    call SaveReal(HT,i,3,x)
    call SaveReal(HT,i,4,y)
    call SaveInteger(HT,i,5,idsp)
    call SaveStr(HT,i,6,ordstr)
    call SaveReal(HT,i,7,life_1)
    call SaveInteger(HT,i,8,GetHandleId(REALF))
    call TimerStart(t,0,false,function UsOrderUTimer)
    set u1 = null
    set u2 = null

endfunction


function UsOrderU2Timer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local unit u2 = LoadUnitHandle(HT,i,2)
    local real x =  LoadReal(HT,i,3)
    local real y =  LoadReal(HT,i,4)
    local integer idsp =  LoadInteger(HT,i,5)
    local string ordstr =  LoadStr(HT,i,6)
    local real life_1 = LoadReal(HT,i,7)
    local abilityreallevelfield REALF1 = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
    local real life_2 = LoadReal(HT,i,9)
    local abilityreallevelfield REALF2 = ConvertAbilityRealLevelField(LoadInteger(HT,i,10))
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, Rad2Deg(Atan2(GetUnitY(u2)-y, GetUnitX(u2)-x))  )
    
    
    call UnitAddAbility(Caster1,idsp ) 
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF1,0,life_1)
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF2,0,life_2)
    call IssueTargetOrder(Caster1,ordstr,u2)
    call UnitApplyTimedLife(Caster1,'B000',6)
    
    
    call DestroyTimer(t)
    call FlushChildHashtable(HT,i)
    set Caster1  = null
    set t = null
    set u1 = null
endfunction



function UsOrderU2 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real Field1,real Field2, abilityreallevelfield  RealField1,abilityreallevelfield  RealField2 returns nothing
    local timer t = CreateTimer()
    local integer i = GetHandleId(t)
    call SaveUnitHandle(HT,i,1,u1)
    call SaveUnitHandle(HT,i,2,u2)
    call SaveReal(HT,i,3,x)
    call SaveReal(HT,i,4,y)
    call SaveInteger(HT,i,5,idsp)
    call SaveStr(HT,i,6,ordstr)
    call SaveReal(HT,i,7,Field1)
    call SaveInteger(HT,i,8,GetHandleId(RealField1))
    call SaveReal(HT,i,9,Field2)
    call SaveInteger(HT,i,10,GetHandleId(RealField2))

    
    call TimerStart(t,0,false,function UsOrderU2Timer)


    set u1 = null
    set t = null
endfunction

function GetUnitLuck takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),5)+1
endfunction

function ElemFuncStart takes unit u, integer id returns nothing
    set GLOB_ELEM_U = u
    set GLOB_ELEM_I = id
    call ExecuteFunc("ElementStartAbilityS")
endfunction 


function AbilStartCD takes unit u, integer id,real cd returns real
    local real ResCD = 1
    local real luck = GetUnitLuck(u)
 
         
    if GetUnitAbilityLevel(u,'A03P') >= 1 then
         set ResCD =  ResCD*(1-0.01*I2R(GetUnitAbilityLevel(u,'A03P'))) 
    endif
    

    if (UnitHasItemS(u,'I03P') or GetUnitTypeId(u ) == 'H01D')  and  GetRandomReal(0,100) <= 25*luck then
		set ResCD = 0.0
		call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl",u,"origin" )  )     
    endif 
    
    if  UnitHasItemS(u,'I08Y') and LoadBoolean(Elem,id,2) then
        if GetRandomReal(0,100) <= 40*luck then
            set ResCD = 0.001
        endif
    endif
    
     if  UnitHasItemS(u,'I08Z') and LoadBoolean(Elem,id,3) then
            set ResCD =ResCD*0.65
    endif   
    


    call ElemFuncStart(u,id)

    call BlzStartUnitAbilityCooldown(u,id,cd*ResCD)
    
    if id != 'A05U' then
        set Global_i = id
        set Global_u = u
        call ExecuteFunc("ResetAbilit_Ec")
    endif

    return cd*ResCD 
endfunction

function AddSpecialEffectTargetFix takes string s1, unit u, string s2 returns effect
    local string EffectString = ""

    if EffectVisible then
        set EffectString = s1
    endif

    return  AddSpecialEffectTarget(EffectString,u,s2)
endfunction


function EffectEndTimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    call DestroyEffect(LoadEffectHandle(HT,GetHandleId(t),1))
    
    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t = null
endfunction



function AddSpecialEffectTargetTimer takes string s1, unit u, string s2,real time returns nothing
    local string EffectString = ""
    local timer t = CreateTimer()
    local effect e 
    if EffectVisible then
        set EffectString = s1
    endif
    set e = AddSpecialEffectTarget(EffectString,u,s2)
    call SaveEffectHandle(HT,GetHandleId(t),1,e)
    call TimerStart(t,time,false,function EffectEndTimer)
    set e = null
    set t =null
endfunction

function USOrderATimer takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local unit u1 = LoadUnitHandle(HT,i,1)
    local real x =  LoadReal(HT,i,3)
    local real y =  LoadReal(HT,i,4)
    local integer idsp =  LoadInteger(HT,i,5)
    local string ordstr =  LoadStr(HT,i,6)
    local real life_1 = LoadReal(HT,i,7)
    local abilityreallevelfield REALF = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
    local unit Caster1 = CreateUnit(GetOwningPlayer(u1),'h015',x,y, 0  )

    call DestroyTimer(t)
    call FlushChildHashtable(HT,i)
    set t  = null

    call UnitAddAbility(Caster1,idsp ) 
    call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)


    call IssueImmediateOrder( Caster1, ordstr )
    call UnitApplyTimedLife(Caster1,'B000',9)


    set Caster1  = null
endfunction


function USOrderA takes unit u1, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield  REALF returns nothing

    local timer t = CreateTimer()
    local integer i = GetHandleId(t)
    call SaveUnitHandle(HT,i,1,u1)
    call SaveReal(HT,i,3,x)
    call SaveReal(HT,i,4,y)
    call SaveInteger(HT,i,5,idsp)
    call SaveStr(HT,i,6,ordstr)
    call SaveReal(HT,i,7,life_1)
    call SaveInteger(HT,i,8,GetHandleId(REALF))
    call TimerStart(t,0,false,function USOrderATimer)
    
endfunction

function GetUnitPowerRune takes unit u returns real
    return LoadReal(HT_unitstate,GetHandleId(u),6)
endfunction

function CreateRandomRune takes real power,real x,real y,unit owner returns item
    local item i = CreateItem( Runes[GetRandomInt(1,RuneCount)] ,x,y)
    call SaveReal(HT,GetHandleId(i),2,power+GetUnitPowerRune(owner) + GetHeroLevel(owner)*2 )
    if GetLocalPlayer() != GetOwningPlayer(owner) then
        call BlzSetItemSkin(i,'I06F')
    endif
    return i
endfunction 

function CreateRune takes real power,real x,real y,unit owner,integer id returns item
    local item i = CreateItem( Runes[id] ,x,y)
    call SaveReal(HT,GetHandleId(i),2,power+GetUnitPowerRune(owner) + GetHeroLevel(owner) )
    if GetLocalPlayer() != GetOwningPlayer(owner) then
        call BlzSetItemSkin(i,'I06F')
    endif
    return i
endfunction


function SetUnitProcHp takes unit u, real bonus returns nothing
    local real BonusOldHp = LoadReal(HT,GetHandleId(u),-412446)
    local real Hp  =   I2R(BlzGetUnitMaxHP(u))-BonusOldHp
    local real BonusNewHp  = Hp*bonus
    call BlzSetUnitMaxHP(u,R2I(Hp + BonusNewHp) )  
    call SaveReal(HT,GetHandleId(u),-412446, I2R(R2I(BonusNewHp)))
endfunction


function GetInfoHeroSpell takes unit u, integer num returns integer
    return LoadInteger(HT_SpellPlayer,GetHandleId(u),num)
endfunction

function GetNumHeroSpell takes unit u,integer id returns integer
    return LoadInteger(HT_SpellPlayer,GetHandleId(u),id)
endfunction

function GetClassUnitSpell takes unit u, integer id returns integer 
    local integer i1 = 1
    local integer i2 = 0
    if LoadBoolean(Elem,GetUnitTypeId(u), id) then
        set i2 = i2 + 1
    endif
    
    loop
        exitwhen i1 > 20

        if LoadBoolean(Elem,GetInfoHeroSpell(u ,i1), id) then
            set i2 = i2 + 1
        endif
        set i1 = i1 + 1
    endloop
    return i2 
endfunction




function AddCooldowns takes unit u,real cd returns nothing
    local integer i1 = 1
    local integer id = 0 
    loop
        exitwhen i1 > 10
            set id = GetInfoHeroSpell(u ,i1)
            call BlzStartUnitAbilityCooldown(u,id, cd+BlzGetUnitAbilityCooldownRemaining(u,id))

        set i1 = i1 + 1
    endloop
endfunction