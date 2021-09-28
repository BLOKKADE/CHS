/*
These are all for when someone buys a spell from the draft shop. 
They add the bought spell to the upgrade shop and clear the draft shop by removing and making a new one.
Only triggers when bought from DraftBuilding.
*/

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
function InitTrig_OnDraftBuy takes nothing returns nothing
    set udg_Draft_TrgOnBuy = CreateTrigger()
    call TriggerRegisterAnyUnitEventBJ( udg_Draft_TrgOnBuy, EVENT_PLAYER_UNIT_SELL_ITEM )
    call TriggerAddCondition( udg_Draft_TrgOnBuy, Condition( function Trig_OnDraftBuy_Conditions ) )
    call TriggerAddAction( udg_Draft_TrgOnBuy, function Trig_OnDraftBuy_Actions )
endfunction

