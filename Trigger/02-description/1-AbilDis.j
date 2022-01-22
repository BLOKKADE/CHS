library AbilityDescription requires RandomShit
    globals
        hashtable HT_des = InitHashtable()

    endglobals

    function SaveAbilityDescription takes integer abilId, integer lvl returns nothing
        if LoadStr(HT_des, abilId, lvl) == null then
            call SaveStr(HT_des, abilId, lvl, BlzGetAbilityExtendedTooltip(abilId, lvl))
        endif
    endfunction

    function GetAbilityDescription takes integer id, integer lvl returns string
        call SaveAbilityDescription(id, lvl)
        
        //call BJDebugMsg("loaded string")
        return LoadStr(HT_des,id,lvl)
    endfunction

    function UpdateAbilityDescription takes string s, player p, integer abilId, string valKey, integer value, integer level returns string
        set s = ReplaceText(valKey, I2S(value), s)
        
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, s, level - 1)
        endif

        //call BJDebugMsg(s)
        return s
    endfunction

    function UpdateAbilityDescriptionString takes string s, player p, integer abilId, string valKey, string value, integer level returns string
        set s = ReplaceText(valKey, value, s)
        
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, s, level - 1)
        endif

        //call BJDebugMsg(s)
        return s
    endfunction

    function ResetAbilityDescription takes player p, integer abilId, integer level returns nothing
        if GetLocalPlayer() == p then
            call BlzSetAbilityExtendedTooltip(abilId, GetAbilityDescription(abilId, level), level)
        endif
    endfunction
endlibrary