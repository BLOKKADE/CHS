globals
    //hashtable HY2 = InitHashtable()
endglobals

function MultiBonusCast takes nothing returns nothing
    local integer abilId = GetSpellAbilityId()
    local unit    caster = GetTriggerUnit()
    local unit    target    = GetSpellTargetUnit()
    local real    targetX
    local real    targetY
    local integer abilOrder = GetUnitCurrentOrder(caster)
    local real    multicastLvl = GetUnitAbilityLevel(caster,'A04F')
    local integer orderType
    local integer Mult = 0
    local integer OGRE_i
    local integer OGRE_i2
    local location spellLoc

    local real luck =  GetUnitLuck(caster)

    if target == null then
        set orderType = 1
        set spellLoc = GetSpellTargetLoc()
        if spellLoc == null then
            set orderType = 0
            set targetX = GetUnitX(caster)
            set targetY = GetUnitY(caster)
        else
            set orderType = 2
            set targetX = GetLocationX(spellLoc)
            set targetY = GetLocationY(spellLoc)
        endif
        call RemoveLocation(spellLoc)
    else
        set orderType = 1
        set targetX = GetUnitX(target)
        set targetY = GetUnitY(target)
    endif

    //Blaze Staff
    if  UnitHasItemS(caster,'I08X') and LoadBoolean(Elem,abilId,1) then
        set Mult = 2
    endif

    //Check if caster has multicast
    if (multicastLvl == 0 and GetUnitTypeId(caster) != 'H01E' and Mult == 0) or abilId == 'AOmi' then
        set caster = null
        set target = null
        return
    endif

    if Trig_Disable_Abilities_Func001C() == false then

        //Multicast chances
        if multicastLvl > 0 then
            if GetRandomReal(0,100)   <=  (1.9+0.1*multicastLvl)*luck then
                set Mult = 5 + Mult
            elseif GetRandomReal(0,100)  <=  (3.85+0.15*multicastLvl)*luck then
                set Mult = 4 + Mult
            elseif GetRandomReal(0,100)  <=  (4.8+0.2*multicastLvl)*luck then
                set Mult = 3 + Mult
            elseif GetRandomReal(0,100)  <=   (8.75+0.25*multicastLvl)*luck then
                set Mult = 2 + Mult
            elseif GetRandomReal(0,100)  <=  (13.6+0.4*multicastLvl)*luck then
                set Mult = 1 + Mult
            else
            set Mult = 0 + Mult
            endif
        endif

        //Ogre Mage multicast chances
        if GetUnitTypeId(caster) == 'H01E' then
            set OGRE_i = 15 + GetHeroLevel(caster) * 2
            set OGRE_i2 =  OGRE_i / 100 
            set OGRE_i = OGRE_i - OGRE_i2 * 100
            
            set Mult = Mult + OGRE_i2
            
            if GetRandomInt(1,100) <= OGRE_i*luck then
                set Mult = Mult + 1
            endif
        endif

        if Mult > 0 then
            call CreateTextTagTimerColor( "Multicast +"+I2S(Mult)+"!",1,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),50,1,255,50,255)
            call Multicast.create(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), abilOrder, orderType, targetX, targetY, Mult)
        endif
        /*
        loop
            set Tim1 = NewTimer()
            call SaveInteger(HY2,GetHandleId(Tim1),1,abilId)
            call SaveUnitHandle(HY2,GetHandleId(Tim1),2,caster)
            call SaveUnitHandle(HY2,GetHandleId(Tim1),3,target)
            call SaveReal(HY2,GetHandleId(Tim1),4,targetX)
            call SaveReal(HY2,GetHandleId(Tim1),5,targetY)
            call SaveInteger(HY2,GetHandleId(Tim1),6,abilOrder)
            call TimerStart(Tim1,0.5+I2R(i1)/2,false,function MultiUnitBonus)

            set i1 = i1 + 1
            exitwhen i1 > Mult
        endloop
        */
    endif

    set caster = null
    set target = null
    set spellLoc = null
endfunction

//===========================================================================
function InitTrig_Multicast takes nothing returns nothing
    set gg_trg_Multicast = CreateTrigger(  )
    call TriggerRegisterAnyUnitEventBJ( gg_trg_Multicast, EVENT_PLAYER_UNIT_SPELL_EFFECT )
    call TriggerAddAction( gg_trg_Multicast, function MultiBonusCast )
endfunction

