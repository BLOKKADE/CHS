library DebugCode requires RandomShit, OldInitialization

    public function SavePlayerDebug takes player p returns nothing
        local string debugCode = ""
        local integer index = 0
        local string name
        local unit playerHero
        local integer i = 1
        local PlayerStats ps

        if (not (GetPlayerSlotState(p) == PLAYER_SLOT_STATE_PLAYING)) then
            return
        endif

        set ps = PlayerStats.forPlayer(p)

        if (not ps.isDebugEnabled()) then
            return
        endif

        loop

            set playerHero = udg_units01[i] // Get player's hero

            // Make sure the hero was found
            if (playerHero != null) then

                set debugCode = debugCode + GetObjectName(GetUnitTypeId(playerHero)) + "|"

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
                //player seperator
                set debugCode = debugCode + "_"
            endif
            set i = i + 1
            exitwhen i > 8
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