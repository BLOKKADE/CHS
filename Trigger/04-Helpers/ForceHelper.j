library ForceHelper
    
    globals
        private string ForceString
        private boolean IsFirst
        private boolean AreAnyAlive
    endglobals

    private function ConcatPlayerName takes nothing returns nothing
        if IsFirst then
            set ForceString = GetPlayerNameColour(GetEnumPlayer())
            set IsFirst = false
        else 
            set ForceString = ForceString + ", " + GetPlayerNameColour(GetEnumPlayer())
        endif
    endfunction

    private function CheckIfPlayerUnitIsAlive takes nothing returns nothing
        if not AreAnyAlive then
            set AreAnyAlive = IsUnitAliveBJ(PlayerHeroes[GetPlayerId(GetEnumPlayer()) + 1]) == true  // Stored as converted player id. Rip.
        endif
    endfunction

    function ConvertForceToString takes force playerForce returns string
        set ForceString = ""
        set IsFirst = true

        call ForForce(playerForce, function ConcatPlayerName)

        return ForceString
    endfunction

    function AreAnyForceUnitsAlive takes force playerForce returns boolean
        set AreAnyAlive = false

        call ForForce(playerForce, function CheckIfPlayerUnitIsAlive)

        return AreAnyAlive
    endfunction

endlibrary