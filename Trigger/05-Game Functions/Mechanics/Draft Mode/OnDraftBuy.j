library DraftOnBuy requires DraftModeFunctions, AbilityData
    /*
    These are all for when someone buys a spell from the draft shop. 
    They add the bought spell to the upgrade shop and clear the draft shop by removing and making a new one.
    Only triggers when bought from DraftBuilding.
    */

    function DraftOnBuyAbility takes integer pid, integer abilId returns nothing
        if (udg_Draft_NOSpellsLearned[pid] < 9) then // (udg_Draft_NOSpellsLearned[pid] < 9) results in drafting 10 spells in total.
            call GenerateDraftSpells(pid, udg_Draft_NODraftSpells[pid]) 
        else
            call RemoveDraftSpells(pid, udg_Draft_NODraftSpells[pid])
        endif
    
        set udg_Draft_NOSpellsLearned[pid] = udg_Draft_NOSpellsLearned[pid] + 1  
    endfunction
endlibrary