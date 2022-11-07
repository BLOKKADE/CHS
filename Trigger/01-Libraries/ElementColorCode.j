library ElementColorCode initializer init
    globals
        string array ClassAbil
    endglobals

    private function init takes nothing returns nothing
        set ClassAbil[Element_Fire] = "[|cffff0000Fire|r]"
        set ClassAbil[Element_Water] = "[|cff00f7ffWater|r]"
        set ClassAbil[Element_Wind] = "[|cffc0c0c0Wind|r]"
        set ClassAbil[Element_Earth] = "[|cffd45e19Earth|r]"
        set ClassAbil[Element_Wild] = "[|cff009600Wild|r]"
        set ClassAbil[Element_Energy] = "[|cff009292Energy|r]"
        set ClassAbil[Element_Dark] = "[|cff000000Dark|r]"
        set ClassAbil[Element_Light] = "[|cffd2d2d2Light|r]"
        set ClassAbil[Element_Cold] = "[|cff8080ffCold|r]"
        set ClassAbil[Element_Poison] = "[|cff3bc739Poison|r]"
        set ClassAbil[Element_Blood] = "[|cff800000Blood|r]"   
        set ClassAbil[Element_Summon] = "[|cff9e5d07Summon|r]"
        set ClassAbil[Element_Arcane] = "[|cff6f2583Arcane|r]"
        
        /*
        set ClassAbil[12] = "[|cffffff96Divinity|r]"
        
        set ClassAbil[14] = "[|cff7a85ffTime|r]"
        set ClassAbil[15] = "[|cffc0dec0Spirit|r]"*/
    endfunction
endlibrary