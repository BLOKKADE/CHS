library AbilityCooldown requires HeroAbilityTable, DummyActiveSpell, GetObjectElement, SpellbaneToken, UnitItems, StableSpells, RandomShit, DousingHex

    function GetHeroTotalAbilitiesCooldown takes unit u returns real
        local real total = 0
        local integer abilId
        local integer abilIdCurrent
        local integer i = 0

        loop
            set abilId = GetHeroSpellAtPosition(u, i)
            set abilIdCurrent = CheckAssociatedSpell(u,abilId)

            set total = total + BlzGetUnitAbilityCooldownRemaining(u, abilIdCurrent)
 
            set i = i + 1
            exitwhen i > 10
        endloop

        return total
    endfunction

    function AddCooldowns takes unit u,real cd returns nothing
        local integer i1 = 1
        local integer id = 0 
        local integer dummyAbilId = 0
        
        loop
            exitwhen i1 > 10
            set id = CheckAssociatedSpell(u, GetHeroSpellAtPosition(u ,i1))

            call BlzStartUnitAbilityCooldown(u,id, cd + BlzGetUnitAbilityCooldownRemaining(u,id))

            set i1 = i1 + 1
        endloop
    endfunction

    function CalculateCooldown takes unit u, integer id, real cd, boolean active returns real
        local real luck = GetUnitCustomState(u, BONUS_LUCK)
        local real xesilChance = - 1
        local real time = cd
        local real ResCD = 1
        local integer i = 0
        local real timeBonus = 0

        //Dousing Hex
        if GetUnitAbilityLevel(u, DOUSING_HEX_BUFF_ID) > 0 then
            call DousingHexActivated(u)
            //call BJDebugMsg("cd bonus: " + R2S(DousingHexCooldown.real[GetHandleId(u)]))
            return cd
        endif

        //Absolute Arcane
        if GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID) > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0 then
            set i = GetUnitElementCount(u, Element_Arcane)
            set ResCD = ResCD * Pow(1 - ((0.0014 * GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID))), i)
            if ResCD < 0.1 then
                set ResCD = 0.1
            endif
        endif

        if active then
            //Frost Bolt
            if id == FROST_BOLT_ABILITY_ID then
                set time = time - (0.5 * GetUnitElementCount(u,Element_Water))
                if time < 2 then
                    set time = 2
                endif
            endif

            //Spellbane Token
            if IsSpellbaneCooldownEnabled(u) then
                //call BJDebugMsg("spellbane bonus: " + R2S(((1 - (GetUnitState(u, UNIT_STATE_MANA) / GetUnitState(u, UNIT_STATE_MAX_MANA))) / 0.05) * 0.5))
                set timeBonus = timeBonus + (((1 - (GetUnitState(u, UNIT_STATE_MANA) / GetUnitState(u, UNIT_STATE_MAX_MANA))) / 0.05) * 0.5)
            endif

            //Fishing Rod and Blink Strike
            if UnitHasItemType(u, 'I07T') and id == BLINK_STRIKE_ABILITY_ID then
                set ResCD = ResCD * 0.5
            endif

            //Fan (this was duplicated for some reason)
            /*//if UnitHasItemType(u,'I08Z') and IsObjectElement(id,Element_Wind) then
                set ResCD = ResCD * 0.65
            endif   
            */

            //Cheater Magic
            if GetUnitAbilityLevel(u, 'A08G') > 0 and IsSpellResettable(id) then
                if id == 'A049' then
                    set ResCD = ResCD * 0.1
                else       
                    set ResCD = ResCD * 0.05
                endif
            endif
        endif
            
        //Fast Magic
        if GetUnitAbilityLevel(u,FAST_MAGIC_ABILITY_ID) >= 1 then
            set ResCD = ResCD *(1 - 0.01 * I2R(GetUnitAbilityLevel(u,FAST_MAGIC_ABILITY_ID))) 
        endif

        //Druid of the Claw
        if GetUnitTypeId(u ) == DRUID_OF_THE_CLAY_UNIT_ID and IsObjectElement(id, Element_Summon) then
            set ResCD = ResCD * 0.5
        endif

        //Frost Circlet
        if IsObjectElement(id, Element_Cold) and GetUnitAbilityLevel(u, FROST_CIRCLET_ABILITY_ID) > 0 then
            set ResCD = ResCD * 0.85
        endif
        
        //Xesil
        if (GetUnitTypeId(u ) == TIME_WARRIOR_UNIT_ID) then
            set xesilChance = 20 + (0.1 * GetHeroLevel(u) )
        endif

        //Xesil's Legacy
        if IsSpellResettable(id) and ((GetUnitTypeId(u ) != TIME_WARRIOR_UNIT_ID and UnitHasItemType(u,'I03P') and GetRandomReal(0,100) <= 25 * luck) or (GetUnitTypeId(u ) == TIME_WARRIOR_UNIT_ID and GetRandomReal(0,100) <= RMinBJ(xesilChance * luck, 90))) then
            set ResCD = 0.001
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl",u,"origin" )  )     
        endif 
        
        //Staff of Water
        if UnitHasItemType(u,'I08Y') and IsObjectElement(id, Element_Water) and IsSpellResettable(id) and GetRandomReal(0,100) <= RMinBJ(40 * luck, 90 ) then
            set ResCD = 0.001
        endif

        return (time * ResCD) + timeBonus
    endfunction

    function AbilStartCD takes unit u, integer id,real cd returns real
        local real newCooldown = CalculateCooldown(u, id, cd, false)
        call ElemFuncStart(u,id)
        call BlzStartUnitAbilityCooldown(u,id, newCooldown)

        if id != ANCIENT_TEACHING_ABILITY_ID then
            set Global_i = id
            set Global_u = u
            call ExecuteFunc("ResetAbilit_Ec")
        endif
        
        return newCooldown 
    endfunction
endlibrary
