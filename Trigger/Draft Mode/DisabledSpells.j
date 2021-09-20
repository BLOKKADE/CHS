globals
    integer array DisabledSpells_Range
    integer array DisabledSpells_Melee
endglobals

function DisableSpellsInit takes nothing returns nothing
    set DisabledSpells_Range[0] = 24 // I00N Cleaving Attack    

    set DisabledSpells_Melee[0] = 91 // I03N Multishot
    set DisabledSpells_Melee[1] = 68 // I02R Black Arrow
    set DisabledSpells_Melee[2] = 66 // I02P Searing Arrow
    set DisabledSpells_Melee[3] = 69 // I02S Cold Arrow
endfunction

function DisableSpell takes integer playerNumber, integer spellId returns nothing
    call SaveIntegerBJ(LoadIntegerBJ(playerNumber, udg_Draft_PlayerSpellsMaxIndex[playerNumber], udg_Draft_PlayerSpells), playerNumber, spellId, udg_Draft_PlayerSpells)
    set udg_Draft_PlayerSpellsMaxIndex[playerNumber] = udg_Draft_PlayerSpellsMaxIndex[playerNumber] - 1
endfunction

function DisableSpells takes integer PlayerNumber returns nothing
    local integer DisabledSpells_RangeMI = 0 //Max Index
    local integer DisabledSpells_MeleeMI = 3 //Max Index
    local integer i = 0
    if ( IsUnitType(udg_units01[PlayerNumber], UNIT_TYPE_RANGED_ATTACKER) == true ) then
        loop 
            exitwhen i > DisabledSpells_RangeMI
            call DisableSpell(PlayerNumber, DisabledSpells_Range[i])
            set i = i + 1
        endloop
        set i = 0
    endif
    if ( IsUnitType(udg_units01[PlayerNumber], UNIT_TYPE_MELEE_ATTACKER) == true ) then
        loop 
            exitwhen i > DisabledSpells_MeleeMI
            call DisableSpell(PlayerNumber, DisabledSpells_Melee[i])
            set i = i + 1
        endloop
        set i = 0
    endif
endfunction