library Tomes initializer init requires RandomShit, CustomState, NonLucrativeTome
    function PlayerAddGold takes player p, integer i returns nothing

        call SetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD,  GetPlayerState(p,PLAYER_STATE_RESOURCE_GOLD) + i )

    endfunction

    function GetItemCost takes item it, boolean gold returns integer
        local integer goldCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_RED )
        local integer lumberCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_GREEN )
        local integer multiplier = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_BLUE )
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

    function PlayerReturnLumber takes item it, integer II, player p returns nothing 
        call AdjustPlayerStateBJ(GetItemCost(it, false),p,PLAYER_STATE_RESOURCE_LUMBER)
        call ResourseRefresh(p)
    endfunction

    function IncomeText takes integer pid, boolean all returns nothing
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
                    call DisplayTimedTextToPlayer(Player(i), 0, 0, 1, GetPlayerNameColour(Player(pid))+ " |cffdfb632upgrades the creeps for themselves to|r |cffd64646level " + I2S(BonusNeutralPlayer[pid] ))
                endif
            endif
            set i = i + 1
            exitwhen i > 8
        endloop
    endfunction

    private function CanAfford takes player p, item it returns boolean
        local integer goldCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_RED )
        local integer lumberCost = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_GREEN )
        local integer multiplier = BlzGetItemIntegerField(it, ITEM_IF_TINTING_COLOR_BLUE )
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
        if GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) >= goldCost and GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) >= lumberCost then
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(p, PLAYER_STATE_RESOURCE_GOLD) - goldCost)
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER) - lumberCost)
            return true
        else
            return false
        endif
    endfunction

    function Trig_Toms_Actions takes nothing returns nothing
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
        local real gloryBonus = 0
        local boolean maxLevel = GetHeroLevel(u) == 600

        if HoldCtrl[pid] then
            set ctrl = true
        endif

        loop
            //Agility level bonus
            if II == AGILITY_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddAgilityLevelBonus(u, 1)

                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif
                //Intelligence level bonus
            elseif II == INTELLIGENCE_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddIntelligenceLevelBonus(u, 1)
                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif
                //Strength level bonus
            elseif II  == STRENGTH_LEVEL_BONUS_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 20000  then
                    call AddStrengthLevelBonus(u, 1)
                    call UnitAddItemById(u,EXPERIENCE_20000_TOME_ITEM_ID)

                    call RemoveItem(It)
                else
                    set ctrl = false
                endif

                //Glory armor
            elseif II  == GLORY_ARMOR_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call BlzSetUnitArmor(u,BlzGetUnitArmor(u)+ 20)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 20
                else
                    set ctrl = false
                endif

                //Glory damage
            elseif II  == GLORY_ATTACK_DAMAGE_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call BlzSetUnitBaseDamage(u,BlzGetUnitBaseDamage(u,0)+ 100,0)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif    

                //Glory hp regen
            elseif II  == GLORY_HIT_POINT_REGENERATION_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call BlzSetUnitRealField(u,ConvertUnitRealField('uhpr'),BlzGetUnitRealField(u,ConvertUnitRealField('uhpr')) + 75)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 75
                else
                    set ctrl = false
                endif      

                //glory magic resistance
            elseif II  == GLORY_MAGIC_PROTECTION_TOME_ITEM_ID then
                if Glory[pid] >= 2000 then

                    call AddUnitMagicDef(u,3)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 2000
                    set gloryBonus = gloryBonus + 3
                else
                    set ctrl = false
                endif    

                //glory magic damage
            elseif II  == GLORY_MAGIC_POWER_TOME_ITEM_ID then
                if Glory[pid] >= 2000 then
                    call AddUnitMagicDmg (u,3)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 2000
                    set gloryBonus = gloryBonus + 3
                else
                    set ctrl = false
                endif    

                //glory mana regen
            elseif II  == GLORY_MANA_REGENERATION_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call BlzSetUnitRealField(u,ConvertUnitRealField('umpr'),BlzGetUnitRealField(u,ConvertUnitRealField('umpr')) + 100)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif   

                //glory pvp bonus
            elseif II  == GLORY_PVP_BONUS_TOME_ITEM_ID then
                if Glory[pid] >= 2000 then
                    // set PvpBonus[pid] = PvpBonus[pid]+1.5
                    call AddUnitPvpBonus(u,1.5)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 2000
                    set gloryBonus = gloryBonus + 1.5
                else
                    set ctrl = false
                endif  

                //glory hit points
            elseif II  == GLORY_HIT_POINTS_TOME_ITEM_ID then
                if Glory[pid] >= 100 then
                    call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 150)
                    call CalculateNewCurrentHP(u, 150)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 100
                    set gloryBonus = gloryBonus + 150
                else
                    set ctrl = false
                endif      

                //glory mana
            elseif II  == GLORY_MANA_TOME_ITEM_ID then
                if Glory[pid] >= 100 then
                    call BlzSetUnitMaxMana(u, BlzGetUnitMaxMana(u) + 100)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid] - 100
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif  

                //glory strength
            elseif II  == GLORY_STRENGTH_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call SetHeroStr(u, GetHeroStr(u, false) + 30, true)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 30
                else
                    set ctrl = false
                endif  

                //glory agility
            elseif II  == GLORY_AGILITY_TOME_ITEM_ID then
                if Glory[pid] >= 1200 then
                    call SetHeroAgi(u, GetHeroAgi(u, false) + 30, true)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1200
                    set gloryBonus = gloryBonus + 30
                else
                    set ctrl = false
                endif  

                //glory intelligence
            elseif II  == GLORY_INTELLIGENCE_TOME_ITEM_ID then
                if Glory[pid] >= 1000 then
                    call SetHeroInt(u, GetHeroInt(u, false) + 30, true)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1000
                    set gloryBonus = gloryBonus + 30
                else
                    set ctrl = false
                endif  

                //glory evasion
            elseif II  == GLORY_EVASION_TOME_ITEM_ID then
                if Glory[pid] >= 1500 then
                    call AddUnitEvasion(u, 5)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 1500
                    set gloryBonus = gloryBonus + 5
                else
                    set ctrl = false
                endif  

                //glory block
            elseif II  == GLORY_BLOCK_TOME_ITEM_ID then
                if Glory[pid] >= 2000 then
                    call AddUnitBlock(u, 100)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 2000
                    set gloryBonus = gloryBonus + 100
                else
                    set ctrl = false
                endif 

                //glory movespeed
            elseif II  == GLORY_MOVESPEED_TOME_ITEM_ID then
                if Glory[pid] >= 10000 and GetUnitMoveSpeed(u) < 522 then
                    call SetUnitMoveSpeed(u, 522)
                    call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Undead\\DarkRitual\\DarkRitualTarget.mdl",u,"head"))
                    set Glory[pid]= Glory[pid]- 10000
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

                //Life
            elseif II == LIFE_TOME_ITEM_ID and (not maxLevel) then
                if GetHeroXP(u) >= 100000  then
                    set Lives[pid] = Lives[pid] + 1
                    call DisplayTimedTextToPlayer(p, 0, 0, 5, "|cffffcc00Lives: |r" + I2S(Lives[pid]))
                    call UnitAddItemById(u,EXPERIENCE_100000_TOME_ITEM_ID)
                    call RemoveItem(It)
                else
                    set ctrl = false
                endif

                //Absolute Acorn
            elseif II == ABSOLUTE_ACORN_TOME_ITEM_ID then
                if GetHeroXP(u) >= 100000 and AddHeroMaxAbsoluteAbility(u)then
                    call UnitAddItemById(u,EXPERIENCE_50000_TOME_ITEM_ID)
                else
                    call PlayerAddGold( GetOwningPlayer(u),8000)  
                    set ctrl = false
                endif

                //Summon Attack
            elseif II == SUMMON_ATTACK_BONUS_ITEM_ID then
                set SummonDamage[pid] = SummonDamage[pid] + 1
                set summonUpgradeBonus = summonDamage[pid]
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
            elseif II == SUMMON_ICE_ARMOR_ITEM_ID then
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

                //Manual of health
            elseif II == 'manh' then 
                call BlzSetUnitMaxHP(u, BlzGetUnitMaxHP(u) + 50)
                //Tome of Power
            elseif II == TOME_OF_POWER_2000_ITEM_ID then 
                call AddHeroXP(u, 2000, false)
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
            call DisplayTimedTextToPlayer(p, 0, 0, 2, GetObjectName(II) + " +|cffffcc00" + R2SW(gloryBonus, 1, 1) + "|r")
        elseif i > 1 then
            call DisplayTimedTextToPlayer(p, 0, 0, 2, "Bought |cff55df32" + I2S(i) + "|r |cffdf9432" + GetObjectName(II) + "|r")
        endif

        if II == 'manh' then
            call CalculateNewCurrentHP(u, i * 50)
        endif

        //Ancient Staff
        if II  == ANCIENT_STAFF_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(ANCIENT_STAFF_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif

            //Ancient Dagger
        elseif II  == ANCIENT_DAGGER_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(ANCIENT_DAGGER_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif

            //Ancient Axe
        elseif II  == ANCIENT_AXE_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(ANCIENT_AXE_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif	

            //Vigour Token
        elseif II  == VIGOUR_TOKEN_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(VIGOUR_TOKEN_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif

            //Flimsy Token
        elseif II  == FLIMSY_TOKEN_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(FLIMSY_TOKEN_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif

            //Spellbane Token
        elseif II  == SPELLBANE_TOKEN_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(SPELL_BANE_TOKEN_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif	

            //Mask of Elusion
        elseif II  == MASK_OF_ELUSION_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(MASK_OF_ELUSION_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),20000)
            endif

            //Mask of Vitality
        elseif II  == MASK_OF_VITALITY_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(MASK_OF_VITALITY_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),20000)
            endif
            //Mask of Protection
        elseif II  == MASK_OF_PROTECTION_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(MASK_OF_PROTECTION_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),20000)
            endif	
            //Sword of Blodthirst
        elseif II  == SWORD_OF_BLOODTHRIST_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(SWORD_OF_BLOODTHRIST_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),10000)
            endif
            //Wisdom Chestplate
        elseif II  == WISDOM_CHESTPLATE_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(WISDOM_CHESTPLATE_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),15000)
            endif
            //Lucky Pants
        elseif II  == LUCKY_PANTS_TOME_ITEM_ID then   
            if Glory[pid] >= 10000 and UnitHasFullItems(u) == false then
                call UnitAddItem(u,CreateItem(LUCKY_PANTS_ITEM_ID,0,0))
                set Glory[pid]= Glory[pid]- 10000 
            else
                call PlayerAddGold( GetOwningPlayer(u),20000)
                    
            endif	
            //Non-Lucrative Tome
        elseif II == NON_LUCRATIVE_TOME_ITEM_ID then
            call NonLucrativeTomeBought(u)
        endif

        call ResourseRefresh(GetOwningPlayer(u)) 
        set It = null
        set u = null
        set p = null
    endfunction


    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_PICKUP_ITEM )
        call TriggerAddAction( trg, function Trig_Toms_Actions )
        set trg = null
    endfunction
endlibrary