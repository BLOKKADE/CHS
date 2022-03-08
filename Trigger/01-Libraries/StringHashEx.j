library StringHashEx requires Table

    globals
        private constant integer REHASH = 1222483
        private key tbKey
        private Table t = tbKey //allowed due to the way Table works
    endglobals

    function StringHashEx takes string key returns integer
        local integer sh = StringHash(key)
        loop
            if not t.string.has(sh) then
                set t.string[sh] = key
                exitwhen true
            endif
            exitwhen t.string[sh] == key
            set sh = sh + REHASH
        endloop
        return sh
    endfunction

endlibrary