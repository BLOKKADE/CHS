library ClearCommand initializer init uses Command, RandomShit

    private function Clear takes Args args returns nothing
        if GetLocalPlayer() == GetTriggerPlayer() then
            call ClearTextMessages()
        endif
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.Clear).name("clear").handles("clear").help("clear", "Removes all text from the screen.")
	endfunction

endlibrary
