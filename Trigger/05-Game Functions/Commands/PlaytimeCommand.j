library TimeCommand initializer init uses Command, RandomShit

    private function Time takes Args args returns nothing
        local integer sec = ModuloInteger(T32_Tick, 1920)
        local integer min = ((T32_Tick - sec) / 1920)
        call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 10, "|ccf61fd31Current playtime|r: |ccffafd31" + I2S(min) + " min|r |ccffd9431" + I2S(R2I(sec / 32)) + " sec|r.")
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.Time).name("time").handles("pt").handles("time").help("time", "Displays the current playtime.")
	endfunction

endlibrary
