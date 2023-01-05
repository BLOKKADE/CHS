library UnlearnAbility initializer init requires RandomShit, Functions, SpellsLearned, CustomGameEvent

    private function UnlearnAbilityConditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == 'I00P'
    endfunction

    private function UnlearnAbilityActions takes nothing returns nothing 
        local integer spellCount = 0 
        local integer lastLearned = 0
        local unit currentUnit = GetTriggerUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local integer currentPlayerId = GetPlayerId(currentPlayer)
    
        if (ArNotLearningAbil == false and AbilityMode != 2 and PlayerLastLearnedSpell[currentPlayerId + 1] != 'Amnz') then
            set spellCount = GetHeroSpellListCount(currentUnit, 0)

            if (spellCount > 0) then
                set HeroAbilityCount[currentPlayerId + 1] = HeroAbilityCount[currentPlayerId + 1] - 1
                set PlayerLastLearnedSpell[currentPlayerId + 1] = GetLastLearnedSpell(currentUnit, SpellList_Normal, true)
                call SetHeroSpellPosition(currentUnit, spellCount, 0)
                call SetHeroSpellListCount(currentUnit, spellCount - 1, 0) 
    
                call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffbbff00Removed |r" + BlzGetAbilityTooltip(PlayerLastLearnedSpell[currentPlayerId + 1], GetUnitAbilityLevel(currentUnit, PlayerLastLearnedSpell[currentPlayerId + 1]) - 1))
                call DestroyEffect(AddSpecialEffectTargetUnitBJ("origin", currentUnit, "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl"))
                call UnitRemoveAbility(currentUnit, PlayerLastLearnedSpell[currentPlayerId + 1])
                call FunResetAbility(PlayerLastLearnedSpell[currentPlayerId + 1], currentUnit)
                call RemoveDummyspell(currentUnit, PlayerLastLearnedSpell[currentPlayerId + 1])
                call CustomGameEvent_FireEvent(EVENT_UNLEARN_ABILITY, EventInfo.create(currentPlayer, PlayerLastLearnedSpell[currentPlayerId + 1], RoundNumber))

                if (AbilityMode == 1) then
                    call RemoveItemFromUpgradeShop(currentPlayerId - 1, GetItemFromAbility(PlayerLastLearnedSpell[currentPlayerId + 1]))
                    call RefreshUpgradeShop(currentPlayerId - 1, currentUnit)
                endif
            endif
    
        else
            call AdjustPlayerStateBJ(20, currentPlayer, PLAYER_STATE_RESOURCE_GOLD)
            call ResourseRefresh(currentPlayer)
            call ForceAddPlayerSimple(currentPlayer, bj_FORCE_PLAYER[11])
    
            if (ArNotLearningAbil == false or AbilityMode == 2) then
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11], 2.00, "|cffffcc00Failed to unlearn!")
            else
                call DisplayTimedTextToForce(bj_FORCE_PLAYER[11], 2.00, "|cffffcc00Failed to unlearn! (Random Mode)")
            endif
    
            call ForceRemovePlayerSimple(currentPlayer, bj_FORCE_PLAYER[11])
        endif

        // Cleanup
        set currentUnit = null
        set currentPlayer = null
    endfunction

    private function init takes nothing returns nothing
        set UnlearnAbilityTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(UnlearnAbilityTrigger, EVENT_PLAYER_UNIT_PICKUP_ITEM)
        call TriggerAddCondition(UnlearnAbilityTrigger, Condition(function UnlearnAbilityConditions))
        call TriggerAddAction(UnlearnAbilityTrigger, function UnlearnAbilityActions)
    endfunction

endlibrary
