library DraftOnBuy initializer init requires DraftModeFunctions/*
    These are all for when someone buys a spell from the draft shop. 
    They add the bought spell to the upgrade shop and clear the draft shop by removing and making a new one.
    Only triggers when bought from DraftBuilding.
    */

    globals
        trigger DraftOnBuyTrigger
    endglobals

    private function DraftOnBuyConditions takes nothing returns boolean
        return GetUnitTypeId(GetSellingUnit()) == DRAFT_BUY_UNIT_ID
    endfunction

    private function DraftOnBuyActions takes nothing returns nothing
        local integer currentPlayerId = GetPlayerId(GetOwningPlayer(GetSellingUnit()))
        call AddItemToStock(udg_Draft_UpgradeBuildings[currentPlayerId], GetItemTypeId(GetSoldItem()), 1, 1)
    
        if (udg_Draft_NOSpellsLearned[currentPlayerId] < 9) then // (udg_Draft_NOSpellsLearned[currentPlayerId] < 9) results in drafting 10 spells in total.
            call GenerateDraftSpells(currentPlayerId, udg_Draft_NODraftSpells) 
        else
            call RemoveDraftSpells(currentPlayerId, udg_Draft_NODraftSpells)
        endif
    
        set udg_Draft_NOSpellsLearned[currentPlayerId] = udg_Draft_NOSpellsLearned[currentPlayerId] + 1  
    endfunction

    private function init takes nothing returns nothing
        set DraftOnBuyTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ(DraftOnBuyTrigger, EVENT_PLAYER_UNIT_SELL_ITEM)
        call TriggerAddCondition(DraftOnBuyTrigger, Condition(function DraftOnBuyConditions))
        call TriggerAddAction(DraftOnBuyTrigger, function DraftOnBuyActions)
    endfunction

endlibrary