library DebugCommand initializer init uses Command, RandomShit, PlayerTracking

    private function ToggleDebug takes Args args returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())

        call ps.setDebugEnabled(not ps.isDebugEnabled())

        call DisplayTextToForce(GetForceOfPlayer(GetTriggerPlayer()), "Successfully toggled debug mode for your hero. Your hero's abilities/items will be saved Documents//Warcraft III//CustomMapData//CHS")
    endfunction

	private function init takes nothing returns nothing
		call Command.create(CommandHandler.ToggleDebug).name("debug").handles("debug").help("debug", "Saves the abilities and items of your hero after every wave")
	endfunction

endlibrary
