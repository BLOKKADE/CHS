library VigourToken

    globals
        group VigourTokenGroup = CreateGroup()
    endglobals

    function VigourTokenHpLoss takes unit u returns nothing
        local unit p = null
        
        call GroupClear(VigourTokenGroup)
        call EnumTargettableUnitsInRange(VigourTokenGroup, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false)
            
        loop
            set p = FirstOfGroup(VigourTokenGroup)
            exitwhen p == null
            if GetUnitState(u, UNIT_STATE_LIFE) < GetUnitState(p, UNIT_STATE_LIFE) then
                call SetUnitState(p, UNIT_STATE_LIFE, GetUnitState(p, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_LIFE) * 0.1))
            endif
            call GroupRemoveUnit(VigourTokenGroup, p)
        endloop
    endfunction
endlibrary