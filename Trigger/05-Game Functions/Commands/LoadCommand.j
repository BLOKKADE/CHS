library LoadCommand initializer init uses Command, RandomShit, PlayerTracking, SaveCore, AchievementsFrame, HeroSelector, LoadSaveCommon

    // This is responsible for parsing the input and determining how to load the code
    // An event is fired from the savecode library once it is done loading
    private function LoadRawCode takes Args args returns nothing
        set SaveTempString = SubStringBJ(GetEventPlayerChatString(), 7, 999)
        set SaveTempInt = S2I(SaveTempString)

        if (StringLength(SaveTempString) == 1) then
            // Do nothing?
        else
            if (StringLength(SaveTempString) > 1) then
                set SaveLoadEvent_Code = SaveTempString
                set SaveLoadEvent_Player = GetTriggerPlayer()
                set SaveLoadEvent = 1.00 // We probably don't need to do this? Could probably call LoadCodeValues directly?
                set SaveLoadEvent = 0.00
                return
            else
                set SaveTempInt = 0
            endif
        endif

        if (not File.ReadEnabled) then
            call DisplayTimedTextToPlayer(GetTriggerPlayer(), 0, 0, 60000, LocalFiles_WarningMessage)
        endif

        call LoadSaveSlot(GetTriggerPlayer(), SaveTempInt)
    endfunction
	
    // This is responsible for trying to autoload the player's save file
    // An event is fired from the savecode library once it is done loading
    public function AutoLoadPlayerSaveCode takes player p returns nothing
        if (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING) then
            set SaveTempInt = 0
            set SaveLoadEvent_Player = p
        
            call LoadSaveSlot(p, SaveTempInt)
        endif
    endfunction

    private function LoadNextBasicValue takes integer maxSaveValue returns integer 
        set SaveCount = SaveCount + 1
        set SaveMaxValue[SaveCount] = maxSaveValue
        call SaveHelper.GUILoadNext()
        return SaveValue[SaveCount]
    endfunction

    // Once the code is finally read by the savecode system and parsed, this function gets called
    // The main idea in loading is understanding what values we stored in the SaveCommand
    // We must load the values in the REVERSE order as we saved them
    private function LoadCodeValues takes nothing returns nothing
        local PlayerStats ps = PlayerStats.forPlayer(SaveLoadEvent_Player)
        local boolean resetSeasonStats = false
        local integer hatIndexTemp = 0
        local integer petIndexTemp = 0
        local integer heroIndex = 0
        local integer currentUnitTypeId = 0

        // Don't load anything if the player has already loaded. A player should only need to load once
        if (ps.hasLoaded()) then
            call DisplayTextToForce(GetForceOfPlayer(SaveLoadEvent_Player), "You have already loaded your Save Code.")
            return
        endif

        set SaveCount = -1
        set SaveTempInt = integer(Savecode.create())

        // Try to load the code
        if not (Savecode(SaveTempInt).Load(SaveLoadEvent_Player, SaveLoadEvent_Code, 1)) then
            call DisplayTextToForce(GetForceOfPlayer(SaveLoadEvent_Player), "Invalid load code.")
            return
        endif

        // Load Game Version
        call ps.setMapVersion(LoadNextBasicValue(MAX_SAVE_VALUE))

        // Check if the game version is different. If so, reset current map version values
        if (ps.getMapVersion() != CurrentGameVersion.getVersion()) then
            // Not every version requires a season reset
            if (CurrentGameVersion.shouldResetStats()) then
                // Trying to load a code that is older than the curret version
                if (ps.getMapVersion() < CurrentGameVersion.getVersion()) then
                    call DisplayTimedTextToPlayer(SaveLoadEvent_Player, 0, 0, 10, "Your Save Code is for an older version of CHS. Resetting Season stats.")
                else
                    // Trying to load a code that is newer than the curret version
                    call DisplayTimedTextToPlayer(SaveLoadEvent_Player, 0, 0, 10, "Your Save Code is for a newer version of CHS. Resetting Season stats.")
                endif

                set resetSeasonStats = true
            else
                call DisplayTimedTextToPlayer(SaveLoadEvent_Player, 0, 0, 10, "New map version detected. Resetting Season stats not required.")
            endif

            call DisplayTimedTextToPlayer(SaveLoadEvent_Player, 0, 0, 10, "Current Map Version: " + CurrentGameVersion.getVersionString())
            call DisplayTimedTextToPlayer(SaveLoadEvent_Player, 0, 0, 10, "Your Map Version: " + GetMapVersionName(ps.getMapVersion()))

            // Always set the latest version if it is different
            call ps.setMapVersion(CurrentGameVersion.getVersion())
        endif

        // Load camera settings
        call ps.setCameraZoom(LoadNextBasicValue(MAX_SAVE_VALUE))

        // The camera setting should be saved correct already, but validate against bad values to prevent errors
        if (ps.getCameraZoom() > 0) then
            if (ps.getCameraZoom() > 3000) then
                call SetCameraFieldForPlayer(SaveLoadEvent_Player, CAMERA_FIELD_TARGET_DISTANCE, 3000.00, 0.50)
                set CamDistance[GetPlayerId(SaveLoadEvent_Player)] = 3000
                call ps.setCameraZoom(3000)
            elseif (ps.getCameraZoom() < 1700) then
                set CamDistance[GetPlayerId(SaveLoadEvent_Player)] = 1700
                call SetCameraFieldForPlayer(SaveLoadEvent_Player, CAMERA_FIELD_TARGET_DISTANCE, 1700.00, 0.50)
                call ps.setCameraZoom(1700)
            else 
                call SetCameraFieldForPlayer(SaveLoadEvent_Player, CAMERA_FIELD_TARGET_DISTANCE, I2R(ps.getCameraZoom()), 0.50)
                set CamDistance[GetPlayerId(SaveLoadEvent_Player)] = ps.getCameraZoom()
            endif
        else
            call ps.setCameraZoom(0)
        endif

        // Draft Save Values
        call ps.setDraftPVPSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setDraftBRSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setDraftPVPAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setDraftBRAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))

        // All Random Save Values
        call ps.setARPVPSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setARBRSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setARPVPAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setARBRAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))

        // All Pick Save Values
        call ps.setAPPVPSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setAPBRSeasonWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setAPPVPAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))
        call ps.setAPBRAllWins(LoadNextBasicValue(MAX_SAVE_VALUE))

        call ps.setDiscordAdToggle(LoadNextBasicValue(MAX_SAVE_VALUE))
        set hatIndexTemp = LoadNextBasicValue(MAX_SAVE_VALUE)
        set petIndexTemp = LoadNextBasicValue(MAX_SAVE_VALUE)

        //Discord ad toggle
        if ps.getDiscordAdToggle() > 0 then
            set DiscordAdDisabled[GetPlayerId(SaveLoadEvent_Player)] = true
        endif

        // Indexing for heroes starts at the last index of the first batch we saved
        set heroIndex = FIRST_HERO_SAVE_COUNT

        loop
            // ONLY LOAD THE FIRST CHUNK OF HEROES WHEN THIS WAS ADDED
            // DO ANOTHER LOOP IF ADDITIONAL PROPERTIES ARE ADDED TO THE SAVE CODE IN THE FUTURE
            exitwhen heroIndex == 0

            set currentUnitTypeId = HeroSelectorUnitCode[heroIndex]

            call ps.setHeroPVPWins(currentUnitTypeId, LoadNextBasicValue(MAX_MINIMAL_SAVE_VALUE))
            call ps.setHeroBRWins(currentUnitTypeId, LoadNextBasicValue(MAX_MINIMAL_SAVE_VALUE))

            set heroIndex = heroIndex - 1
        endloop

        if (SubString(SaveLoadEvent_Code, 0, 1) == "n" and LoadNextBasicValue(MAXINT()) != scommhash(GetPlayerName(SaveLoadEvent_Player))) then
            call DisplayTextToForce(GetForceOfPlayer(SaveLoadEvent_Player), "Invalid load code.")
            call ps.reset()
            return
        endif

        // Preset hat. The hat index will get saved in AchievementsFrame_TryToWearHat
        call AchievementsFrame_TryToWearHat(hatIndexTemp, SaveLoadEvent_Player, false)

        // Preset pet. The pet index will get saved in AchievementsFrame_TryToSummonPet
        call AchievementsFrame_TryToSummonPet(petIndexTemp, SaveLoadEvent_Player, false)

        if (resetSeasonStats) then
            call ps.resetSeasonStats()
        endif

        // Flag that the player finished loading
        call ps.finishedLoading()

        call Savecode(SaveTempInt).destroy()

        call DisplayTextToForce(GetForceOfPlayer(SaveLoadEvent_Player), "Successfully loaded your Save Code")
    endfunction

	private function init takes nothing returns nothing
        local trigger syncEventTrigger = CreateTrigger()
        call TriggerRegisterVariableEvent(syncEventTrigger, "SaveLoadEvent", EQUAL, 1.00)
        call TriggerAddAction(syncEventTrigger, function LoadCodeValues)
        set syncEventTrigger = null

		call Command.create(CommandHandler.LoadRawCode).name("load").handles("load").help("load <code>", "loads your progress from your save code")
	endfunction

endlibrary
