library StableSpells initializer init
    globals
        Table StableSpells
    endglobals

    function IsSpellResettable takes integer abilId returns boolean
        return StableSpells.boolean[abilId] == false
    endfunction

    private function init takes nothing returns nothing
        set StableSpells = Table.create()

        set StableSpells.boolean[DIVINE_SHIELD_ABILITY_ID] = true
        set StableSpells.boolean[DIVINE_BUBBLE_ABILITY_ID] = true
        set StableSpells.boolean[LAST_BREATHS_ABILITY_ID] = true
        set StableSpells.boolean[ABSOLUTE_ARCANE_ABILITY_ID] = true
        set StableSpells.boolean['A0AM'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean[RESET_TIME_ABILITY_ID] = true
        set StableSpells.boolean[ANCIENT_TEACHING_ABILITY_ID] = true
        set StableSpells.boolean['A044'] = true
        set StableSpells.boolean['A0AH'] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean[SAND_OF_TIME_ABILITY_ID] = true
        set StableSpells.boolean[TIME_MANIPULATION_ABILITY_ID] = true
        set StableSpells.boolean[LIQUID_FIRE_ABILITY_ID] = true
        set StableSpells.boolean[ENVENOMED_WEAPONS_ABILITY_ID] = true
        set StableSpells.boolean['A0B6'] = true
        set StableSpells.boolean['A0BA'] = true
        set StableSpells.boolean[CONTRACT_LIVING_ABIL_ID] = true
        set StableSpells.boolean[REINCARNATION_ABILITY_ID] = true
        set StableSpells.boolean[ANCIENT_RUNES_ABILITY_ID] = true
        //set StableSpells.boolean['A085'] = true
    endfunction
endlibrary