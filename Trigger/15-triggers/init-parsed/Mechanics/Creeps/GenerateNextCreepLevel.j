library GenerateNextCreepLevel initializer init requires RandomShit, Functions, CustomGameEvent

    globals
        integer RoundCreepChanceReflectAura = 0
        integer RoundCreepChanceWizardbane = 0
        integer RoundCreepChanceDrunkMaster = 0
        integer RoundCreepChanceSlowAura = 0
        integer RoundCreepChancePulverize = 0 
        integer RoundCreepChanceLastBreath = 0
        integer FireshieldChance = 0
        integer RoundCreepChanceCorrosiveSkin = 0 
        integer RoundCreepChanceFastMagic = 0
        integer RoundCreepChanceImmortalAura = 0
        boolean wizardbaneDebug = false
        HashTable PlayerRoundCreeps
    endglobals

    private function GenerateNextCreepLevelConditions takes nothing returns boolean
        return IsTriggerEnabled(GetTriggeringTrigger()) == true
    endfunction

    private function ResetRoundAbilities takes nothing returns nothing
        local integer index = roundAbilities.integer[0]
        loop
            set roundAbilities.integer[index] = 0
            set index = index - 1
            exitwhen index <= 0
        endloop
        set roundAbilities.integer[0] = 0
    endfunction

    private function AddRoundAbility takes integer abilityId returns nothing
        local integer index = roundAbilities.integer[0] + 1
        set roundAbilities[index] = abilityId
        set roundAbilities.integer[0] = index
    endfunction

    private function ConcatAbility takes string currentAbilities, string nextAbility returns string
        if currentAbilities == "" then
            return "|cff77fc94" + nextAbility + "|r"
        endif

        return currentAbilities + ", |cff77fc94" + nextAbility + "|r"
    endfunction

    private function CheckUnitAbilities takes nothing returns nothing
        local string s = ""
    
        if RoundCreepChanceBash == 1 then
            set s = ConcatAbility(s, "Bash")
            call AddRoundAbility('ACbh')
        endif
    
        if RoundCreepChanceHurlBoulder == 1 then
            set s = ConcatAbility(s, "Hurl Boulder")
            call AddRoundAbility(HURL_BOULDER_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceRejuv == 1 then
            set s = ConcatAbility(s, "Rejuvenation")
            call AddRoundAbility(REJUVENATION_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceBigBadV == 1 then
            set s = ConcatAbility(s, "Big Bad Voodoo")
            call AddRoundAbility('A018')
        endif
    
        if RoundCreepChanceBlink == 1 then
            set s = ConcatAbility(s, "Blink")
            call AddRoundAbility('A01A')
        endif
    
        if RoundCreepChanceCritStrike == 1 then
            set s = ConcatAbility(s, "Critical Strike")
            call AddRoundAbility(CRITICAL_STRIKE_ABILITY_ID)
        endif
    
        if RoundCreepChanceEvasion == 1 then
            set s = ConcatAbility(s, "Evasion")
        endif
    
        if RoundCreepChanceFaerieFire == 1 then
            set s = ConcatAbility(s, "Faerie Fire")
            call AddRoundAbility(FAERIE_FIRE_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceLifesteal == 1 then
            set s = ConcatAbility(s, "Lifesteal")
            call AddRoundAbility('SCva')
        endif
    
        if RoundCreepChanceManaBurn == 1 then
            set s = ConcatAbility(s, "Mana Burn")
            call AddRoundAbility(MANA_BURN_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceShockwave == 1 then
            set s = ConcatAbility(s, "Shockwave")
            call AddRoundAbility(SHOCKWAVE_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceSlow == 1 then
            set s = ConcatAbility(s, "Slow")
            call AddRoundAbility('A013')
        endif
    
        if RoundCreepChanceCleave == 1 then
            set s = ConcatAbility(s, "Cleave")
            call AddRoundAbility('ACce')
        endif
    
        if RoundCreepChanceThorns == 1 then
            set s = ConcatAbility(s, "Thorns Aura")
            call AddRoundAbility(THORNS_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChanceThunderClap == 1 then
            set s = ConcatAbility(s, "Thunder Clap")
            call AddRoundAbility(THUNDER_CLAP_CREEP_ABILITY_ID)
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            set s = ConcatAbility(s, "Reflection Aura")
            call AddRoundAbility(REFLECTION_AUR_ABILITY_ID)
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            set s = ConcatAbility(s, "Wizardbane Aura")
            call AddRoundAbility(WIZARDBANE_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChanceDrunkMaster == 1 then
            set s = ConcatAbility(s, "Drunken Master")
            call AddRoundAbility(DRUNKEN_MASTER_ABILITY_ID)
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            set s = ConcatAbility(s, "Slow Aura")
            call AddRoundAbility(SLOW_AURA_ABILITY_ID)
        endif
    
        if RoundCreepChancePulverize == 1 then
            set s = ConcatAbility(s, "Pulverize")
            call AddRoundAbility(PULVERIZE_ABILITY_ID)
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            set s = ConcatAbility(s, "Last Breath")
            call AddRoundAbility(LAST_BREATHS_ABILITY_ID)
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            set s = ConcatAbility(s, "Corrosive Skin")
            call AddRoundAbility(CORROSIVE_SKIN_ABILITY_ID)
        endif

        if RoundCreepChanceFastMagic == 1 then
            set s = ConcatAbility(s, "Fast Magic")
            call AddRoundAbility(FAST_MAGIC_ABILITY_ID)
        endif

        if RoundCreepChanceImmortalAura == 1 then
            set s = ConcatAbility(s, "Aura of Immortality")
            call AddRoundAbility(AURA_OF_IMMORTALITY_ABILITY_ID)
        endif
    
        if s == "" then
            set RoundAbilities = "|cff77fc94No abilities|r"
        else
            set RoundAbilities = s
        endif
    endfunction

    //removes creeps already created, not sure if it actually does anything
    private function RemovePreviousUnit takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction

    private function UnitAddNewAbilities takes unit u returns nothing
        if RoundCreepChanceCritStrike == 1 then
            call SetUnitAbilityLevel(u, CRITICAL_STRIKE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceDrunkMaster == 1 then
            call UnitAddAbility(u, DRUNKEN_MASTER_ABILITY_ID)
            call FuncEditParam(DRUNKEN_MASTER_ABILITY_ID,u)
            call SetUnitAbilityLevel(u, DRUNKEN_MASTER_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            call UnitAddAbility(u, REFLECTION_AUR_ABILITY_ID)
            call SetUnitAbilityLevel(u, REFLECTION_AUR_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            call UnitAddAbility(u, WIZARDBANE_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, WIZARDBANE_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            call UnitAddAbility(u, SLOW_AURA_ABILITY_ID)
            call SetUnitAbilityLevel(u, SLOW_AURA_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.75), 30))
        endif
    
        if RoundCreepChancePulverize == 1 then
            call UnitAddAbility(u, PULVERIZE_ABILITY_ID)
            call SetUnitAbilityLevel(u, PULVERIZE_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            call UnitAddAbility(u, LAST_BREATHS_ABILITY_ID)
            call FuncEditParam(LAST_BREATHS_ABILITY_ID, u)
            call SetUnitAbilityLevel(u, LAST_BREATHS_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            call UnitAddAbility(u, CORROSIVE_SKIN_ABILITY_ID)
            call SetUnitAbilityLevel(u, CORROSIVE_SKIN_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    
        if RoundCreepChanceFastMagic == 1 then
            call UnitAddAbility(u, FAST_MAGIC_ABILITY_ID)
            call SetUnitAbilityLevel(u, FAST_MAGIC_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceImmortalAura == 1 then
            call UnitAddAbility(u, AURA_OF_IMMORTALITY_ABILITY_ID)
            call SetUnitAbilityLevel(u, AURA_OF_IMMORTALITY_ABILITY_ID, IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    endfunction

    private function GenerateNextCreepLevelActions takes nothing returns nothing
        local integer newAbilChance = 50
        local integer oldAbilChance = 20
        local real magicPowerBonus = 0
        local real magicDefBonus = 0
        local real evasionBonus = 0
        local real blockBonus = 0
        local integer damageBonus = 0
        local string s = ""
        local integer temp = 0
        local location unitSpawnOffset
        local unit creep
        local integer playerId = 0
        local group g = null
        local integer creepDamage

        set RoundCreepInfo[0] = ""
        set RoundCreepInfo[1] = ""
        set RoundCreepInfo[2] = ""
        set RoundCreepInfo[3] = ""
        set RoundCreepInfo[4] = ""
        set RoundCreepInfo[5] = ""
        set RoundCreepInfo[6] = ""
        set RoundCreepInfo[7] = ""

        call DisableTrigger(GetTriggeringTrigger())
        call ConditionalTriggerExecute(CreepTypesTrigger)
        call ResetRoundAbilities()

        if RoundNumber < 15 then
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes - 2)]
        else
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1, MaxCreepUnitTypes)]
        endif

        set RoundCreepMoveSpeed = GetRandomInt(GetRandomInt(150, 150 + RoundNumber * 2), 422 + RoundNumber * 2)
        set RoundCreepMaxAttackSpeed = GetRandomInt(1, RoundNumber)
        
        if RoundNumber > 25 then
            set newAbilChance = 20
        endif
        if RoundNumber > 40 then
            set oldAbilChance = 15
        endif
        if RoundNumber > 5 then
            set RoundCreepChanceBash = GetRandomInt(1, 20)
            set RoundCreepChanceHurlBoulder = GetRandomInt(1, 20)
            set RoundCreepChanceRejuv = GetRandomInt(1, 20)
            set RoundCreepChanceSlow = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceSlowAura = GetRandomInt(1, newAbilChance)
            set RoundCreepChanceImmortalAura = GetRandomInt(1, newAbilChance)
        endif

        if ((RoundNumber + 1) > 1) then
            set RoundCreepChanceBigBadV = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceBlink = GetRandomInt(1, oldAbilChance)

            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceCritStrike = GetRandomInt(1, oldAbilChance)
                set RoundCreepChanceShockwave = GetRandomInt(1, oldAbilChance)
                if RoundNumber > 5 then
                    set RoundCreepChanceThunderClap = GetRandomInt(1, oldAbilChance)    
                endif
            else
                set RoundCreepChanceCritStrike = 0
                set RoundCreepChanceShockwave = 0
                set RoundCreepChanceThunderClap = 0
            endif

            set RoundCreepChanceEvasion = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceFaerieFire = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceLifesteal = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceManaBurn = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceCleave = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceThorns = 0
            set RoundCreepChanceReflectAura = 0

            if wizardbaneDebug then
                set RoundCreepChanceWizardbane = 1
            else
                set RoundCreepChanceWizardbane = 0
                if GetRandomInt(1, oldAbilChance) == 1 then
                    set temp = GetRandomInt(1, 4)
                    if temp == 1 then
                        set RoundCreepChanceThorns = 1
                    elseif temp == 2 then
                        set RoundCreepChanceReflectAura = 1
                    elseif temp == 3 then
                        set RoundCreepChanceWizardbane = 1
                    elseif RoundNumber > 20 then
                        if RoundNumber > 40 then
                            set RoundCreepChanceThorns = GetRandomInt(1, 2)
                            set RoundCreepChanceReflectAura = GetRandomInt(1, 2)
                            set RoundCreepChanceWizardbane = GetRandomInt(1, 2)
                        else
                            set RoundCreepChanceThorns = GetRandomInt(1, 3)
                            set RoundCreepChanceReflectAura = GetRandomInt(1, 3)
                            set RoundCreepChanceWizardbane = GetRandomInt(1, 3)
                        endif
                    endif
                endif
            endif
        endif

        if RoundNumber > 10 then
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceDrunkMaster = GetRandomInt(1, oldAbilChance)
                set RoundCreepChancePulverize = GetRandomInt(1, newAbilChance)
            endif
            set FireshieldChance = GetRandomInt(1, newAbilChance)
            set RoundCreepChanceCorrosiveSkin = GetRandomInt(1, newAbilChance)
        endif
        if RoundNumber >= 35 then
            set RoundCreepChanceFastMagic = GetRandomInt(1, newAbilChance + 6)
        endif
    
        if RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48 then
            set RoundCreepChanceLastBreath = 1
        else  
            set RoundCreepChanceLastBreath = 2
        endif
    
        if RoundNumber < 5 then
            set RoundCreepNumber = RoundNumber + 1
        else
            if RoundCreepChanceLastBreath == 1 then
                set RoundCreepNumber = GetRandomInt(2,5)
            else
                set RoundCreepNumber = GetRandomInt(2,25)
            endif
        endif
    
        if RoundNumber > 0 then
            call CheckUnitAbilities()
        endif

        set RoundNumber = (RoundNumber + 1)

        loop
            exitwhen playerId == 8

            set g = NewGroup()
            set RoundGenCreepIndex = 1

            loop
                exitwhen RoundGenCreepIndex > RoundCreepNumber
                
                if RoundGenCreepIndex > 4 then
                    set RoundCreepChanceBigBadV = 2
                endif

                if RoundNumber > 0 then
                    set ShowCreepAbilButton[playerId] = true
                endif
                
                //Creep upgrade bonuses
                if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                    set magicPowerBonus = 1 * (BonusNeutral + BonusNeutralPlayer[playerId])
                    set damageBonus = ((BonusNeutral + BonusNeutralPlayer[playerId]) * RoundNumber)
                else
                    set magicPowerBonus = 0
                endif

                set magicDefBonus = 0.09 * (BonusNeutral + BonusNeutralPlayer[playerId])
                set evasionBonus = 0.06 * (BonusNeutral + BonusNeutralPlayer[playerId])
                set blockBonus = 0.12 * (BonusNeutral + BonusNeutralPlayer[playerId])

                if RoundNumber < 40 then
                    set damageBonus = damageBonus / 2
                endif
    
                if (GetPlayerSlotState(Player(playerId)) != PLAYER_SLOT_STATE_EMPTY and IsPlayerInForce(Player(playerId), DefeatedPlayers) != true) then
                    set unitSpawnOffset = OffsetLocation(PlayerArenaRectCenters[playerId], GetRandomReal(-600.00, 600.00), GetRandomReal(-600.00, 600.00))
                    set creep = CreateUnitAtLocSaveLast(Player(11), RoundCreepTypeId, unitSpawnOffset, GetRandomDirectionDeg())

                    call GroupAddUnit(g, creep)
                    call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + damageBonus, 0)
    
                    call SetUnitCustomState(creep, BONUS_MAGICPOW, magicPowerBonus)
                    call SetUnitCustomState(creep, BONUS_EVASION, evasionBonus)	
                    call SetUnitCustomState(creep, BONUS_BLOCK, blockBonus + (1 * (RoundNumber)))

                    if wizardbaneDebug then
                        call SetUnitCustomState(creep, BONUS_MAGICPOW, 5000)
                    endif
    
                    if RoundNumber < 3 then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) - 3, 0)
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.8 * (RoundNumber)))
                    elseif RoundNumber < 8  then
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 1 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 4 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1 * (RoundNumber)))
                    elseif RoundNumber < 11  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 2 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 12 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep)) 	
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (0.9 * (RoundNumber)))	
                    elseif RoundNumber < 19  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 1.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 6 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 60 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))  
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.0 * (RoundNumber)))              	
                    elseif RoundNumber < 24  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber *4.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 14 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 80 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))		    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.3 * (RoundNumber)))
                    elseif RoundNumber < 35  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 7.5) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 55 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 120 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))				    
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (1.5 * (RoundNumber)))
                    elseif RoundNumber < 41  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 12) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 200 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 225 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))			
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2 * (RoundNumber)))	    
                    elseif RoundNumber < 45  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 15) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 400 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 450 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (2.25 * (RoundNumber)))
                    elseif RoundNumber < 49  then
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 24) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 500 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 1350 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	   
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (3 * (RoundNumber)))                              
                    else
                        call BlzSetUnitArmor(creep, BlzGetUnitArmor(creep) + RoundNumber * 30) 
                        call BlzSetUnitBaseDamage(creep, BlzGetUnitBaseDamage(creep, 0) + 900 * RoundNumber, 0)
                        call BlzSetUnitMaxHP(creep, BlzGetUnitMaxHP(creep) + 5000 * RoundNumber)
                        call SetWidgetLife(creep, BlzGetUnitMaxHP(creep))	   
                        call SetUnitCustomState(creep, BONUS_MAGICRES, magicDefBonus + (5 * (RoundNumber)))          			    
                    endif
    
                    call SetUnitScalePercent(creep, (85.00 + ((I2R(RoundNumber) - 1.00) * 0.50)), 100, 100)
                    call UnitAddNewAbilities(creep)
                    call ConditionalTriggerExecute(ModifyCreepAbilitiesTrigger)
                    call ConditionalTriggerExecute(CreepPowerAndHpTrigger)
                    call SetUnitMoveSpeed(creep, I2R(RoundCreepMoveSpeed))
                    call SetUnitAbilityLevelSwapped('A000', creep, (R2I(RoundCreepPower) / 2))
                    call SetUnitAbilityLevelSwapped('A002', creep,RoundCreepMaxAttackSpeed)
                    call PauseUnitBJ(true, creep)
                    call SetUnitInvulnerable(creep, true)
                    call ShowUnitHide(creep)
    
                    if SantaHatOn then
                        call UnitAddAbility(creep, 'A0B1')
                    endif
                    
                    if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                        call BlzSetUnitBaseDamage(creep, R2I(BlzGetUnitBaseDamage(creep, 0) * 0.5), 0)
                    endif
    
                    //call BJDebugMsg("rci: " + I2S(playerId))
                    if RoundCreepInfo[playerId] == "" then
                        //call BJDebugMsg("a")
                        set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        set s = RoundCreepTitle + ": "
                        set RoundCreepInfo[playerId] = "|cfff19b9bHit points|r: " + I2S(BlzGetUnitMaxHP(creep)) + "|n"
                        //call BJDebugMsg("b")
                        if IsUnitType(creep, UNIT_TYPE_MELEE_ATTACKER) then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cffebde71Range|r: Melee |n"
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff82f373Range|r: " + I2S(R2I(BlzGetUnitWeaponRealField(creep, UNIT_WEAPON_RF_ATTACK_RANGE, 0))) + "|n"
                            set s = s + "|cff82f373Ranged|r: "
                        endif
                        //call BJDebugMsg("c")
                        if RoundCreepTypeId == 'n01H' or RoundCreepTypeId == 'n00W' then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bddf1Damage Type|r: Magic |n"
                            set s = s + "|cffff00ffMagic Damage|r: "
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff167daDamage Type|r: Physical |n"
                        endif
                        //call BJDebugMsg("d")
                        set creepDamage = BlzGetUnitBaseDamage(creep, 0) + BlzGetUnitDiceNumber(creep, 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(creep, 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower) / 2) - 1) + damageBonus

                        if BonusNeutral == 0 and BonusNeutralPlayer[playerId] == 0 then
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff19bb8Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION))) + "|n"
                        else
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff19bb8Damage|r: " + I2S(creepDamage) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(creep))) + "|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_BLOCK) - blockBonus)) + " + |cff78729e" + I2S(R2I(blockBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICPOW) - magicPowerBonus)) + " + |cff9bc7f1" + I2S(R2I(magicPowerBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_MAGICRES) - magicDefBonus)) + " + |cff9bf1a9" + I2S(R2I(magicDefBonus)) + "|r|n"
                            set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(creep, BONUS_EVASION) - evasionBonus)) + " + |cfff1cc9b" + I2S(R2I(evasionBonus)) + "|r |n"
                        endif

                        set RoundCreepInfo[playerId] = RoundCreepInfo[playerId] + "|cff9bf1a9Movespeed|r: " + I2S(RoundCreepMoveSpeed)
                        //call BJDebugMsg("e")
                        set s = s + RoundAbilities

                        if (RoundNumber > 1) then
                            call DisplayTimedTextToPlayer(Player(playerId), 0, 0, 20, "Next: " + s)
                        endif
                        //call BJDebugMsg("f")
                    endif
                    //call BJDebugMsg("rci finish: " + I2S(playerId))

                    // Cleanup
                    call RemoveLocation(unitSpawnOffset)
                    set unitSpawnOffset = null
                    set creep = null
                endif

                set PlayerRoundCreeps[RoundNumber].group[playerId] = g

                set RoundGenCreepIndex = RoundGenCreepIndex + 1
            endloop
            
            set playerId = playerId + 1
        endloop

        set g = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerRoundCreeps = HashTable.create()
        set GenerateNextCreepLevelTrigger = CreateTrigger()
        call TriggerAddCondition(GenerateNextCreepLevelTrigger, Condition(function GenerateNextCreepLevelConditions))
        call TriggerAddAction(GenerateNextCreepLevelTrigger, function GenerateNextCreepLevelActions)
    endfunction

endlibrary
