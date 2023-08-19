library GetObjectElement requires AbilityData, WitchDoctor, UnitItems, CustomState, HeroAbilityTable, ElementalOrb

    function IsSpellElement takes unit u, integer abilId, integer elementId returns boolean

        //Null Void Orb
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return false
        endif

        //Pretty Bright Gem : Light to Dark and Dark to Light
        if UnitHasItemType(u, 'I0AM') then
            if (elementId == Element_Light and IsObjectElement(abilId, Element_Dark)) or (elementId == Element_Dark and IsObjectElement(abilId, Element_Light)) then
                return true
            endif
        endif
        
        if IsObjectElement(abilId, elementId) then
            return true
        endif

        return false
    endfunction

    function GetSpellElementCount takes unit u, integer abilId, integer elementId returns integer

        //Pretty Bright Gem : Light to Dark and Dark to Light
        if (elementId == Element_Light or elementId == Element_Dark) and UnitHasItemType(u, 'I0AM') then
            if (elementId == Element_Light and IsObjectElement(abilId, Element_Dark)) then
                return GetObjectElementCount(abilId, Element_Dark)
            elseif (elementId == Element_Dark and IsObjectElement(abilId, Element_Light)) then
                return GetObjectElementCount(abilId, Element_Light)
            endif
        endif

        return GetObjectElementCount(abilId, elementId)
    endfunction

    function GetObjectElementsAsString takes unit u, integer abilId, boolean isSpell returns string
        local string s = ""
        local integer i = 1
        local integer elementId = 0
        local integer max = GetObjectElementIndex(abilId)
        local integer count = 0
        loop
            set elementId = GetObjectElementAtIndex(abilId, i)
            if isSpell then
                set count = GetSpellElementCount(u, abilId, elementId)
            else
                set count = GetObjectElementCount(abilId, elementId)
            endif
            
            if count > 1 then
                set s = s + GetFullElementText(elementId) + "x" + I2S(count)
            elseif count == 1 then
                set s = s + GetFullElementText(elementId)
            endif
            set i = i + 1
            exitwhen i > max
        endloop
        return s
    endfunction
    
    function GetUnitElementCount takes unit u, integer elementId returns integer 
        local integer abilId = 0
        local integer i = 1
        local integer elementCount = 0

        //Null Void Orb active effect
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return 0
        endif

        //Null void orb passive effect
        if GetUnitAbilityLevel(u, 'B02R') > 0 then
            set elementCount = elementCount - 2
        endif

        //Elemental Orb
        if UnitHasItemType(u, 'I0CQ') and IsSpellElement(u, GetElementalOrbAbil(u), elementId) then
            set elementCount = elementCount + 2
        endif

        //Pretty Bright Gem +1 to dark and light
        if UnitHasItemType(u, 'I0AM') and (elementId == Element_Light or elementId == Element_Dark) then
            set elementCount = elementCount + 1
        endif

        //Ancient Element
        if GetUnitAbilityLevel(u, ANCIENT_ELEMENT_ABILITY_ID) > 0 and GetUnitAbilityLevel(u, GetElementAbsolute(elementId)) > 0 then
            set elementCount = elementCount + 2
        endif

        //Hero element
        set elementCount = elementCount + GetObjectElementCount(GetUnitTypeId(u), elementId)

        //Hero Force
        if GetUnitAbilityLevel(u, HERO_FORCE_ABILITY_ID) > 0 then
            set elementCount = elementCount + GetObjectElementCount(GetUnitTypeId(u), elementId)
        endif
        
        loop
            exitwhen i > 20 
            set elementCount = elementCount + GetSpellElementCount(u, GetHeroSpellAtPosition(u, i), elementId)  
            set i = i + 1
        endloop

        //Mauler passive
        if GetUnitTypeId(u) == MAULER_UNIT_ID and (elementId == Element_Light or (elementId == Element_Dark and UnitHasItemType(u, 'I0AM'))) then
            set elementCount = elementCount + R2I(GetHeroLevel(u) / 10)
        endif

        //Goblet of Blood
        if elementId == Element_Blood and UnitHasItemType(u, 'I0B9') then
            set elementCount = elementCount + 3
        endif

        //Fan
        if elementId == Element_Wind and UnitHasItemType(u,'I08Z') then
            set elementCount = elementCount + 2
        endif

        //Witch Doctor passive
        if GetUnitTypeId(u) == WITCH_DOCTOR_UNIT_ID then
            if (elementId == Element_Light or elementId == Element_Dark) and UnitHasItemType(u, 'I0AM') then
                set elementCount = elementCount + GetWitchDoctorAbsoluteLevel(u, Element_Light) + GetWitchDoctorAbsoluteLevel(u, Element_Dark)
            else
                set elementCount = elementCount + GetWitchDoctorAbsoluteLevel(u, elementId)
            endif
        endif

        //Counts
        //pretty bright gem bonus to light and dark
        if UnitHasItemType(u, 'I0AM') and (elementId == Element_Light or elementId == Element_Dark) then
            set elementCount = elementCount + GetUnitAbsoluteBonusCount(u, Element_Light) + GetUnitAbsoluteBonusCount(u, Element_Dark)
        else
            set elementCount = elementCount + GetUnitAbsoluteBonusCount(u, elementId)
        endif
        
        if elementCount > 0 then
            return elementCount
        else
            return 0
        endif
    endfunction
endlibrary