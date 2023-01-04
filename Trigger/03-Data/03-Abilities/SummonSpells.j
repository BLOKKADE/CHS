library SummonSpells initializer init
    globals
        Table SummonSpells
        Table SummonCode
    endglobals

    function interface SummonStatCode takes unit u, integer totalLevel returns nothing

    function GetSummonSpell takes integer unitId returns integer
        return SummonSpells.integer[unitId]
    endfunction

    function GetSummonStatFunction takes integer unitId returns SummonStatCode
        return SummonCode.integer[unitId]
    endfunction

    function SetSummonInfo takes integer unitId, integer abilId, SummonStatCode func returns nothing
        set SummonSpells[unitId] = abilId
        set SummonCode.integer[unitId] = func
    endfunction

    private function SetupSummonInfo takes nothing returns nothing
        call SetSummonInfo(WATER_ELEMENTAL_1_UNIT_ID, SUMMON_WATER_ELEMENTAL_ABILITY_ID, SummonStatCode.WaterElementalStats)
        call SetSummonInfo(FERAL_SPIRIT_WOLF_1_UNIT_ID, FERAL_SPIRIT_ABILITY_ID, SummonStatCode.SpiritWolfStats)
        call SetSummonInfo(SERPENT_WARD_1_UNIT_ID, SERPANT_WARD_ABILITY_ID, SummonStatCode.SerpentWardStats)
        call SetSummonInfo(MOUNTAIN_GIANT_1_UNIT_ID, SUMMON_MOUNTAIN_GIANT_ABILITY_ID, SummonStatCode.MountainGiantStats)
        call SetSummonInfo(BEAR_1_UNIT_ID, SUMMON_BEAR_ABILITY_ID, SummonStatCode.BearStats)
        call SetSummonInfo(HAWK_1_UNIT_ID, SUMMON_HAWK_ABILITY_ID, SummonStatCode.HawkStats)
        call SetSummonInfo(QUILBEAST_1_UNIT_ID, SUMMON_QUILBEAST_ABILITY_ID, SummonStatCode.QuilbeastStats)
        call SetSummonInfo(PHOENIX_1_UNIT_ID, PHEONIX_ABILITY_ID, SummonStatCode.PhoenixStats)
        call SetSummonInfo(INFERNAL_1_UNIT_ID, INFERNO_ABILITY_ID, SummonStatCode.InfernoStats)
        call SetSummonInfo(LAVA_SPAWN_1_UNIT_ID, SUMMON_LAVA_SPAWN_ABILITY_ID, SummonStatCode.LavaSpawnStats)
        call SetSummonInfo(POCKET_FACTORY_1_UNIT_ID, POCKET_FACTORY_ABILITY_ID, SummonStatCode.PocketFactoryStats)
        call SetSummonInfo(CLOCKWORK_GOBLIN_1_UNIT_ID, POCKET_FACTORY_ABILITY_ID, SummonStatCode.ClockwerkGoblinStats)
        call SetSummonInfo(PARASITE_1_UNIT_ID, PARASITE_ABILITY_ID, SummonStatCode.ParasiteStats)
        call SetSummonInfo(CARRION_BEETLE_1_UNIT_ID, CARRION_BEETLES_ABILITY_ID, SummonStatCode.CarrionBeetleStats)
        call SetSummonInfo(SKELETON_BATTLEMASTER_1_UNIT_ID, BLACK_ARROW_PASSIVE_ABILITY_ID, SummonStatCode.BlackArrowMeleeSkeletonStats)
        call SetSummonInfo(SKELETON_WARMAGE_1_UNIT_ID, BLACK_ARROW_PASSIVE_ABILITY_ID, SummonStatCode.BlackArrowMeleeSkeletonStats)
        call SetSummonInfo(NECRO_BOOK_WARRIOR_1_UNIT_ID, 0, SummonStatCode.SkeletonStats)
        call SetSummonInfo(NECRO_BOOK_ARCHER_1_UNIT_ID, 0, SummonStatCode.SkeletonStats)
        call SetSummonInfo(BONE_ARMOR_SKELETON_UNIT_ID, 0, SummonStatCode.SkeletonStats)
        call SetSummonInfo(FEARLESS_DEFENDER_CAPTAIN_UNIT_ID, FEARLESS_DEFENDERS_ABILITY_ID, SummonStatCode.FearlessDefendersStats)
    endfunction

    private function init takes nothing returns nothing
        set SummonSpells = Table.create()
        set SummonCode = Table.create()

        call SetupSummonInfo()
    endfunction
endlibrary