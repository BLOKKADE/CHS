library ElementColorCode initializer init
    globals
        string array ClassAbil
        Table FullElementText
        Table ElementText
        Table ElementColour
    endglobals

    function GetElementColour takes integer elementId returns string
        return ElementColour.string[elementId]
    endfunction

    function GetFullElementText takes integer elementId returns string
        return FullElementText.string[elementId]
    endfunction

    private function SetupElement takes integer elementId, string colourCode, string element returns nothing
        set ElementText.string[elementId] = element
        set ElementColour.string[elementId] = colourCode
        set FullElementText.string[elementId] = "[" + ElementColour.string[elementId] + ElementText.string[elementId] + "|r]"
    endfunction

    private function init takes nothing returns nothing
        set ElementText = Table.create()
        set ElementColour = Table.create()
        set FullElementText = Table.create()

        call SetupElement(Element_Fire, "|cffff0000", "Fire")
        call SetupElement(Element_Water, "|cff00f7ff", "Water")
        call SetupElement(Element_Wind, "|cffc0c0c0", "Wind")
        call SetupElement(Element_Earth, "|cffd45e19", "Earth")
        call SetupElement(Element_Wild, "|cff009600", "Wild")
        call SetupElement(Element_Energy, "|cff009292", "Energy")
        call SetupElement(Element_Dark, "|cff000000", "Dark")
        call SetupElement(Element_Light, "|cffd2d2d2", "Light")
        call SetupElement(Element_Cold, "|cff8080ff", "Cold")
        call SetupElement(Element_Poison, "|cff3bc739", "Poison")
        call SetupElement(Element_Blood, "|cff800000", "Blood")
        call SetupElement(Element_Summon, "|cff9e5d07", "Summon")
        call SetupElement(Element_Arcane, "|cff6f2583", "Arcane")
        
        /*
        set ClassAbil[12] = "[|cffffff96Divinity|r]"
        
        set ClassAbil[14] = "[|cff7a85ffTime|r]"
        set ClassAbil[15] = "[|cffc0dec0Spirit|r]"*/
    endfunction
endlibrary