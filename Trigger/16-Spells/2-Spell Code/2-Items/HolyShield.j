library HolyShield initializer init requires RandomShit, AbilityData, CastSpellOnTarget
    globals
        integer array HolyShieldS
        integer CountHolyShieldS 
    endglobals

    private function init takes nothing returns nothing

        set HolyShieldS[0] = 'AHhb'
        set HolyShieldS[1] = 'Ahwd'
        set HolyShieldS[2] = 'AOhw'
        set HolyShieldS[3] = 'Arej'
        
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