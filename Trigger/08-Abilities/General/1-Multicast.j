library MultiBonusCast requires RandomShit, AbilityData, CustomState

    function IsAbilityMulticastable takes integer abilId returns boolean
        return abilId != RESET_TIME_ABILITY_ID and abilId != DEATH_AND_DECAY_ABILITY_ID and abilId != SAND_OF_TIME_ABILITY_ID
    endfunction

    function CanMulticast takes unit caster, integer abilId returns boolean
        return (GetUnitAbilityLevel(caster, MULTICAST_ABILITY_ID) > 0 or GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID or (UnitHasItemType(caster, 'I08X') and IsSpellElement(caster, abilId, Element_Fire) ) or GetUnitAbilityLevel(caster, CHEATER_MAGIC_ABILITY_ID) > 0) and IsAbilityMulticastable(abilId)
    endfunction

    function MultiBonusCast takes unit caster, unit target, integer abilId, integer abilOrder, location spellLoc returns nothing
        local real targetX
        local real targetY
        local real multicastLvl = GetUnitAbilityLevel(caster,MULTICAST_ABILITY_ID)
        local integer orderType = 0
        local integer amount = 0
        local real ogreMage1
        local real ogreMage2

        local real luck = GetUnitCustomState(caster, BONUS_LUCK)

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
        if GetAbilityOrderType(abilId) == 0 then
            set caster = null
            set target = null
            return
        endif

        if CheckIfCastAllowed(caster) == false then

            //Cheater Magic
            if GetUnitAbilityLevel(caster, CHEATER_MAGIC_BUFF_ID) > 0 then
                set amount = 1

                if GetRandomInt(1,100) < 2 * GetUnitAbilityLevel(caster, CHEATER_MAGIC_ABILITY_ID) then
                    set amount = 2
                endif
            endif

            //Blaze Staff
            if UnitHasItemType(caster,'I08X') and IsSpellElement(caster, abilId, Element_Fire) then
                set amount = 2
            endif

            //amounticast chances
            if multicastLvl > 0 then
                if GetRandomReal(0,100)  <=   (8.75 + 0.25 * multicastLvl)* luck then
                    set amount = 2 + amount
                elseif GetRandomReal(0,100)  <=  (13.6 + 0.4 * multicastLvl)* luck then
                    set amount = 1 + amount
                endif
            endif

            //Ogre Mage multicast chances
            if GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID then
                set ogreMage1 = 15 + GetHeroLevel(caster) * 1.2
                set ogreMage2 = ogreMage1 / 100 
                set ogreMage1 = ogreMage1 - ogreMage2 * 100
                
                set amount = amount + R2I(ogreMage2)
                
                if GetRandomReal(1,100) <= ogreMage1 * luck then
                    set amount = amount + 1
                endif
            endif
            
            if amount > 0 then
                call CreateTextTagTimerColor( "Multicast +" + I2S(amount)+ "!",1,GetUnitX(GetTriggerUnit()),GetUnitY(GetTriggerUnit()),80,1,255,50,255)
                call Multicast.create(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), abilOrder, orderType, targetX, targetY, amount)
            endif
        endif
    endfunction
endlibrary