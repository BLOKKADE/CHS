library Functions requires ExtradimensionalCooperation, SpiritTauren, Immolation, EndOfRoundItem, ArenaRing, Glory, MysteriousTalent, SearingArrows, PandaSkin, CustomEvent, HeroAbilityTable
    globals 
        integer RectPid
        integer array Lives
    endglobals

    function SpellLearnedFunc takes unit u, integer abilId returns nothing

        if GetUnitTypeId(u) == TAUREN_UNIT_ID then
            call UpdateSpiritTaurenRuneBonus(u)
        endif
    endfunction

    function SetSkillParameters takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        local integer i1 = 0
        local integer i2 = 0

        if abilId == EVASION_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u,abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u , BONUS_EVASION,   2 * I2R(i1 - i2)  )	
            call SaveInteger(HT,hid, abilId,i1)
        endif

        if abilId == DRUNKEN_MASTER_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u,abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u , BONUS_EVASION,   1.5 * I2R(i1 - i2)  )	
            call SaveInteger(HT,hid, abilId,i1)
        endif 

        if abilId == HARDENED_SKIN_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u,abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u , BONUS_BLOCK,   50 * I2R(i1 - i2)  )	
            call SaveInteger(HT,hid, abilId,i1)
        endif 

        if abilId == FIRE_SHIELD_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u,abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u , BONUS_MAGICRES,   3 * I2R(i1 - i2)  )	
            call SaveInteger(HT,hid, abilId,i1)
        endif 

        if abilId == MEGA_LUCK_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u,abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u , BONUS_LUCK,   0.01 * I2R(i1 - i2)  )	
            call SaveInteger(HT,hid, abilId,i1)
        endif 

        if abilId == DEMOLISH_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            call AddUnitCustomState(u, BONUS_PHYSPOW, 3 * I2R(i1 - i2))
            call SaveInteger(HT,hid, abilId,i1)
        endif

        if abilId == LEARNABILITY_ABILITY_ID then
            set i1 = GetUnitAbilityLevel(u, abilId)
            set i2 = LoadInteger(HT,hid, abilId) 
            if i1 != 0 then
                set LearnabilityBonus.real[hid] = 0.05 + (0.005 * I2R(i1 - i2))
            else
                set LearnabilityBonus.real[hid] = 0
            endif
            call SaveInteger(HT,hid, abilId,i1)
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

    function FuncEditParam takes integer abilId, unit u returns nothing
        local integer NumAbility
        local integer level = GetUnitAbilityLevel(u, abilId)

        if IsUnitType(u, UNIT_TYPE_HERO) and IsAbsolute(abilId) == false then
            call UpdateHeroSpellList(abilId,u,0)

            //call SetChanellOrder(u,abilId,GetHeroSpellAtPosition(u,abilId)  )
        endif

        if IsAbilityEnabled(u, abilId) then
            call ToggleUpdateDescription(GetOwningPlayer(u), abilId, level)
        endif

        call SetSkillParameters(u, abilId)

        if abilId == MYSTERIOUS_TALENT_ABILITY_ID or abilId == ANCIENT_TEACHING_ABILITY_ID or abilId == TIME_MANIPULATION_ABILITY_ID and level == 1 then
            call BlzStartUnitAbilityCooldown(u,abilId,60)
        endif

        /*if abilId == MYSTERIOUS_TALENT_ABILITY_ID then
            call MysteriousTalentUpdateDesc(u)
        endif*/

        if abilId == MEGA_SPEED_ABILITY_ID then     
            if LoadReal(HT, GetHandleId(u),1 ) == 0 then 
                call SaveReal(HT,GetHandleId(u),1, BlzGetUnitAttackCooldown(u,0)    )
            endif
            call SaveReal(HT, GetHandleId(u), MEGA_SPEED_ABILITY_ID, 0.02 * level)	
            //     call BlzSetUnitAttackCooldown(u, 0.92 - (0.02*I2R(GetUnitAbilityLevel(u,abilId)) ),0  )
        endif

        if abilId == ICE_FORCE_ABILITY_ID then
            call UpdateAbilityDescription(GetAbilityDescription(ICE_FORCE_ABILITY_ID, level - 1), GetOwningPlayer(u), ICE_FORCE_ABILITY_ID, ",s01,", R2I((1 - (500 / (500 + GetHeroInt(u, true)))) * 100), level)
        endif

        if abilId == MARTIAL_RETRIBUTION_ABILITY_ID then
            call UpdateAbilityDescription(GetAbilityDescription(ICE_FORCE_ABILITY_ID, level - 1), GetOwningPlayer(u), ICE_FORCE_ABILITY_ID, ",s01,", R2I((1 - (500 / (500 + GetHeroInt(u, true)))) * 100), level)
        endif

        call PandaSkin_CheckAbilitiesAndItems(u)
    endfunction

    function FunResetAbility takes integer abilId, unit u returns nothing

        call ResetHeroSpellPosition(u,abilId)

        call SetSkillParameters(u, abilId)

        call RemoveSkillStruct(u, abilId)

        if GetUnitTypeId(u) == TAUREN_UNIT_ID then
            call UpdateSpiritTaurenRuneBonus(u)
        endif

        /*if abilId == MEGA_SPEED_ABILITY_ID then
            if LoadReal(HT, GetHandleId(u),1 ) != 0 then
                //   call BlzSetUnitAttackCooldown(u,LoadReal(HT, GetHandleId(u),1 ) ,0 ) 
            endif
        endif*/
    endfunction

    function FunctionStartUnit takes unit U returns nothing
        if LoadReal(HT, GetHandleId(U),1 ) == 0 then 
            call SaveReal(HT,GetHandleId(U),- 1001, BlzGetUnitAttackCooldown(U,0)    )
            call SaveInteger(HT,GetHandleId(U),- 1000,  BlzGetUnitIntegerField(U,UNIT_IF_PRIMARY_ATTRIBUTE)    )
        endif
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
        local DarkSeal ds = 0
        local real gloryBonus = 0
        local integer hid = GetHandleId(u)
        local customEvent e = customEvent.create()
        set e.EventUnit = u
        call DispachEvent(CUSTOM_EVENT_COMPLETE_LEVEL, e)

        //cleanup items
        set RectPid = pid
        call EnumItemsInRectBJ(PlayerArenaRects[pid + 1],function SellItemsOnGround)

        //Armor of the Ancestors
        set i1 = LoadInteger(HT,GetHandleId(u),54001)
        if i1 != 0 then 
            call BlzSetUnitArmor(u,BlzGetUnitArmor(u)- i1)
            call AddUnitCustomState(u, BONUS_BLOCK,- i1)
            call SaveInteger(HT,GetHandleId(u),54001,0)
        endif

        //Arcane Infused Sword
        set i1 = LoadInteger(HT,GetHandleId(u),ARCANE_INFUSED_SWORD_ITEM_ID)
        if i1 != 0 then 
            call AddUnitBonus(u, BONUS_DAMAGE, 0 - i1)
            call SaveInteger(HT,GetHandleId(u),ARCANE_INFUSED_SWORD_ITEM_ID,0)
        endif

        set r1 = LoadReal(HT,GetHandleId(u),DESTRUCTION_BLOCK_ABILITY_ID)
        if r1 != 0 then 
            call AddUnitCustomState(u, BONUS_BLOCK, -r1)
            call SaveReal(HT,GetHandleId(u),DESTRUCTION_BLOCK_ABILITY_ID,0)
        endif

        //Murloc Warrior
        set i1 = LoadInteger(HT,GetHandleId(u),54021)
        if i1 != 0 then 
            call SetHeroStr(u,GetHeroStr(u,false)- i1,false)
            call SetHeroAgi(u,GetHeroAgi(u,false)- i1,false)
            call SetHeroInt(u,GetHeroInt(u,false)- i1,false)
            call SaveInteger(HT,GetHandleId(u),54021,0)
        endif

        //Ankh
        if AnkhLimitReached.boolean[hid] then
            if GetItemCharges(GetUnitItem(u, 'ankh')) != 2 then
                set AnkhLimitReached.boolean[hid] = false
            endif
        endif

        //Obsidian Armor
        set i1 = GetValidEndOfRoundItems(u,'I07H') 
        if i1 > 0 then
            call AddUnitCustomState(u, BONUS_BLOCK,20 * i1)
        endif

        //Leather Armor
        set i1 = GetValidEndOfRoundItems(u,'I0CM') 
        if i1 > 0 then
            call BlzSetUnitMaxHP(u,BlzGetUnitMaxHP(u) +   1200 * i1)
        endif

         //Mana gem
         set i1 = GetValidEndOfRoundItems(u,MANA_GEM_ITEM_ID) 
         if i1 > 0 then
             call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) +   275 * i1)
         endif

         //Rapira
        set i1 = GetValidEndOfRoundItems(u,RAPIRA_ITEM_ID) 
        if i1 > 0 then
            call AddUnitBonus(u, BONUS_DAMAGE, 40 * i1)
        endif

         //Golden Armor
         set i1 = GetValidEndOfRoundItems(u,'I0C1') 
         if i1 > 0 then
             call AddUnitCustomState(u, BONUS_MAGICRES,1 * i1)
         endif

        //Extra-dimensional Cooperation
        if GetUnitAbilityLevel(u, EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID) > 0 then
            call ResetExtraDimensional(u)
        endif

        //Time Manipulation
        if GetUnitAbilityLevel(u, TIME_MANIPULATION_ABILITY_ID) > 0 then
            set TimeManipulationTable[GetHandleId(u)].boolean[1] = false
            set TimeManipulationTable[GetHandleId(u)].real[2] = 0
            call BlzEndUnitAbilityCooldown(u, TIME_MANIPULATION_ABILITY_ID)
        endif

        //Wolf Rider - Thrall
        if GetUnitTypeId(u) == WOLF_RIDER_UNIT_ID and (T32_Tick - RoundTimer[pid]) / 32 < 8 + (0.01 * GetHeroLevel(u)) then
            set i1 = R2I(10 + (GetHeroLevel(u) * 1))
            set SpeedFreakBonus[GetHandleId(u)].integer[4] = SpeedFreakBonus[GetHandleId(u)].integer[4] + i1
            call SetBonus(u, 0, SpeedFreakBonus[GetHandleId(u)].integer[4])
            call DisplayTextToPlayer(p,0,0,"|cfffff56eSpeed Freak|r: |cff88ff00+" + I2S(i1) + " agility.|r")
            call SetHeroAgi(u, GetHeroAgi(u, false) + i1, true)
        endif

        //Round glory
        set Glory[pid] = Glory[pid] + GetPlayerGloryBonus(pid)
        call ResourseRefresh(Player(pid)) 
        call AdjustPlayerStateBJ( Income[pid],p,PLAYER_STATE_RESOURCE_GOLD)
        call DisplayTextToPlayer(p,0,0,"|cffffee00Gold Income|r: +" + I2S(Income[pid])  + " - |cff00aa0eLumber|r: +" + I2S(LumberGained[pid]) + " - |cff7af0f8Glory|r: +" + I2S(R2I((GetPlayerGloryBonus(pid)))))

        if IncomeMode < 2 and Income[pid] == 0 then 
            call DisplayTextToPlayer(p,0,0,"You can increase your income in Power Ups Shop II")       
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

        if (RoundNumber == 16 or RoundNumber == 32) then
            set Lives[pid] = Lives[pid] + 1
            call DisplayTextToPlayer(p,0,0,"|cff85ff3eRound|r: " + I2S(RoundNumber) + "|r: |cffecff3e+1 life|r for you being you.")
        endif

        set p = null
    endfunction
endlibrary