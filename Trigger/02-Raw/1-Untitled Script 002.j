library Raw2s initializer InitStringArray

    globals
        string array sOutput
    endglobals

    function InitStringArray takes nothing returns nothing
        set sOutput['0'] = "0"
        set sOutput['1'] = "1"
        set sOutput['2'] = "2"
        set sOutput['3'] = "3"
        set sOutput['4'] = "4"
        set sOutput['5'] = "5"
        set sOutput['6'] = "6"
        set sOutput['7'] = "7"
        set sOutput['8'] = "8"
        set sOutput['9'] = "9"
        set sOutput['a'] = "a"
        set sOutput['b'] = "b"
        set sOutput['c'] = "c"        
        set sOutput['d'] = "d"
        set sOutput['e'] = "e"
        set sOutput['f'] = "f"
        set sOutput['g'] = "g"
        set sOutput['h'] = "h"
        set sOutput['i'] = "i"
        set sOutput['j'] = "j"
        set sOutput['k'] = "k"
        set sOutput['l'] = "l"
        set sOutput['m'] = "m"
        set sOutput['n'] = "n"
        set sOutput['o'] = "o"
        set sOutput['p'] = "p"
        set sOutput['q'] = "q"
        set sOutput['r'] = "r"
        set sOutput['s'] = "s"
        set sOutput['t'] = "t"
        set sOutput['u'] = "u"
        set sOutput['v'] = "v"
        set sOutput['w'] = "w"
        set sOutput['x'] = "x"
        set sOutput['y'] = "y"
        set sOutput['z'] = "z"
        set sOutput['A'] = "A"
        set sOutput['B'] = "B"
        set sOutput['C'] = "C"
        set sOutput['D'] = "D"
        set sOutput['E'] = "E"
        set sOutput['F'] = "F"
        set sOutput['G'] = "G"
        set sOutput['H'] = "H"
        set sOutput['I'] = "I"
        set sOutput['J'] = "J"
        set sOutput['K'] = "K"
        set sOutput['L'] = "L"
        set sOutput['M'] = "M"
        set sOutput['N'] = "N"
        set sOutput['O'] = "O"
        set sOutput['P'] = "P"
        set sOutput['Q'] = "Q"
        set sOutput['R'] = "R"
        set sOutput['S'] = "S"
        set sOutput['T'] = "T"
        set sOutput['U'] = "U"
        set sOutput['V'] = "V"
        set sOutput['W'] = "W"
        set sOutput['X'] = "X"
        set sOutput['Y'] = "Y"
        set sOutput['Z'] = "Z"
    endfunction

    function raw2s takes integer raw returns string
        local string s = ""   
        loop
            set s = sOutput[raw-(raw/256)*256] + s
            set raw = raw/256
        exitwhen raw==0
        endloop    
        return s
    endfunction

endlibrary