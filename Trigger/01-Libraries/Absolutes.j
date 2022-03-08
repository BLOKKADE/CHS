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

        call InitializeAbsolute(1, ABSOLUTE_FIRE_ABILITY_ID)
        call InitializeAbsolute(2, ABSOLUTE_WATER_ABILITY_ID)
        call InitializeAbsolute(3, ABSOLUTE_WIND_ABILITY_ID)
        call InitializeAbsolute(4, ABSOLUTE_EARTH_ABILITY_ID)
        call InitializeAbsolute(5, ABSOLUTE_WILD_ABILITY_ID)

        call InitializeAbsolute(7, ABSOLUTE_DARK_ABILITY_ID)
        call InitializeAbsolute(8, ABSOLUTE_LIGHT_ABILITY_ID)
        call InitializeAbsolute(9, ABSOLUTE_COLD_ABILITY_ID)
        call InitializeAbsolute(11, ABSOLUTE_BLOOD_ABILITY_ID)
        call InitializeAbsolute(Element_Arcane, ABSOLUTE_ARCANE_ABILITY_ID)
        call InitializeAbsolute(Element_Poison, ABSOLUTE_POISON_ABILITY_ID)
    endfunction
endlibrary