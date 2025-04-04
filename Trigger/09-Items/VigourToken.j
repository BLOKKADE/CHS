library VigourToken requires UnitHelpers, ToggleDmgTxt

    function VigourTokenHpLoss takes unit u returns nothing
        local unit p = null
        
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false, Target_Enemy)
            
        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            if GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(p, UNIT_STATE_LIFE) then
                call ShowLoggingText(false, ShowOtherDamageText(u, p, GetUnitState(p, UNIT_STATE_LIFE) * 0.1, "Vigour Token"))
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_LIFE) * 0.1))
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary