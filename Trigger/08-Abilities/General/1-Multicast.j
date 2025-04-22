library MultiBonusCast requires RandomShit, AbilityData, CustomState
    function IsAbilityMulticastable takes integer abilId returns boolean
        return abilId != RESET_TIME_ABILITY_ID and abilId != DEATH_AND_DECAY_ABILITY_ID and abilId != SAND_OF_TIME_ABILITY_ID
    endfunction

    function CanMulticast takes unit caster, integer abilId returns boolean
        return (GetUnitAbilityLevel(caster, MULTICAST_ABILITY_ID) > 0 or GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID or (UnitHasItemType(caster, 'I08X') and IsSpellElement(caster, abilId, Element_Fire)) or GetUnitAbilityLevel(caster, CHEATER_MAGIC_ABILITY_ID) > 0) and IsAbilityMulticastable(abilId)
    endfunction

    function MultiBonusCast takes unit caster, unit target, integer abilId, integer abilOrder, location spellLoc returns nothing
        local real targetX = 0
        local real targetY = 0
        local integer orderType = 0
        local integer amount = 0
        local real multicastLvl = GetUnitAbilityLevel(caster, MULTICAST_ABILITY_ID)
        local real luck = GetUnitCustomState(caster, BONUS_LUCK)
        local real ogreMageChance

        // Determine target coordinates and order type
        if target != null then
            set orderType = Order_Target
            set targetX = GetUnitX(target)
            set targetY = GetUnitY(target)
        elseif spellLoc != null then
            set orderType = Order_Point
            set targetX = GetLocationX(spellLoc)
            set targetY = GetLocationY(spellLoc)
        else
            set orderType = Order_Instant
            set targetX = GetUnitX(caster)
            set targetY = GetUnitY(caster)
        endif

        // Check if ability is valid for casting
        if GetAbilityOrderType(abilId) == 0 or not IsCastingAllowed(caster) then
            set caster = null
            set target = null
            return
        endif

        // Cheater Magic bonus
        if GetUnitAbilityLevel(caster, CHEATER_MAGIC_BUFF_ID) > 0 then
            set amount = 1
            if GetRandomInt(1, 100) < 2 * GetUnitAbilityLevel(caster, CHEATER_MAGIC_ABILITY_ID) then
                set amount = 2
            endif
        endif

        // Blaze Staff bonus
        if UnitHasItemType(caster, 'I08X') and IsSpellElement(caster, abilId, Element_Fire) then
            set amount = amount + 2
        endif

        // Multicast chances
        if multicastLvl > 0 then
            if GetRandomReal(0, 100) <= (8.75 + 0.25 * multicastLvl) * luck then
                set amount = amount + 2
            elseif GetRandomReal(0, 100) <= (13.6 + 0.4 * multicastLvl) * luck then
                set amount = amount + 1
            endif
        endif

        // Ogre Mage multicast chances
        if GetUnitTypeId(caster) == OGRE_MAGE_UNIT_ID then
            set ogreMageChance = 15. + (GetHeroLevel(caster) * 1.2)
            loop
                exitwhen ogreMageChance < 100
                set amount = amount + 1
                set ogreMageChance = ogreMageChance - 100
            endloop
            if GetRandomReal(0, 100) <= ogreMageChance * luck then
                set amount = amount + 1
            endif
        endif

        // Trigger multicast if applicable
        if amount > 0 then
            call CreateTextTagTimerColor("Multicast +" + I2S(amount) + "!", 1, GetUnitX(caster), GetUnitY(caster), 80, 1, 255, 50, 255)
            call Multicast.create(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), abilOrder, orderType, targetX, targetY, amount)
        endif
    endfunction

endlibrary