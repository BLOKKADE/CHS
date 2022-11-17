library ForceHelper requires GetPlayerNames
    
    globals
        private string ForceString
        private boolean IsFirst
        private boolean AreAnyAlive
    endglobals

    private function ConcatPlayerName takes nothing returns nothing
        if (IsFirst) then
            set ForceString = GetPlayerNameColour(GetEnumPlayer())
            set IsFirst = false
        else 
            set ForceString = ForceString + ", " + GetPlayerNameColour(GetEnumPlayer())
        endif
    endfunction

    private function GetPlayerHeroColorName takes nothing returns nothing
        if (IsFirst) then
            set ForceString = GetUnitNamePlayerColour(PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1]) // Stored as converted player id. Rip.
            set IsFirst = false
        else 
            set ForceString = ForceString + ", " + GetUnitNamePlayerColour(PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1]) // Stored as converted player id. Rip.
        endif
    endfunction

    private function CheckIfPlayerUnitIsAlive takes nothing returns nothing
        if (not AreAnyAlive) then
            set AreAnyAlive = IsUnitAliveBJ(PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1]) == true  // Stored as converted player id. Rip.
        endif
    endfunction

    // Converts a force into a comma separated list of colored player names
    function ConvertForceToString takes force playerForce returns string
        set ForceString = ""
        set IsFirst = true

        call ForForce(playerForce, function ConcatPlayerName)

        return ForceString
    endfunction

    // Converts a force into a comma separated list of colored unit names
    function ConvertForceToUnitString takes force playerForce returns string
        set IsFirst = true

        call ForForce(playerForce, function GetPlayerHeroColorName)

        return ForceString
    endfunction

    // Checks if any heroes belonging to the force are alive
    function AreAnyForceUnitsAlive takes force playerForce returns boolean
        set AreAnyAlive = false

        call ForForce(playerForce, function CheckIfPlayerUnitIsAlive)

        return AreAnyAlive
    endfunction

endlibrary