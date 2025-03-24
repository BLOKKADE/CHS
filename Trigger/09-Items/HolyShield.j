library HolyShield initializer init requires RandomShit, AbilityData, CastSpellOnTarget
    globals
        integer array HolyShieldS
        integer CountHolyShieldS 
    endglobals

    private function init takes nothing returns nothing
        set HolyShieldS[0] = HOLY_LIGHT_ABILITY_ID
        set HolyShieldS[1] = TRANQUILITY_ABILITY_ID
        set HolyShieldS[2] = HEALING_WAVE_ABILITY_ID
        set HolyShieldS[3] = REJUVENATION_ABILITY_ID
        set CountHolyShieldS = 3
    endfunction
    
    function UseSpellsHolyShield takes unit caster returns nothing
        local integer i = 0
        local integer learnedCount = 0
        local integer array learnedSpells
        local integer randomIndex
        
        // First, count and store indices of learned spells
        loop
            if GetHeroPositionOfSpell(caster, HolyShieldS[i]) != 0 then
                set learnedSpells[learnedCount] = i
                set learnedCount = learnedCount + 1
            endif
            set i = i + 1
            exitwhen i > CountHolyShieldS
        endloop
        
        // If we have any learned spells, cast a random one
        if learnedCount > 0 then
            set randomIndex = GetRandomInt(0, learnedCount - 1)
            call CastSpell(caster, caster, HolyShieldS[learnedSpells[randomIndex]], GetUnitAbilityLevel(caster, HolyShieldS[learnedSpells[randomIndex]]), GetAbilityOrderType(HolyShieldS[learnedSpells[randomIndex]]), GetUnitX(caster), GetUnitY(caster)).activate()
        endif
    endfunction
endlibrary