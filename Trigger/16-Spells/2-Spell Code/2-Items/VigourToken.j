library VigourToken requires UnitHelpers

    function VigourTokenHpLoss takes unit u returns nothing
        local unit p = null
        
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false)
            
        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            if IsUnitEnemy(p, GetOwningPlayer(u)) and GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(p, UNIT_STATE_LIFE) then
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_LIFE) * 0.1))
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary