library ToggleSpell initializer init requires Immolation, SearingArrows, ColdArrows, MagnetOscillation

    globals
        Table ToggleSpells
    endglobals

    function IsToggleSpell takes integer abilId returns boolean
        return ToggleSpells.boolean[abilId] == true
    endfunction

    function ToggleSpell takes unit caster, integer abilId returns boolean
        if abilId == IMMOLATION_ABILITY_ID then
            call ToggleImmolation(caster)
            return true
        elseif abilId == SEARING_ARROWS_ABILITY_ID then
            call ToggleSearingArrows(caster)
            return true
        elseif abilId == COLD_ARROWS_ABILITY_ID then
            call ToggleColdArrows(caster)
            return true
        elseif abilId == MAGNET_OSC_ABILITY_ID then
            call ToggleMagnetOsc(caster)
            return true
        elseif abilId == MANA_SHIELD_ABILITY_ID then
            return true
        endif

        return false
    endfunction

    private function init takes nothing returns nothing
        set ToggleSpells = Table.create()

        set ToggleSpells.boolean[IMMOLATION_ABILITY_ID] = true
        set ToggleSpells.boolean[SEARING_ARROWS_ABILITY_ID] = true
        set ToggleSpells.boolean[COLD_ARROWS_ABILITY_ID] = true
        set ToggleSpells.boolean[MAGNET_OSC_ABILITY_ID] = true
        set ToggleSpells.boolean[MANA_SHIELD_ABILITY_ID] = true
    endfunction
endlibrary
