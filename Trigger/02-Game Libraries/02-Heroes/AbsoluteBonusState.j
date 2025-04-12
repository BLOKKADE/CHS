library AbsoluteBonusState initializer init requires Table
    globals
        HashTable AbsoluteBonusState
    endglobals

    //Absolute count bonus 100-149
    function SetUnitAbsoluteBonusCount takes unit u,integer id, integer i returns nothing
        set AbsoluteBonusState[GetHandleId(u)].integer[id] = i
    endfunction
    
    function GetUnitAbsoluteBonusCount takes unit u, integer id returns integer
        return AbsoluteBonusState[GetHandleId(u)].integer[id]
     endfunction

     function AddUnitAbsoluteBonusCount takes unit u, integer id, integer i returns nothing
        set AbsoluteBonusState[GetHandleId(u)].integer[id] = GetUnitAbsoluteBonusCount(u, id) + i
     endfunction

    function ResetUnitAbsoluteBonusCount takes unit u returns nothing
        call AbsoluteBonusState.remove(GetHandleId(u))
    endfunction

    private function init takes nothing returns nothing
        set AbsoluteBonusState = HashTable.create()
    endfunction
endlibrary
