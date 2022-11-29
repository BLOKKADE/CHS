library AbilityDescription initializer init requires ReplaceTextLib
    globals
        HashTable AbilityDescription
    endglobals

    function SetAbilityDescription takes integer abilId, integer lvl returns nothing
        if AbilityDescription[abilId].string[lvl] == null then
            set AbilityDescription[abilId].string[lvl] = BlzGetAbilityExtendedTooltip(abilId, lvl)
        endif
    endfunction

    function GetAbilityDescription takes integer abilId, integer lvl returns string
        call SetAbilityDescription(abilId, lvl)
        
        //call BJDebugMsg("loaded string")
        return AbilityDescription[abilId].string[lvl]
    endfunction

    function UpdateAbilityDescription takes string s, player p, integer abilId, string valKey, integer value, integer level returns string
        set s = ReplaceText(valKey, I2S(value), s)
        
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, s, level - 1)
        endif

        return s
    endfunction

    function UpdateAbilityDescriptionString takes string s, player p, integer abilId, string valKey, string value, integer level returns string
        set s = ReplaceText(valKey, value, s)
        
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, s, level - 1)
        endif

        return s
    endfunction

    function ResetAbilityDescription takes player p, integer abilId, integer level returns nothing
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, GetAbilityDescription(abilId, level), level)
        endif
    endfunction

    private function init takes nothing returns nothing
        set AbilityDescription = HashTable.create()
    endfunction
endlibrary