function WaveEnd takes nothing returns nothing
    local timer t = GetExpiredTimer()

    call DestroyLightning(LoadLightningHandle(HT,GetHandleId(t),1))
    call FlushChildHashtable(HT,GetHandleId(t))
    call DestroyTimer(t)
    set t = null
endfunction

function Wave takes real x1, real y1 , real x2, real y2, string line, real time returns nothing
    local lightning l = AddLightningEx(line,true,x1,y1,40,x2,y2,40)
    local timer t = CreateTimer()
    call SaveLightningHandle(HT,GetHandleId(t),1,l)
    call TimerStart(t,time,false,function WaveEnd)
    set l = null
    set t = null
endfunction


function Play3dSound takes string s, real x,real y returns nothing
    local sound snd =  CreateSound(s,false, true, true, 0, 0, "DefaultEAXON")
    call SetSoundChannel( snd, 0)
    call SetSoundDistances( snd, 600.00, 10000.00 )
    call SetSoundDistanceCutoff( snd, 3000.00)
    call SetSoundDuration( snd, GetSoundFileDuration(s) )
    call SetSoundVolume( snd, 127 )
    call SetSoundConeAngles( snd, 0.0, 0.0, 127 )
    call SetSoundConeOrientation( snd, 0.0, 0.0, 0.0 )
    call SetSoundPitch( snd, 1.0 )
    call SetSoundPosition(snd,x, y, 40)
    call SetSoundVolume(snd, 120)
    call StartSound(snd)
    call KillSoundWhenDone(snd)
    
    set snd = null
endfunction



globals
    integer GLOB_HW_I = 0
    integer GLOB_HW_COUNT = 0
    unit GLOB_HW_U1 = null
    unit GLOB_HW_U2 = null
    real GLOB_HW_DMG = 0
    real GLOB_HW_HEAL = 0 
    group GLOB_HW_G = null
    boolean GLOB_HW_ACTIVE = false
    real GLOB_HW_X = 0 
    real GLOB_HW_Y = 0  

endglobals

function StartWave takes unit u1, unit u2, real dmg,real heal, real x, real y returns nothing
    call Wave(x,y,GetUnitX(u2),GetUnitY(u2),"HWPB",0.2)
    call Play3dSound("Abilities/Spells/Orc/HealingWave/HealingWave.flac"   ,x,y)
    
      //  call AddSpecialEffectTargetTimer( "Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl", u2, "chest",2)
        
        
    if IsUnitEnemy(u1,GetOwningPlayer(u2)) then
        call MagicDamage(u1,u2, dmg,'A085')
    else
        call HealUnit(u1,u2,heal)
    endif
endfunction 

function HealingWaveFunc takes nothing returns boolean 

    if GLOB_HW_ACTIVE and GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitInGroup(GetFilterUnit(),GLOB_HW_G) == false and GetFilterUnit() != GLOB_HW_U2  then
        
        call StartWave(GLOB_HW_U1,GetFilterUnit(), GLOB_HW_DMG,GLOB_HW_HEAL,GLOB_HW_X,GLOB_HW_Y)
        set GLOB_HW_U2 = GetFilterUnit() 
        call GroupAddUnit(GLOB_HW_G,GetFilterUnit())
        set GLOB_HW_COUNT = GLOB_HW_COUNT - 1
        set GLOB_HW_ACTIVE = false 
        set GLOB_HW_X = GetUnitX(GLOB_HW_U2)
        set GLOB_HW_Y = GetUnitY(GLOB_HW_U2)

    endif 

    return false
endfunction

function TimerHealingWave takes nothing returns nothing
    local timer t = GetExpiredTimer()
    local integer i = GetHandleId(t)
    local real range = LoadReal(HT,i,7)
    set GLOB_HW_I = i
    set GLOB_HW_COUNT = LoadInteger(HT,i,1)
    set GLOB_HW_U1 = LoadUnitHandle(HT,i,2)
    set GLOB_HW_U2 = LoadUnitHandle(HT,i,3)
    set GLOB_HW_DMG = LoadReal(HT,i,4)
    set GLOB_HW_HEAL = LoadReal(HT,i,5) 
    set GLOB_HW_G = LoadGroupHandle(HT,i,6)
    set GLOB_HW_X = LoadReal(HT,i,8)
    set GLOB_HW_Y = LoadReal(HT,i,9)
    
    set GLOB_HW_ACTIVE = true
    
    call GroupEnumUnitsInRange(GLOB_HW_G,GLOB_HW_X,GLOB_HW_Y, range,HealingWave1 )
    
    
    if GLOB_HW_COUNT > 0 and GLOB_HW_ACTIVE == false then
        call SaveInteger(HT,GetHandleId(t),1,GLOB_HW_COUNT)
      //  call SaveUnitHandle(HT,GetHandleId(t),2,GLOB_HW_U1)
        call SaveUnitHandle(HT,GetHandleId(t),3,GLOB_HW_U2)
      //  call SaveReal(HT,GetHandleId(t),4,GLOB_HW_DMG)
      //  call SaveReal(HT,GetHandleId(t),5,GLOB_HW_HEAL)
      //  call SaveGroupHandle(HT,GetHandleId(t),6,GLOB_HW_G)
      
      call SaveReal(HT,GetHandleId(t),7,GLOB_HW_X)
      call SaveReal(HT,GetHandleId(t),8,GLOB_HW_Y)
    else
        call DestroyTimer(t)
        call DestroyGroup(GLOB_HW_G)
        call FlushChildHashtable(HT,i)
    endif 

    set t = null 
endfunction 




function HealingWaveStart takes unit u1, unit u2, integer count, real heal, real dmg, real range2 returns nothing 
    local group g = CreateGroup()
    local timer t = CreateTimer()
    
    call GroupAddUnit(g,u2)
    call StartWave(u1,u2,dmg,heal,GetUnitX(u1),GetUnitY(u1) )
    
    call SaveInteger(HT,GetHandleId(t),1,count-1)
    call SaveUnitHandle(HT,GetHandleId(t),2,u1)
    call SaveUnitHandle(HT,GetHandleId(t),3,u2)
    call SaveReal(HT,GetHandleId(t),4,dmg)
    call SaveReal(HT,GetHandleId(t),5,heal)
    call SaveGroupHandle(HT,GetHandleId(t),6,g)
    call SaveReal(HT,GetHandleId(t),7,range2 )
    call SaveReal(HT,GetHandleId(t),8,GetUnitX(u2))
    call SaveReal(HT,GetHandleId(t),9,GetUnitY(u2))
    
    call TimerStart(t,0.2,true,function TimerHealingWave)
    set t = null
    set g = null
endfunction