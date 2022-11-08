library CreepDeath initializer init requires RandomShit, MidasTouch

    public function BountyText takes unit source, unit u, integer goldBounty returns nothing
        local texttag floatingtext
        if GetLocalPlayer() == GetOwningPlayer(source) and IsUnitVisible(u, GetLocalPlayer()) then
            set floatingtext = CreateTextTag()
            call SetTextTagText(floatingtext,"+"+I2S(R2I(goldBounty)), 0.023)
            call SetTextTagPos(floatingtext,GetUnitX(u)-21.0,GetUnitY(u),0.0)
            call SetTextTagColor(floatingtext,255,220,0,255)
            call SetTextTagVelocity(floatingtext,0.0,0.04)
            call SetTextTagFadepoint(floatingtext,1)
            call SetTextTagLifespan(floatingtext,2)
            call SetTextTagPermanent(floatingtext,false)
        endif
        set floatingtext = null
    endfunction

    function Trig_Creep_Dies_Func003Func005001001002001 takes nothing returns boolean
        return(IsUnitAliveBJ(GetFilterUnit())==true)
    endfunction
    
    function Trig_Creep_Dies_Func003Func005001001002002 takes nothing returns boolean
        return(GetOwningPlayer(GetFilterUnit())==Player(11))
    endfunction
    
    function Trig_Creep_Dies_Func003Func005001001002 takes nothing returns boolean
        return GetBooleanAnd(Trig_Creep_Dies_Func003Func005001001002001(),Trig_Creep_Dies_Func003Func005001001002002())
    endfunction
    
    function Trig_Creep_Dies_Func003C takes nothing returns boolean
        if(not(CountUnitsInGroup(GetUnitsInRectMatching(PlayerArenaRects[GetConvertedPlayerId(GetOwningPlayer(GetKillingUnitBJ()))],Condition(function Trig_Creep_Dies_Func003Func005001001002)))==0))then
            return false
        endif
        return true
    endfunction

    public function Death takes unit dyingUnit, unit killingHero returns nothing
        local integer pillageBonus = 0
        local integer ringBonus = 0
        local integer remBon = 0
        local integer expBounty = 0
        local integer goldBounty = 0
        local boolean pillage = false
        local player owner = GetOwningPlayer(killingHero)     
        local integer pid = GetPlayerId(owner)
        local real luck = GetUnitCustomState(killingHero, BONUS_LUCK)
        local integer itemCount = 0
        
        //Creep upgrade xp bonus
        set expBounty = expBounty + BonusNeutral + BonusNeutralPlayer[pid] 
        
        //Greedy Goblin
        if GetUnitTypeId(killingHero) == GREEDY_GOBLIN_UNIT_ID then
            set goldBounty = goldBounty + (((22 + GetHeroLevel(killingHero) * 3) * 70) / (70 + GetUnitAbilityLevel(killingHero,PILLAGE_ABILITY_ID)))
            set expBounty = expBounty + (((21 + GetHeroLevel(killingHero) * 4) * 70) / (70 + GetUnitAbilityLevel(killingHero,PILLAGE_ABILITY_ID)))
            set remBon = 20
        endif

        //Midas Touch
        if GetMidasTouch(GetHandleId(dyingUnit)) != 0 then
            set goldBounty = goldBounty + GetMidasTouch(GetHandleId(dyingUnit)).bonus
            set GetMidasTouch(GetHandleId(dyingUnit)).stop = true
        endif

        if IncomeMode == 3 then
            if RoundNumber > 5 then
                set goldBounty = goldBounty + (IMinBJ(RoundNumber - 5, 10) * 19)
                //call BJDebugMsg("auto eco: " + I2S((IMinBJ(RoundNumber - 5, 10) * 19)))
                set expBounty = expBounty + IMinBJ(RoundNumber - 5, 10) * 45
            endif
        else
            //Pillage
            if (IsUnitIllusionBJ(dyingUnit)!=true) and (GetUnitTypeId(dyingUnit)!='n00T') and (GetUnitAbilityLevelSwapped(PILLAGE_ABILITY_ID,killingHero)> 0) and  (IsUnitEnemy(dyingUnit,GetOwningPlayer(killingHero))) then
                if GetRandomReal(0,100) <= 65 * luck then
                    set pillageBonus = (((GetUnitAbilityLevelSwapped(PILLAGE_ABILITY_ID,killingHero) * 18) * 70)/( 70 + remBon + GetUnitAbilityLevelSwapped(LEARNABILITY_ABILITY_ID,killingHero))  )
                    call DestroyEffect(AddLocalizedSpecialEffect("Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl", GetUnitX(dyingUnit), GetUnitY(dyingUnit)))
                    set goldBounty = goldBounty + pillageBonus
                endif
            endif
            
            //Learnability
            if (IsUnitIllusionBJ(dyingUnit)!=true) and (GetUnitTypeId(dyingUnit)!='n00T') and (GetUnitAbilityLevelSwapped(LEARNABILITY_ABILITY_ID,killingHero)> 0) and  (IsUnitEnemy(dyingUnit,GetOwningPlayer(killingHero))) then
                set expBounty = expBounty + ( 35 * GetUnitAbilityLevel(killingHero,LEARNABILITY_ABILITY_ID) * 70 )/(70 + remBon + GetUnitAbilityLevel(killingHero,PILLAGE_ABILITY_ID))	
            endif	
        endif
        
        //Golden Ring
        set itemCount = GetUnitItemTypeCount(killingHero, 'I04R')
        if itemCount > 0 then
            if GetUnitTypeId(killingHero) == ARENA_MASTER_UNIT_ID then
                set goldBounty = goldBounty + (20 * itemCount)
            else
                set goldBounty = goldBounty + (10 * itemCount)
            endif
        endif

        //Urn of Memories
        set itemCount = GetUnitItemTypeCount(killingHero, 'I05U')
        if itemCount > 0 then
            if pillageBonus == 0 then
                set expBounty = expBounty + ((2 * GetHeroLevel(killingHero)) * itemCount)
            else
                set expBounty = expBounty + ((GetHeroLevel(killingHero)) * itemCount )
            endif
        endif

        //Chest of Gread
        /*set itemCount = GetUnitItemTypeCount(killingHero, 'I05A')
        if itemCount > 0 then
            set goldBounty = goldBounty + (50 * itemCount)
            set expBounty = expBounty + (50 * itemCount)
        endif*/

        //Creep bounty
        if (Trig_Creep_Dies_Func003C()) then
            set goldBounty = goldBounty + udg_integer59 + udg_integer61
        else
            set goldBounty = goldBounty + udg_integer59
        endif

        //call BJDebugMsg("cd xp bonus pre: " + I2S(expBounty))
        set expBounty = R2I(expBounty * (1 + (GetMagicNecklaceBonus(killingHero, dyingUnit) + GetLearnabilityBonus(killingHero))))
        //call BJDebugMsg("cd xp bonus post: " + I2S(expBounty))

        if ChestOfGreedBonus.boolean[GetHandleId(dyingUnit)] and UnitHasItemType(killingHero, 'I05A') then
            set goldBounty = R2I(goldBounty * CgBonus)
        endif
        
        call BountyText(killingHero, dyingUnit, goldBounty)
        call SetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) + goldBounty)
        call AddHeroXP (killingHero, expBounty, true)
        call ResourseRefresh(owner)
        //call BJDebugMsg("creep death")
        set owner = null
    endfunction

    //To make Midas Touch work on all summons
    public function NonCreepDeath takes unit dyingUnit, unit killingHero returns nothing
        local real bonus = 1
        set GetMidasTouch(GetHandleId(dyingUnit)).stop = true
        call CreepDeath_BountyText(killingHero, dyingUnit, GetMidasTouch(GetHandleId(dyingUnit)).bonus)
        if ChestOfGreedBonus.boolean[GetHandleId(dyingUnit)] and UnitHasItemType(killingHero, 'I05A') then
            set bonus = CgBonus
        endif
        call SetPlayerState(GetOwningPlayer(killingHero), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(killingHero), PLAYER_STATE_RESOURCE_GOLD) + R2I(GetMidasTouch(GetHandleId(dyingUnit)).bonus * bonus))
        set GetMidasTouch(GetHandleId(dyingUnit)).stop = true
        //call BJDebugMsg("non creep death")
    endfunction

    private function SummonDeath takes nothing returns boolean
        if GetOwningPlayer(GetDyingUnit()) != Player(11) and IsUnitType(GetDyingUnit(), UNIT_TYPE_HERO) == false and GetMidasTouch(GetHandleId(GetDyingUnit())) != 0 then
            call NonCreepDeath(GetDyingUnit(), PlayerHeroes[GetPlayerId(GetOwningPlayer(GetKillingUnit())) + 1])
        endif
        return false
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(trg,EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(trg, Condition(function SummonDeath))
        set trg = null
    endfunction
endlibrary