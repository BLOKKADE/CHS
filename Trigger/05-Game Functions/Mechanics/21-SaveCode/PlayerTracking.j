library PlayerTracking initializer init requires GameInit, Table
    
    // GameInit contains values about what mode is selected
    // AbilityMode -> Pick == 1, AR == 0, Draft == 2
    // RandomHeroMode -> true == Random Hero, false == Pick Hero

    globals
        constant integer MAX_SAVE_VALUE = 9999
        constant integer MAX_MINIMAL_SAVE_VALUE = 999

        private GameVersion array MapVersionLookup
        private boolean SaveEnabled
        private integer CurrentGameVersionIndex = 0

        GameVersion CurrentGameVersion
    endglobals

    struct GameVersion
        private boolean ResetStats
        private integer Version
        private string VersionString

        method shouldResetStats takes nothing returns boolean
            return this.ResetStats
        endmethod

        method getVersion takes nothing returns integer
            return this.Version
        endmethod

        method getVersionString takes nothing returns string
            return this.VersionString
        endmethod

        static method create takes string versionString, integer versionId, boolean resetStats returns thistype
            local thistype this = thistype.allocate()
            set this.VersionString = versionString
            set this.Version = versionId
            set this.ResetStats = resetStats

            // Save the latest
            set CurrentGameVersion = this

            return this
        endmethod

    endstruct

    struct PlayerStats
        // --- Values that are actually saved in the save code
        // All Pick Save Values
        private integer APBRAllWins = 0
        private integer APPVPAllWins = 0
        private integer APBRSeasonWins = 0
        private integer APPVPSeasonWins = 0

        // All Random Save Values
        private integer ARBRAllWins = 0
        private integer ARPVPAllWins = 0
        private integer ARBRSeasonWins = 0
        private integer ARPVPSeasonWins = 0

        // Draft Save Values
        private integer DraftBRAllWins = 0
        private integer DraftPVPAllWins = 0
        private integer DraftBRSeasonWins = 0
        private integer DraftPVPSeasonWins = 0

        // Misc Save Values
        private integer CameraZoom = 0
        private integer DiscordAdToggle = 0
        private integer MapVersion = 0

        // Hats
        private integer HatIndex = 0
        private integer PetIndex = 0

        // Hero stats
        private Table HeroBRWins
        private Table HeroPVPWins
        // --- Values that are actually saved in the save code
 
        // --- Temporary values that are not saved to the load code
        private effect CurrentHatEffect = null
        private integer HeroUnitTypeId = 0
        private boolean IsHeroRandom = false
        private boolean DebugEnabled = false
        private boolean HasAchievementsOpen = false
        private boolean HasScoreboardOpen = false
        private boolean HasBattleCreatorOpen = false
        private boolean HasRewardsOpen = false
        private boolean HasLoaded = false
        private boolean IsReady = false
        private unit Pet = null
        private integer PlayerKillCount = 0
        private integer PetLastSwappedAt = 0
        private integer DuelWins = 0 // Duel wins for the current game
        private integer DuelLosses = 0 // Duel losses for the current game
        private integer BRPVPKillCount = 0 // PVP kills during the BR

        static method create takes nothing returns thistype
            local thistype this = thistype.allocate()
            set this.HeroBRWins = Table.create()
            set this.HeroPVPWins = Table.create()

            return this
        endmethod

        method reset takes nothing returns nothing
            call this.HeroBRWins.destroy()
            call this.HeroPVPWins.destroy()

            set this.HeroBRWins = Table.create()
            set this.HeroPVPWins = Table.create()

            // All Pick Save Values
            set this.APBRAllWins = 0
            set this.APPVPAllWins = 0
            set this.APBRSeasonWins = 0
            set this.APPVPSeasonWins = 0
    
            // All Random Save Values
            set this.ARBRAllWins = 0
            set this.ARPVPAllWins = 0
            set this.ARBRSeasonWins = 0
            set this.ARPVPSeasonWins = 0
    
            // Draft Save Values
            set this.DraftBRAllWins = 0
            set this.DraftPVPAllWins = 0
            set this.DraftBRSeasonWins = 0
            set this.DraftPVPSeasonWins = 0
    
            // Misc Save Values
            set this.CameraZoom = 0
            set this.DiscordAdToggle = 0
            set this.MapVersion = 0
    
            // Hats
            set this.HatIndex = 0
            set this.PetIndex = 0

            // Temp values
            call this.setCurrentHatEffect(null)
            call this.setPet(null)
            set HasLoaded = false
        endmethod

        // --- Temporary values that are not saved to the load code

        // Easy helper function to get the PlayerTracking struct of a player
        public static method forPlayer takes player p returns thistype
            return thistype(GetPlayerId(p) + 1) // First struct created is 1, not 0
        endmethod

        public static method getTooltip takes player p returns string
            local thistype ps = thistype.forPlayer(p)
            local string tooltip = ""
            local integer heroUnitTypeId = ps.getHeroUnitTypeId()

            set tooltip = tooltip + "|cffd0ff00All Pick Stats|r"
            set tooltip = tooltip + "|n -Season BR Wins: " + I2S(ps.getAPBRSeasonWins()) + " (" + I2S(ps.getAPBRAllWins()) + " total)"
            set tooltip = tooltip + "|n -Season PVP Wins: " + I2S(ps.getAPPVPSeasonWins()) + " (" + I2S(ps.getAPPVPAllWins()) + " total)"

            set tooltip = tooltip + "|n|cffd0ff00All Random Stats|r"
            set tooltip = tooltip + "|n -Season BR Wins: " + I2S(ps.getARBRSeasonWins()) + " (" + I2S(ps.getARBRAllWins()) + " total)"
            set tooltip = tooltip + "|n -Season PVP Wins: " + I2S(ps.getARPVPSeasonWins()) + " (" + I2S(ps.getARPVPAllWins()) + " total)"

            set tooltip = tooltip + "|n|cffd0ff00Draft Stats|r"
            set tooltip = tooltip + "|n -Season BR Wins: " + I2S(ps.getDraftBRSeasonWins()) + " (" + I2S(ps.getDraftBRAllWins()) + " total)"
            set tooltip = tooltip + "|n -Season PVP Wins: " + I2S(ps.getDraftPVPSeasonWins()) + " (" + I2S(ps.getDraftPVPAllWins()) + " total)"

            if (heroUnitTypeId != 0) then
                set tooltip = tooltip + "|n|n|cff00f7ffCurrent Hero Stats for " + GetObjectName(heroUnitTypeId) + "|r"
                set tooltip = tooltip + "|n -Total BR Wins: " + I2S(ps.getHeroBRWins(heroUnitTypeId))
                set tooltip = tooltip + "|n -Total PVP Wins: " + I2S(ps.getHeroPVPWins(heroUnitTypeId))
                set tooltip = tooltip + "|n -PVP Kills This Game: " + I2S(ps.getPlayerKillCount())
            endif

            return tooltip
        endmethod

        // --- Functions for data that is not actually saved
        public method isDebugEnabled takes nothing returns boolean
            return this.DebugEnabled
        endmethod

        public method hasLoaded takes nothing returns boolean
            return this.HasLoaded
        endmethod

        public method finishedLoading takes nothing returns nothing
            set this.HasLoaded = true
        endmethod

        public method getCurrentHatEffect takes nothing returns effect
            return this.CurrentHatEffect
        endmethod

        public method getPet takes nothing returns unit
            return this.Pet
        endmethod
        
        public method getPetLastSwappedAt takes nothing returns integer
            return this.PetLastSwappedAt
        endmethod

        public method getDuelWins takes nothing returns integer
            return this.DuelWins
        endmethod

        public method getDuelLosses takes nothing returns integer
            return this.DuelLosses
        endmethod

        public method getHeroUnitTypeId takes nothing returns integer
            return this.HeroUnitTypeId
        endmethod

        public method getIsHeroRandom takes nothing returns boolean
            return this.IsHeroRandom
        endmethod

        public method getPlayerKillCount takes nothing returns integer
            return this.PlayerKillCount
        endmethod

        public method setCurrentHatEffect takes effect value returns nothing
            if (value == null) then
                call DestroyEffect(this.CurrentHatEffect)
            endif

            set this.CurrentHatEffect = value
        endmethod

        public method setDebugEnabled takes boolean value returns nothing
            set this.DebugEnabled = value
        endmethod

        public method setPet takes unit value returns nothing
            if (value == null) then
                call KillUnit(this.Pet)
            endif

            set this.Pet = value
        endmethod

        public method setHeroUnitTypeId takes integer heroUnitTypeId, boolean random returns nothing
            set this.HeroUnitTypeId = heroUnitTypeId
            set this.IsHeroRandom = random
        endmethod

        public method setPetLastSwappedAt takes integer value returns nothing
            set this.PetLastSwappedAt = value
        endmethod

        public method toggleHasAchievementsOpen takes nothing returns boolean
            set this.HasAchievementsOpen = not this.HasAchievementsOpen
            return this.HasAchievementsOpen
        endmethod

        public method toggleHasScoreboardOpen takes nothing returns boolean
            set this.HasScoreboardOpen = not this.HasScoreboardOpen
            return this.HasScoreboardOpen
        endmethod

        public method setHasScoreboardOpen takes boolean value returns nothing
            set this.HasScoreboardOpen = value
        endmethod

        public method toggleHasBattleCreatorOpen takes nothing returns boolean
            set this.HasBattleCreatorOpen = not this.HasBattleCreatorOpen
            return this.HasBattleCreatorOpen
        endmethod

        public method setHasBattleCreatorOpen takes boolean value returns nothing
            set this.HasBattleCreatorOpen = value
        endmethod

        public method toggleHasRewardsOpen takes nothing returns boolean
            set this.HasRewardsOpen = not this.HasRewardsOpen
            return this.HasRewardsOpen
        endmethod

        public method setHasRewardsOpen takes boolean value returns nothing
            set this.HasRewardsOpen = value
        endmethod

        public method toggleIsReady takes nothing returns boolean
            set this.IsReady = not this.IsReady
            return this.IsReady
        endmethod
        
        public method setIsReady takes boolean value returns nothing
            set this.IsReady = value
        endmethod

        public method isReady takes nothing returns boolean
            return this.IsReady
        endmethod

        public method getBRPVPKillCount takes nothing returns string
            if (this.BRPVPKillCount == 0) then
                return "no kills!"
            elseif (this.BRPVPKillCount == 1) then
                return "1 kill!"
            endif

            return I2S(this.BRPVPKillCount) + " kills!"
        endmethod

        public method addDuelWin takes nothing returns nothing
            set this.DuelWins = this.DuelWins + 1
        endmethod

        public method addDuelLoss takes nothing returns nothing
            set this.DuelLosses = this.DuelLosses + 1
        endmethod

        public method resetBRPVPKillCount takes nothing returns nothing
            set this.BRPVPKillCount = 0
        endmethod

        // --- Functions for data that is not actually saved

        // --- Functions for data that is actually saved

        public method addBRPVPKill takes nothing returns nothing
            set this.BRPVPKillCount = this.BRPVPKillCount + 1
        endmethod

        public method getAllBRWins takes nothing returns integer
            // Random
            if (AbilityMode == 0) then
                return this.ARBRAllWins
            // Pick
            elseif (AbilityMode == 1) then
                return this.APBRAllWins
            // Draft
            elseif (AbilityMode == 2) then
                return this.DraftBRAllWins
            endif

            return 0 // Shouldn't ever happen?
        endmethod

        public method getSeasonBRWins takes nothing returns integer
            // Random
            if (AbilityMode == 0) then
                return this.ARBRSeasonWins
            // Pick
            elseif (AbilityMode == 1) then
                return this.APBRSeasonWins
            // Draft
            elseif (AbilityMode == 2) then
                return this.DraftBRSeasonWins
            endif

            return 0 // Shouldn't ever happen?
        endmethod

        public method getAllPVPWins takes nothing returns integer
            // Random
            if (AbilityMode == 0) then
                return this.ARPVPAllWins
            // Pick
            elseif (AbilityMode == 1) then
                return this.APPVPAllWins
            // Draft
            elseif (AbilityMode == 2) then
                return this.DraftPVPAllWins
            endif

            return 0 // Shouldn't ever happen?
        endmethod

        public method getSeasonPVPWins takes nothing returns integer
            // Random
            if (AbilityMode == 0) then
                return this.ARPVPSeasonWins
            // Pick
            elseif (AbilityMode == 1) then
                return this.APPVPSeasonWins
            // Draft
            elseif (AbilityMode == 2) then
                return this.DraftPVPSeasonWins
            endif

            return 0 // Shouldn't ever happen?
        endmethod

        public method getAPBRAllWins takes nothing returns integer
            return this.APBRAllWins
        endmethod

        public method getAPPVPAllWins takes nothing returns integer
            return this.APPVPAllWins
        endmethod

        public method getAPBRSeasonWins takes nothing returns integer
            return this.APBRSeasonWins
        endmethod

        public method getAPPVPSeasonWins takes nothing returns integer
            return this.APPVPSeasonWins
        endmethod

        public method getARBRAllWins takes nothing returns integer
            return this.ARBRAllWins
        endmethod

        public method getARPVPAllWins takes nothing returns integer
            return this.ARPVPAllWins
        endmethod

        public method getARBRSeasonWins takes nothing returns integer
            return this.ARBRSeasonWins
        endmethod

        public method getARPVPSeasonWins takes nothing returns integer
            return this.ARPVPSeasonWins
        endmethod

        public method getDraftBRAllWins takes nothing returns integer
            return this.DraftBRAllWins
        endmethod

        public method getDraftPVPAllWins takes nothing returns integer
            return this.DraftPVPAllWins
        endmethod

        public method getDraftBRSeasonWins takes nothing returns integer
            return this.DraftBRSeasonWins
        endmethod

        public method getDraftPVPSeasonWins takes nothing returns integer
            return this.DraftPVPSeasonWins
        endmethod

        public method getCameraZoom takes nothing returns integer
            return this.CameraZoom
        endmethod

        public method getDiscordAdToggle takes nothing returns integer
            return this.DiscordAdToggle
        endmethod
        
        public method getHeroBRWins takes integer unitCode returns integer
            return this.HeroBRWins[unitCode]
        endmethod

        public method getHeroPVPWins takes integer unitCode returns integer
            return this.HeroPVPWins[unitCode]
        endmethod

        public method getMapVersion takes nothing returns integer
            return this.MapVersion
        endmethod

        public method getHatIndex takes nothing returns integer
            return this.HatIndex
        endmethod

        public method getPetIndex takes nothing returns integer
            return this.PetIndex
        endmethod

        public method setAPBRAllWins takes integer value returns nothing
            set this.APBRAllWins = value
        endmethod

        public method setAPPVPAllWins takes integer value returns nothing
            set this.APPVPAllWins = value
        endmethod

        public method setAPBRSeasonWins takes integer value returns nothing
            set this.APBRSeasonWins = value
        endmethod

        public method setAPPVPSeasonWins takes integer value returns nothing
            set this.APPVPSeasonWins = value
        endmethod
        
        public method setARBRAllWins takes integer value returns nothing
            set this.ARBRAllWins = value
        endmethod

        public method setARPVPAllWins takes integer value returns nothing
            set this.ARPVPAllWins = value
        endmethod

        public method setARBRSeasonWins takes integer value returns nothing
            set this.ARBRSeasonWins = value
        endmethod

        public method setARPVPSeasonWins takes integer value returns nothing
            set this.ARPVPSeasonWins = value
        endmethod

        public method setDraftBRAllWins takes integer value returns nothing
            set this.DraftBRAllWins = value
        endmethod

        public method setDraftPVPAllWins takes integer value returns nothing
            set this.DraftPVPAllWins = value
        endmethod

        public method setDraftBRSeasonWins takes integer value returns nothing
            set this.DraftBRSeasonWins = value
        endmethod
        
        public method setDraftPVPSeasonWins takes integer value returns nothing
            set this.DraftPVPSeasonWins = value
        endmethod

        public method setCameraZoom takes integer value returns nothing
            set this.CameraZoom = value
        endmethod

        public method setDiscordAdToggle takes integer value returns nothing
            set this.DiscordAdToggle = value
        endmethod

        public method setHeroBRWins takes integer unitCode, integer value returns nothing
            set this.HeroBRWins[unitCode] = value
        endmethod

        public method setHeroPVPWins takes integer unitCode, integer value returns nothing
            set this.HeroPVPWins[unitCode] = value
        endmethod

        public method setMapVersion takes integer value returns nothing
            set this.MapVersion = value
        endmethod

        public method setHatIndex takes integer value returns nothing
            set this.HatIndex = value
        endmethod

        public method setPetIndex takes integer value returns nothing
            set this.PetIndex = value
        endmethod
        // --- Functions for data that is actually saved

        private method tryIncrementValue takes integer currentValue, string valueName, integer maxSaveValue returns integer 
            if (currentValue >= maxSaveValue) then
                // TODO maybe reenable one day
                // call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"You have maxed out " + valueName + " at " + I2S(MAX_SAVE_VALUE))
                // call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"Please consider stepping outside for a bit")

                return currentValue
            endif

            return currentValue + 1
        endmethod

        public method addBRWin takes nothing returns nothing
            // Random
            if (AbilityMode == 0) then
                set this.ARBRAllWins = this.tryIncrementValue(this.ARBRAllWins, "All Random BR All Wins", MAX_SAVE_VALUE)
                set this.ARBRSeasonWins = this.tryIncrementValue(this.ARBRSeasonWins, "All Random BR Season Wins", MAX_SAVE_VALUE)
            // Pick
            elseif (AbilityMode == 1) then
                set this.APBRAllWins = this.tryIncrementValue(this.APBRAllWins, "All Pick BR All Wins", MAX_SAVE_VALUE)
                set this.APBRSeasonWins = this.tryIncrementValue(this.APBRSeasonWins, "All Pick BR Season Wins", MAX_SAVE_VALUE)
            // Draft
            elseif (AbilityMode == 2) then
                set this.DraftBRAllWins = this.tryIncrementValue(this.DraftBRAllWins, "Draft BR All Wins", MAX_SAVE_VALUE)
                set this.DraftBRSeasonWins = this.tryIncrementValue(this.DraftBRSeasonWins, "Draft BR Season Wins", MAX_SAVE_VALUE)
            endif

            set HeroBRWins[this.HeroUnitTypeId] = this.tryIncrementValue(HeroBRWins[this.HeroUnitTypeId], "Hero BR Wins", MAX_MINIMAL_SAVE_VALUE)
        endmethod

        public method addPlayerKill takes nothing returns nothing
            set PlayerKillCount = PlayerKillCount + 1
        endmethod

        public method addPVPWin takes nothing returns nothing
            // Random
            if (AbilityMode == 0) then
                set this.ARPVPAllWins = this.tryIncrementValue(this.ARPVPAllWins, "All Random PVP All Wins", MAX_SAVE_VALUE)
                set this.ARPVPSeasonWins = this.tryIncrementValue(this.ARPVPSeasonWins, "All Random PVP Season Wins", MAX_SAVE_VALUE)
            // Pick
            elseif (AbilityMode == 1) then
                set this.APPVPAllWins = this.tryIncrementValue(this.APPVPAllWins, "All Pick PVP All Wins", MAX_SAVE_VALUE)
                set this.APPVPSeasonWins = this.tryIncrementValue(this.APPVPSeasonWins, "All Pick PVP Season Wins", MAX_SAVE_VALUE)
            // Draft
            elseif (AbilityMode == 2) then
                set this.DraftPVPAllWins = this.tryIncrementValue(this.DraftPVPAllWins, "Draft PVP All Wins", MAX_SAVE_VALUE)
                set this.DraftPVPSeasonWins = this.tryIncrementValue(this.DraftPVPSeasonWins, "Draft PVP Season Wins", MAX_SAVE_VALUE)
            endif

            set HeroPVPWins[this.HeroUnitTypeId] = this.tryIncrementValue(HeroPVPWins[this.HeroUnitTypeId], "Hero PVP Wins", MAX_MINIMAL_SAVE_VALUE)
        endmethod

        method shouldResetStats takes nothing returns boolean
            // Assuming we only ever increase versions by one.. which we should
            local integer startIndex = this.getMapVersion() + 1

            loop
                exitwhen startIndex > CurrentGameVersion.getVersion()

                if (MapVersionLookup[startIndex].shouldResetStats()) then
                    return true
                endif

                set startIndex = startIndex + 1
            endloop

            return false
        endmethod

        public method resetSeasonStats takes nothing returns nothing
            // All Pick Season Save Values
            set this.APBRSeasonWins = 0
            set this.APPVPSeasonWins = 0

            // All Random Season Save Values
            set this.ARBRSeasonWins = 0
            set this.ARPVPSeasonWins = 0

            // Draft Season Save Values
            set this.DraftBRSeasonWins = 0
            set this.DraftPVPSeasonWins = 0
        endmethod
    endstruct

    function GetMapVersionName takes integer gameVersion returns string
        if (gameVersion > 0 and MapVersionLookup[gameVersion] != 0) then
            return MapVersionLookup[gameVersion].getVersionString()
        endif

        return "Unknown Map Version: " + I2S(gameVersion)
    endfunction

    function IsSavingEnabled takes nothing returns boolean
        return SaveEnabled
    endfunction

    private function AddGameVersion takes string versionString, boolean resetStats returns nothing
        set MapVersionLookup[CurrentGameVersionIndex] = GameVersion.create(versionString, CurrentGameVersionIndex, resetStats)
        set CurrentGameVersionIndex = CurrentGameVersionIndex + 1
    endfunction

    private function SetupMapVersionLookups takes nothing returns nothing
        // The array index should match the version input to GameVersion.Create(). index == version for GetMapVersionName()
        call AddGameVersion("Invalid Map Version", false) // Placeholder for default map version
        call AddGameVersion("CHS_v1.9.30-beta1", false) // The first game version that supports save codes
        call AddGameVersion("CHS v2.0.2", true) // First version to reset seasonal stats. Had major balancing changes
        // CHS v2.0.3 is missing because we didn't have the GameVersion framework yet. Would have caused a seasonal stat reset otherwise
        call AddGameVersion("CHS v2.1.1", false) // First version with new GameVersion struct
        call AddGameVersion("CHS v2.1.2", false) // Scoreboard desync fix version
        call AddGameVersion("CHS v2.2.0", false) // Scoreboard desync fix version
        call AddGameVersion("CHS v2.2.1", false) // Bunch of small fixes in this one
        call AddGameVersion("CHS v2.2.2", false) // Removed gold and other stuff :)
        call AddGameVersion("CHS v2.2.3", false) // Bugfixes
        call AddGameVersion("CHS v2.3.0", true) // New save system, new map terrain
        call AddGameVersion("CHS v2.3.1", false) // ankh and reincarnation bugfixes
        call AddGameVersion("CHS v2.3.2", false) // ankh and reincarnation bugfixes
        call AddGameVersion("CHS v2.3.3", true) // Reset season fix
        call AddGameVersion("CHS v2.3.4", true) // Draft random fix
        call AddGameVersion("CHS v2.3.5", false) // Ban/Draft fix
        call AddGameVersion("CHS v2.3.6", false) // Another Ban/Draft fix
        call AddGameVersion("CHS v2.4.0", false) // Draws, fixes, live ui
        call AddGameVersion("CHS v2.4.1", true) // Draws, fixes, live ui
        call AddGameVersion("CHS v2.4.2", true) // bugfixes
    endfunction

    private function init takes nothing returns nothing
        local PlayerStats ps = 0
        local force computerPlayers = GetPlayersByMapControl(MAP_CONTROL_COMPUTER)

        // Initialize the PlayerStats for each player. Even if they aren't in the game
        loop
            set ps = PlayerStats.create()
            exitwhen ps == 12 // A static variable that we should be avoiding
        endloop

        set SaveEnabled = CountPlayersInForceBJ(computerPlayers) == 1 // Player 12 = Computer AI

        // Map version stuff
        call SetupMapVersionLookups()

        // Cleanup
        call DestroyForce(computerPlayers)
        set computerPlayers = null
    endfunction

endlibrary