library GetObjectElement requires AbilityData, WitchDoctor, UnitItems, CustomState, HeroAbilityTable

    function IsSpellElement takes unit u, integer abilId, integer id returns boolean

        //Null Void Orb
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return false
        endif

        //Pretty Bright Gem : Light to Dark and Dark to Light
        if UnitHasItemType(u, 'I0AM') then
            if (id == Element_Light and IsObjectElement(abilId, Element_Dark)) or (id == Element_Dark and IsObjectElement(abilId, Element_Light)) then
                return true
            endif
        endif
        
        if IsObjectElement(abilId, id) then
            return true
        endif

        return false
    endfunction

    function GetSpellElementCount takes unit u, integer abilId, integer id returns integer

        //Pretty Bright Gem : Light to Dark and Dark to Light
        if (id == Element_Light or id == Element_Dark) and UnitHasItemType(u, 'I0AM') then
            if (id == Element_Light and IsObjectElement(abilId, Element_Dark)) then
                return GetObjectElementCount(abilId, Element_Dark)
            elseif (id == Element_Dark and IsObjectElement(abilId, Element_Light)) then
                return GetObjectElementCount(abilId, Element_Light)
            endif
        endif

        return GetObjectElementCount(abilId, id)
    endfunction

    function GetObjectElements takes unit u, integer id, boolean isSpell returns string
        local string s = ""
        local integer i = 1
        local integer count = 0
        loop
            if isSpell then
                set count = GetSpellElementCount(u, id, i)
            else
                set count = GetObjectElementCount(id, i)
            endif
            
            if count > 1 then
                set s = s + ClassAbil[i] + "x" + I2S(count)
            elseif count == 1 then
                set s = s + ClassAbil[i]
            endif
            set i = i + 1
            exitwhen i > Element_Maximum
        endloop
        return s
    endfunction
    
    function GetUnitElementCount takes unit u, integer id returns integer 
        local integer abilId = 0
        local integer i = 1
        local integer elementCount = 0

        //Null Void Orb
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return 0
        endif

        //Pretty Bright Gem +1 to dark and light
        if UnitHasItemType(u, 'I0AM') and (id == Element_Light or id == Element_Dark) then
            set elementCount = elementCount + 1
        endif

        //Ancient Element
        if GetUnitAbilityLevel(u, ANCIENT_ELEMENT_ABILITY_ID) > 0 and GetUnitAbilityLevel(u, GetElementAbsolute(id)) > 0 then
            set elementCount = elementCount + 2
        endif

        //Hero element
        set elementCount = elementCount + GetObjectElementCount(GetUnitTypeId(u), id)

        //Hero Force
        if GetUnitAbilityLevel(u, HERO_FORCE_ABILITY_ID) > 0 then
            set elementCount = elementCount + GetObjectElementCount(GetUnitTypeId(u), id)
        endif
        
        loop
            exitwhen i > 20 
            set elementCount = elementCount + GetSpellElementCount(u, GetInfoHeroSpell(u, i), id)  
            set i = i + 1
        endloop

        //Mauler passive
        if GetUnitTypeId(u) == MAULER_UNIT_ID and (id == Element_Light or (id == Element_Dark and UnitHasItemType(u, 'I0AM'))) then
            set elementCount = elementCount + R2I(GetHeroLevel(u) / 10)
        endif

        //Poison Runestone
        if id == Element_Poison and UnitHasItemType(u, 'I0B8') then
            set elementCount = elementCount + 2
        endif

        //Goblet of Blood
        if id == Element_Blood and UnitHasItemType(u, 'I0B9') then
            set elementCount = elementCount + 3
        endif

        //Fan
        if id == Element_Wind and UnitHasItemType(u,'I08Z') then
            set elementCount = elementCount + 2
        endif

        //Witch Doctor passive
        if GetUnitTypeId(u) == WITCH_DOCTOR_UNIT_ID then
            if (id == Element_Light or id == Element_Dark) and UnitHasItemType(u, 'I0AM') then
                set elementCount = elementCount + GetWitchDoctorAbsoluteLevel(u, Element_Light) + GetWitchDoctorAbsoluteLevel(u, Element_Dark)
            else
                set elementCount = elementCount + GetWitchDoctorAbsoluteLevel(u, id)
            endif
        endif

        //Counts
        set elementCount = elementCount + GetUnitAbsoluteBonusCount(u, id)
        
        return elementCount 
    endfunction
endlibrary