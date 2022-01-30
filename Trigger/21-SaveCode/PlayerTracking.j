library PlayerTracking initializer init requires OldInitialization
    
    // OldInitialization contains values about what mode is selected
    // AbilityMode -> Pick == 1, AR == 0, Draft == 2
    // udg_boolean16 -> true == Random Hero, false == Pick Hero

    globals
        constant integer CURRENT_GAME_VERSION = 1 // This value needs to have an index value in the game version string lookup
        constant integer MAX_SAVE_VALUE = 9999
        private string array MapVersionLookup
    endglobals

    struct PlayerStats
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
        private integer MapVersion = 0

        // Other
        private boolean HasLoaded = false

        public static method forPlayer takes player p returns thistype
            return thistype(GetPlayerId(p) + 1) // First struct created is 1, not 0
        endmethod

        public method hasLoaded takes nothing returns boolean
            return this.HasLoaded
        endmethod

        public method finishedLoading takes nothing returns nothing
            set this.HasLoaded = true
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
        
        public method getMapVersion takes nothing returns integer
            return this.MapVersion
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

        public method setMapVersion takes integer value returns nothing
            set this.MapVersion = value
        endmethod

        private method tryIncrementValue takes integer currentValue, string valueName returns integer 
            if (currentValue >= MAX_SAVE_VALUE) then
                call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"You have maxed out " + valueName + " at " + I2S(MAX_SAVE_VALUE))
                call DisplayTimedTextToPlayer(GetLocalPlayer(),0,0,30,"Please consider stepping outside for a bit")

                return currentValue
            endif

            return currentValue + 1
        endmethod

        public method addBRWin takes nothing returns nothing
            // Random
            if (AbilityMode == 0) then
                set this.ARBRAllWins = this.tryIncrementValue(this.ARBRAllWins, "All Random Battle Royale All Wins")
                set this.ARBRSeasonWins = this.tryIncrementValue(this.ARBRSeasonWins, "All Random Battle Royale Season Wins")
            // Pick
            elseif (AbilityMode == 1) then
                set this.APBRAllWins = this.tryIncrementValue(this.APBRAllWins, "All Pick Battle Royale All Wins")
                set this.APBRSeasonWins = this.tryIncrementValue(this.APBRSeasonWins, "All Pick Battle Royale Season Wins")
            // Draft
            elseif (AbilityMode == 2) then
                set this.DraftBRAllWins = this.tryIncrementValue(this.DraftBRAllWins, "Draft Battle Royale All Wins")
                set this.DraftBRSeasonWins = this.tryIncrementValue(this.DraftBRSeasonWins, "Draft Battle Royale Season Wins")
            endif
        endmethod

        public method addPVPWin takes nothing returns nothing
            // Random
            if (AbilityMode == 0) then
                set this.ARPVPAllWins = this.tryIncrementValue(this.ARPVPAllWins, "All Random PVP All Wins")
                set this.ARPVPSeasonWins = this.tryIncrementValue(this.ARPVPSeasonWins, "All Random PVP Season Wins")
            // Pick
            elseif (AbilityMode == 1) then
                set this.APPVPAllWins = this.tryIncrementValue(this.APPVPAllWins, "All Pick PVP All Wins")
                set this.APPVPSeasonWins = this.tryIncrementValue(this.APPVPSeasonWins, "All Pick PVP Season Wins")
            // Draft
            elseif (AbilityMode == 2) then
                set this.DraftPVPAllWins = this.tryIncrementValue(this.DraftPVPAllWins, "Draft PVP All Wins")
                set this.DraftPVPSeasonWins = this.tryIncrementValue(this.DraftPVPSeasonWins, "Draft PVP Season Wins")
            endif
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
        if (gameVersion > 0 and MapVersionLookup[gameVersion] != null) then
            return MapVersionLookup[gameVersion]
        endif

        return "Unknown Map Version: " + I2S(gameVersion)
    endfunction

    private function SetupMapVersionLookups takes nothing returns nothing
        set MapVersionLookup[0] = "Invalid Map Version" // Placeholder for default map version
        set MapVersionLookup[1] = "CHS_v1.9.30-beta1" // The first game version that supports save codes
    endfunction

    private function init takes nothing returns nothing
        // Initialize the PlayerStats for each player. Even if they aren't in the game
        local PlayerStats ps = 0

        loop
            set ps = PlayerStats.create()
            exitwhen ps == 12 // A static variable that we should be avoiding
        endloop

        call SetupMapVersionLookups()
    endfunction
endlibrary