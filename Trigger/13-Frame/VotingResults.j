/*
    The entire voting system could probably be better. 
    Could probably just store all votes in a single array using the index from the voting screen, but it's more dependent then.
    This results in having to use a lot of arrays to count the cotes from every player.
    Oh well. It works.
*/
library VotingResults initializer init

    globals
        integer RoundMode
        integer AbilityMode
        integer HeroMode
        integer IncomeMode
        integer ImmortalMode
        integer PvpBettingMode
        integer HeroBanningMode
        string GameDescription

        // Counts for each type of vote. Used so that we don't need to hardcode indexes or something
        integer RoundButtonCount = 0
        integer AbilityButtonCount = 0
        integer HeroButtonCount = 0
        integer IncomeButtonCount = 0

        // Temporary variables because vjass can't accept an array as a parameter
        private integer array CategoryVotes
    endglobals

    struct PlayerVotes
        private integer RoundVote = 1 // 25 rounds
        private integer AbilityVote = 1 // Pick
        private integer HeroVote = 1 // Pick
        private integer IncomeVote = 1 // Individual
        private integer ImmortalVote = 1 // Normal lives
        private integer PvpBettingVote = 1 // No betting
        private integer HeroBanningVote = 1 // No banning

        public method setRoundVote takes integer value returns nothing 
            set this.RoundVote = value
        endmethod

        public method setAbilityVote takes integer value returns nothing 
            set this.AbilityVote = value
        endmethod

        public method setHeroVote takes integer value returns nothing 
            set this.HeroVote = value
        endmethod

        public method setIncomeVote takes integer value returns nothing 
            set this.IncomeVote = value
        endmethod

        public method setImmortalVote takes integer value returns nothing 
            set this.ImmortalVote = value
        endmethod

        public method setPvpBettingVote takes integer value returns nothing 
            set this.PvpBettingVote = value
        endmethod
        
        public method setHeroBanningVote takes integer value returns nothing 
            set this.HeroBanningVote = value
        endmethod

        public method getRoundVote takes nothing returns integer 
            return this.RoundVote
        endmethod

        public method getAbilityVote takes nothing returns integer 
            return this.AbilityVote
        endmethod

        public method getHeroVote takes nothing returns integer 
            return this.HeroVote
        endmethod

        public method getIncomeVote takes nothing returns integer 
            return this.IncomeVote
        endmethod

        public method getImmortalVote takes nothing returns integer 
            return this.ImmortalVote
        endmethod

        public method getPvpBettingVote takes nothing returns integer 
            return this.PvpBettingVote
        endmethod

        public method getHeroBanningVote takes nothing returns integer 
            return this.HeroBanningVote
        endmethod
    endstruct

    public function SetGameModeDescription takes nothing returns nothing
        set GameDescription = "|cffe9820dGame Mode: "

        if (RoundMode == 1) then
            set GameDescription = GameDescription + "50 Rounds, "
        elseif (RoundMode == 2) then
            set GameDescription = GameDescription + "25 Rounds, "
        endif

        if (AbilityMode == 1) then
            set GameDescription = GameDescription + "Pick Abilities, "
        elseif (AbilityMode == 2) then
            set GameDescription = GameDescription + "Random Abilities, "
        elseif (AbilityMode == 3) then
            set GameDescription = GameDescription + "Draft Abilities, "
        endif

        if (HeroMode == 1) then
            set GameDescription = GameDescription + "Pick Hero, "
        elseif (HeroMode == 2) then
            set GameDescription = GameDescription + "Random Hero, "
        elseif (HeroMode == 3) then
            set GameDescription = GameDescription + "Draft Hero, "
        elseif (HeroMode == 4) then
            set GameDescription = GameDescription + "Same-Draft Hero, "
        endif

        if (IncomeMode == 1) then
            set GameDescription = GameDescription + "Auto-Eco Income, "
        elseif (IncomeMode == 2) then
            set GameDescription = GameDescription + "Individual Income, "
        elseif (IncomeMode == 3) then
            set GameDescription = GameDescription + "Global Income, "
        elseif (IncomeMode == 4) then
            set GameDescription = GameDescription + "Disabled Income, "
        endif

        if (ImmortalMode == 1) then
            set GameDescription = GameDescription + "Mortal Mode, "
        elseif (ImmortalMode == 2) then
            set GameDescription = GameDescription + "Immortal Mode, "
        endif

        if (PvpBettingMode == 1) then
            set GameDescription = GameDescription + "PVP Betting Off, "
        elseif (PvpBettingMode == 2) then
            set GameDescription = GameDescription + "PVP Betting On, "
        endif

        if (HeroBanningMode == 1) then
            set GameDescription = GameDescription + "Hero Banning Off"
        elseif (HeroBanningMode == 2) then
            set GameDescription = GameDescription + "Hero Banning On"
        endif

        set GameDescription = GameDescription + "|r"
    endfunction

    private function GetMaxValueInVoteCounts takes integer modeOptionCount returns integer
        local integer i = 1
        local integer currentMaxValue = CategoryVotes[0] // Max value is the first value to start

        loop
            if (CategoryVotes[i] > currentMaxValue) then
                set currentMaxValue = CategoryVotes[i]
            endif

            set i = i + 1

            exitwhen i > modeOptionCount
        endloop

        return currentMaxValue
    endfunction

    private function GetVoteFromAnyDuplicates takes integer modeOptionCount returns integer
        local integer i = 1 // Index for outer loop
        local integer j = 1 // Index for inner loop
        local integer array duplicateValueIndexes
        local integer duplicateValueIndexesCount = 0
        local integer currentCount
        local integer maxValueToCount = GetMaxValueInVoteCounts(modeOptionCount)
        local integer defaultVoteIndex = 0

        loop
            // Get the next element in the category counts
            set currentCount = CategoryVotes[i]

            // Only want duplicate values of the max value
            if (currentCount == maxValueToCount) then
                // Save a default value for the first max value index
                if (defaultVoteIndex == 0) then
                    set defaultVoteIndex = i
                endif

                // Check if there are any other values that are the same
                loop
                    if (j != i and CategoryVotes[i] == CategoryVotes[j]) then
                        set duplicateValueIndexes[duplicateValueIndexesCount] = i
                        set duplicateValueIndexesCount = duplicateValueIndexesCount + 1
                    endif

                    set j = j + 1
        
                    exitwhen j > modeOptionCount
                endloop
            endif

            set i = i + 1
            set j = 0

            exitwhen i > modeOptionCount
        endloop

        // Choose a random index from the duplicate count array
        if (duplicateValueIndexesCount > 1) then
            return duplicateValueIndexes[GetRandomInt(0, duplicateValueIndexesCount - 1)]
        else
            return defaultVoteIndex
        endif
    endfunction

    public function CountVotes takes nothing returns nothing
        local integer array roundModeCounts
        local integer array abilityModeCounts
        local integer array heroModeCounts
        local integer array incomeModeCounts
        local integer array immortalModeCounts
        local integer array pvpBettingModeCounts
        local integer array heroBanningModeCounts
        local PlayerVotes currentPlayerVotes
        local integer i = 0

        loop
            // Only count votes from players actually in the game
            if GetPlayerSlotState(Player(i)) == PLAYER_SLOT_STATE_PLAYING and (udg_boolean15 == true or Player(i) == udg_player03) then
                set currentPlayerVotes = PlayerVotes(i + 1) // Start at 1

                // Count the votes for each category
                set roundModeCounts[currentPlayerVotes.getRoundVote()] = roundModeCounts[currentPlayerVotes.getRoundVote()] + 1
                set abilityModeCounts[currentPlayerVotes.getAbilityVote()] = abilityModeCounts[currentPlayerVotes.getAbilityVote()] + 1
                set heroModeCounts[currentPlayerVotes.getHeroVote()] = heroModeCounts[currentPlayerVotes.getHeroVote()] + 1
                set incomeModeCounts[currentPlayerVotes.getIncomeVote()] = incomeModeCounts[currentPlayerVotes.getIncomeVote()] + 1
                set immortalModeCounts[currentPlayerVotes.getImmortalVote()] = immortalModeCounts[currentPlayerVotes.getImmortalVote()] + 1
                set pvpBettingModeCounts[currentPlayerVotes.getPvpBettingVote()] = pvpBettingModeCounts[currentPlayerVotes.getPvpBettingVote()] + 1
                set heroBanningModeCounts[currentPlayerVotes.getHeroBanningVote()] = heroBanningModeCounts[currentPlayerVotes.getHeroBanningVote()] + 1
            endif

            set i = i + 1

            exitwhen i == 8
        endloop

        // Round vote counting
        set i = 1
        loop
            set CategoryVotes[i] = roundModeCounts[i]
            set i = i + 1
            exitwhen i > RoundButtonCount
        endloop
        set RoundMode = GetVoteFromAnyDuplicates(RoundButtonCount)

        // Ability vote counting
        set i = 1
        loop
            set CategoryVotes[i] = abilityModeCounts[i]
            set i = i + 1
            exitwhen i > AbilityButtonCount
        endloop
        set AbilityMode = GetVoteFromAnyDuplicates(AbilityButtonCount)

        // Hero vote counting
        set i = 1
        loop
            set CategoryVotes[i] = heroModeCounts[i]
            set i = i + 1
            exitwhen i > HeroButtonCount
        endloop
        set HeroMode = GetVoteFromAnyDuplicates(HeroButtonCount)

        // Income vote counting
        set i = 1
        loop
            set CategoryVotes[i] = incomeModeCounts[i]
            set i = i + 1
            exitwhen i > IncomeButtonCount
        endloop
        set IncomeMode = GetVoteFromAnyDuplicates(IncomeButtonCount)

        // Immortal vote counting
        set i = 1
        loop
            set CategoryVotes[i] = immortalModeCounts[i]
            set i = i + 1
            exitwhen i > 2
        endloop
        set ImmortalMode = GetVoteFromAnyDuplicates(2) // Only 2 options for a checkbox

        // Pvp betting vote counting
        set i = 1
        loop
            set CategoryVotes[i] = pvpBettingModeCounts[i]
            set i = i + 1
            exitwhen i > 2
        endloop
        set PvpBettingMode = GetVoteFromAnyDuplicates(2) // Only 2 options for a checkbox

        // Hero banning vote counting
        set i = 1
        loop
            set CategoryVotes[i] = heroBanningModeCounts[i]
            set i = i + 1
            exitwhen i > 2
        endloop
        set HeroBanningMode = GetVoteFromAnyDuplicates(2) // Only 2 options for a checkbox

        // Set the weird global variables based off of the results
        set udg_boolean08 = RoundMode == 2 // Boolean that flags if the game is short
        //set ElimModeEnabled = ImmortalMode == 1 // Boolean that flags if people should lose lives
        set ModeNoDeath = ImmortalMode == 2 // Another legacy variable to set to prevent breaking everything
        //set udg_boolean07 = false

        call SetGameModeDescription()
    endfunction

    private function init takes nothing returns nothing
        local integer i = 0

        // Create a struct for all human players 0-7
        loop
            call PlayerVotes.create()

            set i = i + 1

            exitwhen i == 8
        endloop
    endfunction

endlibrary