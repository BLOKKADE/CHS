library DraftOnBuy requires DraftModeFunctions, AbilityData

    /*
    Handles when someone buys a spell from the draft shop.
    - Adds the bought spell to the upgrade shop.
    - Refreshes the draft shop with new spells, unless the purchased ability is one of the
      special economic abilities (Pillage, Learnability, Holy Enlightenment).
    */

    function DraftOnBuyAbility takes integer pid, integer abilId returns nothing
        // Skip refresh if the ability is one of the excluded ones
        if abilId == PILLAGE_ABILITY_ID or abilId == LEARNABILITY_ABILITY_ID or abilId == HOLY_ENLIGHTENMENT_ABILITY_ID then
            // Still increment the learned counter if needed
            set udg_Draft_NOSpellsLearned[pid] = udg_Draft_NOSpellsLearned[pid] + 1
            return
        endif

        // Normal draft refresh logic
        if (udg_Draft_NOSpellsLearned[pid] < 9) then
            call GenerateDraftSpells(pid, udg_Draft_NODraftSpells[pid]) 
        else
            call RemoveDraftSpells(pid, udg_Draft_NODraftSpells[pid])
        endif

        set udg_Draft_NOSpellsLearned[pid] = udg_Draft_NOSpellsLearned[pid] + 1  
    endfunction

endlibrary
