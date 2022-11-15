/*
library RoundRobinTest initializer init uses Command, PvpRoundRobin

    private function UpdatePlayers takes Args args returns nothing
        local integer input = S2I(args[1])
        local integer pid = -1
        if input > 1 then
            set pid = input
        endif
        call UpdatePlayerCount(pid)
        call ListT_print(PlayerList, "PlayerList")

        if pid != -1 then
            call BJDebugMsg("odd: " + I2S(OddPlayer))
        endif
	endfunction

    private function RoundRobin takes Args args returns nothing
        call MoveRoundRobin()
        call ListT_print(PlayerList, "PlayerList")
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.UpdatePlayers).name("UpdatePlayers").handles("up").help("", "")
        call Command.create(CommandHandler.RoundRobin).name("UpdateRoundRobin").handles("rrm").help("", "")
	endfunction

endlibrary
*/