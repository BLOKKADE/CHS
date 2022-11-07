library GetPlayerNames initializer init
    globals
        string array PlayerName
    endglobals
    
    function GetPlayerNameColour takes player p returns string
        return PlayerName[GetPlayerId(p)]
    endfunction
    
    function GetPlayerNameNoTag takes string playerName returns string
        local integer i = StringLength(playerName)

        loop
            set i = i - 1
            exitwhen i < 0
            if SubString(playerName, i, i + 1) == "#" then
                return SubString(playerName, 0, i)
            endif
        endloop

        return playerName
    endfunction
    
    private function InitializePlayer takes integer pid, string color returns nothing
        set PlayerName[pid] = color + GetPlayerNameNoTag(GetPlayerName(Player(pid))) + "|r"
    endfunction
    
    private function init takes nothing returns nothing
        call InitializePlayer(0, "|c00ff0303")
        call InitializePlayer(1, "|c000042ff")  
        call InitializePlayer(2, "|c001ce6b9")
        call InitializePlayer(3, "|c00540081")
        call InitializePlayer(4, "|c00fffc01")
        call InitializePlayer(5, "|c00ff8000")
        call InitializePlayer(6, "|c0020c000")
        call InitializePlayer(7, "|c00e55bb0")
        call InitializePlayer(8, "|c00959697")
        call InitializePlayer(9, "|c007ebff1")
        call InitializePlayer(10, "|c00106246")
        call InitializePlayer(11, "|c004e2a04")
    endfunction
endlibrary

