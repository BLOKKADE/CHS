library DummyId initializer init
    globals
        Table DummyId
        integer dummyIndex = 1
    endglobals

    function ResetDummyId takes unit u returns nothing
        set DummyId[GetHandleId(u)] = 0
    endfunction

    function SetDummyId takes unit u returns nothing
        set DummyId[GetHandleId(u)] = dummyIndex
        set dummyIndex = dummyIndex + 1
    endfunction

    function GetDummyId takes unit u returns integer
        return DummyId[GetHandleId(u)]
    endfunction

    private function init takes nothing returns nothing
        set DummyId = Table.create()
    endfunction
endlibrary