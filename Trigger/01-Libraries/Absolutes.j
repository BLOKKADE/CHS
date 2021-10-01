library AbsoluteElements initializer init requires Table
    globals
        Table ElementAbsolutes
        Table AbsoluteElements
    endglobals

    function IsAbsolute takes integer absoluteId returns boolean
        return AbsoluteElements[absoluteId] != 0
    endfunction

    function GetAbsoluteElement takes integer absoluteId returns integer
        return AbsoluteElements[absoluteId]
    endfunction

    function GetElementAbsolute takes integer elementId returns integer
        return ElementAbsolutes[elementId]
    endfunction

    function InitializeAbsolute takes integer elementId, integer absoluteId returns nothing
        set ElementAbsolutes[elementId] = absoluteId
        set AbsoluteElements[absoluteId] = elementId
    endfunction

    private function init takes nothing returns nothing
        set ElementAbsolutes = Table.create()
        set AbsoluteElements = Table.create()

        call InitializeAbsolute(1, 'A07B')
        call InitializeAbsolute(2, 'A07C')
        call InitializeAbsolute(3, 'A07E')
        call InitializeAbsolute(4, 'A07D')
        call InitializeAbsolute(5, 'A07K')

        call InitializeAbsolute(7, 'A07Q')
        call InitializeAbsolute(8, 'A07P')
        call InitializeAbsolute(9, 'A07V')
        call InitializeAbsolute(11, 'A07R')
        call InitializeAbsolute(Element_Arcane, 'A0AB')
        call InitializeAbsolute(Element_Poison, 'A0AC')
    endfunction
endlibrary