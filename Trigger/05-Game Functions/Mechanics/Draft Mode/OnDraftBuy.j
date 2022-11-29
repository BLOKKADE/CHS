library DraftOnBuy initializer init requires DraftModeFunctions/*
    These are all for when someone buys a spell from the draft shop. 
    They add the bought spell to the upgrade shop and clear the draft shop by removing and making a new one.
    Only triggers when bought from DraftBuilding.
    */

    globals
        trigger DraftOnBuyTrigger
    endglobals

    function Trig_OnDraftBuy_Conditions takes nothing returns boolean
        if ( not ( GetUnitTypeId(GetSellingUnit()) == udg_Draft_DraftBuilding ) ) then
            return false
        endif
        return true
    endfunction

    function Trig_OnDraftBuy_Actions takes nothing returns nothing
        local integer PlayerId = GetConvertedPlayerId(GetOwningPlayer(GetSellingUnit()))
        call AddItemToStock( udg_Draft_UpgradeBuildings[PlayerId], GetItemTypeId(GetSoldItem()), 1, 1 )
    
        if (udg_Draft_NOSpellsLearned[PlayerId] < 9) then // (udg_Draft_NOSpellsLearned[PlayerId] < 9) results in drafting 10 spells in total.
            call GenerateDraftSpells(PlayerId, udg_Draft_NODraftSpells) 
        else
            call RemoveDraftSpells(PlayerId, udg_Draft_NODraftSpells)
        endif
    
        set udg_Draft_NOSpellsLearned[PlayerId] = udg_Draft_NOSpellsLearned[PlayerId] + 1  
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        set DraftOnBuyTrigger = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( DraftOnBuyTrigger, EVENT_PLAYER_UNIT_SELL_ITEM )
        call TriggerAddCondition( DraftOnBuyTrigger, Condition( function Trig_OnDraftBuy_Conditions ) )
        call TriggerAddAction( DraftOnBuyTrigger, function Trig_OnDraftBuy_Actions )
    endfunction
endlibrary