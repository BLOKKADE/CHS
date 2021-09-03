library RandomShit requires WitchDoctor
globals

        integer array SpellCP
        integer Global_i = 0
        unit Global_u = null
        
        constant real TEXT_SIZE = 0.024
        constant real TEXT_VEL = 0.06
        constant real TEXT_LIFE = 1
        constant real TEXT_FADE = 0.6

        boolean EffectVisible = true
        string LastBreathAnim = "Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl"

        unit GLOB_DEBUF = null

    endglobals

    function ReplaceText takes string stringToReplace, string value, string inputString returns string
        local integer Lenght = StringLength(stringToReplace)
        local integer Lenght3 = StringLength(inputString)
        local integer lp = 0
        
        
        loop
            exitwhen lp > Lenght3
            if SubString(inputString,lp,lp+Lenght) == stringToReplace then
                return SubString(inputString,0,lp) + value + SubString(inputString,lp+Lenght,Lenght3)
            endif
            set lp = lp + 1
        endloop
        
        return inputString
    endfunction

    function CreateTextTagTimer takes string Text, real Height, real x1, real y1,real z1, real time returns nothing
        local texttag floatingText = CreateTextTag()

        call SetTextTagText(floatingText,Text,Height* TEXT_SIZE)
        call SetTextTagPos(floatingText,x1,y1,z1)
        call SetTextTagColor(floatingText,255,255,120,128)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, TEXT_FADE)
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)
        
        set floatingText = null
    endfunction

    function CreateTextTagTimerColor takes string Text, real Height, real x1, real y1,real z1, real time,integer iR,integer iG,integer iB returns nothing
        local texttag floatingText = CreateTextTag()
        
        call SetTextTagText(floatingText,Text,Height* TEXT_SIZE)
        call SetTextTagPos(floatingText,x1,y1,z1)
        call SetTextTagColor(floatingText,iR,iG,iB,128)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, TEXT_FADE)
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)

        set floatingText =null
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
        call ReleaseTimer(t)
        set t = null
        set u = null
    endfunction

    function AddHeroTempAgi takes unit u, integer value, real time returns nothing
        local timer t = NewTimer()
        
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


    function DebufEx takes unit Un returns nothing
        call UnitRemoveAbility(Un, 'Bclf')
        call UnitRemoveAbility(Un, 'Bply')
        call UnitRemoveAbility(Un, 'Bslo')
        call UnitRemoveAbility(Un, 'BHbd')
        call UnitRemoveAbility(Un, 'BHfs')
        call UnitRemoveAbility(Un, 'BHbn')
        call UnitRemoveAbility(Un, 'Bbof')
        call UnitRemoveAbility(Un, 'Bliq')
        call UnitRemoveAbility(Un, 'Bens')
        call UnitRemoveAbility(Un, 'BOhx')
        call UnitRemoveAbility(Un, 'BOeq')
        call UnitRemoveAbility(Un, 'Bcri')
        call UnitRemoveAbility(Un, 'Bweb')
        call UnitRemoveAbility(Un, 'Bwea')
        call UnitRemoveAbility(Un, 'Bfzr')
        call UnitRemoveAbility(Un, 'Bapl')
        call UnitRemoveAbility(Un, 'BUsl')
        call UnitRemoveAbility(Un, 'BUdd')
        call UnitRemoveAbility(Un, 'Bssd')
        call UnitRemoveAbility(Un, 'Bspo')
        call UnitRemoveAbility(Un, 'Bcor')
        call UnitRemoveAbility(Un, 'Bfae')
        call UnitRemoveAbility(Un, 'BEer')
        call UnitRemoveAbility(Un, 'BEsh')
        call UnitRemoveAbility(Un, 'Bpsd')
        call UnitRemoveAbility(Un, 'Bpoi')
        call UnitRemoveAbility(Un, 'BNba')
        call UnitRemoveAbility(Un, 'BNdh')
        call UnitRemoveAbility(Un, 'BNht')
        call UnitRemoveAbility(Un, 'Basl')
        call UnitRemoveAbility(Un, 'BNdo')
        call UnitRemoveAbility(Un, 'BNbf')
        call UnitRemoveAbility(Un, 'BNrd')
        call UnitRemoveAbility(Un, 'BSTN')
        call UnitRemoveAbility(Un, 'BNpm')
        call UnitRemoveAbility(Un, 'BPpa')
        call UnitRemoveAbility(Un, 'BNrd')
        call UnitRemoveAbility(Un, 'BPSE')
        call UnitRemoveAbility(Un, 'BSTN')
        call UnitRemoveAbility(Un, 'BNsi')
        call UnitRemoveAbility(Un, 'Bcsd')
        call UnitRemoveAbility(Un, 'BHca')
        call UnitRemoveAbility(Un, 'BNht')
        call UnitRemoveAbility(Un, 'BCbf')
        call UnitRemoveAbility(Un, 'Bfro')
        call UnitRemoveAbility(Un, 'Blcb')
        call UnitRemoveAbility(Un, 'BNso')
        call UnitRemoveAbility(Un, 'BNab')
        call UnitRemoveAbility(Un, 'BNic')
        call UnitRemoveAbility(Un, 'BNvc')
        call UnitRemoveAbility(Un, 'B00J')
        call UnitRemoveAbility(Un, 'B00H')
        call UnitRemoveAbility(Un, 'B001')
        call UnitRemoveAbility(Un, 'B005')
        call UnitRemoveAbility(Un, 'B00V')
        call UnitRemoveAbility(Un, 'B017')
        call UnitRemoveAbility(Un, 'A06L')
        call UnitRemoveAbility(Un, 'A06P')
        call UnitRemoveAbility(Un, 'A06R')
        call UnitRemoveAbility(Un, 'B014')
        call UnitRemoveAbility(Un, 'B015')
        call UnitRemoveAbility(Un, 'B016')
        call UnitRemoveAbility(Un, 'Bvul')
        call UnitRemoveAbility(Un, 'Bam2')
        call UnitRemoveAbility(Un, 'BHav')
        call UnitRemoveAbility(Un, 'BNbr')
        call UnitRemoveAbility(Un, 'Bbsk')
        call UnitRemoveAbility(Un, 'Bplg')
        call UnitRemoveAbility(Un, 'Bena')
        call UnitRemoveAbility(Un, 'Beng')
        call UnitRemoveAbility(Un, 'BUfa')
        call UnitRemoveAbility(Un, 'Binf')
        call UnitRemoveAbility(Un, 'Blsh')
        call UnitRemoveAbility(Un, 'Brej')
        call UnitRemoveAbility(Un, 'Bdef')
        call UnitRemoveAbility(Un, 'B002')
        call UnitRemoveAbility(Un, 'Bspl')
        call UnitRemoveAbility(Un, 'BHtc')
        call UnitRemoveAbility(Un, 'BUhf')
        call UnitRemoveAbility(Un, 'B01I')
        call UnitRemoveAbility(Un, 'B01H')
        set Un = null
    endfunction

    function RemoveDebuff takes unit Un returns nothing
        call DebufEx(Un)  
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
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t  = null
        call UnitAddAbility(Caster1,idsp ) 
        if REALF != null then
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)
        endif
        call IssueTargetOrder(Caster1,ordstr,u2)
        call UnitApplyTimedLife(Caster1,'B000',6)
        set Caster1  = null
        set u1 = null
        set u2 = null
    endfunction

    function UsOrderU takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield  REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 6)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.target(u2).activate()
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
        
        
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set Caster1  = null
        set t = null
        set u1 = null
    endfunction



    function UsOrderU2 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real Field1,real Field2, abilityreallevelfield  RealField1,abilityreallevelfield  RealField2 returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 2)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if RealField1 != null then
            call dummy.setAbilityRealField(idsp, RealField1, Field1)
        endif
        if RealField2 != null then
            call dummy.setAbilityRealField(idsp, RealField2, Field2)
        endif
        call dummy.target(u2).activate()
    endfunction

    function GetUnitLuck takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),5)+1
    endfunction

    function ElemFuncStart takes unit u, integer id returns nothing
        set GLOB_ELEM_U = u
        set GLOB_ELEM_I = id
        call ExecuteFunc("ElementStartAbilityS")
    endfunction 

    function CalculateCooldown takes unit u, integer id, real cd returns real
        local real ResCD = 1
        local real luck = GetUnitLuck(u)
        local real xesilChance = 0
            
        if GetUnitAbilityLevel(u,'A03P') >= 1 then
            set ResCD =  ResCD*(1-0.01*I2R(GetUnitAbilityLevel(u,'A03P'))) 
        endif
        
        if (GetUnitTypeId(u ) == 'H01D') then
            set xesilChance = 15 + (0.1*GetHeroLevel(u) )
        endif

        if (xesilChance <= 25*luck and UnitHasItemS(u,'I03P') and GetRandomReal(0,100) <= 25*luck) or (GetUnitTypeId(u ) == 'H01D' and UnitHasItemS(u,'I03P') == false and GetRandomReal(0,100) <= xesilChance*luck) then
            set ResCD = 0.001
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

        return ResCD * cd
    endfunction

    function AbilStartCD takes unit u, integer id,real cd returns real
        local real newCooldown =  CalculateCooldown(u, id, cd)

        call ElemFuncStart(u,id)
        call BlzStartUnitAbilityCooldown(u,id,newCooldown)
        
        if id != 'A05U' then
            set Global_i = id
            set Global_u = u
            call ExecuteFunc("ResetAbilit_Ec")
        endif

        return newCooldown 
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
        local effect fx = LoadEffectHandle(HT,GetHandleId(t),1)
        
        if LoadBoolean(HT, GetHandleId(t), 2) then
            call BlzSetSpecialEffectX(fx, 0)
            call BlzSetSpecialEffectY(fx, 10000)
        endif
        call DestroyEffect(fx)
        
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set fx = null
        set t = null
    endfunction



    function AddSpecialEffectTargetTimer takes string s1, unit u, string s2,real time, boolean skipDeath returns nothing
        local string EffectString = ""
        local timer t = NewTimer()
        local effect e 
        if EffectVisible then
            set EffectString = s1
        endif
        set e = AddSpecialEffectTarget(EffectString,u,s2)
        call SaveEffectHandle(HT,GetHandleId(t),1,e)
        call SaveBoolean(HT, GetHandleId(t), 2, skipDeath)
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

        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t  = null

        call UnitAddAbility(Caster1,idsp ) 
        call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)


        call IssueImmediateOrder( Caster1, ordstr )
        call UnitApplyTimedLife(Caster1,'B000',9)


        set Caster1  = null
    endfunction


    function USOrderA takes unit u1, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield  REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 9)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.instant().activate()
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

    function RemoveHeroAbilities takes unit u returns nothing
        local integer i = 0
        local integer abilId = 0
        loop
            set abilId = GetInfoHeroSpell(u, i)
            if abilId != 0 then
                call UnitRemoveAbility(u, abilId)
            endif
            set i = i + 1
            exitwhen i > 20
        endloop
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

        if id == 8 and GetUnitTypeId(u) == 'H002' then
            set i2 = i2 + R2I(GetHeroLevel(u) / 10)
        endif

        if GetUnitTypeId(u) == 'O006' then
            set i2 = i2 + GetWitchDoctorAbsoluteLevel(u, id)
        endif
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
endlibrary