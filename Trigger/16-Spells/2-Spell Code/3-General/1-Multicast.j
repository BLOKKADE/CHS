library MultiBonusCast requires RandomShit, AbilityData, CustomState
    function MultiBonusCast takes unit caster, unit target, integer abilId, integer abilOrder, location spellLoc returns nothing
        local real targetX
        local real targetY
        local real multicastLvl = GetUnitAbilityLevel(caster,MULTICAST_ABILITY_ID)
        local integer orderType = 0
        local integer amount = 0
        local integer OGRE_i
        local integer OGRE_i2

        local real luck = GetUnitLuck(caster)
        
        if target == null then
            set orderType = 1
            if spellLoc == null then
                set orderType = 0
                set targetX = GetUnitX(caster)
                set targetY = GetUnitY(caster)
            else
                set orderType = 2
                set targetX = GetLocationX(spellLoc)
                set targetY = GetLocationY(spellLoc)
            endif
        else
            set orderType = 1
            set targetX = GetUnitX(target)
            set targetY = GetUnitY(target)
        endif

        

        //Check if caster has multicast
        if abilId == MIRROR_IMAGE_ABILITY_ID then
            set caster = null
            set target = null
            return
        endif

        if Trig_Disable_Abilities_Func001C(caster) == false then

            //Blaze Staff
            if UnitHasItemS(caster,'I08X') and IsSpellElement(caster, abilId,1) then
                set amount = 2
            endif

            //amounticast chances
            if multicastLvl > 0 then
                if GetRandomReal(0,100)   <=  (1.9 + 0.1 * multicastLvl)* luck then
                    set amount = 5 + amount
                elseif GetRandomReal(0,100)  <=  (3.85 + 0.15 * multicastLvl)* luck then
                    set amount = 4 + amount
                elseif GetRandomReal(0,100)  <=  (4.8 + 0.2 * multicastLvl)* luck then
                    set amount = 3 + amount
                elseif GetRandomReal(0,100)  <=   (8.75 + 0.25 * multicastLvl)* luck then
                    set amount = 2 + amount
                elseif GetRandomReal(0,100)  <=  (13.6 + 0.4 * multicastLvl)* luck then
                    set amount = 1 + amount
                else
                    set amount = 0 + amount
                endif
            endif

            //Ogre Mage multicast chances
            if GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID then
                set OGRE_i = 15 + GetHeroLevel(caster) * 2
                set OGRE_i2 = OGRE_i / 100 
                set OGRE_i = OGRE_i - OGRE_i2 * 100
                
                set amount = amount + OGRE_i2
                
                if GetRandomInt(1,100) <= OGRE_i * luck then
                    set amount = amount + 1
                endif
            endif
            
            if amount > 0 then
                call CreateTextTagTimerColor( "Multicast +" + I2S(amount)+ "!",1,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),80,1,255,50,255)
                call Multicast.create(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), abilOrder, orderType, targetX, targetY, amount)
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
                call TimerStart(Tim1,0.5 + I2R(i1)/ 2,false,function MultiUnitBonus)

                set i1 = i1 + 1
                exitwhen i1 > Mult
            endloop
            */
        endif
    endfunction
endlibrary