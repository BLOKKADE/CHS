library trigger103 initializer init requires RandomShit, Functions

    globals
        integer RoundCreepChanceReflectAura = 0
        integer RoundCreepChanceWizardbane = 0
        integer RoundCreepChanceDrunkMaster = 0
        integer RoundCreepChanceSlowAura = 0
        integer RoundCreepChancePulverize = 0 
        integer RoundCreepChanceLastBreath = 0
        integer FireshieldChance = 0
        integer RoundCreepChanceCorrosiveSkin = 0 
        integer RoundCreepChanceMulticast = 0
        integer RoundCreepChanceFastMagic = 0
        integer RoundCreepChanceImmortalAura = 0
        boolean wizardbaneDebug = false
    endglobals

    function Trig_Generate_Next_Level_Conditions takes nothing returns boolean
        if(not(IsTriggerEnabled(GetTriggeringTrigger())==true))then
            return false
        endif
        return true
    endfunction


    function ResetRoundAbilities takes nothing returns nothing
        local integer index = roundAbilities.integer[0]
        loop
            set roundAbilities.integer[index] = 0
            set index = index - 1
            exitwhen index <= 0
        endloop
        set roundAbilities.integer[0] = 0
    endfunction


    function Trig_Generate_Next_Level_Func012C takes nothing returns boolean
        if(not((RoundNumber + 1)> 1))then
            return false
        endif
        return true
    endfunction


    function Trig_Generate_Next_Level_Func014C takes nothing returns boolean
        if(not((RoundNumber + 1)<= 8))then
            return false
        endif
        return true
    endfunction


    function AddRoundAbility takes integer abilityId returns nothing
        local integer index = roundAbilities.integer[0] + 1
        set roundAbilities[index] = abilityId
        set roundAbilities.integer[0] = index
    endfunction


    function CheckUnitAbilities takes nothing returns nothing
        local string s = ""
    
        if RoundCreepChanceBash == 1 then
            set s = s + "Bash "
            call AddRoundAbility('ACbh')
        endif
    
        if RoundCreepChanceHurlBoulder == 1 then
            set s = s + "Hurl Boulder "
            call AddRoundAbility('A00W')
        endif
    
        if RoundCreepChanceRejuv == 1 then
            set s = s + "Rejuvenation "
            call AddRoundAbility('A00X')
        endif
    
        if RoundCreepChanceBigBadV == 1 then
            set s = s + "Big Bad Voodoo "
            call AddRoundAbility('A018')
        endif
    
        if RoundCreepChanceBlink == 1 then
            set s = s + "Blink "
            call AddRoundAbility('A01A')
        endif
    
        if RoundCreepChanceCritStrike == 1 then
            set s = s + "Critical Strike "
            call AddRoundAbility('AOcr')
        endif
    
        if RoundCreepChanceEvasion == 1 then
            set s = s + "Evasion "
        endif
    
        if RoundCreepChanceFaerieFire == 1 then
            set s = s + "Faerie Fire "
            call AddRoundAbility('A016')
        endif
    
        if RoundCreepChanceLifesteal == 1 then
            set s = s + "Lifesteal "
            call AddRoundAbility('SCva')
        endif
    
        if RoundCreepChanceManaBurn == 1 then
            set s = s + "Mana Burn "
            call AddRoundAbility('A00V')
        endif
    
        if RoundCreepChanceShockwave == 1 then
            set s = s + "Shockwave "
            call AddRoundAbility('A00U')
        endif
    
        if RoundCreepChanceSlow == 1 then
            set s = s + "Slow "
            call AddRoundAbility('A013')
        endif
    
        if RoundCreepChanceCleave == 1 then
            set s = s + "Cleave "
            call AddRoundAbility('ACce')
        endif
    
        if RoundCreepChanceThorns == 1 then
            set s = s + "Thorns Aura "
            call AddRoundAbility('A08F')
        endif
    
        if RoundCreepChanceThunderClap == 1 then
            set s = s + "Thunder Clap "
            call AddRoundAbility('A01B')
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            set s = s + "Reflection Aura "
            call AddRoundAbility('A093')
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            set s = s + "Wizardbane Aura  "
            call AddRoundAbility('A088')
        endif
    
        if RoundCreepChanceDrunkMaster == 1 then
            set s = s + "Drunken Master "
            call AddRoundAbility('Acdb')
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            set s = s + "Slow Aura "
            call AddRoundAbility('AOr2')
        endif
    
        if RoundCreepChancePulverize == 1 then
            set s = s + "Pulverize "
            call AddRoundAbility('Awar')
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            set s = s + "Last Breath "
            call AddRoundAbility('A05R')
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            set s = s + "Corrosive Skin "
            call AddRoundAbility('A00Q')
        endif
    
        if RoundCreepChanceMulticast == 1 then
            set s = s + "Multicast "
            call AddRoundAbility('A04F')
        endif
    
        if RoundCreepChanceFastMagic == 1 then
            set s = s + "Fast Magic "
            call AddRoundAbility('A03P')
        endif

        if RoundCreepChanceImmortalAura == 1 then
            set s = s + "Aura of Immortality"
            call AddRoundAbility('A02L')
        endif
    
        if s == "" then
            set RoundAbilities = "|cff77fc94No abilities|r "
        else
            set RoundAbilities = "|cff77fc94" + s + "|r"
        endif
    endfunction

    //removes creeps already created, not sure if it actually does anything
    function Trig_Generate_Next_Level_Func018A takes nothing returns nothing
        call DeleteUnit(GetEnumUnit())
    endfunction


    function Trig_Generate_Next_Level_Func021Func001Func001C takes nothing returns boolean
        if(not(GetPlayerSlotState(ConvertedPlayer(udg_integer40))!=PLAYER_SLOT_STATE_EMPTY))then
            return false
        endif
        if(not(IsPlayerInForce(ConvertedPlayer(udg_integer40),DefeatedPlayers)!=true))then
            return false
        endif
        return true
    endfunction


    function UnitAddNewAbilities takes unit u returns nothing
        if RoundCreepChanceCritStrike == 1 then
            call SetUnitAbilityLevel(u, 'AOcr', IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceDrunkMaster == 1 then
            call UnitAddAbility(u, 'Acdb')
            call FuncEditParam('Acdb',u)
            call SetUnitAbilityLevel(u, 'Acdb', IMinBJ(R2I(RoundNumber * 0.3), 30))
        endif
    
        if RoundCreepChanceReflectAura == 1 then
            call UnitAddAbility(u, 'A093')
            call SetUnitAbilityLevel(u, 'A093', IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceWizardbane == 1 then
            call UnitAddAbility(u, 'A088')
            call SetUnitAbilityLevel(u, 'A088', IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceSlowAura == 1 then
            call UnitAddAbility(u, 'AOr2')
            call SetUnitAbilityLevel(u, 'AOr2', IMinBJ(R2I(RoundNumber * 0.75), 30))
        endif
    
        if RoundCreepChancePulverize == 1 then
            call UnitAddAbility(u, 'Awar')
            call SetUnitAbilityLevel(u, 'Awar', IMinBJ(R2I(RoundNumber * 0.4), 30))
        endif
    
        if RoundCreepChanceLastBreath == 1 then
            call UnitAddAbility(u, 'A05R')
            call FuncEditParam('A05R', u)
            call SetUnitAbilityLevel(u, 'A05R', IMinBJ(R2I(RoundNumber * 0.2), 30))
        endif
    
        if RoundCreepChanceCorrosiveSkin == 1 then
            call UnitAddAbility(u, 'A00Q')
            call SetUnitAbilityLevel(u, 'A00Q', IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    
        if RoundCreepChanceMulticast == 1 then
            call UnitAddAbility(u, 'A04F')
            call SetUnitAbilityLevel(u, 'A04F', IMinBJ(R2I(RoundNumber * 0.5), 30))
        endif
    
        if RoundCreepChanceFastMagic == 1 then
            call UnitAddAbility(u, 'A03P')
            call SetUnitAbilityLevel(u, 'A03P', IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif

        if RoundCreepChanceImmortalAura == 1 then
            call UnitAddAbility(u, 'A02L')
            call SetUnitAbilityLevel(u, 'A02L', IMinBJ(R2I(RoundNumber * 0.6), 30))
        endif
    endfunction


    function Trig_Generate_Next_Level_Actions takes nothing returns nothing
        local integer newAbilChance = 50
        local integer oldAbilChance = 20
        local real magicPowerBonus = 0
        local real magicDefBonus = 0
        local real evasionBonus = 0
        local real blockBonus = 0
        local integer damageBonus = 0
        local string s = ""
        local integer temp = 0
        set RoundCreepInfo[0] = ""
        set RoundCreepInfo[1] = ""
        set RoundCreepInfo[2] = ""
        set RoundCreepInfo[3] = ""
        set RoundCreepInfo[4] = ""
        set RoundCreepInfo[5] = ""
        set RoundCreepInfo[6] = ""
        set RoundCreepInfo[7] = ""
        call DisableTrigger(GetTriggeringTrigger())
        call ConditionalTriggerExecute(udg_trigger104)
        call ResetRoundAbilities()
        if RoundNumber < 15 then
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1,MaxCreepUnitTypes - 2)]
        else
            set RoundCreepTypeId = CreepUnitTypeIds[GetRandomInt(1,MaxCreepUnitTypes)]
        endif
        set RoundCreepMoveSpeed = GetRandomInt(GetRandomInt(150, 150 + RoundNumber * 2),400)
        set RoundCreepMaxAttackSpeed = GetRandomInt(1,RoundNumber)
        
        if RoundNumber > 25 then
            set newAbilChance = 20
        endif
        if RoundNumber > 40 then
            set oldAbilChance = 15
        endif
        if RoundNumber > 5 then
            set RoundCreepChanceBash = GetRandomInt(1,20)
            set RoundCreepChanceHurlBoulder = GetRandomInt(1,20)
            set RoundCreepChanceRejuv = GetRandomInt(1,20)
            set RoundCreepChanceSlow = GetRandomInt(1, oldAbilChance)
            set RoundCreepChanceSlowAura = GetRandomInt(1, newAbilChance)
            set RoundCreepChanceImmortalAura = GetRandomInt(1, newAbilChance)
        endif
        if(Trig_Generate_Next_Level_Func012C())then
            set RoundCreepChanceBigBadV = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceBlink = GetRandomInt(1,oldAbilChance)
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceCritStrike = GetRandomInt(1,oldAbilChance)
                set RoundCreepChanceShockwave = GetRandomInt(1,oldAbilChance)
                if RoundNumber > 5 then
                    set RoundCreepChanceThunderClap = GetRandomInt(1,oldAbilChance)    
                endif
            else
                set RoundCreepChanceCritStrike = 0
                set RoundCreepChanceShockwave = 0
                set RoundCreepChanceThunderClap = 0
            endif
            set RoundCreepChanceEvasion = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceFaerieFire = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceLifesteal = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceManaBurn = GetRandomInt(1,oldAbilChance)
            
            
            set RoundCreepChanceCleave = GetRandomInt(1,oldAbilChance)
            set RoundCreepChanceThorns = 0
            set RoundCreepChanceReflectAura = 0
            if wizardbaneDebug then
                set RoundCreepChanceWizardbane = 1
            else
            set RoundCreepChanceWizardbane = 0
                if GetRandomInt(1, oldAbilChance) == 1 then
                    set temp = GetRandomInt(1,4)
                    if temp == 1 then
                        set RoundCreepChanceThorns = 1
                    elseif temp == 2 then
                        set RoundCreepChanceReflectAura = 1
                    elseif temp == 3 then
                        set RoundCreepChanceWizardbane = 1
                    elseif RoundNumber > 20 then
                        if RoundNumber > 40 then
                            set RoundCreepChanceThorns = GetRandomInt(1,2)
                            set RoundCreepChanceReflectAura = GetRandomInt(1,2)
                            set RoundCreepChanceWizardbane = GetRandomInt(1,2)
                        else
                            set RoundCreepChanceThorns = GetRandomInt(1,3)
                            set RoundCreepChanceReflectAura = GetRandomInt(1,3)
                            set RoundCreepChanceWizardbane = GetRandomInt(1,3)
                        endif
                    endif
                endif
            endif
            
        endif
        if RoundNumber > 10 then
            if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                set RoundCreepChanceDrunkMaster = GetRandomInt(1,oldAbilChance)
                set RoundCreepChancePulverize = GetRandomInt(1,newAbilChance)
            endif
            set FireshieldChance = GetRandomInt(1,newAbilChance)
            set RoundCreepChanceCorrosiveSkin = GetRandomInt(1,newAbilChance)
        endif
        if RoundNumber >= 35 then
            set RoundCreepChanceMulticast = GetRandomInt(1,newAbilChance + 10)
            set RoundCreepChanceFastMagic = GetRandomInt(1,newAbilChance + 6)
        endif
    
        if RoundNumber == 28 or RoundNumber == 38 or RoundNumber == 48 then
            set RoundCreepChanceLastBreath = 1
        else  
            set RoundCreepChanceLastBreath = 2
        endif
    
        if(Trig_Generate_Next_Level_Func014C())then
            set RoundCreepNumber = GetRandomInt(2,(RoundNumber / 2 + 4))
        else
            set RoundCreepNumber = GetRandomInt(2,25)
        endif
    
        if RoundNumber > 0 then
            call CheckUnitAbilities()
        endif

        set RoundNumber =(RoundNumber + 1)
        call ForGroupBJ(udg_group05,function Trig_Generate_Next_Level_Func018A)
        call GroupClear(udg_group05)
        set RoundGenCreepIndex = 1
        loop
            exitwhen RoundGenCreepIndex > RoundCreepNumber
            set udg_integer40 = 1
            if RoundGenCreepIndex > 4 then
                set RoundCreepChanceBigBadV = 2
            endif
            loop
                exitwhen udg_integer40 > 8
                if RoundNumber > 1 then
                    set ShowCreepAbilButton[udg_integer40 - 1] = true
                endif
                
                //Creep upgrade bonuses
                if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                    set magicPowerBonus = 1 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1])
                    set damageBonus = ((BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )* RoundNumber)
                else
                    set magicPowerBonus = 0
                endif
                set magicDefBonus = 0.09 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
                set evasionBonus = 0.06 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
                set blockBonus = 0.12 *(BonusNeutral + BonusNeutralPlayer[udg_integer40 - 1] )
                if RoundNumber < 40 then
                    set damageBonus = damageBonus / 2
                endif
    
                if(Trig_Generate_Next_Level_Func021Func001Func001C())then
                    call CreateNUnitsAtLoc(1,RoundCreepTypeId,Player(11),OffsetLocation(GetRectCenter(PlayerArenaRects[udg_integer40]),GetRandomReal(- 600.00,600.00),GetRandomReal(- 600.00,600.00)),GetRandomDirectionDeg())
                    call GroupAddUnitSimple(GetLastCreatedUnit(),udg_group05)
                    //call UnitAddAbility(GetLastCreatedUnit(),'A057')
                    //call BlzUnitDisableAbility(GetLastCreatedUnit(),'A057',false,true)
    
                    call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0) + damageBonus,0)
    
                    call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICPOW, magicPowerBonus)
                    call SetUnitCustomState(GetLastCreatedUnit(), BONUS_EVASION, evasionBonus)	
                    call SetUnitCustomState(GetLastCreatedUnit(), BONUS_BLOCK, blockBonus + (1 *(RoundNumber)))

                    if wizardbaneDebug then
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICPOW, 5000)
                    endif
    
                    if RoundNumber < 3 then
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)- 3,0)
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (0.4 *(RoundNumber)))
                    elseif RoundNumber < 8  then
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 1 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 3 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (0.5 *(RoundNumber)))
                    elseif RoundNumber < 11  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber / 3) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 2 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 8 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) ) 	
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (0.6 *(RoundNumber)))	
                    elseif RoundNumber < 19  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 1) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 6 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 40 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )  
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (0.7 *(RoundNumber)))              	
                    elseif RoundNumber < 24  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 3) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 14 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 45 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )		    
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (0.8 *(RoundNumber)))
                    elseif RoundNumber < 35  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 5) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 55 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 75 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )				    
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (1. *(RoundNumber)))
                    elseif RoundNumber < 41  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 8) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 200 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 150 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )			
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (1.25 *(RoundNumber)))	    
                    elseif RoundNumber < 45  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 10) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 400 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 325 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (1.5 *(RoundNumber)))
                    elseif RoundNumber < 49  then
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 12) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 500 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 900 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	   
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (2 *(RoundNumber)))                              
                    else
                        call BlzSetUnitArmor(GetLastCreatedUnit() , BlzGetUnitArmor(GetLastCreatedUnit()) + RoundNumber * 15) 
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),BlzGetUnitBaseDamage(GetLastCreatedUnit(),0)+ 900 * RoundNumber,0)
                        call BlzSetUnitMaxHP(GetLastCreatedUnit(), BlzGetUnitMaxHP(GetLastCreatedUnit())+ 2500 * RoundNumber)
                        call SetWidgetLife(GetLastCreatedUnit(),BlzGetUnitMaxHP(GetLastCreatedUnit()) )	   
                        call SetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES, magicDefBonus + (2.5 *(RoundNumber)))          			    
                    endif
    
    
    
    
                    call SetUnitScalePercent(GetLastCreatedUnit(),(85.00 +((I2R(RoundNumber)- 1.00)* 0.50)),100,100)
                    call UnitAddNewAbilities(GetLastCreatedUnit())
                    call ConditionalTriggerExecute(udg_trigger99)
                    call ConditionalTriggerExecute(udg_trigger100)
                    call SetUnitMoveSpeed(GetLastCreatedUnit(),I2R(RoundCreepMoveSpeed))
                    call SetUnitAbilityLevelSwapped('A000',GetLastCreatedUnit(),(R2I(RoundCreepPower)/ 2))
                    call SetUnitAbilityLevelSwapped('A002',GetLastCreatedUnit(),RoundCreepMaxAttackSpeed)
                    call PauseUnitBJ(true,GetLastCreatedUnit())
                    call SetUnitInvulnerable(GetLastCreatedUnit(),true)
                    call ShowUnitHide(GetLastCreatedUnit())
    
                    if SantaHatOn then
                        call UnitAddAbility(GetLastCreatedUnit(), 'A0B1')
                    endif
                    
                    if RoundCreepTypeId != 'n01H' and RoundCreepTypeId != 'n00W' then
                        call BlzSetUnitBaseDamage(GetLastCreatedUnit(),R2I(BlzGetUnitBaseDamage(GetLastCreatedUnit(),0) * 0.5),0)
                    endif
    
                    //call BJDebugMsg("rci: " + I2S(udg_integer40 - 1))
                    if RoundCreepInfo[udg_integer40 - 1] == "" then
                        //call BJDebugMsg("a")
                        set RoundCreepTitle = "|cffdd9bf1" + I2S(RoundCreepNumber) + " |r|cff77d2fc" + GetObjectName(RoundCreepTypeId) + "|r"
                        set s = RoundCreepTitle + ": "
                        set RoundCreepInfo[udg_integer40 - 1] = "|cfff19b9bHit points|r: " + I2S(BlzGetUnitMaxHP(GetLastCreatedUnit())) + "|n"
                        //call BJDebugMsg("b")
                        if IsUnitType(GetLastCreatedUnit(), UNIT_TYPE_MELEE_ATTACKER) then
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cffebde71Range|r: Melee |n"
                        else
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff82f373Range|r: " + I2S(R2I(BlzGetUnitWeaponRealField(GetLastCreatedUnit(), UNIT_WEAPON_RF_ATTACK_RANGE, 0))) + "|n"
                            set s = s + "|cff82f373Ranged|r: "
                        endif
                        //call BJDebugMsg("c")
                        if RoundCreepTypeId == 'n01H' or RoundCreepTypeId == 'n00W' then
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bddf1Damage Type|r: magic |n"
                            set s = s + "|cff9bddf1Magic Damage|r: "
                        else
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff167daDamage Type|r: physical |n"
                        endif
                        //call BJDebugMsg("d")
                        if BonusNeutral == 0 and BonusNeutralPlayer[udg_integer40 - 1] == 0 then
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff19bb8Damage|r: " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1)) + " - " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + (BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) * BlzGetUnitDiceSides(GetLastCreatedUnit(), 0) ) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1)) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(GetLastCreatedUnit()))) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_BLOCK))) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICPOW))) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES))) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_EVASION)))
                        else
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff19bb8Damage|r: " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1) - damageBonus) + " - " + I2S(BlzGetUnitBaseDamage(GetLastCreatedUnit(), 0) + (BlzGetUnitDiceNumber(GetLastCreatedUnit(), 0) * BlzGetUnitDiceSides(GetLastCreatedUnit(), 0) + BlzGetAbilityIntegerLevelField(BlzGetUnitAbility(GetLastCreatedUnit(), 'A000'), ABILITY_ILF_ATTACK_BONUS, (R2I(RoundCreepPower)/ 2) - 1) - damageBonus )) + " + |cfff19bb8" + I2S(R2I(damageBonus)) + "|r|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9babf1Armor|r: " + I2S(R2I(BlzGetUnitArmor(GetLastCreatedUnit()))) + "|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff78729eBlock|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_BLOCK) - blockBonus)) + " + |cff78729e" + I2S(R2I(blockBonus)) + "|r|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bc7f1Magic power|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICPOW) - magicPowerBonus)) + "+ |cff9bc7f1" + I2S(R2I(magicPowerBonus)) + "|r|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cff9bf1a9Magic protection|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_MAGICRES) - magicDefBonus)) + " + |cff9bf1a9" + I2S(R2I(magicDefBonus)) + "|r|n"
                            set RoundCreepInfo[udg_integer40 - 1] = RoundCreepInfo[udg_integer40 - 1] + "|cfff1cc9bEvasion|r: " + I2S(R2I(GetUnitCustomState(GetLastCreatedUnit(), BONUS_EVASION) - evasionBonus)) + " + |cfff1cc9b" + I2S(R2I(evasionBonus)) + "|r"
                        endif
                        //call BJDebugMsg("e")
                        set s = s + RoundAbilities
                        call DisplayTimedTextToPlayer(Player(udg_integer40 - 1), 0, 0, 20, "Next: " + s)
                        //call BJDebugMsg("f")
                    endif
                    //call BJDebugMsg("rci finish: " + I2S(udg_integer40 - 1))
                else
                endif
                set udg_integer40 = udg_integer40 + 1
            endloop
            set RoundGenCreepIndex = RoundGenCreepIndex + 1
        endloop
    endfunction


    private function init takes nothing returns nothing
        set udg_trigger103 = CreateTrigger()
        call TriggerAddCondition(udg_trigger103,Condition(function Trig_Generate_Next_Level_Conditions))
        call TriggerAddAction(udg_trigger103,function Trig_Generate_Next_Level_Actions)
    endfunction


endlibrary
