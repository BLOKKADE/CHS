library ModeCommand initializer init uses Command, RandomShit, VotingResults

    private function ModeCommandActions takes Args args returns nothing
        call DisplayTimedTextToPlayer(GetTriggerPlayer(),0,0,15, GameDescription)
    endfunction
    
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.ModeCommandActions).name("mode").handles("mode").help("mode", "gets the current game settings")
	endfunction

endlibrary
