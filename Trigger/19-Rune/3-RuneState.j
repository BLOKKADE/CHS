globals 
    unit GLOB_RUNE_U = null
    real GLOB_RUNE_POWER = 0

endglobals


function GetRuneOwner takes item i returns player
    return Player(0)
endfunction


function GetRunePower takes item i returns real 
    return 1. + LoadReal(HT,GetHandleId(i),2)/100
endfunction