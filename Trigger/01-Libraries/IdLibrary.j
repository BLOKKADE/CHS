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

        // --- Summons ---

        // Single Summons
        constant integer CARRION_BEETLE_1_UNIT_ID                       = 'u001'
        constant integer CLOCKWORK_GOBLIN_1_UNIT_ID                     = 'n011'
        constant integer MOUNTAIN_GIANT_1_UNIT_ID                       = 'e00N'
        constant integer PARASITE_1_UNIT_ID                             = 'ncfs'
        constant integer PHOENIX_1_UNIT_ID                              = 'h009'
        constant integer POCKET_FACTORY_1_UNIT_ID                       = 'n010'
        constant integer PRIEST_1_UNIT_ID                               = 'h015'
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
        StaticIdGroup RAISE_DEAD_SPAWNS
        constant integer RAISE_DEAD_WARRIOR_1_UNIT_ID                   = 'n02S'
        constant integer RAISE_DEAD_ARCHER_1_UNIT_ID                    = 'n02R'
        constant integer RAISE_DEAD_CAPTAIN_1_UNIT_ID                   = 'h01A'
        constant integer RAISE_DEAD_SKELETON_1_UNIT_ID                  = 'u003'

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

        // --- Summons ---

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
        constant integer GRUNT_UNIT_ID                                  = 'H01J'
        constant integer LICH_UNIT_ID                                   = 'H018'
        constant integer LIEUTENANT_UNIT_ID                             = 'E000'
        constant integer MAULER_UNIT_ID                                 = 'H002'
        constant integer MEDIVH_UNIT_ID                                 = 'H01G'
        constant integer MYSTIC_UNIT_ID                                 = 'O008'
        constant integer NAHA_SIREN_UNIT_ID                             = 'H003'
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
        constant integer TROLL_BERSERKER_UNIT_ID                        = 'O00A'
        constant integer TROLL_HEADHUNTER_UNIT_ID                       = 'N00I'
        constant integer URSA_WARRIOR_UNIT_ID                           = 'N00Q'
        constant integer WAR_GOLEM_UNIT_ID                              = 'N00C'
        constant integer WITCH_DOCTOR_UNIT_ID                           = 'O006'
        constant integer YETI_UNIT_ID                                   = 'O00B'

        // Abilities
        constant integer ABSOLUTE_FIRE_ABILITY_ID                       = 'A07B'
        constant integer ATTACK_SPEED_BONUS_ABILITY_ID                  = 'A0A5'
        constant integer BLACK_ARROW_ABILITY_ID                         = 'ANba'
        constant integer BLACK_ARROW_PASSIVE_ABILITY_ID                 = 'A0AW'
        constant integer CARRION_BEETLES_ABILITY_ID                     = 'AUcb'
        constant integer CRITICAL_STRIKE_ABILITY_ID                     = 'AOcr'
        constant integer CUTTING_ABILITY_ID                             = 'A081'
        constant integer DAMAGE_BONUS_ABILITY_ID                        = 'A0A8'
        constant integer DOME_OF_PROTECTION_ABILITY_ID                  = 'A0B9'
        constant integer FERAL_SPIRIT_ABILITY_ID                        = 'AOsf'
        constant integer ICE_ARMOR_ABILITY_ID                           = 'A053'
        constant integer LAST_BREATHS_ABILITY_ID                        = 'A05R'
        constant integer PARASITE_ABILITY_ID                            = 'ANpa'
        constant integer PHEONIX_ABILITY_ID                             = 'AHpx'
        constant integer POCKET_FACTORY_ABILITY_ID                      = 'ANsy'
        constant integer RAISE_DEAD_ABILITY_ID                          = 'Arai'
        constant integer SERPANT_WARD_ABILITY_ID                        = 'AOsw'
        constant integer STAT_BONUS_ABILITY_ID                          = 'A0B4'
        constant integer SUMMON_BEAR_ABILITY_ID                         = 'ANsg'
        constant integer SUMMON_HAWK_ABILITY_ID                         = 'ANsw'
        constant integer SUMMON_LAVA_SPAWN_ABILITY_ID                   = 'ANlm'
        constant integer SUMMON_MOUNTAIN_GIANT_ABILITY_ID               = 'AEsv'
        constant integer SUMMON_QUILBEAST_ABILITY_ID                    = 'Arsq'
        constant integer SUMMON_WATER_ELEMENTAL_ABILITY_ID              = 'AHwe'
        constant integer WILD_DEFENSE_ABILITY_ID                        = 'A06X'
        
        // Tauren Abilities
        StaticIdGroup TAUREN_ABILITIES
        constant integer SPIRIT_LINK_ABILITY_ID                         = 'A0B7'
        constant integer UNHOLY_FRENZY_ABILITY_ID                       = 'Auhf'
        constant integer SHOCKWAVE_ABILITY_ID                           = 'AOsh'
        constant integer ENTAGLING_ROOTS_ABILITY_ID                     = 'AEer'
        constant integer LIFE_DRAIN_ABILITY_ID                          = 'ANdr'
        constant integer IMMOLATION_ABILITY_ID                          = 'AEim'
        constant integer STORM_BOLT_ABILITY_ID                          = 'AHtb'
        constant integer CLUSTER_ROCKETS_ABILITY_ID                     = 'A0AT'
        constant integer LIGHTNING_SHIELD_ABILITY_ID                    = 'ACls'
        constant integer PLAGUE_ABILITY_ID                              = 'A017'
        constant integer VOLCANO_ABILITY_ID                             = 'A09X'
        constant integer MIRROR_IMAGE_ABILITY_ID                        = 'AOmi'

        // --- Groupings ---

        // --- Groupings ---
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
        // Tauren Abilities
        set TAUREN_ABILITIES = StaticIdGroup.create()
        call TAUREN_ABILITIES.add(SPIRIT_LINK_ABILITY_ID)
        call TAUREN_ABILITIES.add(UNHOLY_FRENZY_ABILITY_ID)
        call TAUREN_ABILITIES.add(SHOCKWAVE_ABILITY_ID)
        call TAUREN_ABILITIES.add(ENTAGLING_ROOTS_ABILITY_ID)
        call TAUREN_ABILITIES.add(LIFE_DRAIN_ABILITY_ID)
        call TAUREN_ABILITIES.add(IMMOLATION_ABILITY_ID)
        call TAUREN_ABILITIES.add(STORM_BOLT_ABILITY_ID)
        call TAUREN_ABILITIES.add(CLUSTER_ROCKETS_ABILITY_ID)
        call TAUREN_ABILITIES.add(LIGHTNING_SHIELD_ABILITY_ID)
        call TAUREN_ABILITIES.add(PLAGUE_ABILITY_ID)
        call TAUREN_ABILITIES.add(VOLCANO_ABILITY_ID)
        call TAUREN_ABILITIES.add(MIRROR_IMAGE_ABILITY_ID)
    endfunction

    private function SetupSummons takes nothing returns nothing
        // Bears
        set BEARS = StaticIdGroup.create()
        call BEARS.add(BEAR_1_UNIT_ID)
        call BEARS.add(BEAR_2_UNIT_ID)
        call BEARS.add(BEAR_3_UNIT_ID)

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
        set RAISE_DEAD_SPAWNS = StaticIdGroup.create()
        call RAISE_DEAD_SPAWNS.add(RAISE_DEAD_WARRIOR_1_UNIT_ID)
        call RAISE_DEAD_SPAWNS.add(RAISE_DEAD_ARCHER_1_UNIT_ID)
        call RAISE_DEAD_SPAWNS.add(RAISE_DEAD_CAPTAIN_1_UNIT_ID)
        call RAISE_DEAD_SPAWNS.add(RAISE_DEAD_SKELETON_1_UNIT_ID)

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