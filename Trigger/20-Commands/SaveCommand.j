library SaveCommand initializer init uses Command, RandomShit, PlayerTracking, SaveCore

    /*
        The main idea in saving is that you save an integer into the `Save` array for every `thing` you want to save
        The value we save only makes sense to us. We can save whatever wacky values as long as we know what they mean when we load the code
        CodeGen has some nice automatic functionality in it. Like saving the player's name to the code, validating the name, and saving to disk

        Example Save Code:
            Save[0] = <game_version>    - Probably defined as some global variable and we update it every version. Validate against this when loading
            Save[1] = 12                - The amount of wins
            Save[2] = 127               - The total amount of wins across versions
    */

    private function SaveNextBasicValue takes integer value returns nothing
        set SaveCount = SaveCount + 1
        set SaveMaxValue[SaveCount] = MAX_SAVE_VALUE
        set SaveValue[SaveCount] = value
    endfunction

    private function SaveCode takes Args args returns nothing
        local integer saveIndex = 0
        local PlayerStats ps = PlayerStats.forPlayer(GetTriggerPlayer())
        set SaveCount = -1 // This must get set to -1 every time we generate a new code

        // All Pick Save Values
        call SaveNextBasicValue(ps.getAPBRAllWins())
        call SaveNextBasicValue(ps.getAPPVPAllWins())
        call SaveNextBasicValue(ps.getAPBRSeasonWins())
        call SaveNextBasicValue(ps.getAPPVPSeasonWins())

        // All Random Save Values
        call SaveNextBasicValue(ps.getARBRAllWins())
        call SaveNextBasicValue(ps.getARPVPAllWins())
        call SaveNextBasicValue(ps.getARBRSeasonWins())
        call SaveNextBasicValue(ps.getARPVPSeasonWins())

        // Draft Save Values
        call SaveNextBasicValue(ps.getDraftBRAllWins())
        call SaveNextBasicValue(ps.getDraftPVPAllWins())
        call SaveNextBasicValue(ps.getDraftBRSeasonWins())
        call SaveNextBasicValue(ps.getDraftPVPSeasonWins())

        // Misc Save Values
        call SaveNextBasicValue(ps.getCameraZoom())
        call SaveNextBasicValue(CURRENT_GAME_VERSION)

        set SaveTempInt = Savecode.create()
        loop
            exitwhen saveIndex > SaveCount
            call Savecode(SaveTempInt).Encode(SaveValue[saveIndex], SaveMaxValue[saveIndex])
            set saveIndex = saveIndex + 1
        endloop

        set SaveTempString = ""
        set SaveTempString = Savecode(SaveTempInt).Save(GetTriggerPlayer(), 1)
        call SaveFile.create(GetTriggerPlayer(), "", -1, SaveTempString)
        
        if (SaveShowCode) then
            set SaveCodeColored = Savecode_colorize(SaveTempString)

            call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,SaveCodeColored)
            call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"Your Save Code has been saved to:")
            call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"Documents//Warcraft III//CustomMapData//CHS")
        endif
	endfunction
	
	private function init takes nothing returns nothing
		call Command.create(CommandHandler.SaveCode).name("save").handles("save").help("save", "saves your current progress")
	endfunction

endlibrary
