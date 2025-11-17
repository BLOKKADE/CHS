library UnlearnAbility initializer init requires RandomShit, Functions, SpellsLearned, CustomGameEvent

    // helper to check protected abilities
    private function IsUnlearnableAbility takes integer abilId returns boolean
        return abilId == PILLAGE_ABILITY_ID or abilId == LEARNABILITY_ABILITY_ID or abilId == HOLY_ENLIGHTENMENT_ABILITY_ID
    endfunction

    private function UnlearnAbilityConditions takes nothing returns boolean
        return GetItemTypeId(GetManipulatedItem()) == 'I00P'
    endfunction

    private function UnlearnAbilityActions takes nothing returns nothing 
        local integer spellCount = 0 
        local integer lastLearned = 0
        local unit currentUnit = GetTriggerUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local integer currentPlayerId = GetPlayerId(currentPlayer)
    
        if (ArNotLearningAbil == false and AbilityMode != 2 and PlayerLastLearnedSpell[currentPlayerId] != 'Amnz') then
            set spellCount = GetHeroSpellListCount(currentUnit, 0)

            if (spellCount > 0) then
                set PlayerLastLearnedSpell[currentPlayerId] = GetLastLearnedSpell(currentUnit, SpellList_Normal, true)
                set lastLearned = PlayerLastLearnedSpell[currentPlayerId]

                // block if protected
                if IsUnlearnableAbility(lastLearned) then
                    call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffffcc00This ability cannot be unlearned!")
                else
                    set HeroAbilityCount[currentPlayerId] = HeroAbilityCount[currentPlayerId] - 1
                    call SetHeroSpellPosition(currentUnit, spellCount, 0)
                    call SetHeroSpellListCount(currentUnit, spellCount - 1, 0) 
    
                    call DisplayTimedTextToPlayer(currentPlayer, 0, 0, 10, "|cffbbff00Removed |r" + BlzGetAbilityTooltip(lastLearned, GetUnitAbilityLevel(currentUnit, lastLearned) - 1))
                    call DestroyEffect(AddSpecialEffectTargetUnitBJ("origin", currentUnit, "Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl"))
                    call UnitRemoveAbility(currentUnit, lastLearned)
                    call FunResetAbility(lastLearned, currentUnit)
                    call RemoveDummyspell(currentUnit, lastLearned)
                    call CustomGameEvent_FireEvent(EVENT_UNLEARN_ABILITY, EventInfo.create(currentPlayer, lastLearned, RoundNumber))

                    if (AbilityMode == 1) then
                        call RemoveItemFromUpgradeShop(currentPlayerId, GetItemFromAbility(lastLearned))
                        call RefreshUpgradeShop(currentPlayerId, currentUnit)
                    endif
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
