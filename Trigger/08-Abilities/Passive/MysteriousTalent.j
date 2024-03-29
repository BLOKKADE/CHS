library MysteriousTalent requires HeroAbilityTable, AbilityData, CastSpellOnTarget, StableSpells, AbilityDescription

    function MysteriousTalentActivate takes unit caster returns nothing
        local integer i = 0
        local integer abilId
        local unit target
        local integer orderType = 0
        local real range = 0
        
        loop
            set abilId = GetHeroSpellAtPosition(caster, i)
            if abilId != 0 and IsSpellResettable(abilId) then
                call CastSpellAuto(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), 0, 0, -1).activate()
            endif 
            set i = i + 1
            exitwhen i > 10
        endloop

        set target = null
    endfunction

endlibrary