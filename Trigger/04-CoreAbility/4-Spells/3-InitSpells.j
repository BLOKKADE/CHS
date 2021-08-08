globals 

    AbilityData GLOBAL_HERO_A = 0
    unit GLOBAL_HERO_U = null
    real GLOBAL_HERO_LVL = 0
    
    integer PARAMETR_DMG = 0
    integer PARAMETR_DMG2 = 0
    integer PARAMETR_DMG3 = 0
    string PARAMETR_TOOLTIP = null
    string PARAMETR_NAME = null
endglobals 

function SetFunctionAbilityLvl takes integer id, string s returns nothing
    local DamageAbility D = 0
    
    call SaveStr(HT_abilsys,id,1,s+"_lvl")
    set PARAMETR_DMG = 0 
    set PARAMETR_DMG2 = 0 
    set PARAMETR_DMG3 = 0 
    set PARAMETR_TOOLTIP = null
    set PARAMETR_NAME = null 
    call ExecuteFunc(s+"_initparam")
    if PARAMETR_DMG != 0 then
        set D = DamageAbility.create(id,1)
        call SaveInteger(HT_abilsys,id,2,PARAMETR_DMG)
        call SaveInteger(HT_abilsys,PARAMETR_DMG,3,D)
    endif
    if PARAMETR_DMG2 != 0 then
        set D = DamageAbility.create(id,2)
        call SaveInteger(HT_abilsys,id,6,PARAMETR_DMG2)
        call SaveInteger(HT_abilsys,PARAMETR_DMG2,3,D)
    endif
    if PARAMETR_DMG3 != 0 then
        set D = DamageAbility.create(id,3)
        call SaveInteger(HT_abilsys,id,6,PARAMETR_DMG3)
        call SaveInteger(HT_abilsys,PARAMETR_DMG3,3,D)
    endif
    if PARAMETR_TOOLTIP != null then
      call SaveStr(HT_abilsys,id,4,PARAMETR_TOOLTIP)
    endif
    if PARAMETR_NAME != null then
      call SaveStr(HT_abilsys,id,5,PARAMETR_NAME)
    endif
endfunction 


function SetStats takes unit u, integer id, AbilityData A returns nothing
    local ability abil = BlzGetUnitAbility(u,id)
    call SetUnitAbilityLevel(u,id,2)
    
    if A.Param1Field != 0 then
        call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param1Field))
     if A.Param1FieldType == 0 then
        call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param1Field),0,A.GetParam1())
     else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param1Field),0,R2I(A.GetParam1()))
     endif
    endif 
    if A.Param2Field != 0 then
            call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param2Field))
         if A.Param2FieldType == 0 then
     call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param2Field),0,A.GetParam2())
          else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param2Field),0,R2I(A.GetParam2()))
     endif
    endif 
    if A.Param3Field != 0 then
            call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param3Field))
         if A.Param3FieldType == 0 then
     call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param3Field),0,A.GetParam3())
          else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param3Field),0,R2I(A.GetParam3()))
     endif
    endif 
    if A.Param4Field != 0 then
            call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param4Field))
         if A.Param4FieldType == 0 then
     call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param4Field),0,A.GetParam4())
          else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param4Field),0,R2I(A.GetParam4()))
     endif
    endif 
    if A.Param5Field != 0 then
            call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param5Field))
         if A.Param5FieldType == 0 then
     call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param5Field),0,A.GetParam5())
          else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param5Field),0,R2I(A.GetParam5()))
     endif
    endif 
    if A.Param6Field != 0 then
            call DisplayTextToPlayer(GetLocalPlayer(),0,0,I2S(A.Param6Field))
         if A.Param6FieldType == 0 then
     call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField(A.Param6Field),0,A.GetParam6())
          else
        call BlzSetAbilityIntegerLevelField( abil ,ConvertAbilityIntegerLevelField(A.Param6Field),0,R2I(A.GetParam6()))
     endif
    endif 
      
      
    if A.DurationHero1 != NULL then
        call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField('ahdu'),0,A.GetDurationHero1() )
    endif 
    
    if A.DurationNormal1 != NULL then
        call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField('adur'),0,A.GetDurationNormal1() )
    endif
    
    call BlzSetUnitAbilityManaCost(u,id,0,R2I(A.GetCost1()))
    call BlzSetUnitAbilityCooldown(u,id,0,R2I(A.GetCooldown1()))   
    
    if A.CastingTime1 != NULL then
        call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField('acas'),0,A.GetCastingTime1() )
    endif 
    call BlzSetAbilityRealLevelField( abil ,ConvertAbilityRealLevelField('aare'),0,A.GetArea1() )
    call SetUnitAbilityLevel(u,id,1)    
    set abil = null
endfunction

function DummyInitAbil takes unit Hero, unit Dummy, integer id returns nothing
    local AbilityData A = GetAbilityData(Hero,id)
    call SetStats(Dummy,id,A)
endfunction


function AddSpellLvl takes unit u, integer id returns nothing
    local AbilityData A = GetAbilityData(u,id)
    if A.Level <= 30 then
        set A.Level = A.Level + 1
    else 
        set A.Level = A.Level + 0.1
    endif
    set GLOBAL_HERO_U = u 
    set GLOBAL_HERO_A = A 
    set GLOBAL_HERO_LVL = A.Level + A.BonusLevel
    call ExecuteFunc( LoadStr(HT_abilsys,id,1))
    call SetStats(u,id,A)

endfunction

function AddAbilityData takes unit u, integer id returns nothing
    local AbilityData A = AbilityData.create()
    set A.Level = 1
    set GLOBAL_HERO_U = u 
    set GLOBAL_HERO_A = A 
    set GLOBAL_HERO_LVL = 1 
    call SaveInteger(HT_abilsys,GetHandleId(u),id, A )
    call ExecuteFunc( LoadStr(HT_abilsys,id,1))
    call SetStats(u,id,A)
endfunction


function TempAbilityData takes integer id, real lvl returns AbilityData 
    local AbilityData A = AbilityData.create()
    set A.Level = lvl 
    set GLOBAL_HERO_U = null 
    set GLOBAL_HERO_A = A
    set GLOBAL_HERO_LVL = lvl
    call ExecuteFunc( LoadStr(HT_abilsys,id,1))
    return A
endfunction



function Trig_InitSpells_Actions takes nothing returns nothing
    local integer i = 1
    loop
        exitwhen i > udg_integer26
        call SetFunctionAbilityLvl(udg_integers08[i],raw2s(udg_integers08[i]))
        set i = i + 1
    endloop
endfunction

//===========================================================================
function InitTrig_InitSpells takes nothing returns nothing
    set gg_trg_InitSpells = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_InitSpells, 0.00 )
    call TriggerAddAction( gg_trg_InitSpells, function Trig_InitSpells_Actions )
endfunction

