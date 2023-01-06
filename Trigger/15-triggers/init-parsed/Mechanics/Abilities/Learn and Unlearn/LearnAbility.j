library LearnAbility initializer init requires RandomShit, Functions, CustomGameEvent, AbilityCommand

    globals
        unit BuyingUnit = null
    endglobals

    private function LearnAbilityConditions takes nothing returns boolean
        return GetAbilityFromItem(GetItemTypeId(GetManipulatedItem())) != 0
    endfunction

    private function EconomicModeAbility takes integer abilId returns boolean
        return ECONOMIC_ABILITIES.contains(abilId) and IncomeMode == 3
    endfunction

    private function BuyLevels takes player p, unit u, integer abil, boolean maxBuy, boolean new returns nothing
        local integer i = GetUnitAbilityLevel(u, abil) + 1
        local integer cost = BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr'))
        local integer lumber = GetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER)
        local location unitLocation = GetUnitLoc(u)

        //call BJDebugMsg("u: " + GetUnitName(u) + " abil: " + GetObjectName(abil) + " lvl: " + I2S(i) + " new: " + B2S(new))
        if maxBuy and i < 30 then
            loop
                if lumber - cost < 0 then
                    exitwhen true
                endif
                set lumber = lumber - cost
                set i = i + 1
                exitwhen i >= 30
            endloop
            call SetPlayerState(p, PLAYER_STATE_RESOURCE_LUMBER, lumber)
        endif
        //call BJDebugMsg("u: " + GetUnitName(u) + " abil: " + GetObjectName(abil) + " lvl: " + I2S(i) + " new: " + B2S(new))
        if new then
            call UnitAddAbility(u, abil)
            call SpellLearnedFunc(u, abil)
            if AbilityMode == 1 then
                call AddItemToUpgradeShop(GetPlayerId(p), GetItemTypeId(GetManipulatedItem()))
            endif
        endif
        if i > 1 and i < 31 then
            call SetUnitAbilityLevel(u, BoughtAbility, i)
        endif

        call SetupDummySpell(u, abil, i, new)

        if new then
            call InitializeAbilityCommand(u, abil)
        endif

        call UnitAddAbility(u, abil)

        if new then
            call CustomGameEvent_FireEvent(EVENT_LEARN_ABILITY, EventInfo.create(p, abil, RoundNumber))
        else
            call CustomGameEvent_FireEvent(EVENT_LEVEL_ABILITY, EventInfo.create(p, abil, RoundNumber))
        endif

        call FuncEditParam(abil, u)
        call DestroyEffect(AddSpecialEffectLocBJ(unitLocation, "Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl"))
        call DisplayTimedTextToPlayer(p, 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(abil, GetUnitAbilityLevel(u, abil) - 1))

        // Cleanup
        call RemoveLocation(unitLocation)
        set unitLocation = null
    endfunction

    private function LearnAbilityActions takes nothing returns nothing
        local boolean maxAbil = false
        local integer playerId = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))

        set BuyingUnit = PlayerHeroes[playerId]
        set BoughtAbility = GetAbilityFromItem(GetItemTypeId(GetManipulatedItem()))

        // Bought ability item is invalid or is an absolute
        if (BoughtAbility == 0 or IsAbsolute(BoughtAbility) or GetTriggerUnit() != BuyingUnit) then
            return
        endif

        if (HoldShift[GetPlayerId(GetOwningPlayer(BuyingUnit))]) then
            set maxAbil = true
        endif

        // Economy abiliy logic
        if (EconomicModeAbility(BoughtAbility)) then
            if (ARLearningAbil == true) then
                call ConditionalTriggerExecute(LearnRandomAbilityTrigger)
                return
            else
                call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffbbff00Failed to learn|r")
                
                if (AbilityMode == 1) then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr')), GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "[|cffffc896Economic|r] spells are |cffff0000unavailable in Economy mode|r: instead you get bonus gold and experience by default.")
                endif

                return
            endif
        endif

        if (ArNotLearningAbil == false) then
            if (GetUnitAbilityLevel(BuyingUnit, BoughtAbility) == 0) then
                // Reached max abilities
                if (HeroAbilityCount[playerId + 1] >= 10) then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr')), GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(BuyingUnit) )
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r")
                    return
                endif

                set HeroAbilityCount[playerId + 1] = HeroAbilityCount[playerId + 1] + 1
                set PlayerLastLearnedSpell[playerId + 1] = BoughtAbility
                call BuyLevels(GetOwningPlayer(BuyingUnit), BuyingUnit, BoughtAbility, maxAbil, true)
            else
                //increase level ap
                if (GetUnitAbilityLevel(BuyingUnit, BoughtAbility) < 30) then
                    call BuyLevels(GetOwningPlayer(BuyingUnit), BuyingUnit, BoughtAbility, maxAbil, false)
                else
                    //max level reached
                    if (ARLearningAbil == false) then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr')), GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                    else
                        call AdjustPlayerStateBJ(5, GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                    endif

                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: Maximum ability level")
                    return
                endif
            endif
        else
            if (GetUnitAbilityLevel(BuyingUnit, BoughtAbility) >= 0) then
                //failed ar
                if (ARLearningAbil == false) then
                    call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr')), GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                else
                    call AdjustPlayerStateBJ(5, GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                    call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                endif

                call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: (Random mode) 3")
                return
            else
                //increase level ap
                if (GetUnitAbilityLevel(BuyingUnit, BoughtAbility) < 30) then
                    call IncUnitAbilityLevelSwapped(BoughtAbility, BuyingUnit)
                    call FuncEditParam(BoughtAbility, BuyingUnit)
                    call DestroyEffect(AddSpecialEffectLocBJ(GetUnitLoc(BuyingUnit), "Objects\\Spawnmodels\\Other\\ToonBoom\\ToonBoom.mdl"))
                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffbbff00Learned |r" + BlzGetAbilityTooltip(BoughtAbility, GetUnitAbilityLevel(BuyingUnit, BoughtAbility)))
                else
                    if (ARLearningAbil == false) then
                        call AdjustPlayerStateBJ(BlzGetItemIntegerField(GetManipulatedItem(), ConvertItemIntegerField('iclr')), GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                    else
                        call AdjustPlayerStateBJ(5, GetOwningPlayer(BuyingUnit), PLAYER_STATE_RESOURCE_LUMBER)
                        call ResourseRefresh(GetOwningPlayer(BuyingUnit))
                    endif

                    call DisplayTimedTextToPlayer(GetOwningPlayer(BuyingUnit), 0, 0, 2.0, "|cffffe600Failed to learn|r: 4")
                    return
                endif
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set LearnAbilityTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(LearnAbilityTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(LearnAbilityTrigger, Condition(function LearnAbilityConditions))
        call TriggerAddAction(LearnAbilityTrigger, function LearnAbilityActions)
    endfunction

endlibrary
