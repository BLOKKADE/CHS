library MightRune requires Utility
    function MightRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local real power = GLOB_RUNE_POWER 
        call SetHeroStr(u, GetHeroStr(u, false) + R2I(5 * power), true)
        call SetHeroAgi(u, GetHeroAgi(u, false) + R2I(5 * power), true)
        call SetHeroInt(u, GetHeroInt(u, false) + R2I(5 * power), true)
        set u = null
        return false
    endfunction
endlibrary