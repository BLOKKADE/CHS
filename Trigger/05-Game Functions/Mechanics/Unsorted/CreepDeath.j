library CreepDeath initializer init requires RandomShit, MidasTouch, ArenaMasterBonus

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

    private function IsAliveCreepUnitFilter takes nothing returns boolean
        return (UnitAlive(GetFilterUnit()) == true) and (GetOwningPlayer(GetFilterUnit()) == Player(11))
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
        local item It = GetManipulatedItem()
        local real luck = GetUnitCustomState(killingHero, BONUS_LUCK)
        local integer itemCount = 0
        local group playerArenaCreeps

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
            if (IsUnitIllusionBJ(dyingUnit) != true) and (GetUnitTypeId(dyingUnit) != 'n00T') and (GetUnitAbilityLevelSwapped(PILLAGE_ABILITY_ID, killingHero)> 0) and  (IsUnitEnemy(dyingUnit, GetOwningPlayer(killingHero))) then
                if GetRandomReal(0,100) <= (65 + LuckyTriggerBonusChance(killingHero)) * luck then
                    set pillageBonus = (((GetUnitAbilityLevelSwapped(PILLAGE_ABILITY_ID, killingHero) * 18) * 70) / (70 + remBon + GetUnitAbilityLevelSwapped(LEARNABILITY_ABILITY_ID, killingHero)))
                    call DestroyEffect(AddLocalizedSpecialEffect("Abilities\\Spells\\Other\\Transmute\\PileofGold.mdl", GetUnitX(dyingUnit), GetUnitY(dyingUnit)))
                    set goldBounty = goldBounty + pillageBonus
                endif
            endif
            
            //Learnability
            if (IsUnitIllusionBJ(dyingUnit) != true) and (GetUnitTypeId(dyingUnit) != 'n00T') and (GetUnitAbilityLevelSwapped(LEARNABILITY_ABILITY_ID, killingHero)> 0) and  (IsUnitEnemy(dyingUnit, GetOwningPlayer(killingHero))) then
                set expBounty = expBounty + (35 * GetUnitAbilityLevel(killingHero,LEARNABILITY_ABILITY_ID) * 70) / (70 + remBon + GetUnitAbilityLevel(killingHero,PILLAGE_ABILITY_ID))	
            endif	
        endif
        
        //Golden Ring
        set itemCount = GetUnitItemTypeCount(killingHero, 'I04R')
        if itemCount > 0 then
            set goldBounty = goldBounty + ((10 * ArenaMasterMultiplier(killingHero)) * itemCount)
            set goldBounty = goldBounty + (itemCount * (RoundNumber) * ArenaMasterMultiplier(killingHero))
        endif

        //Agility level bonus
        if UnitHasItemType(killingHero, AGILITY_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(killingHero) != STOMP_TREE_UNIT_ID and not UnitHasItemType(killingHero, STRENGTH_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(killingHero, INTELLIGENCE_MANUSCRIPT_ITEM_ID) then
            if GetHeroXP(killingHero) >= 20000 then
                call AddStatLevelBonus(killingHero, BONUS_AGILITY, 1)
                call UnitAddItemById(killingHero, EXPERIENCE_20000_TOME_ITEM_ID)
                call RemoveItem(It)
                call DisplayTextToPlayer(GetOwningPlayer(killingHero), 0, 0, "|cffffffffYour agility per level has been increased by 1!|r")
            endif
        endif

        //Strength level bonus
        if UnitHasItemType(killingHero, STRENGTH_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(killingHero) != STOMP_TREE_UNIT_ID and not UnitHasItemType(killingHero, AGILITY_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(killingHero, INTELLIGENCE_MANUSCRIPT_ITEM_ID) then
            if GetHeroXP(killingHero) >= 20000 then
                call AddStatLevelBonus(killingHero, BONUS_STRENGTH, 1)
                call UnitAddItemById(killingHero, EXPERIENCE_20000_TOME_ITEM_ID)
                call RemoveItem(It)
                call DisplayTextToPlayer(GetOwningPlayer(killingHero), 0, 0, "|cffffffffYour strength per level has been increased by 1!|r")
            endif
        endif

        //Intelligence level bonus
        if UnitHasItemType(killingHero, INTELLIGENCE_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(killingHero) != STOMP_TREE_UNIT_ID and not UnitHasItemType(killingHero, STRENGTH_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(killingHero, AGILITY_MANUSCRIPT_ITEM_ID) then
            if GetHeroXP(killingHero) >= 20000 then
                call AddStatLevelBonus(killingHero, BONUS_INTELLIGENCE, 1)
                call UnitAddItemById(killingHero, EXPERIENCE_20000_TOME_ITEM_ID)
                call RemoveItem(It)
                call DisplayTextToPlayer(GetOwningPlayer(killingHero), 0, 0, "|cffffffffYour intelligence per level has been increased by 1!|r")
            endif
        endif

        //Urn of Memories
        set itemCount = GetUnitItemTypeCount(killingHero, URN_ITEM_ID)
        if itemCount > 0 then
            if pillageBonus == 0 then
                set expBounty = expBounty + ((2 * GetHeroLevel(killingHero)) * itemCount)
            else
                set expBounty = expBounty + ((GetHeroLevel(killingHero)) * itemCount)
            endif
        endif

        //Chest of Gread
        /*set itemCount = GetUnitItemTypeCount(killingHero, 'I05A')
        if itemCount > 0 then
            set goldBounty = goldBounty + (50 * itemCount)
            set expBounty = expBounty + (50 * itemCount)
        endif*/

        //Creep bounty
        set playerArenaCreeps = GetUnitsInRectMatching(PlayerArenaRects[pid], Condition(function IsAliveCreepUnitFilter))

        if (CountUnitsInGroup(playerArenaCreeps) == 0) then
            set goldBounty = goldBounty + BaseCreepBounty + BountyDivisionOffset
        else
            set goldBounty = goldBounty + BaseCreepBounty
        endif

        //call BJDebugMsg("cd xp bonus pre: " + I2S(expBounty))
        set expBounty = R2I(expBounty * (1 + (GetMagicNecklaceBonus(killingHero, dyingUnit) + GetLearnabilityBonus(killingHero))))
        //call BJDebugMsg("cd xp bonus post: " + I2S(expBounty))

        if ChestOfGreedBonus.boolean[GetHandleId(dyingUnit)] and UnitHasItemType(killingHero, 'I05A') then
            set goldBounty = R2I(goldBounty * CgBonus)
        endif

        // Round 50 bonus gold and experience
        if RoundNumber == 50 then
            set goldBounty = R2I(goldBounty * 3)
            set expBounty = R2I(expBounty * 3)
        endif

        // Gradual bonus for low creep count (added to existing bounty)
        if RoundCreepNumber == 2 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 2.5)
            set expBounty = expBounty + R2I(I2R(expBounty) * 2.5)
        elseif RoundCreepNumber == 3 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 2.3)
            set expBounty = expBounty + R2I(I2R(expBounty) * 2.3)
        elseif RoundCreepNumber == 4 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 2.1)
            set expBounty = expBounty + R2I(I2R(expBounty) * 2.1)
        elseif RoundCreepNumber == 5 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 1.9)
            set expBounty = expBounty + R2I(I2R(expBounty) * 1.9)
        elseif RoundCreepNumber == 6 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 1.8)
            set expBounty = expBounty + R2I(I2R(expBounty) * 1.8)
        elseif RoundCreepNumber == 7 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 1.7)
            set expBounty = expBounty + R2I(I2R(expBounty) * 1.7)
        elseif RoundCreepNumber == 8 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 1.6)
            set expBounty = expBounty + R2I(I2R(expBounty) * 1.6)
        elseif RoundCreepNumber == 9 then
            set goldBounty = goldBounty + R2I(I2R(goldBounty) * 1.5)
            set expBounty = expBounty + R2I(I2R(expBounty) * 1.5)
        endif
        
        call BountyText(killingHero, dyingUnit, goldBounty)
        call SetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(owner, PLAYER_STATE_RESOURCE_GOLD) + goldBounty)
        call AddHeroXP(killingHero, expBounty, true)
        call ResourseRefresh(owner)
        //call BJDebugMsg("creep death")

        // Cleanup
        call DestroyGroup(playerArenaCreeps)
        set playerArenaCreeps = null
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
            call NonCreepDeath(GetDyingUnit(), PlayerHeroes[GetPlayerId(GetOwningPlayer(GetKillingUnit()))])
        endif

        return false
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(trg, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(trg, Condition(function SummonDeath))
        set trg = null
    endfunction

endlibrary