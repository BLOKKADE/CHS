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

        loop             
            if GetNumHeroSpell(caster, HolyShieldS[i]) != 0 then
                call CastSpell(caster, caster, HolyShieldS[i], GetUnitAbilityLevel(caster,HolyShieldS[i]), GetAbilityOrderType(HolyShieldS[i]), GetUnitX(caster), GetUnitY(caster)).activate()
            endif
            set i = i + 1
            exitwhen i > CountHolyShieldS
        endloop
    endfunction
endlibrary