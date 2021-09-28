library Glory initializer initLState
    globals
        real array Glory
        real array GloryRoundBonus
        framehandle ResPlayer = null
        integer array WinCount
    endglobals

    function ResourseRefresh takes player Pl returns nothing 
        local integer pid = GetPlayerId(Pl)
        local string S = "Glory:  " + I2S(R2I(Glory[pid]))

        if GetLocalPlayer() == Pl then
            call BlzFrameSetText(ResPlayer ,S)
        endif
    endfunction

    function initLState takes nothing returns nothing
        set ResPlayer = BlzGetFrameByName("ResourceBarUpkeepText" , 0)
        set Glory[0] = 0
        set Glory[1] = 0
        set Glory[2] = 0
        set Glory[3] = 0
        set Glory[4] = 0
        set Glory[5] = 0
        set Glory[6] = 0
        set Glory[7] = 0
        set Glory[8] = 0
    endfunction

    function FunWinner takes unit u returns nothing 
        local integer pid = GetPlayerId(GetOwningPlayer(u))

        call ResourseRefresh(GetOwningPlayer(u)) 

        if udg_boolean08 == true then
            if WinCount[pid] != udg_integer02 then
                set Glory[pid] = Glory[pid] + 4000  + ((udg_integer02/5)-1)*2000
                set WinCount[pid] = udg_integer02 
                else
                set Glory[pid] = Glory[pid] + 2000  + ((udg_integer02/5)-1)*1000
            endif
        else
            if WinCount[pid] != udg_integer02 then
                set Glory[pid] = Glory[pid] + 3000  + ((udg_integer02/5)-1)*1000
            set WinCount[pid] = udg_integer02 
                else
                set Glory[pid] = Glory[pid] + 1500  + ((udg_integer02/5)-1)*500
            endif
        endif

        call ResourseRefresh(GetOwningPlayer(u))     
    endfunction
endlibrary