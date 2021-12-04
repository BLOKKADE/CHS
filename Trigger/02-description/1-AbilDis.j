library AbilityDescription requires RandomShit
    globals
        hashtable HT_des = InitHashtable()

    endglobals


    function GetDesriptionAbility takes integer id, integer lvl returns string
        if LoadStr(HT_des,id,lvl) == null then
            //call BJDebugMsg("saved string")
            call SaveStr(HT_des,id,lvl,BlzGetAbilityExtendedTooltip(id,lvl))
        endif
        
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
endlibrary