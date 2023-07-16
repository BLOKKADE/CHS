/*
    The IdLibrary is responsible for keeping track of groups of units.
    These groups of units are used for checking if some unit/item/ability/destructible id
    is in a group. It's a one line check and the data store is all done in one array!
    Only drawback is we can only have the max array size of ids which is ~8000.

    Lastly, you can have a group of groups! This makes it easy to search multiple different groups,
    all at once without having to check each group individually. The data returned when finding is
    the group that matched and the index.
*/
library IdLibrary initializer init

    globals
        constant integer ID_NOT_FOUND                                   = -1

        // --- Unit IDs ---

        // --- Dummies ---
        StaticIdGroup DUMMIES

        constant integer HERO_PREVIEW_UNIT_ID                           = 'e005'
        constant integer SELL_ITEM_DUMMY                                = 'h00F'
        constant integer PRIEST_1_UNIT_ID                               = 'h015'
        constant integer PET_BASE_UNIT_ID                               = 'e002'
        constant integer SUDDEN_DEATH_UNIT_ID                           = 'n00V'
        constant integer SUDDEN_DEATH_ABILITY_ID                        = 'A0CU'
        constant integer SHADE_BR_RESPAWN_UNIT_ID                       = 'u009'

        // --- Shops ---
        constant integer DRAFT_BUY_UNIT_ID                              = 'h00C'
        constant integer DRAFT_UPGRADE_UNIT_ID                          = 'h00D'

        constant integer ABSOLUTE_SHOP_UNIT_ID                          = 'n031'
        constant integer AUTOCAST_TOGGLE_SPELLS_UNIT_ID                 = 'n013'
        constant integer CHRONUS_SPELLS_UNIT_ID                         = 'n02M'
        constant integer SUMMON_SPELLS_UNIT_ID                          = 'n014'

        constant integer ACTIVE_SPELLS_I_UNIT_ID                        = 'n00D'
        constant integer ACTIVE_SPELLS_II_UNIT_ID                       = 'n003'
        constant integer ACTIVE_SPELLS_III_UNIT_ID                      = 'n00U'
        constant integer ACTIVE_SPELLS_IV_UNIT_ID                       = 'n00Y'
        constant integer ACTIVE_SPELLS_V_UNIT_ID                        = 'n02O'
        constant integer ACTIVE_SPELLS_VI_UNIT_ID                       = 'n033'

        constant integer PASSIVE_SPELLS_I_UNIT_ID                       = 'n001'
        constant integer PASSIVE_SPELLS_II_UNIT_ID                      = 'n012'
        constant integer PASSIVE_SPELLS_III_UNIT_ID                     = 'n00S'
        constant integer PASSIVE_SPELLS_IV_UNIT_ID                      = 'n02N'
        constant integer PASSIVE_SPELLS_V_UNIT_ID                       = 'n02X'
        constant integer PASSIVE_SPELLS_VI_UNIT_ID                      = 'n032'
        constant integer PASSIVE_SPELLS_VII_UNIT_ID                     = 'n01E'

        constant integer ITEM_SHOP_I_UNIT_ID                            = 'n00Z'
        constant integer ITEM_SHOP_II_UNIT_ID                           = 'n01D'
        constant integer ITEM_SHOP_III_UNIT_ID                          = 'n02I'
        constant integer ITEM_SHOP_IV_UNIT_ID                           = 'n02J'
        constant integer ITEM_SHOP_V_UNIT_ID                            = 'n02Q'
        constant integer ITEM_SHOP_VI_UNIT_ID                           = 'n02Y'
        constant integer ITEM_SHOP_VII_UNIT_ID                          = 'n01P'
        constant integer ITEM_SHOP_VIII_UNIT_ID                         = 'n03A'

        constant integer RUNESTONE_SHOP_UNIT_ID                         = 'n02Z'
        constant integer ELEMENTAL_ITEM_SHOP_UNIT_ID                    = 'n030'
        constant integer GLORY_SHOP_UNIT_ID                             = 'n02U'
        constant integer SUMMON_BUFFS_SHOP_UNIT_ID                      = 'n02H'
        
        constant integer ARENA_BUFFS_SHOP_I_UNIT_ID                     = 'n02T'
        constant integer ARENA_BUFFS_SHOP_II_UNIT_ID                    = 'n036'

        constant integer PVE_SHOP_I_UNIT_ID                             = 'n02V'
        constant integer PVE_SHOP_II_UNIT_ID                            = 'n02W'
        constant integer ABSOLUTE_GLORY_UNIT_ID                         = 'n00M'

        // --- Summons ---

        StaticIdGroup SUMMONS

        // Single Summons
        constant integer CARRION_BEETLE_1_UNIT_ID                       = 'u001'
        constant integer CLOCKWORK_GOBLIN_1_UNIT_ID                     = 'n011'
        constant integer MOUNTAIN_GIANT_1_UNIT_ID                       = 'e00N'
        constant integer PARASITE_1_UNIT_ID                             = 'ncfs'
        constant integer PHOENIX_1_UNIT_ID                              = 'h009'
        constant integer POCKET_FACTORY_1_UNIT_ID                       = 'n010'
        
        constant integer SKELETON_BATTLEMASTER_1_UNIT_ID                = 'n015'
        constant integer SKELETON_MAGE_1_UNIT_ID                        = 'uskm'
        constant integer SKELETON_WARMAGE_1_UNIT_ID                     = 'u004'
        constant integer SKELETON_WARRIOR_1_UNIT_ID                     = 'uske'

        // Group Summons
        // Bears
        StaticIdGroup BEARS
        constant integer BEAR_1_UNIT_ID                                 = 'ngz1'
        constant integer BEAR_2_UNIT_ID                                 = 'ngz2'
        constant integer BEAR_3_UNIT_ID                                 = 'ngz3'

        // Feral Spirit Wolfs
        StaticIdGroup FERAL_SPIRIT_WOLVES
        constant integer FERAL_SPIRIT_WOLF_1_UNIT_ID                    = 'osw1'
        constant integer FERAL_SPIRIT_WOLF_2_UNIT_ID                    = 'osw2'
        constant integer FERAL_SPIRIT_WOLF_3_UNIT_ID                    = 'osw3'

        // Hawks
        StaticIdGroup HAWKS
        constant integer HAWK_1_UNIT_ID                                 = 'nwe1'
        constant integer HAWK_2_UNIT_ID                                 = 'nwe2'
        constant integer HAWK_3_UNIT_ID                                 = 'nwe3'

        // Infernals
        StaticIdGroup INFERNALS
        constant integer INFERNAL_1_UNIT_ID                             = 'n01N'
        constant integer INFERNAL_2_UNIT_ID                             = 'n01E'
        constant integer INFERNAL_3_UNIT_ID                             = 'n01M'
        constant integer INFERNAL_4_UNIT_ID                             = 'n01O'
        constant integer INFERNAL_5_UNIT_ID                             = 'n01P'
        constant integer INFERNAL_6_UNIT_ID                             = 'n01Q'
        constant integer INFERNAL_7_UNIT_ID                             = 'n01R'
        constant integer INFERNAL_8_UNIT_ID                             = 'n01S'
        constant integer INFERNAL_9_UNIT_ID                             = 'n01T'
        constant integer INFERNAL_10_UNIT_ID                            = 'n01U'
        constant integer INFERNAL_11_UNIT_ID                            = 'n01V'
        constant integer INFERNAL_12_UNIT_ID                            = 'n01W'
        constant integer INFERNAL_13_UNIT_ID                            = 'n01X'
        constant integer INFERNAL_14_UNIT_ID                            = 'n01Y'
        constant integer INFERNAL_15_UNIT_ID                            = 'n01Z'
        constant integer INFERNAL_16_UNIT_ID                            = 'n020'
        constant integer INFERNAL_17_UNIT_ID                            = 'n021'
        constant integer INFERNAL_18_UNIT_ID                            = 'n022'
        constant integer INFERNAL_19_UNIT_ID                            = 'n023'
        constant integer INFERNAL_20_UNIT_ID                            = 'n026'
        constant integer INFERNAL_21_UNIT_ID                            = 'n025'
        constant integer INFERNAL_22_UNIT_ID                            = 'n027'
        constant integer INFERNAL_23_UNIT_ID                            = 'n028'
        constant integer INFERNAL_24_UNIT_ID                            = 'n029'
        constant integer INFERNAL_25_UNIT_ID                            = 'n02A'
        constant integer INFERNAL_26_UNIT_ID                            = 'n02C'
        constant integer INFERNAL_27_UNIT_ID                            = 'n02D'
        constant integer INFERNAL_28_UNIT_ID                            = 'n02E'
        constant integer INFERNAL_29_UNIT_ID                            = 'n02F'
        constant integer INFERNAL_30_UNIT_ID                            = 'n02G'

        // Lava Spawns
        StaticIdGroup LAVA_SPAWNS
        constant integer LAVA_SPAWN_1_UNIT_ID                           = 'nlv1'
        constant integer LAVA_SPAWN_2_UNIT_ID                           = 'nlv2'
        constant integer LAVA_SPAWN_3_UNIT_ID                           = 'nlv3'

        // Quilbeasts
        StaticIdGroup QUILBEASTS
        constant integer QUILBEAST_1_UNIT_ID                            = 'nqb1'
        constant integer QUILBEAST_2_UNIT_ID                            = 'nqb2'
        constant integer QUILBEAST_3_UNIT_ID                            = 'nqb3'
        constant integer QUILBEAST_4_UNIT_ID                            = 'nqb4'

        // Raise Dead Units
        StaticIdGroup SKELLIESCAPTAINS
        constant integer NECRO_BOOK_WARRIOR_1_UNIT_ID                   = 'n02S'
        constant integer NECRO_BOOK_ARCHER_1_UNIT_ID                    = 'n02R'
        constant integer FEARLESS_DEFENDER_CAPTAIN_UNIT_ID              = 'h01A'
        constant integer BONE_ARMOR_SKELETON_UNIT_ID                    = 'u003'

        // Serpant Wards
        StaticIdGroup SERPENT_WARDS
        constant integer SERPENT_WARD_1_UNIT_ID                         = 'osp1'
        constant integer SERPENT_WARD_2_UNIT_ID                         = 'osp2'
        constant integer SERPENT_WARD_3_UNIT_ID                         = 'osp3'

        // Water Elementals
        StaticIdGroup WATER_ELEMENTALS
        constant integer WATER_ELEMENTAL_1_UNIT_ID                      = 'hwat'
        constant integer WATER_ELEMENTAL_2_UNIT_ID                      = 'hwt2'
        constant integer WATER_ELEMENTAL_3_UNIT_ID                      = 'hwt3'

        constant integer FAERIE_DRAGON_UNIT_ID                          = 'e001'

        // Heroes
        StaticIdGroup HEROES
        constant integer ABOMINATION_UNIT_ID                            = 'H005'
        constant integer ARENA_MASTER_UNIT_ID                           = 'H00A'
        constant integer AVATAR_SPIRIT_UNIT_ID                          = 'O003'
        constant integer BANSHEE_UNIT_ID                                = 'H01I'
        constant integer BEAST_MASTER_UNIT_ID                           = 'N00P'
        constant integer BLADE_MASTER_UNIT_ID                           = 'N00K'
        constant integer BLOOD_MAGE_UNIT_ID                             = 'H001'
        constant integer CENTAUR_ARCHER_UNIT_ID                         = 'H01B'
        constant integer COLD_KNIGHT_UNIT_ID                            = 'N02K'
        constant integer DARK_HUNTER_UNIT_ID                            = 'H000'
        constant integer DEMON_HUNTER_UNIT_ID                           = 'O004'
        constant integer DOOM_GUARD_UNIT_ID                             = 'H016'
        constant integer DEADLORD_UNIT_ID                               = 'O002'
        constant integer DRUID_OF_THE_CLAY_UNIT_ID                      = 'H006'
        constant integer FALLEN_RANGER_UNIT_ID                          = 'N00B'
        constant integer GHOUL_UNIT_ID                                  = 'H01H'
        constant integer GNOME_MASTER_UNIT_ID                           = 'H019'
        constant integer GREEDY_GOBLIN_UNIT_ID                          = 'N02P'
        constant integer CRYPT_LORD_UNIT_ID                             = 'H01J'
        constant integer HUNTRESS_UNIT_ID                               = 'N00R'
        constant integer LICH_UNIT_ID                                   = 'H018'
        constant integer LIEUTENANT_UNIT_ID                             = 'E000'
        constant integer MAULER_UNIT_ID                                 = 'H002'
        constant integer MEDIVH_UNIT_ID                                 = 'H01G'
        constant integer MORTAR_TEAM_UNIT_ID                            = 'H004'
        constant integer MYSTIC_UNIT_ID                                 = 'O008'
        constant integer NAGA_SIREN_UNIT_ID                             = 'H003'
        constant integer OGRE_MAGE_UNIT_ID                              = 'H01E'
        constant integer OGRE_WARRIOR_UNIT_ID                           = 'H01C'
        constant integer ORC_CHAMPION_UNIT_ID                           = 'N024'
        constant integer PIT_LORD_UNIT_ID                               = 'O007'
        constant integer PYROMANCER_UNIT_ID                             = 'O005'
        constant integer RANGER_UNIT_ID                                 = 'H007'
        constant integer ROCK_GOLEM_UNIT_ID                             = 'H017'
        constant integer SATYR_TRICKSTER_UNIT_ID                        = 'O00C'
        constant integer SEER_UNIT_ID                                   = 'H01L'
        constant integer SKELETON_BRUTE_UNIT_ID                         = 'N00O'
        constant integer SORCERER_UNIT_ID                               = 'H008'
        constant integer TAUREN_UNIT_ID                                 = 'O000'
        constant integer THUNDER_WITCH_UNIT_ID                          = 'O001'
        constant integer TIME_WARRIOR_UNIT_ID                           = 'H01D'
        constant integer TINKER_UNIT_ID                                 = 'N00L'
        constant integer TROLL_BERSERKER_UNIT_ID                        = 'O00A'
        constant integer TROLL_HEADHUNTER_UNIT_ID                       = 'N00I'
        constant integer URSA_WARRIOR_UNIT_ID                           = 'N00Q'
        constant integer WAR_GOLEM_UNIT_ID                              = 'N00C'
        constant integer WITCH_DOCTOR_UNIT_ID                           = 'O006'
        constant integer WOLF_RIDER_UNIT_ID                             = 'U000'
        constant integer MURLOC_WARRIOR_UNIT_ID                         = 'H01F'
        constant integer YETI_UNIT_ID                                   = 'O00B'
        // --- Unit IDs ---

        // --- Ability IDs ---
        constant integer ABSOLUTE_ARCANE_ABILITY_ID                     = 'A0D8'
        constant integer ABSOLUTE_BLOOD_ABILITY_ID                      = 'A07R'
        constant integer ABSOLUTE_COLD_ABILITY_ID                       = 'A07V'
        constant integer ABSOLUTE_DARK_ABILITY_ID                       = 'A07Q'
        constant integer ABSOLUTE_EARTH_ABILITY_ID                      = 'A07D'
        constant integer ABSOLUTE_FIRE_ABILITY_ID                       = 'A07B'
        constant integer ABSOLUTE_LIGHT_ABILITY_ID                      = 'A07P'
        constant integer ABSOLUTE_POISON_ABILITY_ID                     = 'A0AC'
        constant integer ABSOLUTE_WATER_ABILITY_ID                      = 'A07C'
        constant integer ABSOLUTE_WILD_ABILITY_ID                       = 'A07K'
        constant integer ABSOLUTE_WIND_ABILITY_ID                       = 'A07E'
        constant integer ACID_BOMB_ABILITY_ID                           = 'ANab'
        constant integer ACID_SPRAY_ABILITY_ID                          = 'ANhs'
        constant integer ACTIVATE_AVATAR_ABILITY_ID                     = 'A0AE'
        constant integer HERO_FORCE_ABILITY_ID                           = 'A02T'
        constant integer ANCIENT_BLOOD_ABILITY_ID                       = 'A0CH'
        constant integer ANCIENT_ELEMENT_ABILITY_ID                     = 'A07T'
        constant integer ANCIENT_RUNES_ABILITY_ID                       = 'A06Z'
        constant integer RUNE_MASTERY_ABILITY_ID                        = 'A09O'
        constant integer ANCIENT_TEACHING_ABILITY_ID                    = 'A05U'
        constant integer ANTI_MAGIC_SHEL_ABILITY_ID                     = 'Aam2'
        constant integer ARCANE_ASSAUL_ABILITY_ID                       = 'A098'
        constant integer ARCANE_STRIKE_ABILITY_ID                       = 'A0AB'
        constant integer ATTACK_SPEED_BONUS_ABILITY_ID                  = 'A0A5'
        constant integer AURA_OF_FEAR_ABILITY_ID                        = 'A02K'
        constant integer AURA_OF_IMMORTALITY_ABILITY_ID                 = 'A02L'
        constant integer AURA_OF_VULNERABILITY_ABILITY_ID               = 'A02M'
        constant integer BACKSTAB_ABILITY_ID                            = 'A0D0'
        constant integer BANISH_ABILITY_ID                              = 'AHbn'
        constant integer BASH_ABILITY_ID                                = 'A06S'
        constant integer BATTLE_ROAR_ABILITY_ID                         = 'ANbr'
        constant integer BERSERK_ABILITY_ID                             = 'Absk'
        constant integer BIG_BAD_VOODOO_ABILITY_ID                      = 'AOvd'
        constant integer BLACK_ARROW_ABILITY_ID                         = 'ANba'
        constant integer BLACK_ARROW_PASSIVE_ABILITY_ID                 = 'A0AW'
        constant integer BLESSED_PROTECTIO_ABILITY_ID                   = 'A045'
        constant integer CRUSHING_WAVE_ABILITY_ID                       = 'A04Z'
        constant integer BLINK_ABILITY_ID                               = 'AEbl'
        constant integer BLINK_STRIKE_ABILITY_ID                        = 'A08J'
        constant integer BLIZZARD_ABILITY_ID                            = 'AHbz'
        constant integer BLOODLUST_ABILITY_ID                           = 'Ablo'
        constant integer BREATH_OF_FIRE_ABILITY_ID                      = 'ANbf'
        constant integer BRILLIANCE_AURA_ABILITY_ID                     = 'AHab'
        constant integer CARRION_BEETLES_ABILITY_ID                     = 'A06N'
        constant integer CARRION_SWARM_ABILITY_ID                       = 'AUcs'
        constant integer CHAIN_LIGHTNING_ABILITY_ID                     = 'AOcl'
        constant integer CHAOS_MAGIC_ABILITY_ID                         = 'A04L'
        constant integer CHEATER_MAGIC_ABILITY_ID                       = 'A040'
        constant integer CHRONUS_WIZARD_ABILITY_ID                      = 'A03Y'
        constant integer CLEAVING_ATTACK_ABILITY_ID                     = 'ANca'
        constant integer CLUSTER_ROCKETS_ABILITY_ID                     = 'ANcs'
        constant integer COLD_ARROWS_ABILITY_ID                         = 'A03S'
        constant integer COLD_WIND_ABILITY_ID                           = 'A07N'
        constant integer COMBUSTION_ABILITY_ID                          = 'A04H'
        constant integer COMMAND_AURA_ABILITY_ID                        = 'ACac'
        constant integer CORROSIVE_SKIN_ABILITY_ID                      = 'A00Q'
        constant integer CRITICAL_STRIKE_ABILITY_ID                     = 'AOcr'
        constant integer CRUELTY_ABILITY_ID                             = 'A067'
        constant integer CURSE_ABILITY_ID                               = 'Acrs'
        constant integer CUTTING_ABILITY_ID                             = 'A081'
        constant integer CYCLONE_ABILITY_ID                             = 'A05X'
        constant integer DAMAGE_BONUS_ABILITY_ID                        = 'A0A8'
        constant integer DARK_SEAL_ABILITY_ID                           = 'A09K'
        constant integer DEATH_AND_DECAY_ABILITY_ID                     = 'AUdd'
        constant integer DEATH_PACT_ABILITY_ID                          = 'A00M'
        constant integer DEMOLISH_ABILITY_ID                            = 'ANde'
        constant integer DEMONS_CURSE_ABILITY_ID                        = 'A042'
        constant integer DESTRUCTION_ABILITY_ID                         = 'ACpv'
        constant integer DESTRUCTION_BLOCK_ABILITY_ID                   = 'A0CW'
        constant integer DEVASTATING_BLOW_ABILITY_ID                    = 'A050'
        constant integer DEVOTION_AURA_ABILITY_ID                       = 'AHad'
        constant integer DIVINE_BUBBLE_ABILITY_ID                       = 'A07S'
        constant integer DIVINE_GIFT_ABILITY_ID                         = 'A082'
        constant integer DIVINE_SHIELD_ABILITY_ID                       = 'AHds'
        constant integer DOME_OF_PROTECTION_ABILITY_ID                  = 'A0B9'
        constant integer DOUSING_HE_ABILITY_ID                          = 'A09I'
        constant integer DRAIN_AURA_ABILITY_ID                          = 'A023'
        constant integer DRUNKEN_HAZE_ABILITY_ID                        = 'ANdh'
        constant integer DRUNKEN_MASTER_ABILITY_ID                      = 'Acdb'
        constant integer EARTHQUAKE_ABILITY_ID                          = 'A07L'
        constant integer ENDURANCE_AURA_ABILITY_ID                      = 'AOae'
        constant integer ENERGY_SHIELD_ABILITY_ID                       = 'A0CZ'
        constant integer ENSNARE_ABILITY_ID                             = 'ANen'
        constant integer ENTAGLING_ROOTS_ABILITY_ID                     = 'AEer'
        constant integer ENVENOMED_WEAPONS_ABILITY_ID                   = 'A06O'
        constant integer EVASION_ABILITY_ID                             = 'AEev'
        constant integer EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID        = 'A08I'
        constant integer FAERIE_FIRE_ABILITY_ID                         = 'Afae'
        constant integer FAN_OF_KNIVES_ABILITY_ID                       = 'AEfk'
        constant integer FAST_MAGIC_ABILITY_ID                          = 'A03P'
        constant integer FATAL_FLA_ABILITY_ID                           = 'A0AA'
        constant integer FEARLESS_DEFENDERS_ABILITY_ID                  = 'A041'
        constant integer FERAL_SPIRIT_ABILITY_ID                        = 'A0CA'
        constant integer FINGER_OF_DEATH_ABILITY_ID                     = 'Afod'
        constant integer FINISHING_BLOW_ABILITY_ID                      = 'A02N'
        constant integer FIRE_FORCE_ABILITY_ID                          = 'A02U'
        constant integer FIRE_SHIELD_ABILITY_ID                         = 'A01T'
        constant integer FLAME_STRIKE_ABILITY_ID                        = 'AHfs'
        constant integer FOG_ABILITY_ID                                 = 'Aclf'
        constant integer FORKED_LIGHTNING_ABILITY_ID                    = 'ANfl'
        constant integer FROSTBITE_OF_THE_SOUL_ABILITY_ID               = 'A080'
        constant integer FROST_ARMOR_ABILITY_ID                         = 'AUfu'
        constant integer FROST_BOLT_ABILITY_ID                          = 'A07X'
        constant integer FROST_NOVA_ABILITY_ID                          = 'AUfn'
        constant integer HARDENED_SKIN_ABILITY_ID                       = 'Assk'
        constant integer HEALING_WARD_ABILITY_ID                        = 'Ahwd'
        constant integer HEALING_WAVE_ABILITY_ID                        = 'AOhw'
        constant integer HEAVY_BLOW_ABILITY_ID                          = 'A04G'
        constant integer HERO_BUFF_ABILITY_ID                           = 'A03Q'
        constant integer HOLY_ENLIGHTENMENT_ABILITY_ID                  = 'A04K'
        constant integer HOLY_LIGHT_ABILITY_ID                          = 'A01W'
        constant integer HOWL_OF_TERROR_ABILITY_ID                      = 'ANht'
        constant integer ICE_FORCE_ABILITY_ID                           = 'A053'
        constant integer ICY_BREATH_ABILITY_ID                          = 'A046'
        constant integer IMMOLATION_ABILITY_ID                          = 'A01J'
        constant integer IMPALE_ABILITY_ID                              = 'AUim'
        constant integer INCINERATE_ABILITY_ID                          = 'A06M'
        constant integer INFERNO_ABILITY_ID                             = 'AUin'
        constant integer INNER_FIRE_ABILITY_ID                          = 'Ainf'
        constant integer LAST_BREATHS_ABILITY_ID                        = 'A05R'
        constant integer LEARNABILITY_ABILITY_ID                        = 'A02W'
        constant integer LIFE_DRAIN_ABILITY_ID                          = 'ANdr'
        constant integer LIGHTNING_SHIELD_ABILITY_ID                    = 'A057'
        constant integer LIQUID_FIRE_ABILITY_ID                         = 'A06Q'
        constant integer MAGIC_CRITICAL_HIT_ABILITY_ID                  = 'A06U'
        constant integer MANA_BONUS_ABILITY_ID                          = 'A02X'
        constant integer MANA_SHIELD_ABILITY_ID                         = 'ANms'
        constant integer MANA_STARVATIO_ABILITY_ID                      = 'A09J'
        constant integer MARTIAL_RETRIBUTION_ABILITY_ID                 = 'A089'
        constant integer PACKING_TAPE_ABILITY_ID                        = 'A0DU'
        constant integer MEGA_LUCK_ABILITY_ID                           = 'A06V'
        constant integer MEGA_SPEED_ABILITY_ID                          = 'A02O'
        constant integer MIDAS_TOUCH_ABILITY_ID                         = 'A0A2'
        constant integer MIRROR_IMAGE_ABILITY_ID                        = 'AOmi'
        constant integer MONSOON_ABILITY_ID                             = 'ANmo'
        constant integer MULTICAST_ABILITY_ID                           = 'A04F'
        constant integer MULTISHOT_ABILITY_ID                           = 'Aroc'
        constant integer MAGNET_OSC_ABILITY_ID                          = 'A054'
        constant integer MYSTERIOUS_TALENT_ABILITY_ID                   = 'A05Z'
        constant integer NECROMANCERS_ARMY_ABILITY_ID                   = 'A0B0'
        constant integer PARASITE_ABILITY_ID                            = 'ANpa'
        constant integer PARASITE_2_ABILITY_ID                          = 'A0CB'
        constant integer PHASE_SHIFT_ABILITY_ID                         = 'Apsh'
        constant integer PHEONIX_ABILITY_ID                             = 'AHpx'
        constant integer PILLAGE_ABILITY_ID                             = 'Asal'
        constant integer PLAGUE_ABILITY_ID                              = 'A017'
        constant integer POCKET_FACTORY_ABILITY_ID                      = 'ANsy'
        constant integer POWER_OF_ICE_ABILITY_ID                        = 'A02Z'
        constant integer POWER_OF_WATER_ABILITY_ID                      = 'A0D5'
        constant integer PULVERIZE_ABILITY_ID                           = 'Awar'
        constant integer PURGE_ABILITY_ID                               = 'A08E'
        constant integer RAIN_OF_FIRE_ABILITY_ID                        = 'ANrf'
        constant integer RAISE_DEAD_ABILITY_ID                          = 'Arai'
        constant integer RANDOM_SPELL_ABILITY_ID                        = 'A07U'
        constant integer RAPID_RECOVERY_ABILITY_ID                      = 'A03X'
        constant integer REACTION_ABILITY_ID                            = 'A06C'
        constant integer REFLECTION_AUR_ABILITY_ID                      = 'A093'
        constant integer REINCARNATION_ABILITY_ID                       = 'ANr2'
        constant integer REJUVENATION_ABILITY_ID                        = 'Arej'
        constant integer RESET_TIME_ABILITY_ID                          = 'A024'
        constant integer ENERGY_TRAP_ABILITY_ID                         = 'A052'
        constant integer RETALIATION_AUR_ABILITY_ID                     = 'A0A9'
        constant integer SAND_OF_TIME_ABILITY_ID                        = 'A083'
        constant integer SEARING_ARROWS_ABILITY_ID                      = 'A034'
        constant integer SERPANT_WARD_ABILITY_ID                        = 'AOsw'
        constant integer SHADOW_STRIKE_ABILITY_ID                       = 'AEsh'
        constant integer SHOCKWAVE_ABILITY_ID                           = 'AOsh'
        constant integer SILENCE_ABILITY_ID                             = 'ANsi'
        constant integer SLOW_AURA_ABILITY_ID                           = 'AOr2'
        constant integer SOUL_BURN_ABILITY_ID                           = 'ANso'
        constant integer SPIKED_CARAPACE_ABILITY_ID                     = 'A0CC'
        constant integer SPIRIT_LINK_ABILITY_ID                         = 'A0B7'
        constant integer STAMPEDE_ABILITY_ID                            = 'ANst'
        constant integer STARFALL_ABILITY_ID                            = 'AEsf'
        constant integer STASIS_TRAP_ABILITY_ID                         = 'Asta'
        constant integer STAT_BONUS_ABILITY_ID                          = 'A0B4'
        constant integer STONE_PROTECTION_ABILITY_ID                    = 'A060'
        constant integer STORM_BOLT_ABILITY_ID                          = 'AHtb'
        constant integer SHADOW_DANCE_ABILITY_ID                        = 'A0D1'
        constant integer SHADOW_STEP_ABILITY_ID                         = 'A0CX'
        constant integer SUMMON_BEAR_ABILITY_ID                         = 'ANsg'
        constant integer SUMMON_HAWK_ABILITY_ID                         = 'ANsw'
        constant integer SUMMON_LAVA_SPAWN_ABILITY_ID                   = 'A06K'
        constant integer SUMMON_MOUNTAIN_GIANT_ABILITY_ID               = 'AEsv'
        constant integer SUMMON_QUILBEAST_ABILITY_ID                    = 'Arsq'
        constant integer SUMMON_WATER_ELEMENTAL_ABILITY_ID              = 'AHwe'
        constant integer TEMPORARY_INVISIBILITY_ABILITY_ID              = 'A03U'
        constant integer TEMPORARY_POWER_ABILITY_ID                     = 'A04E'
        constant integer THORNS_AURA_ABILITY_ID                         = 'A08F'
        constant integer THUNDER_CLAP_ABILITY_ID                        = 'AHtc'
        constant integer THUNDER_FORCE_ABILITY_ID                       = 'A0DX'
        constant integer TIME_MANIPULATION_ABILITY_ID                   = 'A0AS'
        constant integer TRANQUILITY_ABILITY_ID                         = 'AEtq'
        constant integer TRUESHOT_AURA_ABILITY_ID                       = 'AEar'
        constant integer UNHOLY_AURA_ABILITY_ID                         = 'AUau'
        constant integer UNHOLY_FRENZY_ABILITY_ID                       = 'Auhf'
        constant integer UNLIMITED_AGON_ABILITY_ID                      = 'A0AQ'
        constant integer VAMPIRISM_ABILITY_ID                           = 'AUav'
        constant integer WAR_DRUMS_ABILITY_ID                           = 'Aakb'
        constant integer WAR_STOMP_ABILITY_ID                           = 'AOws'
        constant integer WHIRLWIND_ABILITY_ID                           = 'A025'
        constant integer WILD_DEFENSE_ABILITY_ID                        = 'A0B9'
        constant integer WIND_WALK_ABILITY_ID                           = 'AOwk'
        constant integer WIZARDBANE_AURA_ABILITY_ID                     = 'A088'
        constant integer MARTIAL_THEFT_ABILITY_ID                       = 'A05S'
        constant integer SUMMON_MAGIC_DMG_ABILITY_ID                    = 'A0CQ'
        constant integer ERUPTION_ABILITY_ID                            = 'A0DA'
        constant integer WILD_DEFENSE_SUMMON_ABILITY_ID                 = 'A06X'
        constant integer ICE_ARMOR_SUMMON_ABILITY_ID                    = 'A0CY'
        constant integer GNOME_MASTER_PASSIVE_ABILITY_ID                = 'A0DK'
        constant integer CONTEMPORARY_RUNES_ABILITY_ID                  = 'A0DN'
        constant integer ENERGY_BOMBARDMENT_ABILITY_ID                  = 'A0DQ'
        constant integer COLD_KNIGHT_PASSIVE_ABILITY_ID                 = 'A0DR'
        
        // Dummy Abilities
        constant integer ACID_SPRAY_DUMMY_ABILITY_ID                    = 'ANhs'
        constant integer BLIZZARD_DUMMY_ABILITY_ID                      = 'AHbz'
        constant integer CLOUD_DUMMY_ABILITY_ID                         = 'Aclf'
        constant integer CLUSTER_ROCKETS_DUMMY_ABILITY_ID               = 'ANcs'
        constant integer MONSOON_DUMMY_ABILITY_ID                       = 'ANmo'
        constant integer RAIN_OF_FIRE_DUMMY_ABILITY_ID                  = 'ANrf'
        constant integer STAMPEDE_DUMMY_ABILITY_ID                      = 'ANst'
        constant integer STARFALL_DUMMY_ABILITY_ID                      = 'AEsf'
        constant integer TRANQUILITY_DUMMY_ABILITY_ID                   = 'AEtq'
        constant integer STUN_ABILITY_ID                                = 'A0C2'
        constant integer CARBEE_SPIKED_CARAP_ABILITY_ID                 = 'A0CD'
        constant integer ERUPTION_IMMUNE_ABILITY_ID                     = 'A0D9'
        constant integer DEATH_AND_DECAY_DUMMY_ABILITY_ID               = 'A0E2'
        constant integer FOG_DUMMY_ABILITY_ID                           = 'A0E3'
        constant integer GNOME_MASTER_PASSIVE_DUMMY_ABILITY_ID          = 'A0EG'
        
        // Creep Abilities
        constant integer FAERIE_FIRE_CREEP_ABILITY_ID                   = 'A016'
        constant integer HURL_BOULDER_CREEP_ABILITY_ID                  = 'A00W'
        constant integer MANA_BURN_CREEP_ABILITY_ID                     = 'A00V'
        constant integer REJUVENATION_CREEP_ABILITY_ID                  = 'A00X'
        constant integer SHOCKWAVE_CREEP_ABILITY_ID                     = 'A00U'
        constant integer THUNDER_CLAP_CREEP_ABILITY_ID                  = 'A01B'

        // Active Spell Dummy Abilities

        StaticIdGroup ACTIVE_SPELL_DUMMY_ABILITIES
        constant integer ACTIVE_SPELL_DUMMY_0                           = 'A0BJ'
        constant integer ACTIVE_SPELL_DUMMY_1                           = 'A0BO'
        constant integer ACTIVE_SPELL_DUMMY_2                           = 'A0BN'
        constant integer ACTIVE_SPELL_DUMMY_3                           = 'A0BM'
        constant integer ACTIVE_SPELL_DUMMY_4                           = 'A0BG'
        constant integer ACTIVE_SPELL_DUMMY_5                           = 'A0BH'
        constant integer ACTIVE_SPELL_DUMMY_6                           = 'A0BI'
        constant integer ACTIVE_SPELL_DUMMY_7                           = 'A0BP'
        constant integer ACTIVE_SPELL_DUMMY_8                           = 'A0BK'
        constant integer ACTIVE_SPELL_DUMMY_9                           = 'A0BL'

        // --- Item Ability IDs ---

        constant integer CONTRACT_LIVING_ABIL_ID                        = 'A02P'
        constant integer BLOKKADE_SHIELD_ABIL_ID                        = 'A01X'
        constant integer TITANIUM_SPIKE_ABIL_ID                         = 'A01Y'
        constant integer TITANIUM_SPIKE_IMMUN_ABIL_ID                   = 'A032'

        constant integer FROST_CIRCLET_ABILITY_ID                       = 'A0C3'
        constant integer DECAYING_SCYTHE_ABILITY_ID                     = 'A0C4'
        constant integer DECAYING_SCYTHE_DUMMY_ABILITY_ID               = 'A0C5'
        constant integer DECAYING_SCYTHE_DUMMY2_ABILITY_ID              = 'A0C6'
        constant integer SCORCHED_SCIMITAR_ABILITY_ID                   = 'A0C1'
        constant integer SPIKED_SHIELD_ABILITY_ID                       = 'A0C7'
        constant integer DRUIDIC_FOCUS_ABILITY_ID                       = 'A0CE'
        constant integer DRUIDIC_FOCUS_ROOTS_ABILITY_ID                 = 'A0CF'
        constant integer BANNER_OF_MANY_DUMMY_ABILITY_ID                = 'A0CG'
        constant integer SPEED_BLADE_BUFF_ID                            = 'B02I'
        constant integer CONQ_BAMBOO_STICK_ABILITY_ID                   = 'A0CM'
        constant integer CONQ_BAMBOO_STICK_SUMMON_ABILITY_ID            = 'S000'
        constant integer TERRESTRIAL_GLAIVE_ABILITY_ID                  = 'A0DJ'
        constant integer DRIED_MUSHROOM_ABILITY_ID                      = 'A0DV'
        constant integer ARCANE_ABSORPTION_GAUNTLETS_ABILITY_ID         = 'A0DY'
        constant integer LIGHT_MAGIC_SHIELD_ABILITY_ID                  = 'A0E1'
        constant integer LIGHT_MAGIC_SHIELD_BUFF_ABILITY_ID             = 'A0E0'

        // --- Item IDs ---
        constant integer CONQ_BAMBOO_STICK_ITEM_ID                      = 'I0C2'
        constant integer ARCANE_INFUSED_SWORD_ITEM_ID                   = 'I0BN'
        constant integer MARTIAL_THEFT_ITEM_ID                          = 'I0BL'
        constant integer CONTRACT_LIVING_ITEM_ID                        = 'I0BF'
        constant integer BLOKKADE_SHIELD_ITEM_ID                        = 'I0BD'
        constant integer TITANIUM_SPIKE_ITEM_ID                         = 'I0BE'
        constant integer ABSOLUTE_ACORN_TOME_ITEM_ID                    = 'I09D'
        constant integer ABSOLUTE_ARCANE_ITEM_ID                        = 'I0CT'
        constant integer ABSOLUTE_BLOOD_ITEM_ID                         = 'I099'
        constant integer ABSOLUTE_COLD_ITEM_ID                          = 'I09F'
        constant integer ABSOLUTE_DARK_ITEM_ID                          = 'I098'
        constant integer ABSOLUTE_EARTH_ITEM_ID                         = 'I08V'
        constant integer ABSOLUTE_FIRE_ITEM_ID                          = 'I08T'
        constant integer ABSOLUTE_LIGHT_ITEM_ID                         = 'I097'
        constant integer ABSOLUTE_POISON_ITEM_ID                        = 'I0B3'
        constant integer ABSOLUTE_WATER_ITEM_ID                         = 'I08U'
        constant integer ABSOLUTE_WILD_ITEM_ID                          = 'I093'
        constant integer ABSOLUTE_WIND_ITEM_ID                          = 'I08W'
        constant integer ACID_BOMB_ITEM_ID                              = 'I01Z'
        constant integer ACID_SPRAY_ITEM_ID                             = 'I028'
        constant integer ACTIVATE_AVATAR_ITEM_ID                        = 'I027'
        constant integer AGILITY_LEVEL_BONUS_TOME_ITEM_ID               = 'I05H'
        constant integer HERO_FORCE_ITEM_ID                             = 'I054'
        constant integer ANCIENT_AXE_ITEM_ID                            = 'I06Y'
        constant integer DRIED_MUSHROOM_ITEM_ID                         = 'I0BT'
        constant integer DRIED_MUSHROOM_TOME_ITEM_ID                    = 'I0D8'
        constant integer ANCIENT_AXE_TOME_ITEM_ID                       = 'I06Z'
        constant integer ENERGY_TRAP_ITEM_ID                            = 'I0BJ'
        constant integer ENERGY_SHIELD_ITEM_ID                          = 'I0CJ'
        constant integer MAGNET_OSC_ITEM_ID                             = 'I0BK'
        constant integer ANCIENT_ELEMENT_ITEM_ID                        = 'I0C0'
        constant integer ANCIENT_BLOOD_ITEM_ID                          = 'I09B'
        constant integer ANCIENT_DAGGER_ITEM_ID                         = 'I06X'
        constant integer ANCIENT_DAGGER_TOME_ITEM_ID                    = 'I070'
        constant integer ANCIENT_RUNES_ITEM_ID                          = 'I08K'
        constant integer ANCIENT_STAFF_ITEM_ID                          = 'I06V'
        constant integer ANCIENT_STAFF_TOME_ITEM_ID                     = 'I06W'
        constant integer ANCIENT_TEACHING_ITEM_ID                       = 'I07N'
        constant integer ANTI_MAGIC_SHEL_ITEM_ID                        = 'I03S'
        constant integer ARCANE_ASSAUL_ITEM_ID                          = 'I09Z'
        constant integer ARCANE_STRIKE_ITEM_ID                          = 'I0B2'
        constant integer AURA_OF_FEAR_ITEM_ID                           = 'I04Y'
        constant integer AURA_OF_IMMORTALITY_ITEM_ID                    = 'I04X'
        constant integer AURA_OF_VULNERABILITY_ITEM_ID                  = 'I04Z'
        constant integer BANISH_ITEM_ID                                 = 'I02C'
        constant integer BASH_ITEM_ID                                   = 'I00L'
        constant integer BACKSTAB_ITEM_ID                               = 'I0CK'
        constant integer BATTLE_ROAR_ITEM_ID                            = 'I02D'
        constant integer BERSERK_ITEM_ID                                = 'I036'
        constant integer BIG_BAD_VOODOO_ITEM_ID                         = 'I03Z'
        constant integer BLACK_ARROW_ITEM_ID                            = 'I02R'
        constant integer BLESSED_PROTECTIO_ITEM_ID                      = 'I05V'
        constant integer BLINK_ITEM_ID                                  = 'I03M'
        constant integer BLINK_STRIKE_ITEM_ID                           = 'I09P'
        constant integer BLIZZARD_ITEM_ID                               = 'I024'
        constant integer BLOODLUST_ITEM_ID                              = 'I02F'
        constant integer BREATH_OF_FIRE_ITEM_ID                         = 'I01T'
        constant integer BRILLIANCE_AURA_ITEM_ID                        = 'I00U'
        constant integer CARRION_BEETLES_ITEM_ID                        = 'I02M'
        constant integer CARRION_SWARM_ITEM_ID                          = 'I008'
        constant integer CHAIN_LIGHTNING_ITEM_ID                        = 'I010'
        constant integer CHAOS_MAGIC_ITEM_ID                            = 'I06D'
        constant integer CHEATER_MAGIC_ITEM_ID                          = 'I05R'
        constant integer CHRONUS_WIZARD_ITEM_ID                         = 'I05Q'
        constant integer CLEAVING_ATTACK_ITEM_ID                        = 'I00N'
        constant integer CLUSTER_ROCKETS_ITEM_ID                        = 'I01A'
        constant integer COLD_ARROWS_ITEM_ID                            = 'I02S'
        constant integer COLD_WIND_ITEM_ID                              = 'I096'
        constant integer COMBUSTION_ITEM_ID                             = 'I06A'
        constant integer COMMAND_AURA_ITEM_ID                           = 'I02X'
        constant integer CORROSIVE_SKIN_ITEM_ID                         = 'I02I'
        constant integer CRITICAL_STRIKE_ITEM_ID                        = 'I00B'
        constant integer CRUELTY_ITEM_ID                                = 'I07X'
        constant integer CURSE_ITEM_ID                                  = 'I02V'
        constant integer CUTTING_ITEM_ID                                = 'I09I'
        constant integer CYCLONE_ITEM_ID                                = 'I07Q'
        constant integer DARK_SEAL_ITEM_ID                              = 'I0CH'
        constant integer DESTRUCTION_BLOCK_ITEM_ID                      = 'I0CG'
        constant integer DEATH_AND_DECAY_ITEM_ID                        = 'I02E'
        constant integer DEATH_PACT_ITEM_ID                             = 'I01V'
        constant integer DEMOLISH_ITEM_ID                               = 'I05X'
        constant integer DEMONS_CURSE_ITEM_ID                           = 'I05T'
        constant integer DESTRUCTION_ITEM_ID                            = 'I05Y'
        constant integer DEVASTATING_BLOW_ITEM_ID                       = 'I03X'
        constant integer DEVOTION_AURA_ITEM_ID                          = 'I009'
        constant integer DIVINE_BUBBLE_ITEM_ID                          = 'I09A'
        constant integer DIVINE_GIFT_ITEM_ID                            = 'I09J'
        constant integer DIVINE_SHIELD_ITEM_ID                          = 'I011'
        constant integer DOUSING_HE_ITEM_ID                             = 'I0AN'
        constant integer DRAIN_AURA_ITEM_ID                             = 'I04H'
        constant integer DRUNKEN_HAZE_ITEM_ID                           = 'I01S'
        constant integer DRUNKEN_MASTER_ITEM_ID                         = 'I05W'
        constant integer EARTHQUAKE_ITEM_ID                             = 'I094'
        constant integer ENDURANCE_AURA_ITEM_ID                         = 'I000'
        constant integer ENSNARE_ITEM_ID                                = 'I03A'
        constant integer ENTANGLING_ROOTS_ITEM_ID                       = 'I00Q'
        constant integer ENVENOMED_WEAPONS_ITEM_ID                      = 'I03E'
        constant integer EVASION_ITEM_ID                                = 'I00A'
        constant integer EXPERIENCE_20000_TOME_ITEM_ID                  = 'I05K'
        constant integer EXPERIENCE_50000_TOME_ITEM_ID                  = 'I09E'
        constant integer EXPERIENCE_100000_TOME_ITEM_ID                 = 'I07C'
        constant integer EXTRADIMENSIONAL_CO_OPERATIO_ITEM_ID           = 'I09Q'
        constant integer FAERIE_FIRE_ITEM_ID                            = 'I02T'
        constant integer FAN_OF_KNIVES_ITEM_ID                          = 'I003'
        constant integer FAST_MAGIC_ITEM_ID                             = 'I05M'
        constant integer FATAL_FLA_ITEM_ID                              = 'I0B0'
        constant integer FEARLESS_DEFENDERS_ITEM_ID                     = 'I05S'
        constant integer FERAL_SPIRIT_ITEM_ID                           = 'I004'
        constant integer FINGER_OF_DEATH_ITEM_ID                        = 'I03Q'
        constant integer FINISHING_BLOW_ITEM_ID                         = 'I050'
        constant integer FIRE_FORCE_ITEM_ID                             = 'I055'
        constant integer FIRE_SHIELD_ITEM_ID                            = 'I07L'
        constant integer FLAME_STRIKE_ITEM_ID                           = 'I005'
        constant integer FLIMSY_TOKEN_ITEM_ID                           = 'I0A3'
        constant integer FLIMSY_TOKEN_TOME_ITEM_ID                      = 'I0A6'
        constant integer FOG_ITEM_ID                                    = 'I063'
        constant integer FORKED_LIGHTNING_ITEM_ID                       = 'I001'
        constant integer FROSTBITE_OF_THE_SOUL_ITEM_ID                  = 'I09H'
        constant integer FROST_ARMOR_ITEM_ID                            = 'I01W'
        constant integer FROST_BOLT_ITEM_ID                             = 'I09G'
        constant integer FROST_NOVA_ITEM_ID                             = 'I00C'
        constant integer GLORY_ABSOLUTE_ARCANE_COUNT_TOME_ITEM_ID      = 'I0C5'
        constant integer GLORY_ABSOLUTE_BLOOD_COUNT_TOME_ITEM_ID       = 'I0C7'
        constant integer GLORY_ABSOLUTE_DARK_COUNT_TOME_ITEM_ID        = 'I0CA'
        constant integer GLORY_ABSOLUTE_COLD_COUNT_TOME_ITEM_ID        = 'I0C9'
        constant integer GLORY_ABSOLUTE_EARTH_COUNT_TOME_ITEM_ID       = 'I0CB'
        constant integer GLORY_ABSOLUTE_FIRE_COUNT_TOME_ITEM_ID        = 'I0C4'
        constant integer GLORY_ABSOLUTE_LIGHT_COUNT_TOME_ITEM_ID       = 'I0C6'
        constant integer GLORY_ABSOLUTE_POISION_COUNT_TOME_ITEM_ID     = 'I0C8'
        constant integer GLORY_ABSOLUTE_WATER_COUNT_TOME_ITEM_ID       = 'I0CD'
        constant integer GLORY_ABSOLUTE_WILD_COUNT_TOME_ITEM_ID        = 'I0CC'
        constant integer GLORY_ABSOLUTE_WIND_COUNT_TOME_ITEM_ID        = 'I0CE'
        constant integer GLORY_AGILITY_TOME_ITEM_ID                     = 'I09X'
        constant integer GLORY_ARMOR_TOME_ITEM_ID                       = 'I06O'
        constant integer GLORY_ATTACK_DAMAGE_TOME_ITEM_ID               = 'I06N'
        constant integer GLORY_BLOCK_TOME_ITEM_ID                       = 'I09V'
        constant integer GLORY_EVASION_TOME_ITEM_ID                     = 'I09Y'
        constant integer GLORY_HIT_POINTS_TOME_ITEM_ID                  = 'I06P'
        constant integer GLORY_HIT_POINT_REGENERATION_TOME_ITEM_ID      = 'I06M'
        constant integer GLORY_INTELLIGENCE_TOME_ITEM_ID                = 'I09U'
        constant integer GLORY_LUCK_TOME_ITEM_ID                        = 'I0CF'
        constant integer GLORY_MAGIC_POWER_TOME_ITEM_ID                 = 'I06R'
        constant integer GLORY_PHYS_POWER_TOME_ITEM_ID                  = 'I0CU'
        constant integer GLORY_MAGIC_PROTECTION_TOME_ITEM_ID            = 'I06Q'
        constant integer GLORY_MANA_REGENERATION_TOME_ITEM_ID           = 'I06T'
        constant integer GLORY_MANA_TOME_ITEM_ID                        = 'I06U'
        constant integer GLORY_ATTACKCD_TOME_ITEM_ID                    = 'I0D2'
        constant integer GLORY_MOVESPEED_TOME_ITEM_ID                   = 'I09T'
        constant integer GLORY_PVP_BONUS_TOME_ITEM_ID                   = 'I06S'
        constant integer GLORY_STRENGTH_TOME_ITEM_ID                    = 'I09W'
        constant integer HARDENED_SKIN_ITEM_ID                          = 'I02O'
        constant integer HEALING_WARD_ITEM_ID                           = 'I033'
        constant integer HEALING_WAVE_ITEM_ID                           = 'I029'
        constant integer HEAVY_BLOW_ITEM_ID                             = 'I069'
        constant integer HERO_BUFF_ITEM_ID                              = 'I05N'
        constant integer HOLY_ENLIGHTENMENT_ITEM_ID                     = 'I06C'
        constant integer HOLY_LIGHT_ITEM_ID                             = 'I00D'
        constant integer HOWL_OF_TERROR_ITEM_ID                         = 'I040'
        constant integer ICE_FORCE_ITEM_ID                              = 'I06L'
        constant integer ICY_BREATH_ITEM_ID                             = 'I05Z'
        constant integer IMMOLATION_ITEM_ID                             = 'I00V'
        constant integer IMPALE_ITEM_ID                                 = 'I006'
        constant integer INCINERATE_ITEM_ID                             = 'I045'
        constant integer INCOME_DEFAULT_TOME_ITEM_ID                    = 'I074'
        constant integer INCOME_INDIVIDUAL_TOME_ITEM_ID                 = 'I09O'
        constant integer ANTAGONIZE_CREEPS_ITEM_ID                      = 'I0D5'
        constant integer INFERNO_ITEM_ID                                = 'I02A'
        constant integer INNER_FIRE_ITEM_ID                             = 'I02W'
        constant integer INTELLIGENCE_LEVEL_BONUS_TOME_ITEM_ID          = 'I05I'
        constant integer LAST_BREATHS_ITEM_ID                           = 'I07J'
        constant integer LEARNABILITY_ITEM_ID                           = 'I056'
        constant integer LIFE_DRAIN_ITEM_ID                             = 'I00M'
        constant integer LIFE_TOME_ITEM_ID                              = 'I07D'
        constant integer LIGHTNING_SHIELD_ITEM_ID                       = 'I038'
        constant integer LIQUID_FIRE_ITEM_ID                            = 'I03B'
        constant integer LUCKY_PANTS_ITEM_ID                            = 'I0AJ'
        constant integer LUCKY_PANTS_TOME_ITEM_ID                       = 'I0AB'
        constant integer MAGIC_CRITICAL_HIT_ITEM_ID                     = 'I081'
        constant integer MANA_BONUS_ITEM_ID                             = 'I057'
        constant integer MANA_SHIELD_ITEM_ID                            = 'I03F'
        constant integer MANA_STARVATIO_ITEM_ID                         = 'I0AO'
        constant integer MARTIAL_RETRIBUTION_ITEM_ID                    = 'I09L'
        constant integer MANA_GEM_ITEM_ID                               = 'I0CO'
        constant integer MASK_OF_ELUSION_ITEM_ID                        = 'I0AD'
        constant integer MASK_OF_ELUSION_TOME_ITEM_ID                   = 'I0A8'
        constant integer MASK_OF_PROTECTION_ITEM_ID                     = 'I0AE'
        constant integer MASK_OF_PROTECTION_TOME_ITEM_ID                = 'I0A9'
        constant integer MASK_OF_VITALITY_ITEM_ID                       = 'I0AC'
        constant integer MASK_OF_VITALITY_TOME_ITEM_ID                  = 'I0A7'
        constant integer PACKING_TAPE_ITEM_ID                           = 'I0D7'
        constant integer PACKING_TAPE_TOME_ITEM_ID                      = 'I0D6'
        constant integer MEGA_LUCK_ITEM_ID                              = 'I085'
        constant integer MEGA_SPEED_ITEM_ID                             = 'I051'
        constant integer MIDAS_TOUCH_ITEM_ID                            = 'I00G'
        constant integer MIRROR_IMAGE_ITEM_ID                           = 'I00Z'
        constant integer MONSOON_ITEM_ID                                = 'I06G'
        constant integer MULTICAST_ITEM_ID                              = 'I068'
        constant integer MULTISHOT_ITEM_ID                              = 'I03N'
        constant integer MYSTERIOUS_TALENT_ITEM_ID                      = 'I07R'
        constant integer ORB_OF_ELEMENTS                                = 'I0CQ'
        constant integer NECROMANCERS_ARMY_ITEM_ID                      = 'I02Q'
        constant integer NON_LUCRATIVE_TOME_ITEM_ID                     = 'I0B4'
        constant integer RAPIRA_ITEM_ID                                 = 'I0CP'
        constant integer PARASITE_ITEM_ID                               = 'I02U'
        constant integer PHASE_SHIFT_ITEM_ID                            = 'I03U'
        constant integer PHOENIX_ITEM_ID                                = 'I032'
        constant integer PILLAGE_ITEM_ID                                = 'I03D'
        constant integer PLAGUE_ITEM_ID                                 = 'I03V'
        constant integer POCKET_FACTORY_ITEM_ID                         = 'I02G'
        constant integer POWER_OF_ICE_ITEM_ID                           = 'I058'
        constant integer POWER_OF_WATER_ITEM_ID                         = 'I0CR'
        constant integer PULVERIZE_ITEM_ID                              = 'I02H'
        constant integer PURGE_ITEM_ID                                  = 'I09N'
        constant integer RAIN_OF_FIRE_ITEM_ID                           = 'I025'
        constant integer RANDOM_SPELL_ITEM_ID                           = 'I09C'
        constant integer RAPID_RECOVERY_ITEM_ID                         = 'I05P'
        constant integer REACTION_ITEM_ID                               = 'I07Z'
        constant integer REFLECTION_AUR_ITEM_ID                         = 'I09S'
        constant integer REINCARNATION_ITEM_ID                          = 'I00Y'
        constant integer REJUVENATION_ITEM_ID                           = 'I037'
        constant integer RESET_TIME_ITEM_ID                             = 'I04I'
        constant integer RETALIATION_AUR_ITEM_ID                        = 'I0B1'
        constant integer SAND_OF_TIME_ITEM_ID                           = 'I09K'
        constant integer SEARING_ARROWS_ITEM_ID                         = 'I02P'
        constant integer SERPANT_WARD_ITEM_ID                           = 'I00E'
        constant integer SHADOW_STRIKE_ITEM_ID                          = 'I00F'
        constant integer SHOCKWAVE_ITEM_ID                              = 'I00R'
        constant integer SILENCE_ITEM_ID                                = 'I03C'
        constant integer SLOW_AURA_ITEM_ID                              = 'I03G'
        constant integer SOUL_BURN_ITEM_ID                              = 'I062'
        constant integer SPELLBANE_TOKEN_TOME_ITEM_ID                   = 'I0A5'
        constant integer SPELL_BANE_TOKEN_ITEM_ID                       = 'I0A1'
        constant integer SPIKED_CARAPACE_ITEM_ID                        = 'I00O'
        constant integer SPIRIT_LINK_ITEM_ID                            = 'I035'
        constant integer STAMPEDE_ITEM_ID                               = 'I026'
        constant integer STARFALL_ITEM_ID                               = 'I01Y'
        constant integer STASIS_TRAP_ITEM_ID                            = 'I044'
        constant integer STONE_PROTECTION_ITEM_ID                       = 'I07S'
        constant integer STORM_BOLT_ITEM_ID                             = 'I00X'
        constant integer STRENGTH_LEVEL_BONUS_TOME_ITEM_ID              = 'I05J'
        constant integer SHADOW_BLADE_ITEM_ID                           = 'I0CN'
        constant integer SHADOW_DANCE_ITEM_ID                           = 'I0CL'
        constant integer SHADOW_STEP_ITEM_ID                            = 'I0CI'
        constant integer SUMMON_ARMOR_BONUS_ITEM_ID                     = 'I04L'
        constant integer SUMMON_ATTACK_BONUS_ITEM_ID                    = 'I04K'
        constant integer SUMMON_BEAR_ITEM_ID                            = 'I030'
        constant integer SUMMON_CRITICAL_STRIKE_ITEM_ID                 = 'I0AP'
        constant integer SUMMON_CUTTING_ITEM_ID                         = 'I0AS'
        constant integer SUMMON_DOME_OF_PROTECTION_ITEM_ID              = 'I0BC'
        constant integer SUMMON_HAWK_ITEM_ID                            = 'I02Z'
        constant integer SUMMON_HP_BONUS_ITEM_ID                        = 'I04M'
        constant integer SUMMON_ICE_FORCE_ITEM_ID                       = 'I0AQ'
        constant integer SUMMON_LAST_BREATHS_ITEM_ID                    = 'I0AR'
        constant integer SUMMON_LAVA_SPAWN_ITEM_ID                      = 'I00T'
        constant integer SUMMON_MOUNTAIN_GIANT_ITEM_ID                  = 'I03Y'
        constant integer SUMMON_QUILBEAST_ITEM_ID                       = 'I031'
        constant integer SUMMON_WATER_ELEMENTAL_ITEM_ID                 = 'I00S'
        constant integer WILD_DEFENSE_ITEM_ID                           = 'I087'
        constant integer SWORD_OF_BLOODTHRIST_ITEM_ID                   = 'I0AI'
        constant integer SWORD_OF_BLOODTHRIST_TOME_ITEM_ID              = 'I0AG'
        constant integer TEMPORARY_INVISIBILITY_ITEM_ID                 = 'I05O'
        constant integer TEMPORARY_POWER_ITEM_ID                        = 'I067'
        constant integer THORNS_AURA_ITEM_ID                            = 'I00H'
        constant integer THUNDER_CLAP_ITEM_ID                           = 'I00I'
        constant integer THUNDER_FORCE_ITEM_ID                          = 'I053'
        constant integer TIME_MANIPULATION_ITEM_ID                      = 'I0BA'
        constant integer TOME_OF_AGILITY_5_ITEM_ID                      = 'tdx2'
        constant integer TOME_OF_AGILITY_10_ITEM_ID                     = 'I03H'
        constant integer TOME_OF_AGILITY_ITEM_ID                        = 'tdex'
        constant integer TOME_OF_EXPERIENCE_100_ITEM_ID                 = 'texp'
        constant integer TOME_OF_INTELLIGENCE_5_ITEM_ID                 = 'tin2'
        constant integer TOME_OF_INTELLIGENCE_10_ITEM_ID                = 'I03J'
        constant integer TOME_OF_INTELLIGENCE_ITEM_ID                   = 'tint'
        constant integer TOME_OF_POWER_2000_ITEM_ID                     = 'tkno'
        constant integer TOME_OF_STRENGTH_5_ITEM_ID                     = 'tst2'
        constant integer TOME_OF_STRENGTH_10_ITEM_ID                    = 'I03I'
        constant integer TOME_OF_STRENGTH_ITEM_ID                       = 'tstr'
        constant integer TRANQUILITY_ITEM_ID                            = 'I042'
        constant integer TRUESHOT_AURA_ITEM_ID                          = 'I00W'
        constant integer UNHOLY_AURA_ITEM_ID                            = 'I007'
        constant integer UNHOLY_FRENZY_ITEM_ID                          = 'I034'
        constant integer UNLIMITED_AGON_ITEM_ID                         = 'I0BB'
        constant integer VAMPIRISM_ITEM_ID                              = 'I00J'
        constant integer VIGOUR_TOKEN_ITEM_ID                           = 'I0A2'
        constant integer VIGOUR_TOKEN_TOME_ITEM_ID                      = 'I0A4'
        constant integer WAR_DRUMS_ITEM_ID                              = 'I002'
        constant integer WAR_STOMP_ITEM_ID                              = 'I00K'
        constant integer WHIRLWIND_ITEM_ID                              = 'I02B'
        constant integer WIND_WALK_ITEM_ID                              = 'I01R'
        constant integer WISDOM_CHESTPLATE_ITEM_ID                      = 'I0AH'
        constant integer WISDOM_CHESTPLATE_TOME_ITEM_ID                 = 'I0AA'
        constant integer WIZARDBANE_AURA_ITEM_ID                        = 'I09M'
        constant integer CRUSHING_WAVE_ITEM_ID                          = 'I0BI'
        constant integer SCORCHED_SCIMITAR_ITEM_ID                      = 'I0BO'
        constant integer DRUIDIC_FOCUS_ITEM_ID                          = 'I0BW'
        constant integer BANNER_OF_MANY_ITEM_ID                         = 'I0BY'
        constant integer ARCANE_RUNESTONE_ITEM_ID                       = 'I0B7'
        constant integer DARK_RUNESTONE_ITEM_ID                         = 'I0B5'
        constant integer LIGHT_RUNESTONE_ITEM_ID                        = 'I095'
        constant integer POISON_RUNESTONE_ITEM_ID                       = 'I0B8'
        constant integer WILD_RUNESTONE_ITEM_ID                         = 'I0B6'
        constant integer SHINING_RUNESTONE_ITEM_ID                      = 'I08L'
        constant integer MYSTERIOUS_RUNESTONE_ITEM_ID                   = 'I08M'
        constant integer RUNESTONE_OF_CREATION_ITEM_ID                  = 'I08N'
        constant integer FIRE_RUNESTONE_ITEM_ID                         = 'I08P'
        constant integer WATER_RUNESTONE_ITEM_ID                        = 'I08Q'
        constant integer EARTH_RUNESTONE_ITEM_ID                        = 'I08R'
        constant integer WIND_RUNESTONE_ITEM_ID                         = 'I08S'
        constant integer ERUPTION_ITEM_ID                               = 'I039'
        constant integer CONTEMPORARY_RUNES_ITEM_ID                     = 'I0D3'
        constant integer ENERGY_BOMBARDMENT_ITEM_ID                     = 'I0D4'
        constant integer LIGHT_MAGIC_SHIELD_ITEM_ID                     = 'I06K'

        // --- Buff IDs ---
        constant integer DARK_SEAL_BUFF_ID                              = 'A0DE'
        constant integer DESTR_OF_BLOCK_BUFF_ID                         = 'A0DF'
        constant integer FAN_OF_KNIVES_BUFF_ID                          = 'A0DB'
        constant integer CONQ_BAMBOO_STICK_BUFF_ID                      = 'B02J'
        constant integer CONTRACT_LIVING_BUFF_ID                        = 'A059'
        constant integer ACID_BOMB_BUFF_ID                              = 'BNab'
        constant integer ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID              = 'B01N'
        constant integer ANTI_MAGIC_SHELL_BUFF_ID                       = 'Bam2'
        constant integer AVATAR_BUFF_ID                                 = 'BHav'
        constant integer BANISH_BUFF_ID                                 = 'BHbn'
        constant integer BATTLE_ROAR_BUFF_ID                            = 'BNbr'
        constant integer BERSERK_BUFF_ID                                = 'Bbsk'
        constant integer BLACK_ARROW_BUFF_ID                            = 'BNba'
        constant integer BLEED_BUFF_ID                                  = 'B01I'
        constant integer BLIZZARD_BUFF_ID                               = 'BHbd'
        constant integer BLOODSTONE_BUFF_ID                             = 'B01V'
        constant integer BREATH_OF_FIRE_BUFF_ID                         = 'BNbf'
        constant integer BREATH_OF_FROST_BUFF_ID                        = 'BCbf'
        constant integer BURNING_OIL_BUFF_ID                            = 'Bbof'
        constant integer CHEATER_MAGIC_BUFF_ID                          = 'B01G'
        constant integer CLOUD_BUFF_ID                                  = 'Bclf'
        constant integer COLD_ARROWS_NON_STACKING_BUFF_ID               = 'BHca'
        constant integer COLD_ARROWS_STACKING_BUFF_ID                   = 'B02A'
        constant integer CORROSIZE_BREATH_BUFF_ID                       = 'Bcor'
        constant integer CRIPPLE_BUFF_ID                                = 'Bcri'
        constant integer DEATH_AND_DECAY_BUFF_ID                        = 'BUdd'
        constant integer DISEASE_BUFF_ID                                = 'Bapl'
        constant integer DISEASE_CLOUD_BUFF_ID                          = 'Bplg'
        constant integer DOOM_BUFF_ID                                   = 'BNdo'
        constant integer DOUSING_HEX_BUFF_ID                            = 'A0DD'
        constant integer DRUNKEN_HAZE_BUFF_ID                           = 'BNdh'
        constant integer EARTHQUAKE_BUFF_ID                             = 'BOeq'
        constant integer ENERGY_SHIELD_BUFF_ID                          = 'B02N'
        constant integer ENSNARE_AIR_BUFF_ID                            = 'Bena'
        constant integer ENSNARE_GENERAL_BUFF_ID                        = 'Bens'
        constant integer ENSNARE_GROUND_BUFF_ID                         = 'Beng'
        constant integer ENTANGLING_ROOTS_BUFF_ID                       = 'BEer'
        constant integer EXTRADIMENSIONAL_COOPERATION_BUFF_ID           = 'B01H'
        constant integer FAERIE_FIRE_BUFF_ID                            = 'Bfae'
        constant integer FEAR_AURA_BUFF_ID                              = 'B00H'
        constant integer FLAME_STRIKE_BUFF_ID                           = 'BHfs'
        constant integer FLIMSY_TOKEN_BUFF_ID                           = 'B01Q'
        constant integer FROST_ARMOR_BUFF_ID                            = 'BUfa'
        constant integer HERO_BUFF_ID                                   = 'B00T'
        constant integer HEX_BUFF_ID                                    = 'BOhx'
        constant integer HOWL_OF_TERROR_BUFF_ID                         = 'BNht'
        constant integer IMMOBILITY_BUFF_ID                             = 'B017'
        constant integer INCINERATE_BUFF_ID                             = 'BNic' // Completely vanilla
        constant integer INCINERATE_CUSTOM_BUFF_ID                      = 'B014' // Custom
        constant integer INNER_FIRE_BUFF_ID                             = 'Binf'
        constant integer INVULNERABLE_BUFF_ID                           = 'Bvul'
        constant integer LIGHTNING_SHIELD_BUFF_ID                       = 'Blsh'
        constant integer LIQUID_FIRE_BUFF_ID                            = 'Bliq' // Almost vanilla. Has custom target
        constant integer LIQUID_FIRE_CUSTOM_BUFF_ID                     = 'B016' // Custom
        constant integer LUCKY_PANTS_BUFF_ID                            = 'B01S'
        constant integer MANA_STARVATION_BUFF_ID                        = 'B01Z'
        constant integer MANA_STARVATION_NERF_BUFF_ID                   = 'B01X'
        constant integer MIDAS_TOUCH_BUFF_ID                            = 'B021'
        constant integer NULL_VOID_ORB_BUFF_ID                          = 'B01W'
        constant integer PARASITE_BUFF_ID                               = 'BNpa'
        constant integer PARASITE_MINION_BUFF_ID                        = 'BNpm'
        constant integer POISON_NON_STACKING_BUFF_ID                    = 'Bpoi' // Completely vanilla
        constant integer POISON_NON_STACKING_CUSTOM_BUFF_ID             = 'B015' // Custom
        constant integer POISON_STACKING_BUFF_ID                        = 'Bpsd'
        constant integer POLYMORPH_BUFF_ID                              = 'Bply'
        constant integer RAIN_OF_FIRE_BUFF_ID                           = 'BNrd'
        constant integer RAPIER_OF_THE_GODS_BUFF_ID                     = 'B000'
        constant integer REJUVENATION_BUFF_ID                           = 'Brej'
        constant integer SCROLL_OF_PROTECTION_BUFF_ID                   = 'Bdef'
        constant integer SENSATUS_SHIELD_OF_HONOR_BUFF_ID               = 'B002'
        constant integer SHADOW_STRIKE_BUFF_ID                          = 'BEsh'
        constant integer SILENCE_BUFF_ID                                = 'BNsi'
        constant integer SLEEP_BUFF_ID                                  = 'BUsl'
        constant integer SLOWED_BUFF_ID                                 = 'Bfro'
        constant integer SLOW_AURA_BUFF_ID                              = 'B001'
        constant integer SLOW_BUFF_ID                                   = 'Bslo'
        constant integer SLOW_POISON_NON_STACKING_BUFF_ID               = 'Bspo'
        constant integer SLOW_POISON_STACKING_BUFF_ID                   = 'Bssd'
        constant integer SOUL_BURN_BUFF_ID                              = 'BNso'
        constant integer SPELLBANE_TOKEN_BUFF_ID                        = 'B01R'
        constant integer SPIRIT_LINK_BUFF_ID                            = 'Bspl'
        constant integer STUNNED_BUFF_ID                                = 'BSTN' // Completely vanilla
        constant integer STUNNED_CUSTOM_BUFF_ID                         = 'B00J' // Custom
        constant integer STUNNED_PAUSE_BUFF_ID                          = 'BPSE'
        constant integer THE_CURSE_OF_DEMONS_BUFF_ID                    = 'B00V'
        constant integer THUNDER_CLAP_BUFF_ID                           = 'BHtc'
        constant integer TORNADO_SLOW_AURA_BUFF_ID                      = 'Basl'
        constant integer UNHOLY_FRENZY_BUFF_ID                          = 'BUhf'
        constant integer VIGOUR_TOKEN_BUFF_ID                           = 'B01P'
        constant integer WEB_AIR_BUFF_ID                                = 'Bwea'
        constant integer WEB_GROUND_BUFF_ID                             = 'Bweb'
        constant integer WHIRLWIND_BUFF_ID                              = 'B005'
        constant integer WISDOM_CHESTPLATE_BUFF_ID                      = 'B020'
        constant integer DECAYING_SCYTHE_BUFF_ID                        = 'B02D'
        constant integer DECAYING_SCYTHE_BUFF2_ID                       = 'B02E'
        constant integer DRUIDIC_FOCUS_BUFF_ID                          = 'B02F'
        constant integer ERUPTION_IMMUNE_BUFF_ID                        = 'B02O'
        constant integer DRUNKEN_HAZE_IGNITE_BUFF_ID                    = 'A0DL'
        constant integer DRIED_MUSHROOM_DUMMY_BUFF_ID                   = 'B02Y'

        StaticIdGroup RUNESTONE_ITEM_ABILITIES

        // --- Runestone Ability Ids
        constant integer FIRE_RUNESTONE_ABIL_ID                         = 'A076'
        constant integer WATER_RUNESTONE_ABIL_ID                        = 'A077'
        constant integer EARTH_RUNESTONE_ABIL_ID                        = 'A078'
        constant integer WIND_RUNESTONE_ABIL_ID                         = 'A079'
        constant integer LIGHT_RUNESTONE_ABIL_ID                        = 'A0AK'
        constant integer DARK_RUNESTONE_ABIL_ID                         = 'A0AL'
        constant integer ARCANE_RUNESTONE_ABIL_ID                       = 'A0AM'
        constant integer WILD_RUNESTONE_ABIL_ID                         = 'A0AN'
        constant integer POISON_RUNESTONE_ABIL_ID                       = 'A0AO'
        constant integer CREATION_RUNESTONE_ABIL_ID                     = 'A073'
        constant integer MYSTERIOUS_RUNESTONE_ABIL_ID                   = 'A072'
        constant integer SHINING_RUNESTONE_ABIL_ID                      = 'A0DM'

        // --- Buff IDs ---

        // --- Groups --- A place for groups that contains IDs from random places

        StaticIdGroup ECONOMIC_ABILITIES

        // --- Groups ---

        // --- Groups of Groups --- A place for groups that contain groups of IDs

        // --- Groups of Groups ---
    endglobals

    struct StaticIdGroup
        // Keeps track of the next available index for inserting a unit id
        private static integer FirstUnusedUnitIdIndex = 0

        // The unit id array containing all unit ids
        private static integer array UnitIds

        // The first and last index for the specific id group
        private integer BeginIndex
        private integer EndIndex

        // Store how many elements are in this group
        private integer Size

        // Parent group used when slicing
        StaticIdGroup ParentIdGroup = ID_NOT_FOUND

        public static method create takes nothing returns thistype
			local thistype this = thistype.allocate()
			
			set this.BeginIndex = FirstUnusedUnitIdIndex
			set this.EndIndex = FirstUnusedUnitIdIndex
			set this.Size = 0

			return this
		endmethod

        public method add takes integer unitId returns nothing
            // Set the unit id
            set UnitIds[FirstUnusedUnitIdIndex] = unitId
            set this.Size = this.Size + 1

            // Update the indexes
            set FirstUnusedUnitIdIndex = FirstUnusedUnitIdIndex + 1
            set this.EndIndex = FirstUnusedUnitIdIndex
        endmethod

        public method contains takes integer unitId returns boolean
            return this.find(unitId) != ID_NOT_FOUND
        endmethod

        public method find takes integer unitId returns integer
            local integer index = this.BeginIndex
            loop
                exitwhen index >= this.EndIndex
                if (this.UnitIds[index] == unitId) then
                    return index
                endif
                set index = index + 1
            endloop
            return ID_NOT_FOUND
        endmethod

        public method findRelativeIndex takes integer unitId returns integer
            local integer index = this.find(unitId)
            
            if (index != ID_NOT_FOUND) then
                return index - this.BeginIndex
            endif

            return ID_NOT_FOUND
        endmethod

        public method first takes nothing returns integer
            return this.BeginIndex
        endmethod

        public method get takes integer index returns integer
            return UnitIds[index]
        endmethod
        
        public method getByRelativeIndex takes integer index returns integer
            return UnitIds[this.BeginIndex + index]
        endmethod

        public method getParent takes nothing returns thistype
            if (this.ParentIdGroup != ID_NOT_FOUND) then
                // Continue to get the highest parent using recursion
                return this.ParentIdGroup.getParent()
            endif

            return this
        endmethod

        public method last takes nothing returns integer
            return this.EndIndex - 1
        endmethod

        public method size takes nothing returns integer
            return this.Size
        endmethod

        public method slice takes integer minIndex, integer maxIndex returns thistype
            local thistype that = thistype.create()

            set that.BeginIndex = minIndex
			set that.EndIndex = maxIndex + 1
            set that.Size = maxIndex - minIndex
            set that.ParentIdGroup = this

            return that
        endmethod
    endstruct
    
    struct StaticIdGroupIndexPair
        integer Index
        StaticIdGroup StaticIdGroup

        public static method create takes StaticIdGroup staticIdGroup, integer index returns thistype
            local thistype this = thistype.allocate()
            
            set this.StaticIdGroup = staticIdGroup
            set this.Index = index
            
            return this
        endmethod

        public method get takes nothing returns integer
            if (this.Index != ID_NOT_FOUND) then
                return StaticIdGroup.get(this.Index)
            endif

            return ID_NOT_FOUND
        endmethod
    endstruct

    struct StaticIdGrouping
        // Keeps track of the next available index for inserting a StaticIdGroup
        private static integer FirstUnusedStaticIdGroupIndex = 0

        // The StaticIdGroups groups
        private static StaticIdGroup array StaticIdGroups

        // The first and last index for the specific id group
        private integer BeginIndex
        private integer EndIndex

        public static method create takes nothing returns thistype
            local thistype this = thistype.allocate()
            
            set this.BeginIndex = FirstUnusedStaticIdGroupIndex
            set this.EndIndex = FirstUnusedStaticIdGroupIndex
            
            return this
        endmethod

        public method add takes StaticIdGroup staticIdGroup returns nothing
            // Set the unit id
            set StaticIdGroups[FirstUnusedStaticIdGroupIndex] = staticIdGroup

            // Update the indexes
            set FirstUnusedStaticIdGroupIndex = FirstUnusedStaticIdGroupIndex + 1
            set this.EndIndex = FirstUnusedStaticIdGroupIndex
        endmethod
        
        public method contains takes integer unitId returns boolean
            local integer index = this.BeginIndex
            local StaticIdGroup staticIdGroup
            
            loop
                exitwhen index >= this.EndIndex
                if (this.StaticIdGroups[index].contains(unitId)) then
                    return true
                endif
                set index = index + 1
            endloop

            return false
        endmethod

        public method find takes integer unitId returns StaticIdGroupIndexPair
            local integer index = this.BeginIndex
            
            loop
                exitwhen index >= this.EndIndex
                if (this.StaticIdGroups[index].contains(unitId)) then
                    return StaticIdGroupIndexPair.create(this.StaticIdGroups[index], this.StaticIdGroups[index].find(unitId))
                endif
                set index = index + 1
            endloop

            return ID_NOT_FOUND
        endmethod

        public method findRelativeIndex takes integer unitId returns StaticIdGroupIndexPair
            local integer index = this.BeginIndex
            
            loop
                exitwhen index >= this.EndIndex
                if (this.StaticIdGroups[index].contains(unitId)) then
                    return StaticIdGroupIndexPair.create(this.StaticIdGroups[index], this.StaticIdGroups[index].findRelativeIndex(unitId))
                endif
                set index = index + 1
            endloop

            return ID_NOT_FOUND
        endmethod
    endstruct

    private function SetupAbilities takes nothing returns nothing
        // Economic Abilities
        set ECONOMIC_ABILITIES = StaticIdGroup.create()
        call ECONOMIC_ABILITIES.add(HOLY_ENLIGHTENMENT_ABILITY_ID)
        call ECONOMIC_ABILITIES.add(LEARNABILITY_ABILITY_ID)
        call ECONOMIC_ABILITIES.add(MIDAS_TOUCH_ABILITY_ID)
        call ECONOMIC_ABILITIES.add(PILLAGE_ABILITY_ID)

        set ACTIVE_SPELL_DUMMY_ABILITIES = StaticIdGroup.create()
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_0)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_1)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_2)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_3)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_4)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_5)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_6)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_7)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_8)
        call ACTIVE_SPELL_DUMMY_ABILITIES.add(ACTIVE_SPELL_DUMMY_9)
    endfunction

    private function SetupSummons takes nothing returns nothing
        //SUMMONS
        set SUMMONS = StaticIdGroup.create()
        call SUMMONS.add(BEAR_1_UNIT_ID)
        call SUMMONS.add(FERAL_SPIRIT_WOLF_1_UNIT_ID)
        call SUMMONS.add(HAWK_1_UNIT_ID)
        call SUMMONS.add(INFERNAL_1_UNIT_ID)
        call SUMMONS.add(LAVA_SPAWN_1_UNIT_ID)
        call SUMMONS.add(QUILBEAST_1_UNIT_ID)
        call SUMMONS.add(SERPENT_WARD_1_UNIT_ID)
        call SUMMONS.add(WATER_ELEMENTAL_1_UNIT_ID)
        call SUMMONS.add(SKELETON_BATTLEMASTER_1_UNIT_ID)
        call SUMMONS.add(SKELETON_WARMAGE_1_UNIT_ID)
        call SUMMONS.add(CARRION_BEETLE_1_UNIT_ID)
        call SUMMONS.add(PARASITE_1_UNIT_ID)
        call SUMMONS.add(CLOCKWORK_GOBLIN_1_UNIT_ID)
        call SUMMONS.add(POCKET_FACTORY_1_UNIT_ID)
        call SUMMONS.add(PHOENIX_1_UNIT_ID)
        call SUMMONS.add(MOUNTAIN_GIANT_1_UNIT_ID)
        call SUMMONS.add(SKELETON_WARRIOR_1_UNIT_ID)
        call SUMMONS.add(SKELETON_MAGE_1_UNIT_ID)
        call SUMMONS.add(NECRO_BOOK_WARRIOR_1_UNIT_ID)
        call SUMMONS.add(NECRO_BOOK_ARCHER_1_UNIT_ID)
        call SUMMONS.add(FEARLESS_DEFENDER_CAPTAIN_UNIT_ID)
        call SUMMONS.add(BONE_ARMOR_SKELETON_UNIT_ID)
        call SUMMONS.add(FAERIE_DRAGON_UNIT_ID)

        // Bears
        set BEARS = StaticIdGroup.create()
        call BEARS.add(BEAR_1_UNIT_ID)
        call BEARS.add(BEAR_2_UNIT_ID)
        call BEARS.add(BEAR_3_UNIT_ID)

        // Dummy units
        set DUMMIES = StaticIdGroup.create()
        call DUMMIES.add(PET_BASE_UNIT_ID)
        call DUMMIES.add(SELL_ITEM_DUMMY)
        call DUMMIES.add(HERO_PREVIEW_UNIT_ID)
        call DUMMIES.add(PRIEST_1_UNIT_ID)
        call DUMMIES.add(DRAFT_BUY_UNIT_ID)
        call DUMMIES.add(DRAFT_UPGRADE_UNIT_ID)
        call DUMMIES.add(SUDDEN_DEATH_UNIT_ID)
        call DUMMIES.add(SHADE_BR_RESPAWN_UNIT_ID)

        // Feral Spirit Wolfs
        set FERAL_SPIRIT_WOLVES = StaticIdGroup.create()
        call FERAL_SPIRIT_WOLVES.add(FERAL_SPIRIT_WOLF_1_UNIT_ID)
        call FERAL_SPIRIT_WOLVES.add(FERAL_SPIRIT_WOLF_2_UNIT_ID)
        call FERAL_SPIRIT_WOLVES.add(FERAL_SPIRIT_WOLF_3_UNIT_ID)

        // Hawks
        set HAWKS = StaticIdGroup.create()
        call HAWKS.add(HAWK_1_UNIT_ID)
        call HAWKS.add(HAWK_2_UNIT_ID)
        call HAWKS.add(HAWK_3_UNIT_ID)

        // Infernals
        set INFERNALS = StaticIdGroup.create()
        call INFERNALS.add(INFERNAL_1_UNIT_ID)
        call INFERNALS.add(INFERNAL_2_UNIT_ID)
        call INFERNALS.add(INFERNAL_3_UNIT_ID)
        call INFERNALS.add(INFERNAL_4_UNIT_ID)
        call INFERNALS.add(INFERNAL_5_UNIT_ID)
        call INFERNALS.add(INFERNAL_6_UNIT_ID)
        call INFERNALS.add(INFERNAL_7_UNIT_ID)
        call INFERNALS.add(INFERNAL_8_UNIT_ID)
        call INFERNALS.add(INFERNAL_9_UNIT_ID)
        call INFERNALS.add(INFERNAL_10_UNIT_ID)
        call INFERNALS.add(INFERNAL_11_UNIT_ID)
        call INFERNALS.add(INFERNAL_12_UNIT_ID)
        call INFERNALS.add(INFERNAL_13_UNIT_ID)
        call INFERNALS.add(INFERNAL_14_UNIT_ID)
        call INFERNALS.add(INFERNAL_15_UNIT_ID)
        call INFERNALS.add(INFERNAL_16_UNIT_ID)
        call INFERNALS.add(INFERNAL_17_UNIT_ID)
        call INFERNALS.add(INFERNAL_18_UNIT_ID)
        call INFERNALS.add(INFERNAL_19_UNIT_ID)
        call INFERNALS.add(INFERNAL_20_UNIT_ID)
        call INFERNALS.add(INFERNAL_21_UNIT_ID)
        call INFERNALS.add(INFERNAL_22_UNIT_ID)
        call INFERNALS.add(INFERNAL_23_UNIT_ID)
        call INFERNALS.add(INFERNAL_24_UNIT_ID)
        call INFERNALS.add(INFERNAL_25_UNIT_ID)
        call INFERNALS.add(INFERNAL_26_UNIT_ID)
        call INFERNALS.add(INFERNAL_27_UNIT_ID)
        call INFERNALS.add(INFERNAL_28_UNIT_ID)
        call INFERNALS.add(INFERNAL_29_UNIT_ID)
        call INFERNALS.add(INFERNAL_30_UNIT_ID)

        // Lava Spawns
        set LAVA_SPAWNS = StaticIdGroup.create()
        call LAVA_SPAWNS.add(LAVA_SPAWN_1_UNIT_ID)
        call LAVA_SPAWNS.add(LAVA_SPAWN_2_UNIT_ID)
        call LAVA_SPAWNS.add(LAVA_SPAWN_3_UNIT_ID)

        // Quilbeasts
        set QUILBEASTS = StaticIdGroup.create()
        call QUILBEASTS.add(QUILBEAST_1_UNIT_ID)
        call QUILBEASTS.add(QUILBEAST_2_UNIT_ID)
        call QUILBEASTS.add(QUILBEAST_3_UNIT_ID)
        call QUILBEASTS.add(QUILBEAST_4_UNIT_ID)

        // Raise Dead Units
        set SKELLIESCAPTAINS = StaticIdGroup.create()
        call SKELLIESCAPTAINS.add(NECRO_BOOK_WARRIOR_1_UNIT_ID)
        call SKELLIESCAPTAINS.add(NECRO_BOOK_ARCHER_1_UNIT_ID)
        call SKELLIESCAPTAINS.add(BONE_ARMOR_SKELETON_UNIT_ID)

        // Serpant Wards
        set SERPENT_WARDS = StaticIdGroup.create()
        call SERPENT_WARDS.add(SERPENT_WARD_1_UNIT_ID)
        call SERPENT_WARDS.add(SERPENT_WARD_2_UNIT_ID)
        call SERPENT_WARDS.add(SERPENT_WARD_3_UNIT_ID)

        // Water Elementals
        set WATER_ELEMENTALS = StaticIdGroup.create()
        call WATER_ELEMENTALS.add(WATER_ELEMENTAL_1_UNIT_ID)
        call WATER_ELEMENTALS.add(WATER_ELEMENTAL_2_UNIT_ID)
        call WATER_ELEMENTALS.add(WATER_ELEMENTAL_3_UNIT_ID)

        set RUNESTONE_ITEM_ABILITIES = StaticIdGroup.create()
        call RUNESTONE_ITEM_ABILITIES.add(FIRE_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(WATER_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(EARTH_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(WIND_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(LIGHT_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(DARK_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(ARCANE_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(WILD_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(POISON_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(CREATION_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(MYSTERIOUS_RUNESTONE_ABIL_ID)
        call RUNESTONE_ITEM_ABILITIES.add(SHINING_RUNESTONE_ABIL_ID)
    endfunction

    private function SetupGroupings takes nothing returns nothing
        // Currently no groups of groups
    endfunction

    private function InitTriggers takes nothing returns nothing
        // Groups
        call SetupAbilities()
        call SetupSummons()

        // Groupings
        call SetupGroupings()
    endfunction

    private function init takes nothing returns nothing
        // Help prevent the operation limit on startup
        call InitTriggers.execute()
    endfunction

endlibrary