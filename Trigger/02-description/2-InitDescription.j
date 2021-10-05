library ElementTexts initializer init
    globals
        string array ClassAbil
    endglobals

    private function init takes nothing returns nothing
        set ClassAbil[1] = "[|cffff0000Fire|r]"
        set ClassAbil[2] = "[|cff00f7ffWater|r]"
        set ClassAbil[3] = "[|cffc0c0c0Wind|r]"
        set ClassAbil[4] = "[|cffd45e19Earth|r]"
        set ClassAbil[5] = "[|cff009600Wild|r]"
        set ClassAbil[6] = "[|cff009292Energy|r]"
        set ClassAbil[7] = "[|cff000000Dark|r]"
        set ClassAbil[8] = "[|cffd2d2d2Light|r]"
        set ClassAbil[9] = "[|cff8080ffCold|r]"
        set ClassAbil[10] = "[|cff3bc739Poison|r]"
        set ClassAbil[11] = "[|cff800000Blood|r]"   

        set ClassAbil[13] = "[|cff6f2583Arcane|r]"
        
        /*
        set ClassAbil[12] = "[|cffffff96Divinity|r]"
        
        set ClassAbil[14] = "[|cff7a85ffTime|r]"
        set ClassAbil[15] = "[|cffc0dec0Spirit|r]"*/
    endfunction
endlibrary