library SummonSpells initializer init
    globals
        Table SummonSpells
    endglobals

    function GetSummonSpell takes integer unitId returns integer
        return SummonSpells.integer[unitId]
    endfunction

    private function init takes nothing returns nothing
        set SummonSpells = Table.create()

        set SummonSpells[WATER_ELEMENTAL_1_UNIT_ID] = SUMMON_WATER_ELEMENTAL_ABILITY_ID
        set SummonSpells[FERAL_SPIRIT_WOLF_1_UNIT_ID] = FERAL_SPIRIT_ABILITY_ID
        set SummonSpells[SERPENT_WARD_1_UNIT_ID] = SERPANT_WARD_ABILITY_ID
        set SummonSpells[MOUNTAIN_GIANT_1_UNIT_ID] = SUMMON_MOUNTAIN_GIANT_ABILITY_ID
        set SummonSpells[BEAR_1_UNIT_ID] = SUMMON_BEAR_ABILITY_ID
        set SummonSpells[HAWK_1_UNIT_ID] = SUMMON_HAWK_ABILITY_ID
        set SummonSpells[QUILBEAST_1_UNIT_ID] = SUMMON_QUILBEAST_ABILITY_ID
        set SummonSpells[PHOENIX_1_UNIT_ID] = PHEONIX_ABILITY_ID
        set SummonSpells[INFERNAL_1_UNIT_ID] = INFERNO_ABILITY_ID
        set SummonSpells[LAVA_SPAWN_1_UNIT_ID] = SUMMON_LAVA_SPAWN_ABILITY_ID
        set SummonSpells[POCKET_FACTORY_1_UNIT_ID] = POCKET_FACTORY_ABILITY_ID
        set SummonSpells[CLOCKWORK_GOBLIN_1_UNIT_ID] = POCKET_FACTORY_ABILITY_ID
        set SummonSpells[PARASITE_1_UNIT_ID] = PARASITE_ABILITY_ID
        set SummonSpells[CARRION_BEETLE_1_UNIT_ID] = CARRION_BEETLES_ABILITY_ID
        set SummonSpells[SKELETON_BATTLEMASTER_1_UNIT_ID] = BLACK_ARROW_PASSIVE_ABILITY_ID
        set SummonSpells[SKELETON_WARMAGE_1_UNIT_ID] = BLACK_ARROW_PASSIVE_ABILITY_ID
        set SummonSpells[FEARLESS_DEFENDER_CAPTAIN_UNIT_ID] = FEARLESS_DEFENDERS_ABILITY_ID
    endfunction
endlibrary