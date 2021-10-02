library SpellDataTable initializer init
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
    // 8 = manifold staff
    // 9 = Spellbane Token
    // 10 = Extradimensional Multiply

    function Trig_SpellDataTable_Actions takes nothing returns nothing
        set SpellData = HashTable.create()
    endfunction

    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterTimerEventSingle( trg, 0.00 )
        call TriggerAddAction( trg, function Trig_SpellDataTable_Actions )
        set trg = null
    endfunction
endlibrary