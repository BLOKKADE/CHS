library Tomes initializer init requires RandomShit, CustomState, NonLucrativeTome, LearnAbsolute

    globals
        Table GloryRegenLevel
        Table GloryAttackCdBonus
        Table GloryAttackCdLevel
        integer array MaxAbsolute
    endglobals

    private function PlayerAddGold takes player p, integer i returns nothing
        call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,  GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) + i)
    endfunction

    // Function is currently not used
    private function GetItemCost takes item it, boolean gold returns integer
        local integer goldCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_RED)
        local integer lumberCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_GREEN)
        local integer multiplier = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_BLUE)
        if multiplier == 255 then
            set multiplier = 1
        endif
        if goldCost == 255 then
            set goldCost = 0
        else
            set goldCost = goldCost * multiplier
        endif

        if lumberCost == 255 then
            set lumberCost = 0
        else
            set lumberCost = lumberCost * multiplier
        endif

        if gold then
            return goldCost + (lumberCost * 30)
        else
            return lumberCost + ((goldCost - (ModuloInteger(goldCost, 30))) / 30)
        endif
    endfunction

    // Function is currently not used
    private function PlayerReturnLumber takes item it, integer II, player p returns nothing 
        call AdjustPlayerStateBJ(GetItemCost(it, false),p,PLAYER_STATE_RESOURCE_LUMBER)
        call ResourseRefresh(p)
    endfunction

    private function IncomeText takes integer pid, boolean all returns nothing
        local integer i = 0
        loop
            if all then
                if pid == i then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, "|cffdfb632You upgraded your creeps to|r |cffd64646level " + I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r (|cffdf9432Global level: " + I2S(BonusNeutral) + "|r)")
                elseif IncomeSpamDisabled[i] == false then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+ " |cffdfb632upgrades creeps to|r |cffd64646lvl " + I2S(BonusNeutral + BonusNeutralPlayer[i]) + "|r (|cffdf9432Global: " + I2S(BonusNeutral) + "|r)")
                endif
            else
                if pid == i then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, "|cffdfb632You upgraded your creeps to|r |cffd64646level " + I2S(BonusNeutral + BonusNeutralPlayer[pid]) + "|r")
                elseif IncomeSpamDisabled[i] == false then
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+ " |cffdfb632upgrades the creeps for themselves to|r |cffd64646level " + I2S(BonusNeutralPlayer[pid]))
                endif
            endif
            set i = i + 1
            exitwhen i == 8
        endloop
    endfunction

    private function CanAfford takes player p, item it returns boolean
        local integer goldCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_RED)
        local integer lumberCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_GREEN)
        local integer multiplier = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_BLUE)
        if multiplier == 255 then
            set multiplier = 1
        endif
        if goldCost == 255 then
            set goldCost = 0
        else
            set goldCost = goldCost * multiplier
        endif

        if lumberCost != 255 then
            set goldCost = goldCost + lumberCost * multiplier * 30
        endif
        if GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) >= goldCost then
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) - goldCost)
            return true
        else
            return false
        endif
    endfunction

    private function TomesActions takes nothing returns nothing
        local item It = GetManipulatedItem()
        local integer II = GetItemTypeId(It)
        local unit u = GetTriggerUnit()
        local player p = GetOwningPlayer(u)
        local integer pid = GetPlayerId(p)
        local boolean ctrl = false
        local integer creepLevelBonus = 0
        local integer creepLevelPlayerBonus = 0
        local integer i = 0
        local integer summonUpgradeBonus = 0
        local real temp = 0
        local real gloryBonus = 0
        local boolean maxLevel = GetHeroLevel(u) == 600
        local boolean expTome = false
        local string max = "|cffff0000You already have 4 Glory Absolute Bonuses|r"

        if ((GetItemType(It) == ITEM_TYPE_POWERUP or GetItemType(It) == ITEM_TYPE_CAMPAIGN) and not IsHeroUnitId(GetUnitTypeId(u))) then
            set u = null
            set p = null
            set It = null
			return
		endif

        if HoldShift[pid] then
            set ctrl = true
        endif

        if (II == ANKH_ITEM_ID and GetUnitItemTypeCount(u, ANKH_ITEM_ID) > 1) then
            call DisplayTimedTextToPlayer(p, 0, 0, 2, "Cannot have more than 1 |cffdf9432" + GetObjectName(II) + "|r")
            call UnitRemoveItem(u, It)
            set u = null
            set p = null
            set It = null
            return
        endif

        loop
            //Agility level bonus
            if II == AGILITY_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddStatLevelBonus(u, BONUS_AGILITY, 1)

                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif
                //Intelligence level bonus
            elseif II == INTELLIGENCE_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddStatLevelBonus(u, BONUS_INTELLIGENCE, 1)
                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif
                //Strength level bonus
            elseif II  == STRENGTH_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddStatLevelBonus(u, BONUS_STRENGTH, 1)
                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)

                    call RemoveItem(It)
                else
                    set ctrl = false
                endif

                //Glory armor
            elseif II  == GLORY_ARMOR_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call BlzSetUnitArmor(u,BlzGetUnitArmor(u)+ 25)
                    
                    
                    set gloryBonus = gloryBonus + 25
                else
                    set ctrl = false
                endif

                //Glory damage
            elseif II  == GLORY_ATTACK_DAMAGE_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ 100,0)
                    
                    
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif    

                //Glory hp regen
            elseif II  == GLORY_HIT_POINT_REGENERATION_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    set GloryRegenLevel[GetHandleId(u)] = GloryRegenLevel[GetHandleId(u)] + 1
                    call AddUnitBonusReal(u, BONUS_HEALTH_REGEN, 50)
                    
                    
                    set gloryBonus = gloryBonus + 50 
                else
                    set ctrl = false
                endif      

                //glory magic resistance
            elseif II  == GLORY_MAGIC_PROTECTION_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then

                    call AddUnitCustomState(u, BONUS_MAGICRES,5)
                    
                    
                    set gloryBonus = gloryBonus + 5
                else
                    set ctrl = false
                endif    

                //glory magic damage
            elseif II  == GLORY_MAGIC_POWER_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call AddUnitCustomState(u, BONUS_MAGICPOW, 2)
                    
                    
                    set gloryBonus = gloryBonus + 2
                else
                    set ctrl = false
                endif 

                //glory phys power
            elseif II  == GLORY_PHYS_POWER_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call AddUnitCustomState(u, BONUS_PHYSPOW,2)
                    
                    
                    set gloryBonus = gloryBonus + 2
                else
                    set ctrl = false
                endif  
                
                //glory mana regen
            elseif II  == GLORY_MANA_REGENERATION_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call BlzSetUnitRealField(u,ConvertUnitRealField('umpr'),BlzGetUnitRealField(u,ConvertUnitRealField('umpr')) + 100)
                    
                    
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif   
                //glory luck
            elseif II  == GLORY_LUCK_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call AddUnitCustomState(u, BONUS_LUCK, 0.01)
                    set gloryBonus = gloryBonus + 1
                else
                    set ctrl = false
                endif  

                //glory pvp bonus
            elseif II  == GLORY_PVP_BONUS_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    // set PvpBonus[pid] = PvpBonus[pid]+1.5
                    call AddUnitCustomState(u, BONUS_PVP,1.5)
                    
                    
                    set gloryBonus = gloryBonus + 1.5
                else
                    set ctrl = false
                endif  

                //glory hit points
            elseif II  == GLORY_HIT_POINTS_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) + 300)
                    
                    
                    set gloryBonus = gloryBonus + 300
                else
                    set ctrl = false
                endif      

                //glory mana
            elseif II  == GLORY_MANA_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + 200)
                    set gloryBonus = gloryBonus + 200
                else
                    set ctrl = false
                endif  

                //glory attack cooldown
            elseif II  == GLORY_ATTACKCD_TOME_ITEM_ID then
                if LoadReal(HT, GetHandleId(u), - 1001) - (LoadReal(HT, GetHandleId(u), - 1001) * GloryAttackCdBonus.real[GetHandleId(u)]) > 0.40 and BuyGloryItem(pid, II) then
                    set GloryAttackCdLevel.integer[GetHandleId(u)] = GloryAttackCdLevel.integer[GetHandleId(u)] + 1
                    set GloryAttackCdBonus.real[GetHandleId(u)] = 1 - Pow(0.94, GloryAttackCdLevel.integer[GetHandleId(u)])
                    set temp = BlzGetUnitAttackCooldown(u, 0)
                    if ModifyAttackCooldown(u, GetHandleId(u)) <= 0.40 then
                        set ctrl = false
                    endif
                    set gloryBonus = temp - BlzGetUnitAttackCooldown(u, 0)
                else
                    set ctrl = false
                endif  

                //glory strength
            elseif II  == GLORY_STRENGTH_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call SetHeroStr(u, GetHeroStr(u, false) + 50, true)
                    
                    
                    set gloryBonus = gloryBonus + 50
                else
                    set ctrl = false
                endif  

                //glory agility
            elseif II  == GLORY_AGILITY_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call SetHeroAgi(u, GetHeroAgi(u, false) + 50, true)
                    
                    
                    set gloryBonus = gloryBonus + 50
                else
                    set ctrl = false
                endif  

                //glory intelligence
            elseif II  == GLORY_INTELLIGENCE_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call SetHeroInt(u, GetHeroInt(u, false) + 50, true)
                    
                    set gloryBonus = gloryBonus + 50
                else
                    set ctrl = false
                endif  

                //glory evasion
            elseif II  == GLORY_EVASION_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call AddUnitCustomState(u, BONUS_EVASION, 5)
                    
                    set gloryBonus = gloryBonus + 5
                else
                    set ctrl = false
                endif  

                //glory block
            elseif II  == GLORY_BLOCK_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    call AddUnitCustomState(u, BONUS_BLOCK, 100)
                    
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif 

                //glory movespeed
            elseif II  == GLORY_MOVESPEED_TOME_ITEM_ID then
                if BuyGloryItem(pid, II) then
                    //call SetUnitMoveSpeed(u, 522)
                    call BlzSetUnitRealField(u, UNIT_RF_SPEED, 522)
                    
                    set gloryBonus = gloryBonus + 522
                endif   
                set ctrl = false
            
                //Income all
            elseif II  == INCOME_DEFAULT_TOME_ITEM_ID then   
                set Income[pid] = Income[pid] + 90
                set BonusNeutral = BonusNeutral + 1
                set BonusNeutralPlayer[pid] = BonusNeutralPlayer[pid] + 3
                set creepLevelBonus = creepLevelBonus + 1
                set creepLevelPlayerBonus = creepLevelPlayerBonus + 1

                //Income individual
            elseif II  == INCOME_INDIVIDUAL_TOME_ITEM_ID then   

                set Income[pid] = Income[pid] + 90
                set BonusNeutralPlayer[pid] = BonusNeutralPlayer[pid] + 4
                set creepLevelPlayerBonus = creepLevelPlayerBonus + 4

                //Antagonize Creeps
            elseif II  == ANTAGONIZE_CREEPS_ITEM_ID then   
                if not CreepAntagonisationBought[pid] then
                    set CreepAntagonisationBought[pid] = true
                    set CreepAntagonisationBonus.real[pid] = CreepAntagonisationBonus.real[pid] + 1
                    call DisplayTimedTextToPlayer(p, 0, 0, 5, "|cffffcc00Next round your creeps are: |r|cffff5e00" + R2SW(CreepAntagonisationBonus.real[pid] * 100, 1, 1) + "%|R |cffffcc00stronger.|r")
                else
                    call DisplayTimedTextToPlayer(p, 0, 0, 5, "|cffffcc00You have already antagonised your creeps.|r")
                endif
                set ctrl = false

                //Life
            elseif II == LIFE_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 100000  then
                    set Lives[pid] = Lives[pid] + 1
                    call UpdateLivesForPlayer(p, Lives[pid], false)
                    call DisplayTimedTextToPlayer(p, 0, 0, 5, "|cffffcc00Lives: |r" + I2S(Lives[pid]))
                    call UnitAddItemById(u,EXPERIENCE_100000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif

                //Absolute Acorn
            elseif II == ABSOLUTE_ACORN_TOME_ITEM_ID then
                if GetHeroXP(u) >= 100000 and AddHeroMaxAbsoluteAbility(u) then
                    call UnitAddItemById(u,EXPERIENCE_50000_TOME_ITEM_ID)
                else
                    call PlayerAddGold(GetOwningPlayer(u),8000)  
                    set ctrl = false
                endif
            /*
                //Summon Attack
            elseif II == SUMMON_ATTACK_BONUS_ITEM_ID then
                set SummonDamage[pid] = SummonDamage[pid] + 1
                set summonUpgradeBonus = SummonDamage[pid]
                //Summon Armor
            elseif II == SUMMON_ARMOR_BONUS_ITEM_ID then
                set SummonArmor[pid] = SummonArmor[pid] + 1
                set summonUpgradeBonus = SummonArmor[pid]
                //Summon hit points
            elseif II == SUMMON_HP_BONUS_ITEM_ID then
                set SummonHitPoints[pid] = SummonHitPoints[pid] + 1
                set summonUpgradeBonus = SummonHitPoints[pid]
                //Summon Crit
            elseif II == SUMMON_CRITICAL_STRIKE_ITEM_ID then
                if SummonCrit[pid] < 30 then
                    set SummonCrit[pid] = SummonCrit[pid] + 1
                    set summonUpgradeBonus = SummonCrit[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                //Summon Cutting
            elseif II == SUMMON_CUTTING_ITEM_ID then
                if SummonCutting[pid] < 30 then
                    set SummonCutting[pid] = SummonCutting[pid] + 1
                    set summonUpgradeBonus = SummonCutting[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                //Summon Ice Armor
            elseif II == SUMMON_ICE_FORCE_ITEM_ID then
                if SummonIceArmor[pid] < 30 then
                    set SummonIceArmor[pid] = SummonIceArmor[pid] + 1
                    set summonUpgradeBonus = SummonIceArmor[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                //Summon Dome of Protection
            elseif II == SUMMON_DOME_OF_PROTECTION_ITEM_ID then
                if SummonDomeProtection[pid] < 30 then
                    set SummonDomeProtection[pid] = SummonDomeProtection[pid] + 1
                    set summonUpgradeBonus = SummonDomeProtection[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                //Summon Last Breath
            elseif II == SUMMON_LAST_BREATHS_ITEM_ID then
                if SummonLastBreath[pid] < 30 then
                    set SummonLastBreath[pid] = SummonLastBreath[pid] + 1
                    set summonUpgradeBonus = SummonLastBreath[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                //Summon Wild Defense
            elseif II == SUMMON_WILD_DEFENSE_ITEM_ID then
                if SummonWildDefense[pid] < 30 then
                    set SummonWildDefense[pid] = SummonWildDefense[pid] + 1
                    set summonUpgradeBonus = SummonWildDefense[pid]
                else
                    call PlayerReturnLumber(It, II, p)
                    set ctrl = false
                endif
                */
                //Manual of health
            elseif II == 'manh' then 
                call SetUnitMaxHp(u, BlzGetUnitMaxHP(u) + 50)
                //Tome of Power
            elseif II == TOME_OF_POWER_2000_ITEM_ID then 
                call AddHeroXP(u, 2000, false)
                set expTome = true
                //Tome of agility + 1
            elseif II == TOME_OF_AGILITY_ITEM_ID then 
                call SetHeroAgi(u, GetHeroAgi(u, false) + 1, true)
                //Tome of intelligence +1
            elseif II == TOME_OF_INTELLIGENCE_ITEM_ID then 
                call SetHeroInt(u, GetHeroInt(u, false) + 1, true)
                //Tome of strength +1
            elseif II == TOME_OF_STRENGTH_ITEM_ID then 
                call SetHeroStr(u, GetHeroStr(u, false) + 1, true)
                //Tome of Agility +10
            elseif II == TOME_OF_AGILITY_10_ITEM_ID then 
                call SetHeroAgi(u, GetHeroAgi(u, false) + 10, true)
                //Tome of intelligence +10
            elseif II == TOME_OF_INTELLIGENCE_10_ITEM_ID then 
                call SetHeroInt(u, GetHeroInt(u, false) + 10, true)
                //Tome of strength +10
            elseif II == TOME_OF_STRENGTH_10_ITEM_ID then 
                call SetHeroStr(u, GetHeroStr(u, false) + 10, true)
                //Tome of agility +5
            elseif II == TOME_OF_AGILITY_5_ITEM_ID then 
                call SetHeroAgi(u, GetHeroAgi(u, false) + 5, true)
                //Tome of intelligence +5
            elseif II == TOME_OF_INTELLIGENCE_5_ITEM_ID then 
                call SetHeroInt(u, GetHeroInt(u, false) + 5, true)
                //Tome of strength +5
            elseif II == TOME_OF_STRENGTH_5_ITEM_ID then 
                call SetHeroStr(u, GetHeroStr(u, false) + 5, true)
                //Tome of experience
            elseif II == TOME_OF_EXPERIENCE_100_ITEM_ID then
                call AddHeroXP(u, 100, false)
                set expTome = true
            else
                set ctrl = false
            endif
            set i = i + 1
            exitwhen ctrl == false or CanAfford(p, It) == false or i >= 1000
        endloop

        if creepLevelBonus > 0 then
            call IncomeText(pid, true)
        elseif creepLevelPlayerBonus > 0 then
            call IncomeText(pid, false)
        elseif summonUpgradeBonus > 0 then
            call DisplayTimedTextToPlayer(p, 0, 0, 2, GetObjectName(II) + " - [|cffffcc00Level " + I2S(summonUpgradeBonus) + "|r]")
        elseif gloryBonus > 0 then
            call DisplayTimedTextToPlayer(p, 0, 0, 2, GetObjectName(II) + " +|cffffcc00" + R2SW(gloryBonus, 1, 2) + "|r")
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"origin"))
        elseif i > 1 then
            call DisplayTimedTextToPlayer(p, 0, 0, 2, "Bought |cff55df32" + I2S(i) + "|r |cffdf9432" + GetObjectName(II) + "|r")
        endif

        if expTome then
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\AIem\\AIemTarget.mdl", u, "origin"))
        endif
        
        //Ancient Staff
        if II  == ANCIENT_STAFF_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(ANCIENT_STAFF_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Ancient Dagger
        elseif II  == ANCIENT_DAGGER_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(ANCIENT_DAGGER_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Ancient Axe
        elseif II  == ANCIENT_AXE_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(ANCIENT_AXE_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Dried Mushroom
        elseif II  == DRIED_MUSHROOM_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(DRIED_MUSHROOM_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),25000)
            endif

            //Vigour Token
        elseif II  == VIGOUR_TOKEN_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(VIGOUR_TOKEN_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Flimsy Token
        elseif II  == FLIMSY_TOKEN_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(FLIMSY_TOKEN_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Spellbane Token
        elseif II  == SPELLBANE_TOKEN_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(SPELL_BANE_TOKEN_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif	

            //Mask of Elusion
        elseif II  == MASK_OF_ELUSION_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(MASK_OF_ELUSION_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),20000)
            endif

            //Mask of Vitality
        elseif II  == MASK_OF_VITALITY_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(MASK_OF_VITALITY_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),20000)
            endif

            //Packing Tape
        elseif II == PACKING_TAPE_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(PACKING_TAPE_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif

            //Mask of Protection
        elseif II  == MASK_OF_PROTECTION_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(MASK_OF_PROTECTION_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),20000)
            endif	
            //Sword of Blodthirst
        elseif II  == SWORD_OF_BLOODTHRIST_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(SWORD_OF_BLOODTHRIST_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),10000)
            endif
            //Wisdom Chestplate
        elseif II  == WISDOM_CHESTPLATE_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(WISDOM_CHESTPLATE_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),15000)
            endif
            //Lucky Pants
        elseif II  == LUCKY_PANTS_TOME_ITEM_ID then   
            if UnitHasInventorySpace(u) and BuyGloryItem(pid, II) then
                call UnitAddItem(u,CreateItem(LUCKY_PANTS_ITEM_ID,0,0))
                
            else
                call PlayerAddGold(GetOwningPlayer(u),20000)
                    
            endif	
            //Ankh of Reincarnation
        elseif II == 'I0BH' then
            set It = GetUnitItem(u, ANKH_ITEM_ID)

            if (It != null) then
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Cannot buy more |cffdf9432" + GetObjectName(II) + "|r")
                call PlayerAddGold(GetOwningPlayer(u), 400)
            elseif (not HasPlayerFinishedLevel(u, p)) then
                call DisplayTimedTextToPlayer(p, 0, 0, 2, "Cannot buy |cffdf9432" + GetObjectName(II) + "|r during a round")
                call PlayerAddGold(GetOwningPlayer(u), 400)
            elseif UnitHasInventorySpace(u) and It == null then
                call UnitAddItemById(u, ANKH_ITEM_ID)
            endif
            //Non-Lucrative Tome
        elseif II == NON_LUCRATIVE_TOME_ITEM_ID then
            call NonLucrativeTomeBought(u)
        endif

        if GetItemType(It) == ITEM_TYPE_POWERUP then
            call RemoveItem(It)
        endif

        call ResourseRefresh(GetOwningPlayer(u)) 

        // Cleanup
        set It = null
        set u = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        local trigger tomesTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(tomesTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddAction(tomesTrigger, function TomesActions)
        set tomesTrigger = null

        set GloryRegenLevel = Table.create()
        set GloryAttackCdLevel = Table.create()
        set GloryAttackCdBonus = Table.create()
    endfunction

endlibrary