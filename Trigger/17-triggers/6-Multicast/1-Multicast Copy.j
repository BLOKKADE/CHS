globals

    hashtable HY2 = InitHashtable()

endglobals


function MultiBonusCast takes nothing returns nothing
local integer id_spell = GetSpellAbilityId()
local unit    caster = GetTriggerUnit()
local unit    Beg    = GetSpellTargetUnit()
local real    GetX = GetSpellTargetX()
local real    GetY = GetSpellTargetY()
local integer OrderUnit = GetUnitCurrentOrder(caster)
local real    GetU
local timer   Tim1
local real    AbilLvl = GetUnitAbilityLevel(caster,'A04F')
local real    Chance  = 0
local integer Mult = 0
local integer i1 = 1
local integer OGRE_i
local integer OGRE_i2

    local real luck =  GetUnitLuck(caster)



if  UnitHasItemS(caster,'I08X') and LoadBoolean(Elem,id_spell,1) then
    set Mult = 2
endif


if AbilLvl == 0 and GetUnitTypeId(caster) != 'H01E' and Mult == 0 then
    set caster = null
    set Beg = null
    return
endif



if Trig_Disable_Abilities_Func001C() == false then

    if AbilLvl > 0 then

        if GetRandomReal(0,100)   <=  (1.9+0.1*AbilLvl)*luck then
            set Mult = 5 + Mult
        elseif GetRandomReal(0,100)  <=  (3.85+0.15*AbilLvl)*luck then
            set Mult = 4 + Mult
        elseif GetRandomReal(0,100)  <=  (4.8+0.2*AbilLvl)*luck then
            set Mult = 3 + Mult
        elseif GetRandomReal(0,100)  <=   (8.75+0.25*AbilLvl)*luck then
            set Mult = 2 + Mult
        elseif GetRandomReal(0,100)  <=  (13.6+0.4*AbilLvl)*luck then
            set Mult = 1 + Mult
        else
          set Mult = 0 + Mult
        endif

    endif


    if GetUnitTypeId(caster) == 'H01E' then
      set OGRE_i =15 + GetHeroLevel(caster)*2
      set OGRE_i2 =  OGRE_i/100 
      set OGRE_i = OGRE_i - OGRE_i2*100
      
      set Mult = Mult +  OGRE_i2
      
      if GetRandomInt(1,100) <= OGRE_i*luck then
      
        set Mult = Mult + 1
      
      endif
    endif





if Mult == 0 then

set caster = null
set Beg = null
set Tim1 = null
return
endif
 
call CreateTextTagTimerColor(  "MULTICAST X"+I2S(Mult+1)+"!",1,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),50,1,50,50,255)

loop
exitwhen i1 > Mult

set Tim1 = CreateTimer()
call SaveInteger(HY2,GetHandleId(Tim1),1,id_spell)
call SaveUnitHandle(HY2,GetHandleId(Tim1),2,caster)
call SaveUnitHandle(HY2,GetHandleId(Tim1),3,Beg)
call SaveReal(HY2,GetHandleId(Tim1),4,GetX)
call SaveReal(HY2,GetHandleId(Tim1),5,GetY)
call SaveInteger(HY2,GetHandleId(Tim1),6,OrderUnit)
call TimerStart(Tim1,0.5+I2R(i1)/2,false,function MultiUnitBonus)

set i1 = i1 + 1
endloop
endif
set caster = null
set Beg = null
set Tim1 = null
endfunction

//===========================================================================
function InitTrig_Multicast_Copy takes nothing returns nothing
    set gg_trg_Multicast_Copy = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Multicast_Copy, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddAction( gg_trg_Multicast_Copy, function MultiBonusCast )
endfunction

