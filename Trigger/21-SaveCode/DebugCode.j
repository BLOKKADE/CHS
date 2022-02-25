library DebugCode requires RandomShit, OldInitialization

    public function SavePlayerDebug takes player p returns nothing
        local string debugCode = ""
        local integer index = 0
        local string name
        local unit playerHero
        local PlayerStats ps

        if (not (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING)) then
            return
        endif

        set ps = PlayerStats.forPlayer(p)

        if (not ps.isDebugEnabled()) then
            return
        endif

        set playerHero = udg_units01[GetPlayerId(p) + 1] // Get player's hero

        // Make sure the hero was found
        if (playerHero == null) then
            call DisplayTimedTextToPlayer(p,0,0,30,"Unable to find your hero to create a debug save file for")
            return
        endif

        set debugCode = GetObjectName(GetUnitTypeId(playerHero)) + "|"

        // Save the abilities
        loop
            set name = GetObjectName(GetInfoHeroSpell(playerHero, index))

            if (name == "Default string") then
                set debugCode = debugCode + "NA|"
            else
                set debugCode = debugCode + name + "|"
            endif

            // Go to the next spell
            set index = index + 1
            exitwhen index == 20
        endloop

        // Save the items
        set index = 0
        loop
            set name = GetObjectName(GetItemTypeId(UnitItemInSlot(playerHero, index)))

            if (name == "Default string") then
                set debugCode = debugCode + "NA"
            else
                set debugCode = debugCode + name
            endif

            // Go to the next item
            set index = index + 1
            exitwhen index > 5

            // Add a separator
            set debugCode = debugCode + "|"
        endloop

        call SaveFile.create(p, "", 1, debugCode)

        // Cleanup
        set playerHero = null
    endfunction

    private function SavePlayerDebugEveryoneEnum takes nothing returns nothing
        call SavePlayerDebug(GetEnumPlayer())
    endfunction

    public function SavePlayerDebugEveryone takes nothing returns nothing
        // Save everyones codes
        call ForForce(GetPlayersAll(), function SavePlayerDebugEveryoneEnum)
    endfunction

endlibrary