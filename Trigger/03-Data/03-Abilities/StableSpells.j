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
        set StableSpells.boolean[WIND_WALK_ABILITY_ID] = true
        set StableSpells.boolean[DIVINE_BUBBLE_ABILITY_ID] = true
        set StableSpells.boolean[LAST_BREATHS_ABILITY_ID] = true
        set StableSpells.boolean[ARCANE_STRIKE_ABILITY_ID] = true
        set StableSpells.boolean[ARCANE_RUNESTONE_ABIL_ID] = true
        set StableSpells.boolean['A08P'] = true
        set StableSpells.boolean[RESET_TIME_ABILITY_ID] = true
        set StableSpells.boolean[ANCIENT_TEACHING_ABILITY_ID] = true
        set StableSpells.boolean[URN_ABIL_ID] = true
        set StableSpells.boolean['A0AH'] = true
        set StableSpells.boolean[SAND_OF_TIME_ABILITY_ID] = true
        set StableSpells.boolean[TIME_MANIPULATION_ABILITY_ID] = true
        set StableSpells.boolean[LIQUID_FIRE_ABILITY_ID] = true
        set StableSpells.boolean[ENVENOMED_WEAPONS_ABILITY_ID] = true
        set StableSpells.boolean['A0B6'] = true
        set StableSpells.boolean['A0BA'] = true
        set StableSpells.boolean[CONTRACT_LIVING_ABIL_ID] = true
        set StableSpells.boolean[REINCARNATION_ABILITY_ID] = true
        set StableSpells.boolean[ANCIENT_RUNES_ABILITY_ID] = true
        set StableSpells.boolean[ANTI_MAGIC_FLAG_ABIL_ID] = true
        set StableSpells.boolean[SCROLL_OF_TRANSFORMATION_ABIL_ID] = true
        set StableSpells.boolean[DEVASTATING_BLOW_ABILITY_ID] = true
        set StableSpells.boolean[DARK_SEAL_ABILITY_ID] = true
        set StableSpells.boolean[DESTRUCTION_BLOCK_ABILITY_ID] = true
        set StableSpells.boolean[CONTEMPORARY_RUNES_ABILITY_ID] = true
        set StableSpells.boolean[ANCIENT_ELEMENT_ABILITY_ID] = true
        set StableSpells.boolean[HERO_BUFF_ABILITY_ID] = true
        set StableSpells.boolean[TEMPORARY_INVISIBILITY_ABILITY_ID] = true
        set StableSpells.boolean[TEMPORARY_POWER_ABILITY_ID] = true
        set StableSpells.boolean[CHEATER_MAGIC_ABILITY_ID] = true
        set StableSpells.boolean[BLESSED_PROTECTIO_ABILITY_ID] = true
        set StableSpells.boolean[RAPID_RECOVERY_ABILITY_ID] = true
        set StableSpells.boolean[DEMONS_CURSE_ABILITY_ID] = true
        set StableSpells.boolean[ACTIVATE_AVATAR_ABILITY_ID] = true
    endfunction
endlibrary
