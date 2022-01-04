library DummyId initializer init
    globals
        Table DummyId
        integer dummyIndex = 0
    endglobals

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