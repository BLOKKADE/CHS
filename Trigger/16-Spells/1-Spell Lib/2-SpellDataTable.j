globals
    HashTable SpellData
endglobals

// 1 = Thorns / Wizardbane
// 2 = whirlwind
// 3 = cosmic retribution phys
// 4 = whirlwind bool
// 5 = extra dimensional cooperation bool
// 6 = extra dimensional cooperation count
// 7 = last attack damage

function Trig_SpellDataTable_Actions takes nothing returns nothing
    set SpellData = HashTable.create()
endfunction

//===========================================================================
function InitTrig_SpellDataTable takes nothing returns nothing
    set gg_trg_SpellDataTable = CreateTrigger(  )
    call TriggerRegisterTimerEventSingle( gg_trg_SpellDataTable, 0.00 )
    call TriggerAddAction( gg_trg_SpellDataTable, function Trig_SpellDataTable_Actions )
endfunction

