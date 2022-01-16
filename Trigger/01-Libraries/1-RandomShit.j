library RandomShit requires WitchDoctor, AbilityData, SpellbaneToken, StableSpells, IdLibrary
    globals

        integer array SpellCP
        integer Global_i = 0
        unit Global_u = null
        
        constant real TEXT_SIZE = 0.024
        constant real TEXT_VEL = 0.09
        constant real TEXT_LIFE = 1
        constant real TEXT_FADE = 0.6

        boolean EffectVisible = true
        string LastBreathAnim = "Abilities\\Spells\\Undead\\Unsummon\\UnsummonTarget.mdl"

        unit GLOB_DEBUF = null

    endglobals

    function ReplaceText takes string stringToReplace, string value, string inputString returns string
        local integer Lenght = StringLength(stringToReplace)
        local integer Lenght3 = StringLength(inputString)
        local integer lp = 0
        
        
        loop
            exitwhen lp > Lenght3
            if SubString(inputString,lp,lp + Lenght) == stringToReplace then
                return SubString(inputString,0,lp) + value + SubString(inputString,lp + Lenght,Lenght3)
            endif
            set lp = lp + 1
        endloop
        
        return inputString
    endfunction

    function CreateTextTagTimer takes string Text, real Height, real x1, real y1,real z1, real time returns nothing
        local texttag floatingText = CreateTextTag()

        call SetTextTagText(floatingText,Text,Height * TEXT_SIZE)
        call SetTextTagPos(floatingText,x1,y1,z1)
        call SetTextTagColor(floatingText,255,255,120,200)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, time - (time * 0.1))
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)
        
        set floatingText = null
    endfunction

    function CreateTextTagTimerColor takes string Text, real Height, real x1, real y1,real z1, real time,integer iR,integer iG,integer iB returns nothing
        local texttag floatingText = CreateTextTag()
        
        call SetTextTagText(floatingText,Text,Height * TEXT_SIZE)
        call SetTextTagPos(floatingText,x1,y1,z1)
        call SetTextTagColor(floatingText,iR,iG,iB,200)
        
        call SetTextTagVelocity(floatingText,0.01, TEXT_VEL)
        call SetTextTagFadepoint(floatingText, time - (time * 0.1))
        call SetTextTagLifespan(floatingText, time)
        call SetTextTagPermanent(floatingText,false)

        set floatingText = null
    endfunction

    function GetUnitItem takes unit u, integer id returns item 
        local integer i = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                return UnitItemInSlot(u, i)
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return null
    endfunction

    function UnitHasItemS takes unit u, integer id returns boolean 
        local integer i = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                return true
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return false
    endfunction


    function UnitHasItemI takes unit u, integer id returns integer
        local integer i = 0
        local integer count = 0

        loop
            if GetItemTypeId(UnitItemInSlot(u, i)) == id then
                set count = count + 1
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        return count
    endfunction


    function EndHeroTempAgi takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer value = LoadInteger(HT,GetHandleId(t),1)
        local unit u = LoadUnitHandle(HT,GetHandleId(t),2)
        
        call SetHeroAgi(u,GetHeroAgi(u,false)- value,false)

        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set t = null
        set u = null
    endfunction

    function AddHeroTempAgi takes unit u, integer value, real time returns nothing
        local timer t = NewTimer()
        
        call SetHeroAgi(u,GetHeroAgi(u,false)+ value,false)
        call SaveInteger(HT,GetHandleId(t),1,value)
        call SaveUnitHandle(HT,GetHandleId(t),2,u)
        call TimerStart(t,time,false,function EndHeroTempAgi)
        set t = null
    endfunction




    function UnitHasFullItems takes unit u returns boolean
        if UnitItemInSlot(u,0) != null and UnitItemInSlot(u,1) != null and UnitItemInSlot(u,2) != null and UnitItemInSlot(u,3) != null and UnitItemInSlot(u,4) != null and UnitItemInSlot(u,5) != null then
            return true
        endif
        return false
    endfunction

    function PositiveBuffs takes unit u returns nothing
        call UnitRemoveAbility(u, INVULNERABLE_BUFF_ID)
        call UnitRemoveAbility(u, ANTI_MAGIC_SHELL_BUFF_ID)
        call UnitRemoveAbility(u, AVATAR_BUFF_ID)
        call UnitRemoveAbility(u, BATTLE_ROAR_BUFF_ID)
        call UnitRemoveAbility(u, BERSERK_BUFF_ID)
        call UnitRemoveAbility(u, FROST_ARMOR_BUFF_ID)
        call UnitRemoveAbility(u, INNER_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, LIGHTNING_SHIELD_BUFF_ID)
        call UnitRemoveAbility(u, REJUVENATION_BUFF_ID)
        call UnitRemoveAbility(u, SCROLL_OF_PROTECTION_BUFF_ID)
        call UnitRemoveAbility(u, SENSATUS_SHIELD_OF_HONOR_BUFF_ID)
        call UnitRemoveAbility(u, SPIRIT_LINK_BUFF_ID)
        call UnitRemoveAbility(u, 'A09H')
        call UnitRemoveAbility(u, 'A09R')
        call UnitRemoveAbility(u, 'A09S')
        call UnitRemoveAbility(u, EXTRADIMENSIONAL_COOPERATION_BUFF_ID)
        call UnitRemoveAbility(u, LUCKY_PANTS_BUFF_ID)
        call UnitRemoveAbility(u, MANA_STARVATION_BUFF_ID)
        call UnitRemoveAbility(u, WISDOM_CHESTPLATE_BUFF_ID)
        call UnitRemoveAbility(u, 'A08G')
        call UnitRemoveAbility(u, CHEATER_MAGIC_BUFF_ID)
        call UnitRemoveAbility(u, HERO_BUFF_ID)
    endfunction

    function NegativeBuffs takes unit u returns nothing
        call UnitRemoveAbility(u, CLOUD_BUFF_ID)
        call UnitRemoveAbility(u, POLYMORPH_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_BUFF_ID)
        call UnitRemoveAbility(u, BLIZZARD_BUFF_ID)
        call UnitRemoveAbility(u, FLAME_STRIKE_BUFF_ID)
        call UnitRemoveAbility(u, BANISH_BUFF_ID)
        call UnitRemoveAbility(u, BURNING_OIL_BUFF_ID)
        call UnitRemoveAbility(u, LIQUID_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_GENERAL_BUFF_ID)
        call UnitRemoveAbility(u, HEX_BUFF_ID)
        call UnitRemoveAbility(u, EARTHQUAKE_BUFF_ID)
        call UnitRemoveAbility(u, CRIPPLE_BUFF_ID)
        call UnitRemoveAbility(u, WEB_GROUND_BUFF_ID)
        call UnitRemoveAbility(u, WEB_AIR_BUFF_ID)
        call UnitRemoveAbility(u, DISEASE_BUFF_ID)
        call UnitRemoveAbility(u, SLEEP_BUFF_ID)
        call UnitRemoveAbility(u, DEATH_AND_DECAY_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_POISON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_POISON_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, CORROSIZE_BREATH_BUFF_ID)
        call UnitRemoveAbility(u, FAERIE_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, ENTANGLING_ROOTS_BUFF_ID)
        call UnitRemoveAbility(u, SHADOW_STRIKE_BUFF_ID)
        call UnitRemoveAbility(u, POISON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, POISON_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, BLACK_ARROW_BUFF_ID)
        call UnitRemoveAbility(u, DRUNKEN_HAZE_BUFF_ID)
        call UnitRemoveAbility(u, HOWL_OF_TERROR_BUFF_ID)
        call UnitRemoveAbility(u, TORNADO_SLOW_AURA_BUFF_ID)
        call UnitRemoveAbility(u, DOOM_BUFF_ID)
        call UnitRemoveAbility(u, BREATH_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, RAIN_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_BUFF_ID)
        call UnitRemoveAbility(u, PARASITE_MINION_BUFF_ID)
        // call UnitRemoveAbility(u, 'BPpa') Does not exist
        call UnitRemoveAbility(u, RAIN_OF_FIRE_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_PAUSE_BUFF_ID)
        call UnitRemoveAbility(u, SILENCE_BUFF_ID)
        call UnitRemoveAbility(u, COLD_ARROWS_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, COLD_ARROWS_NON_STACKING_BUFF_ID)
        call UnitRemoveAbility(u, HOWL_OF_TERROR_BUFF_ID)
        call UnitRemoveAbility(u, BREATH_OF_FROST_BUFF_ID)
        call UnitRemoveAbility(u, SLOWED_BUFF_ID)
        call UnitRemoveAbility(u, 'Blcb')
        call UnitRemoveAbility(u, SOUL_BURN_BUFF_ID)
        call UnitRemoveAbility(u, ACID_BOMB_BUFF_ID)
        call UnitRemoveAbility(u, INCINERATE_BUFF_ID)
        call UnitRemoveAbility(u, VOLCANO_BUFF_ID)
        call UnitRemoveAbility(u, STUNNED_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, FEAR_AURA_BUFF_ID)
        call UnitRemoveAbility(u, SLOW_AURA_BUFF_ID)
        call UnitRemoveAbility(u, WHIRLWIND_BUFF_ID)
        call UnitRemoveAbility(u, THE_CURSE_OF_DEMONS_BUFF_ID)
        call UnitRemoveAbility(u, IMMOBILITY_BUFF_ID)
        call UnitRemoveAbility(u, 'A06L')
        call UnitRemoveAbility(u, 'A06P')
        call UnitRemoveAbility(u, 'A06R')
        call UnitRemoveAbility(u, INCINERATE_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, POISON_NON_STACKING_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, LIQUID_FIRE_CUSTOM_BUFF_ID)
        call UnitRemoveAbility(u, DISEASE_CLOUD_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_AIR_BUFF_ID)
        call UnitRemoveAbility(u, ENSNARE_GROUND_BUFF_ID)
        call UnitRemoveAbility(u, THUNDER_CLAP_BUFF_ID)
        call UnitRemoveAbility(u, UNHOLY_FRENZY_BUFF_ID)
        call UnitRemoveAbility(u, BLEED_BUFF_ID)
        call UnitRemoveAbility(u, NULL_VOID_ORB_BUFF_ID)
        call UnitRemoveAbility(u, ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID)
        call UnitRemoveAbility(u, FLIMSY_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, SPELLBANE_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, VIGOUR_TOKEN_BUFF_ID)
        call UnitRemoveAbility(u, BLOODSTONE_BUFF_ID)
        call UnitRemoveAbility(u, DOUSING_HEX_BUFF_ID)
        call UnitRemoveAbility(u, MANA_STARVATION_NERF_BUFF_ID)
        call UnitRemoveAbility(u, MIDAS_TOUCH_BUFF_ID)
        call UnitRemoveAbility(u, 'A09B')
        call UnitRemoveAbility(u, 'A08O')
        call UnitRemoveAbility(u, 'A03V')
    endfunction

    //0 = all, 1 = negative, 2 = positive
    function RemoveDebuff takes unit u, integer buffType returns nothing
        if buffType == 0 or buffType == 1 then
            call NegativeBuffs(u)
        endif

        if buffType == 0 or buffType == 2 then
            call PositiveBuffs(u)
        endif
    endfunction


    function UsOrderUTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u1 = LoadUnitHandle(HT,i,1)
        local unit u2 = LoadUnitHandle(HT,i,2)
        local real x = LoadReal(HT,i,3)
        local real y = LoadReal(HT,i,4)
        local integer idsp = LoadInteger(HT,i,5)
        local string ordstr = LoadStr(HT,i,6)
        local real life_1 = LoadReal(HT,i,7)
        local abilityreallevelfield REALF = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
        local unit Caster1 = CreateUnit(GetOwningPlayer(u1),PRIEST_1_UNIT_ID,x,y, Rad2Deg(Atan2(GetUnitY(u2)- y, GetUnitX(u2)- x))  )
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t = null
        call UnitAddAbility(Caster1,idsp ) 
        if REALF != null then
            call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)
        endif
        call IssueTargetOrder(Caster1,ordstr,u2)
        call UnitApplyTimedLife(Caster1,RAPIER_OF_THE_GODS_BUFF_ID,6)
        set Caster1 = null
        set u1 = null
        set u2 = null
    endfunction

    function USOrder4field takes unit u1, real x, real y,integer idsp, string ordstr, real Field1, abilityreallevelfield RealField1, real Field2, abilityreallevelfield RealField2,real Field3, abilityreallevelfield RealField3,real Field4, abilityreallevelfield RealField4 returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 2)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if RealField1 != null then
            call dummy.setAbilityRealField(idsp, RealField1, Field1)
        endif
        if RealField2 != null then
            call dummy.setAbilityRealField(idsp, RealField2, Field2)
        endif
        if RealField3 != null then
            call dummy.setAbilityRealField(idsp, RealField3, Field3)
        endif
        if RealField4 != null then
            call dummy.setAbilityRealField(idsp, RealField4, Field4)
        endif
        call dummy.instant().activate()
    endfunction

    function UsOrderU takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 6)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.target(u2).activate()
    endfunction


    function UsOrderU2Timer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u1 = LoadUnitHandle(HT,i,1)
        local unit u2 = LoadUnitHandle(HT,i,2)
        local real x = LoadReal(HT,i,3)
        local real y = LoadReal(HT,i,4)
        local integer idsp = LoadInteger(HT,i,5)
        local string ordstr = LoadStr(HT,i,6)
        local real life_1 = LoadReal(HT,i,7)
        local abilityreallevelfield REALF1 = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
        local real life_2 = LoadReal(HT,i,9)
        local abilityreallevelfield REALF2 = ConvertAbilityRealLevelField(LoadInteger(HT,i,10))
        local unit Caster1 = CreateUnit(GetOwningPlayer(u1),PRIEST_1_UNIT_ID,x,y, Rad2Deg(Atan2(GetUnitY(u2)- y, GetUnitX(u2)- x))  )
        
        
        call UnitAddAbility(Caster1,idsp ) 
        call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF1,0,life_1)
        call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF2,0,life_2)
        call IssueTargetOrder(Caster1,ordstr,u2)
        call UnitApplyTimedLife(Caster1,RAPIER_OF_THE_GODS_BUFF_ID,6)
        
        
        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set Caster1 = null
        set t = null
        set u1 = null
    endfunction



    function UsOrderU2 takes unit u1, unit u2, real x, real y,integer idsp, string ordstr, real Field1,real Field2, abilityreallevelfield RealField1,abilityreallevelfield RealField2 returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 2)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if RealField1 != null then
            call dummy.setAbilityRealField(idsp, RealField1, Field1)
        endif
        if RealField2 != null then
            call dummy.setAbilityRealField(idsp, RealField2, Field2)
        endif
        call dummy.target(u2).activate()
    endfunction

    function GetInfoHeroSpell takes unit u, integer num returns integer
        return LoadInteger(HT_SpellPlayer,GetHandleId(u),num)
    endfunction

    function GetNumHeroSpell takes unit u,integer id returns integer
        return LoadInteger(HT_SpellPlayer,GetHandleId(u),id)
    endfunction

    function IsSpellElement takes unit u, integer abilId, integer id returns boolean

        //Null Void Orb
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return false
        endif

        //Pretty Bright Gem : Light to Dark and Dark to Light
        if UnitHasItemS(u, 'I0AM') then
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
        if (id == Element_Light or id == Element_Dark) and UnitHasItemS(u, 'I0AM') then
            if (id == Element_Light and IsObjectElement(abilId, Element_Dark)) then
                return GetObjectElementCount(abilId, Element_Dark)
            elseif (id == Element_Dark and IsObjectElement(abilId, Element_Light)) then
                return GetObjectElementCount(abilId, Element_Light)
            endif
        endif

        return GetObjectElementCount(abilId, id)
    endfunction
    
    function GetClassUnitSpell takes unit u, integer id returns integer 
        local integer abilId = 0
        local integer i = 1
        local integer elementCount = 0

        //Null Void Orb
        if GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) > 0 then
            return 0
        endif

        //Pretty Bright Gem +1 to dark and light
        if UnitHasItemS(u, 'I0AM') and (id == Element_Light or id == Element_Dark) then
            set elementCount = elementCount + 1
        endif

        //Hero element
        set elementCount = elementCount + GetObjectElementCount(GetUnitTypeId(u), id)
        
        loop
            exitwhen i > 20 
            set elementCount = elementCount + GetSpellElementCount(u, GetInfoHeroSpell(u, i), id)  
            set i = i + 1
        endloop

        //Mauler passive
        if GetUnitTypeId(u) == MAULER_UNIT_ID and (id == Element_Light or (id == Element_Dark and UnitHasItemS(u, 'I0AM'))) then
            set elementCount = elementCount + R2I(GetHeroLevel(u) / 8)
        endif

        if id == Element_Poison and UnitHasItemS(u, 'I0B8') then
            set elementCount = elementCount + 2
        endif

        if id == Element_Blood and UnitHasItemS(u, 'I0B9') then
            set elementCount = elementCount + 2
        endif

        //Witch Doctor passive
        if GetUnitTypeId(u) == WITCH_DOCTOR_UNIT_ID then
            set elementCount = elementCount + GetWitchDoctorAbsoluteLevel(u, id)
        endif
        
        return elementCount 
    endfunction

    function GetUnitLuck takes unit u returns real
        return LoadReal(HT_unitstate,GetHandleId(u),5)+ 1
    endfunction

    function ElemFuncStart takes unit u, integer id returns nothing
        set GLOB_ELEM_U = u
        set GLOB_ELEM_I = id
        call ExecuteFunc("ElementStartAbilityS")
    endfunction 

    function CalculateCooldown takes unit u, integer id, real cd, boolean active returns real
        local real luck = GetUnitLuck(u)
        local real xesilChance = - 1
        local real time = cd
        local real ResCD = 1
        local integer i = 0

        //Absolute Arcane
        if GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID) > 0 and GetUnitAbilityLevel(u, NULL_VOID_ORB_BUFF_ID) == 0 then
            set i = GetClassUnitSpell(u, Element_Arcane)
            loop
                set ResCD = ResCD * (1 - ((0.002 * GetUnitAbilityLevel(u, ABSOLUTE_ARCANE_ABILITY_ID))))
                set i = i - 1
                exitwhen i <= 0
            endloop
            if ResCD < 0.1 then
                set ResCD = 0.1
            endif
        endif

        if active then
            //Frost Bolt
            if id == FROST_BOLT_ABILITY_ID then
                set time = time - (0.5 * GetClassUnitSpell(u,2))
                if time < 2 then
                    set time = 2
                endif
            endif

            //Spellbane Token
            if IsSpellbaneCooldownEnabled(u) then
                //call BJDebugMsg("spellbane bonus: " + R2S(((1 - (GetUnitState(u, UNIT_STATE_MANA) / GetUnitState(u, UNIT_STATE_MAX_MANA))) / 0.05) * 0.5))
                set time = time + (((1 - (GetUnitState(u, UNIT_STATE_MANA) / GetUnitState(u, UNIT_STATE_MAX_MANA))) / 0.05) * 0.5)
            endif

            //Fishing Rod and Blink Strike
            if UnitHasItemS(u, 'I07T') and id == BLINK_STRIKE_ABILITY_ID then
                set ResCD = ResCD * 0.5
            endif

            //Fan
            if UnitHasItemS(u,'I08Z') and IsObjectElement(id,3) then
                set ResCD = ResCD * 0.65
            endif   

            //Cheater Magic
            if GetBuffLevel(u, 'A08G') > 0 and IsSpellResettable(id) then
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
        if GetUnitTypeId(u ) == DRUID_OF_THE_CLAY_UNIT_ID and IsObjectElement(id, 12) then
            set ResCD = ResCD * 0.5
        endif
        
        //Xesil
        if (GetUnitTypeId(u ) == TIME_WARRIOR_UNIT_ID) then
            set xesilChance = 15 + (0.1 * GetHeroLevel(u) )
        endif

        //Xesil's Legacy
        if (GetUnitTypeId(u ) != TIME_WARRIOR_UNIT_ID and UnitHasItemS(u,'I03P') and GetRandomReal(0,100) <= 25 * luck) or (xesilChance <= 25 * luck and UnitHasItemS(u,'I03P') and GetRandomReal(0,100) <= 25 * luck) or (UnitHasItemS(u,'I03P') == false and GetRandomReal(0,100) <= xesilChance * luck) and IsSpellResettable(id) then
            set ResCD = 0.001
            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Other\\Charm\\CharmTarget.mdl",u,"origin" )  )     
        endif 
        
        //Staff of Water
        if UnitHasItemS(u,'I08Y') and IsObjectElement(id, 2) and IsSpellResettable(id) then
            if GetRandomReal(0,100) <= 40 * luck then
                set ResCD = 0.001
            endif
        endif
        
        //Fan
        if UnitHasItemS(u,'I08Z') and IsObjectElement(id,3) then
            set ResCD = ResCD * 0.65
        endif  

        //Dousing Hex
        if GetUnitAbilityLevel(u, DOUSING_HEX_BUFF_ID) > 0 then
            //call BJDebugMsg("cd bonus: " + R2S(DousingHexCooldown.real[GetHandleId(u)]))
            set ResCD = ResCD * DousingHexCooldown.real[GetHandleId(u)]
        endif

        return time * ResCD
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

    function AddSpecialEffectFix takes string s1, real x, real y returns effect
        local string EffectString = ""

        if EffectVisible then
            set EffectString = s1
        endif

        return AddSpecialEffect(EffectString, x, y)
    endfunction

    function AddSpecialEffectTargetFix takes string s1, unit u, string s2 returns effect
        local string EffectString = ""

        if EffectVisible then
            set EffectString = s1
        endif

        return AddSpecialEffectTarget(EffectString,u,s2)
    endfunction


    function EffectEndTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local effect fx = LoadEffectHandle(HT,GetHandleId(t),1)

        if LoadBoolean(HT, GetHandleId(t), 2) then
            call BlzSetSpecialEffectX(fx, 0)
            call BlzSetSpecialEffectY(fx, 10000)
        endif
        call DestroyEffect(fx)
        
        call FlushChildHashtable(HT,GetHandleId(t))
        call ReleaseTimer(t)
        set fx = null
        set t = null
    endfunction

    function AddSpecialEffectTimer takes string s1, real x, real y,real time, boolean skipDeath returns nothing
        local string EffectString = ""
        local timer t = NewTimer()
        local effect e 
        if EffectVisible then
            set EffectString = s1
        endif
        set e = AddSpecialEffect(EffectString, x, y)
        call SaveEffectHandle(HT,GetHandleId(t),1,e)
        call SaveBoolean(HT, GetHandleId(t), 2, skipDeath)
        call TimerStart(t,time,false,function EffectEndTimer)
        set e = null
        set t = null
    endfunction

    function AddSpecialEffectTargetTimer takes string s1, unit u, string s2,real time, boolean skipDeath returns nothing
        local string EffectString = ""
        local timer t = NewTimer()
        local effect e 
        if EffectVisible then
            set EffectString = s1
        endif
        set e = AddSpecialEffectTarget(EffectString,u,s2)
        call SaveEffectHandle(HT,GetHandleId(t),1,e)
        call SaveBoolean(HT, GetHandleId(t), 2, skipDeath)
        call TimerStart(t,time,false,function EffectEndTimer)
        set e = null
        set t = null
    endfunction

    function USOrderATimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer i = GetHandleId(t)
        local unit u1 = LoadUnitHandle(HT,i,1)
        local real x = LoadReal(HT,i,3)
        local real y = LoadReal(HT,i,4)
        local integer idsp = LoadInteger(HT,i,5)
        local string ordstr = LoadStr(HT,i,6)
        local real life_1 = LoadReal(HT,i,7)
        local abilityreallevelfield REALF = ConvertAbilityRealLevelField(LoadInteger(HT,i,8))
        local unit Caster1 = CreateUnit(GetOwningPlayer(u1),PRIEST_1_UNIT_ID,x,y, 0  )

        call ReleaseTimer(t)
        call FlushChildHashtable(HT,i)
        set t = null

        call UnitAddAbility(Caster1,idsp ) 
        call BlzSetAbilityRealLevelField( BlzGetUnitAbility(Caster1,idsp),REALF,0,life_1)


        call IssueImmediateOrder( Caster1, ordstr )
        call UnitApplyTimedLife(Caster1,RAPIER_OF_THE_GODS_BUFF_ID,9)


        set Caster1 = null
    endfunction


    function USOrderA takes unit u1, real x, real y,integer idsp, string ordstr, real life_1, abilityreallevelfield REALF returns nothing
        local DummyOrder dummy = DummyOrder.create(u1, x, y, GetUnitFacing(u1), 9)
        call dummy.addActiveAbility(idsp, 1, OrderId(ordstr))
        if REALF != null then
            call dummy.setAbilityRealField(idsp, REALF, life_1)
        endif
        call dummy.instant().activate()
    endfunction

    function SetUnitProcHp takes unit u, real bonus returns nothing
        local real BonusOldHp = LoadReal(HT,GetHandleId(u),- 412446)
        local real Hp = I2R(BlzGetUnitMaxHP(u))- BonusOldHp
        local real BonusNewHp = Hp * bonus
        call BlzSetUnitMaxHP(u,R2I(Hp + BonusNewHp) )  
        call SaveReal(HT,GetHandleId(u),- 412446, I2R(R2I(BonusNewHp)))
    endfunction

    function RemoveHeroAbilities takes unit u returns nothing
        local integer i = 0
        local integer abilId = 0
        loop
            set abilId = GetInfoHeroSpell(u, i)
            if abilId != 0 then
                call UnitRemoveAbility(u, abilId)
            endif
            set i = i + 1
            exitwhen i > 20
        endloop
    endfunction

    function AddCooldowns takes unit u,real cd returns nothing
        local integer i1 = 1
        local integer id = 0 
        
        loop
            exitwhen i1 > 10
            set id = GetInfoHeroSpell(u ,i1)
            call BlzStartUnitAbilityCooldown(u,id, cd + BlzGetUnitAbilityCooldownRemaining(u,id))

            set i1 = i1 + 1
        endloop
        


    endfunction
endlibrary