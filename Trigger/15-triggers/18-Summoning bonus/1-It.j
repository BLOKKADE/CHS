library SummonUpgrade initializer init
    function Trig_It_Conditions takes nothing returns boolean
        if GetItemTypeId(GetManipulatedItem()) == 'I04K' then
            call SetPlayerTechResearchedSwap( 'R000', ( 1 + GetPlayerTechCountSimple('R000', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
        elseif GetItemTypeId(GetManipulatedItem()) == 'I04M' then
            call SetPlayerTechResearchedSwap( 'R002', ( 1 + GetPlayerTechCountSimple('R002', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
        elseif GetItemTypeId(GetManipulatedItem()) == 'I04L' then
            call SetPlayerTechResearchedSwap( 'R001', ( 1 + GetPlayerTechCountSimple('R001', GetOwningPlayer(GetTriggerUnit())) ), GetOwningPlayer(GetTriggerUnit()) )
        endif
        return false
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_PICKUP_ITEM )
        call TriggerAddCondition( trg, Condition( function Trig_It_Conditions ) )
        set trg = null
    endfunction
endlibrary