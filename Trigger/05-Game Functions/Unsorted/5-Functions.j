library Functions initializer init requires ExtradimensionalCooperation, Sorcerer, EnergyBombardment, SpiritTauren, Immolation, EndOfRoundItem, ArenaMasterBonus, Glory, MysteriousTalent, SearingArrows, PandaSkin, CustomGameEvent, HeroAbilityTable, SellItems
    globals 
        integer RectPid
        integer array Lives
    endglobals

    function SpellLearnedFunc takes unit u, integer abilId returns nothing

        if GetUnitTypeId(u) == TAUREN_UNIT_ID then
            call UpdateSpiritTaurenRuneBonus(u)
        endif

        if GetUnitTypeId(u) == SORCERER_UNIT_ID then
            call AddToSpellList(u, SORCERER_UNIT_ID, abilId)
        endif

        if GetUnitAbilityLevel(u, TERRESTRIAL_GLAIVE_ABILITY_ID) != 0 then
            call AddToSpellList(u, TERRESTRIAL_GLAIVE_ABILITY_ID, abilId)
        endif

        if GetUnitAbilityLevel(u, CONTEMPORARY_RUNES_ABILITY_ID) != 0 then
            if abilId != CONTEMPORARY_RUNES_ABILITY_ID then
                call AddToSpellList(u, CONTEMPORARY_RUNES_ABILITY_ID, abilId)
            else
                call CreateSpellList(u, CONTEMPORARY_RUNES_ABILITY_ID, SpellListFilter.ContempRunesSpellListFilter)
            endif
        endif

        if abilId == ENERGY_BOMBARDMENT_ABILITY_ID then
            call LearnEnergyBombardment(u)
        endif
    endfunction

    function SetSkillParameters takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        local integer i1 = 0
        local integer i2 = 0

        if abilId == EVASION_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_EVASION, 2 * I2R(i1 - i2))	
            call SaveInteger(HT, hid, abilId, i1)
        endif

        if abilId == DRUNKEN_MASTER_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_EVASION, 1.5 * I2R(i1 - i2))	
            call SaveInteger(HT, hid, abilId, i1)
        endif 

        if abilId == HARDENED_SKIN_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_BLOCK, 50 * I2R(i1 - i2))	
            call SaveInteger(HT, hid, abilId, i1)
        endif 

        if abilId == FIRE_SHIELD_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_MAGICRES, 3 * I2R(i1 - i2))	
            call SaveInteger(HT, hid, abilId, i1)
        endif 

        if abilId == MEGA_LUCK_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_LUCK, 0.015 * I2R(i1 - i2))	
            call SaveInteger(HT, hid, abilId, i1)
        endif 

        if abilId == DEMOLISH_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            call AddUnitCustomState(u, BONUS_PHYSPOW, 3 * I2R(i1 - i2))
            call SaveInteger(HT, hid, abilId, i1)
        endif

        if abilId == LEARNABILITY_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId) 
            if i1 != 0 then
                set LearnabilityBonus.real[hid] = 0.05 + (0.005 * I2R(i1 - i2))
            else
                set LearnabilityBonus.real[hid] = 0
            endif
            call SaveInteger(HT, hid, abilId, i1)
        endif

        if abilId == SPIKED_CARAPACE_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT, hid, abilId)
            call AddUnitBonus(u, BONUS_ARMOR, 7 * (i1 - i2))
            call SaveInteger(HT, hid, abilId, i1)
        endif

        if abilId == UNHOLY_AURA_ABILITY_ID then
            set i1 = GetSpellValue(10, 5, GetUnitAbilityLevel(u, abilId))
            set i2 = LoadInteger(HT, hid, abilId)
            call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, i1 - i2)
            call SaveInteger(HT, hid, abilId, i1)
        endif
    endfunction

    function RemoveSkillStruct takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        
        if abilId == SEARING_ARROWS_ABILITY_ID then
            call GetSearingArrowsStruct(hid).destroy()
        endif

        if abilId == IMMOLATION_ABILITY_ID then
            call GetImmolationStruct(hid).destroy()
        endif
    endfunction

    //Todo: Refactor this library so this isnt needed
    function TempUpdateMartialRetributionText takes integer handleId, player p, integer abilLvl, integer heroLvl returns nothing
        local string s = UpdateAbilityDescription(GetAbilityDescription(MARTIAL_RETRIBUTION_ABILITY_ID, abilLvl - 1), p, MARTIAL_RETRIBUTION_ABILITY_ID, ",s00,", R2I(MartialRetributionStorage.real[handleId]), abilLvl)
        call UpdateAbilityDescription(s, p, MARTIAL_RETRIBUTION_ABILITY_ID, ",s01,", R2I((300 * abilLvl) * (1 + 0.02 * heroLvl)), abilLvl)
    endfunction

    function FuncEditParam takes integer abilId, unit u returns nothing
        local integer NumAbility
        local integer level = GetUnitAbilityLevel(u, abilId)

        if IsUnitType(u, UNIT_TYPE_HERO) and IsAbsolute(abilId) == false then
            call UpdateHeroSpellList(abilId, u, 0)

            //call SetChanellOrder(u, abilId, GetHeroSpellAtPosition(u, abilId))
        endif

        if IsAbilityEnabled(u, abilId) then
            call ToggleUpdateDescription(GetOwningPlayer(u), abilId, level)
        endif

        if abilId == ABSOLUTE_DARK_ABILITY_ID then
            call UnitAddAbility(u, 'A0DH')
        endif

        call SetSkillParameters(u, abilId)

        if abilId == MYSTERIOUS_TALENT_ABILITY_ID or abilId == ANCIENT_TEACHING_ABILITY_ID or abilId == TIME_MANIPULATION_ABILITY_ID and level == 1 then
            call BlzStartUnitAbilityCooldown(u, abilId, 60)
            if HasDummySpell(u, abilId) then
                call BlzStartUnitAbilityCooldown(u, GetDummySpell(u, abilId), 60)
            endif
        endif

        if abilId == MEGA_SPEED_ABILITY_ID then     
            if LoadReal(HT, GetHandleId(u), 1) == 0 then 
                call SaveReal(HT, GetHandleId(u), 1, BlzGetUnitAttackCooldown(u, 0))
            endif
        endif

        if abilId == ICE_FORCE_ABILITY_ID then
            call UpdateAbilityDescription(GetAbilityDescription(ICE_FORCE_ABILITY_ID, level - 1), GetOwningPlayer(u), ICE_FORCE_ABILITY_ID, ",s01,", R2I((1 - (500. / (500. + GetHeroInt(u, true)))) * 100), level)
        endif

        if abilId == MARTIAL_RETRIBUTION_ABILITY_ID then
            call TempUpdateMartialRetributionText(GetHandleId(u), GetOwningPlayer(u), level, GetHeroLevel(u))
        endif

        call SecretCheck_CheckAbilitiesAndItems(u)
    endfunction

    function FunResetAbility takes integer abilId, unit u returns nothing

        call ResetHeroSpellPosition(u, abilId)

        call SetSkillParameters(u, abilId)

        call RemoveSkillStruct(u, abilId)

        if GetUnitTypeId(u) == TAUREN_UNIT_ID then
            call UpdateSpiritTaurenRuneBonus(u)
        endif

        if UnitHasFilterSpellList(GetHandleId(u)) then
            call RemoveSpellFromAllUnitLists(u, abilId)
        endif

        if GetFilterList(GetHandleId(u), abilId) != 0 then
            call RemoveSpellList(u, abilId)
        endif

        if abilId == ABSOLUTE_DARK_ABILITY_ID then
            call UnitRemoveAbility(u, 'A0DH')
        endif
    endfunction

    function SaveUnitBaseValues takes unit u returns nothing
        call SaveReal(HT, GetHandleId(u), -1001, BlzGetUnitAttackCooldown(u, 0))
    endfunction

    function SellItemsOnGround takes nothing returns nothing
        local itemtype itemType = GetItemType(GetEnumItem())
        if itemType != ITEM_TYPE_POWERUP and itemType != ITEM_TYPE_CAMPAIGN then
            call SellItem(RectPid, GetEnumItem())
        endif
    endfunction

    function Func_completeLevel takes unit u returns nothing
        local player p = GetOwningPlayer(u)
        local integer pid = GetPlayerId(p)
        local integer i1 = 0 
        local real r1 = 0
        local real gloryBonus = 0
        local integer hid = GetHandleId(u)

        //cleanup items
        set RectPid = pid
        call EnumItemsInRectBJ(PlayerArenaRects[pid], function SellItemsOnGround)

        //Extra-dimensional Cooperation
        if GetUnitAbilityLevel(u, EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID) > 0 then
            call ResetExtraDimensional(u)
        endif

        //Wolf Rider - Thrall
        if GetUnitTypeId(u) == WOLF_RIDER_UNIT_ID and (T32_Tick - RoundTimer[pid]) / 32 < 8 + (0.01 * GetHeroLevel(u)) then
            set i1 = R2I(10 + (GetHeroLevel(u) * 1))
            set SpeedFreakBonus[GetHandleId(u)].integer[4] = SpeedFreakBonus[GetHandleId(u)].integer[4] + i1
            call SetBonus(u, 0, SpeedFreakBonus[GetHandleId(u)].integer[4])
            call DisplayTextToPlayer(p, 0, 0, "|cfffff56eSpeed Freak|r: |cff88ff00+" + I2S(i1) + " agility.|r")
            call SetHeroAgi(u, GetHeroAgi(u, false) + i1, true)
        endif

        //Round glory
        set Glory[pid] = Glory[pid] + GetPlayerGloryBonus(pid)
        call ResourseRefresh(Player(pid)) 
        call AdjustPlayerStateBJ(Income[pid], p, PLAYER_STATE_RESOURCE_GOLD)
        call DisplayTextToPlayer(p, 0, 0, "|cffffee00Gold Income|r: +" + I2S(Income[pid])  + " + (|cffffee00Bonus|r: +" + I2S(LumberGained[pid]) + ") - |cff7af0f8Glory|r: +" + I2S(R2I((GetPlayerGloryBonus(pid)))))

        if IncomeMode < 2 and Income[pid] == 0 then 
            call DisplayTextToPlayer(p, 0, 0, "You can increase your income in Power Ups Shop II")       
        endif

        if RoundNumber == 1 then
            call ShowDiscordFrames(p, true)
        endif

        if RoundNumber == 2 then
            call ShowDiscordFrames(p, false)
        endif
        
        if ModuloInteger(RoundNumber, 3) == 0 then
            call Hints_DisplayHint(pid)
        endif

        set p = null
    endfunction

    function OnRoundEnd takes EventInfo ev returns nothing
        local integer pid = GetPlayerId(ev.p)
        if ev.roundNumber == 16 or ev.roundNumber == 32 then
            set Lives[pid] = Lives[pid] + 1
            call UpdateLivesForPlayer(ev.p, Lives[pid], false)
            call DisplayTextToPlayer(ev.p, 0, 0, "|cff85ff3eRound|r: " + I2S(ev.roundNumber) + "|r: |cffecff3e+1 life|r for you being you.")
        endif
    endfunction

    private function init takes nothing returns nothing
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.OnRoundEnd)
    endfunction
endlibrary