library StartFunction requires TimerUtils, DummyOrder RandomShit, RuneInit, BoneArmor, CustomEvent
    globals
        hashtable HT_timerSpell = InitHashtable()
        integer array RoundTimer
    endglobals

    function PreRoundStart takes unit hero, integer hid returns nothing
        //Blokkade's Shield
        if GetUnitAbilityLevel(hero, BLOKKADE_SHIELD_ABIL_ID) > 0 then
            set BlokShieldCharges[hid] = 0
            set BlokShieldStartTick[hid] = T32_Tick
            set BlokShieldAttackCount[hid] = 0
            call SetBlokShieldCharges(hero, hid)
        endif
    endfunction

    function OnRoundStart takes unit hero, integer hid returns nothing
        local item it 

        //Ankh limit
        set it = GetUnitItem(hero, 'ankh')
        if it != null then
            if GetItemCharges(it) == 2 then
                set AnkhLimitReached.boolean[hid] = true
            endif
        endif

        set it = null
    endfunction

    function FunctionTimerSpell takes nothing returns nothing
        local timer startbattle = GetExpiredTimer()
        local timer nTimer = null
        local timer oTimer = null
        local unit Herou = LoadUnitHandle(HT_timerSpell,GetHandleId(startbattle),1)
        local integer startType = LoadInteger(HT_timerSpell, GetHandleId(startbattle), 4)
        local integer pid = GetPlayerId(GetOwningPlayer(Herou))
        local real abilLevel = 0
        local real heroLevel = 0
        local real ChronusLevel = 1 + (0.05 * I2R(GetUnitAbilityLevel(Herou,CHRONUS_WIZARD_ABILITY_ID)))
        local real r4 = 0
        local real r5 = 0
        local integer i = 0
        local integer i1 = 0
        local unit U = null
        local integer hid = GetHandleId(Herou)
        local boolean chronusActivated = false
            
        if Herou != null and (IsPlayerInForce(GetOwningPlayer(Herou), udg_force07) or GetPlayerSlotState(GetOwningPlayer(Herou)) != PLAYER_SLOT_STATE_PLAYING) then
            call SetUnitInvulnerable(Herou, false)
            call KillUnit(Herou)
            set Herou = null
            set startbattle = null
            return
        endif
        set heroLevel = GetHeroLevel(Herou)

        if startType != 6 then
            call OnRoundStart(Herou, hid)
        endif

        call ResetTimeManipulation(Herou, startType)
            
        //Hero Buff
        set abilLevel = GetUnitAbilityLevel(Herou,HERO_BUFF_ABILITY_ID)
        if abilLevel > 0 then
            call HeroBuffCast(Herou, R2I(abilLevel), R2I(heroLevel), ChronusLevel, (10 +(heroLevel * 0.02)) * ChronusLevel)
            set chronusActivated = true
        endif
        
        //Temporary Inisibility
        set abilLevel = GetUnitAbilityLevel(Herou,TEMPORARY_INVISIBILITY_ABILITY_ID)    
        if abilLevel > 0 then
            call TempInvisStruct.create(Herou, (1.8 + (0.2 * abilLevel)) * ChronusLevel)
            set chronusActivated = true
        endif
            
        //Temporary Power
        set abilLevel = GetUnitAbilityLevel(Herou,TEMPORARY_POWER_ABILITY_ID)    
        if abilLevel > 0 then
            call TempPowerCast(Herou, (10 + (0.02 * heroLevel)) * ChronusLevel)
            set chronusActivated = true
        endif
            
        //Holy Enlightenment
        set abilLevel = GetUnitAbilityLevel(Herou,HOLY_ENLIGHTENMENT_ABILITY_ID)    
        if abilLevel > 0 and startType != 6 then
            call ElemFuncStart(Herou,HOLY_ENLIGHTENMENT_ABILITY_ID)
            set r4 = 50 *(heroLevel + 3)*(heroLevel + 4)- 110  
            set r5 = GetHeroXP(Herou)

            if GetUnitAbilityLevel(Herou,PILLAGE_ABILITY_ID) > 0 then   
                call AddHeroXP(Herou,   R2I((r4 - r5)*(abilLevel * 1.5))/ 200  , true) 
            else
                call AddHeroXP(Herou,   R2I((r4 - r5)*(abilLevel * 1.5))/ 100  , true) 
            endif
        endif
        
        //Cheater Magic
        set abilLevel = GetUnitAbilityLevel(Herou,CHEATER_MAGIC_ABILITY_ID)    
        if abilLevel > 0 then
            call CheaterMagicStruct.create(Herou, (2.75 + (0.25 * abilLevel))* ChronusLevel)
            set chronusActivated = true
        endif
            
        //Blessed Protection
        set abilLevel = GetUnitAbilityLevel(Herou,BLESSED_PROTECTIO_ABILITY_ID)    
        if abilLevel > 0 then
            call BlessedProtectionStruct.create(Herou, (2.70 + (0.3 * abilLevel))* ChronusLevel)
            set chronusActivated = true
        endif
            
        //Shining Runestone
        set i1 = GetUnitItemTypeCount( Herou,SHINING_RUNESTONE_ITEM_ID )
        set i = 0
        if i1 > 0 then
            //call ElemFuncStart(Herou,SHINING_RUNESTONE_ITEM_ID)
            loop 
                exitwhen i >= R2I(i1)
                call CreateRandomRune(0,GetRandomReal(- 100,100)+ GetUnitX(Herou) ,GetRandomReal(- 100,100)+ GetUnitY(Herou)   ,Herou)
                set i = i + 1
            endloop
        endif
            
        //Grunt
        if GetUnitTypeId(Herou) == GRUNT_UNIT_ID then
            call GruntsGruntStruct.create(Herou, ChronusLevel)
        endif
            
        //Bone Armor
        if UnitHasItemType(Herou,'I07O') then
            call ElemFuncStart(Herou,'I07O')
            set U = CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,40 * ChronusLevel)
            set U = CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,40 * ChronusLevel)
            set U = CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,40 * ChronusLevel)
            set U = CreateUnit(GetOwningPlayer(Herou),'u003',GetUnitX(Herou),GetUnitY(Herou),0)
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,40 * ChronusLevel)
            call StartBoneArmor(Herou)
        endif
            
        //Fearless Defenders
        set abilLevel = GetUnitAbilityLevel(Herou,FEARLESS_DEFENDERS_ABILITY_ID)   
        if abilLevel > 0 then
            call ElemFuncStart(Herou,FEARLESS_DEFENDERS_ABILITY_ID)
            set U = CreateUnit( GetOwningPlayer(Herou),'h01A',GetUnitX(Herou)+ 40 * CosBJ(- 30 + GetUnitFacing(Herou)),GetUnitY(Herou)+ 40 * SinBJ(- 30 + GetUnitFacing(Herou)),GetUnitFacing(Herou) )
            call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)- 500 + R2I((abilLevel * 10000)*(1 +(heroLevel * 0.038) )) )
            call BlzSetUnitBaseDamage(U, BlzGetUnitBaseDamage(U,0) - 10 + R2I((abilLevel * 100)*(1 +(heroLevel * 0.038)) ),0)
            call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,(8 + (heroLevel * 0.09)) * ChronusLevel)
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",U,"head"))

            set U = CreateUnit( GetOwningPlayer(Herou),'h01A',GetUnitX(Herou)+ 40 * CosBJ(30 + GetUnitFacing(Herou)),GetUnitY(Herou)+ 40 * SinBJ(30 + GetUnitFacing(Herou)),GetUnitFacing(Herou) )
            call BlzSetUnitMaxHP(U, BlzGetUnitMaxHP(U)- 500 + R2I((abilLevel * 10000)*(1 +(heroLevel * 0.038) )) )
            call BlzSetUnitBaseDamage(U, BlzGetUnitBaseDamage(U,0) - 10 + R2I((abilLevel * 100)*(1 +(heroLevel * 0.038)) ),0)
            call SetWidgetLife(U,BlzGetUnitMaxHP(U) )
            call UnitApplyTimedLife(U,FEARLESS_DEFENDERS_ABILITY_ID,(8 + (heroLevel * 0.09)) * ChronusLevel)
            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Human\\Resurrect\\ResurrectTarget.mdl",U,"head"))  
            set chronusActivated = true     
        endif

        //Faerie Dragon
        if GetUnitTypeId(Herou) == MYSTIC_UNIT_ID then
            set r4 = GetUnitX(Herou)+ 40 * CosBJ(- 30 + GetUnitFacing(Herou))
            set r5 = GetUnitY(Herou)+ 40 * SinBJ(- 30 + GetUnitFacing(Herou))
            call DestroyEffect(AddLocalizedSpecialEffect(FX_BLINK, r4, r5))
            set U = CreateUnit(GetOwningPlayer(Herou), 'e001', r4, r5, GetUnitFacing(Herou))

            call BlzSetUnitAttackCooldown(U, BlzGetUnitAttackCooldown(U,0) * (8 / (8.9 + (heroLevel / 3))), 0)
            call SetUnitAbilityLevelSwapped('A000',U,R2I(GetHeroLevel(Herou)/ 3))
            call SetUnitBonusReal(U, BONUS_ATTACK_SPEED, GetHeroLevel(Herou) * 0.03)
        endif

        //Magic Blade
        set i1 = GetUnitItemTypeCount( Herou,'I06I' )
        if i1 > 0 then
            call ElemFuncStart(Herou,'I06I')
            call SetUnitState(Herou, UNIT_STATE_MANA, GetUnitState(Herou, UNIT_STATE_MANA)- 70000 * i1  )
        endif
            
        //Armor of Ancestors
        set i1 = GetUnitItemTypeCount( Herou,'I07G' )
        if i1 > 0 then
            call ElemFuncStart(Herou,'I07G')
            call BlzSetUnitArmor(Herou,BlzGetUnitArmor(Herou)+ i1 * 20 * RoundCreepNumber )
            call AddUnitCustomState(Herou, BONUS_BLOCK,i1 * 20 * RoundCreepNumber)
            call SaveInteger(HT,hid,54001,LoadInteger(HT,hid,54001)+ i1 * 20 * RoundCreepNumber) 
        endif

        //Arcane Infused Sword
        set i1 = GetUnitItemTypeCount( Herou, ARCANE_INFUSED_SWORD_ITEM_ID )
        if i1 > 0 then
            set i = R2I((GetUnitDamage(Herou, 0) - LoadInteger(HT,hid,ARCANE_INFUSED_SWORD_ITEM_ID))* 0.05 * RoundCreepNumber)
            call AddUnitBonus(Herou, BONUS_DAMAGE, i)
            call SaveInteger(HT,hid, ARCANE_INFUSED_SWORD_ITEM_ID ,LoadInteger(HT,hid,ARCANE_INFUSED_SWORD_ITEM_ID) + i) 
        endif
            
        //Book of Necromancy
        set i1 = GetUnitItemTypeCount( Herou,'I06J' )
        if i1 > 0 then
            call ElemFuncStart(Herou,'I06J')
            set SummonDamage[pid] = SummonDamage[pid] + i1
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon Attack Bonus - [|cffffcc00Level " + I2S(SummonDamage[pid]) + "|r] - (|cff89ff52+" + I2S(SummonDamage[pid] * 3) + ")|r")
            set SummonArmor[pid] = SummonArmor[pid] + i1
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon Armor Bonus - [|cffffcc00Level " + I2S(SummonArmor[pid]) + "|r] - (|cff89ff52+" + I2S(SummonArmor[pid]) + ")|r")
            set SummonHitPoints[pid] = SummonHitPoints[pid] + i1  
            call DisplayTimedTextToPlayer(Player(pid), 0, 0, 2, "Summon HP Bonus - [|cffffcc00Level " + I2S(SummonHitPoints[pid]) + "|r] - (|cff89ff52+" + I2S(SummonHitPoints[pid] * 50) + ")|r")
            
        endif 

        //Blokkade's Shield
        if GetUnitAbilityLevel(Herou, BLOKKADE_SHIELD_ABIL_ID) > 0 then
            set BlokShieldCharges[hid] = BlokShieldCharges[hid] + 6
            call SetBlokShieldCharges(Herou, hid)
        endif

        //Gnome
        if GetUnitTypeId(Herou) == GNOME_MASTER_UNIT_ID then
            call ElemFuncStart(Herou,GNOME_MASTER_UNIT_ID)
            if BrStarted then
                call DummyInstantCast4(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03Z',"stomp",55 * heroLevel,ABILITY_RLF_DAMAGE_INCREASE, 99999,ABILITY_RLF_AREA_OF_EFFECT ,1 +(heroLevel * 0.04),ABILITY_RLF_DURATION_HERO,2 +(heroLevel * 0.08),ABILITY_RLF_DURATION_NORMAL)
            else
                call DummyInstantCast4(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03Z',"stomp",55 * heroLevel,ABILITY_RLF_DAMAGE_INCREASE,1800,ABILITY_RLF_AREA_OF_EFFECT ,1 +(heroLevel * 0.04),ABILITY_RLF_DURATION_HERO,2 +(heroLevel * 0.08),ABILITY_RLF_DURATION_NORMAL)
            endif
        endif
                
        //Rapid Recovery
        set abilLevel = GetUnitAbilityLevel(Herou,RAPID_RECOVERY_ABILITY_ID)    
        if abilLevel > 0 then
            call ElemFuncStart(Herou,RAPID_RECOVERY_ABILITY_ID)
            call DummyInstantCast4(Herou,GetUnitX(Herou),GetUnitY(Herou),'A03W',"battleroar", (BlzGetUnitMaxHP(Herou) * 0.002 * abilLevel)*(1 + 0.02 * heroLevel),ABILITY_RLF_LIFE_REGENERATION_RATE, (GetUnitState(Herou, UNIT_STATE_MAX_MANA) * 0.002 * abilLevel)*(1 + 0.02 * heroLevel),ABILITY_RLF_MANA_REGEN ,(10 +(heroLevel * 0.02))* ChronusLevel,ABILITY_RLF_DURATION_HERO,(10 +(heroLevel * 0.02))* ChronusLevel,ABILITY_RLF_DURATION_NORMAL)
            set chronusActivated = true
        endif
            
        //Demon Curse
        set abilLevel = GetUnitAbilityLevel(Herou,DEMONS_CURSE_ABILITY_ID)    
        if abilLevel > 0 then
            call ElemFuncStart(Herou,DEMONS_CURSE_ABILITY_ID)
            call DummyInstantCast4(Herou,GetUnitX(Herou),GetUnitY(Herou),'A043',"howlofterror",0,ABILITY_RLF_DAMAGE_INCREASE_PERCENT_ROA1,(10 * abilLevel)*(1 + 0.02 * heroLevel),ABILITY_RLF_DAMAGE_HBZ2 ,(8 +(heroLevel * 0.09))* ChronusLevel,ABILITY_RLF_DURATION_HERO,(8 +(heroLevel * 0.09))* ChronusLevel,ABILITY_RLF_DURATION_NORMAL)
            set chronusActivated = true
        endif

        //Time Manipulation
        if GetUnitAbilityLevel(Herou, TIME_MANIPULATION_ABILITY_ID) > 0 then
            call TimeManipulationStart(Herou, chronusActivated)
        endif
        
        call FlushChildHashtable(HT_timerSpell,GetHandleId(startbattle )) 
        call ReleaseTimer(startbattle)
        set U = null
        set Herou = null
        set startbattle = null
        set nTimer = null
    endfunction

    function FixAbilityU takes unit u returns nothing
        local integer i1 = 0
        local real r1 = 0
        local DarkSeal = ds = 0
        local customEvent e = customEvent.create()
        set e.EventUnit = u
        call DispachEvent(CUSTOM_EVENT_FIX_START_ROUND, e)

        set i1 = LoadInteger(HT,GetHandleId(u),54021)
            
        if i1 != 0 then 
            call SetHeroStr(u,GetHeroStr(u,false)- i1,false)
            call SetHeroAgi(u,GetHeroAgi(u,false)- i1,false)
            call SetHeroInt(u,GetHeroInt(u,false)- i1,false)
            call SaveInteger(HT,GetHandleId(u),54021,0)
        endif

        set r1 = LoadReal(HT,GetHandleId(u),DESTRUCTION_BLOCK_ABILITY_ID)
        if r1 != 0 then 
            call AddUnitCustomState(u, BONUS_BLOCK, -r1)
            call SaveReal(HT,GetHandleId(u),DESTRUCTION_BLOCK_ABILITY_ID,0)
        endif
    endfunction
    //i1 = 1 = battle royale
    //i1 = 2 = unused
    //i1 = 3 = pve round start
    //i1 = 4 = duels
    //i1 = 5 = elimination
    //i1 = 6 = urn/time manipulation
    function StartFunctionSpell takes unit Hero, integer i1 returns nothing
        local timer startbattle = NewTimer()
            
        if i1 != 6 then
            call FixAbilityU (Hero)
        endif    

        if i1 == 3 then
            call PreRoundStart(Hero, GetHandleId(Hero))
        endif
        
        call SaveInteger(HT_timerSpell,GetHandleId(startbattle),4, i1)
        call SaveUnitHandle(HT_timerSpell,GetHandleId(startbattle),1,Hero)     
        if i1 == 2 then
            call TimerStart(startbattle,4.25,false,function FunctionTimerSpell )
            
        else
            set RoundTimer[GetPlayerId(GetOwningPlayer(Hero))] = T32_Tick + R2I(0.05 * 32)
            call TimerStart(startbattle,0.05,false,function FunctionTimerSpell )   
        endif
        set startbattle = null
        //	call DisplayTextToPlayer(GetLocalPlayer(),0,0,"yea"+I2S(i1) )
    endfunction
endlibrary
