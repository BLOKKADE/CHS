library MysteriousTalent requires RandomShit, AbilityData, CastSpellOnTarget

    globals
        HashTable MysteriousTalentMode
        //00 = off cooldown & no manifold
        //01 = off cooldown & manifold
        //10 = nearby enemy & no manifold
        //11 = nearby enemy & manifold
    endglobals
    function MysteriousTalentActivate takes unit caster returns nothing
        local integer i = 0
        local integer abilId
        local unit target
        local integer orderType = 0
        local real range = 0
        
        loop
            set abilId = GetHeroSpellAtPosition(caster, i)
            if IsSpellResettable(abilId) then
                call CastSpellAuto(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), 0, 0, -1)
            endif 
            set i = i + 1
            exitwhen i > 10
        endloop

        set target = null
    endfunction

    function MysteriousTalentUpdateDesc takes unit caster returns nothing
        local player p = GetOwningPlayer(caster)
        local integer abilId = MYSTERIOUS_TALENT_ABILITY_ID
        local integer abilLvl = GetUnitAbilityLevel(caster, MYSTERIOUS_TALENT_ABILITY_ID)
        local string s = GetAbilityDescription(abilId, abilLvl - 1)
        local string cdModeTxt = ""
        local string manifoldModeTxt = ""
        local integer hid = GetHandleId(caster)

        if MysteriousTalentMode[hid].boolean[0] then
            set cdModeTxt = "enemy nearby"
        else
            set cdModeTxt = "instant"
        endif

        if MysteriousTalentMode[hid].boolean[1] then
            set manifoldModeTxt = "on"
        else
            set manifoldModeTxt = "off"
        endif

        set s = UpdateAbilityDescriptionString(s, p, abilId, ",0,", cdModeTxt, abilLvl)
        set s = UpdateAbilityDescriptionString(s, p, abilId, ",1,", manifoldModeTxt, abilLvl)

        set p = null
    endfunction

    function MysteriousTalentCast takes unit caster returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(caster))
        local boolean shift = HoldShift[pid]
        local integer hid = GetHandleId(caster)

        if shift then
            set MysteriousTalentMode[hid].boolean[1] = MysteriousTalentMode[hid].boolean[1] != true
        else
            set MysteriousTalentMode[hid].boolean[0] = MysteriousTalentMode[hid].boolean[0] != true
        endif

        call MysteriousTalentUpdateDesc(caster)
    endfunction
endlibrary