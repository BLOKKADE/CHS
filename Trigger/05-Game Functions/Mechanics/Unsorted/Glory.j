library Glory initializer initLState
    globals
        real array Glory
        real array GloryRoundBonus
        framehandle ResPlayer = null
        integer array WinCount
    endglobals

    function SetVersion takes nothing returns nothing
        call BlzFrameSetText(ResPlayer, CurrentGameVersion.getVersionString())
    endfunction

    function ResourseRefresh takes player Pl returns nothing 
        local integer pid = GetPlayerId(Pl)
        local string S = "Glory:  " + I2S(R2I(Glory[pid]))

        if (not BrStarted) and GetLocalPlayer() == Pl then
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

    function GetPlayerGloryBonus takes integer pid returns real
        local real gloryBonus = 0

        //Arena Ring
        set gloryBonus = gloryBonus + ((ArenaMasterMultiplier(PlayerHeroes[pid]) * 100) * GetValidEndOfRoundItems(PlayerHeroes[pid], 'I0AF'))

        //Default bonus
        set gloryBonus = gloryBonus + 200

        //Round bonus (Arena Master)
        set gloryBonus = gloryBonus + GloryRoundBonus[pid]

        return gloryBonus
    endfunction

    function FunWinner takes unit u returns nothing 
        local integer pid = GetPlayerId(GetOwningPlayer(u))

        call ResourseRefresh(GetOwningPlayer(u)) 

        if GameModeShort == true then
            if WinCount[pid] != RoundNumber then
                set Glory[pid] = Glory[pid] + 4000 + ((RoundNumber / 5)- 1)* 2000
                set WinCount[pid] = RoundNumber 
            else
                set Glory[pid] = Glory[pid] + 2000 + ((RoundNumber / 5)- 1)* 1000
            endif
        else
            if WinCount[pid] != RoundNumber then
                set Glory[pid] = Glory[pid] + 3000 + ((RoundNumber / 5)- 1)* 1000
                set WinCount[pid] = RoundNumber 
            else
                set Glory[pid] = Glory[pid] + 1500 + ((RoundNumber / 5)- 1)* 500
            endif
        endif

        call ResourseRefresh(GetOwningPlayer(u))     
    endfunction
endlibrary