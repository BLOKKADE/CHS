library BuffRepositoryData initializer init requires BuffRepository
    private function SetupPositiveBuffs takes nothing returns nothing
        call SetupBuffInfo1(INVULNERABLE_BUFF_ID, 0, BUFFTYPE_POSITIVE, true)
        call SetupBuffInfo1(ANTI_MAGIC_SHELL_BUFF_ID, ANTI_MAGIC_SHEL_ABILITY_ID, BUFFTYPE_POSITIVE, true)
        call SetupBuffInfo1(AVATAR_BUFF_ID, ACTIVATE_AVATAR_ABILITY_ID, BUFFTYPE_POSITIVE, true) //unused?
        call SetupBuffInfo1(BATTLE_ROAR_BUFF_ID, BATTLE_ROAR_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(BERSERK_BUFF_ID, BERSERK_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(FROST_ARMOR_BUFF_ID, FROST_ARMOR_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(INNER_FIRE_BUFF_ID, INNER_FIRE_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(LIGHTNING_SHIELD_BUFF_ID, LIGHTNING_SHIELD_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(REJUVENATION_BUFF_ID, REJUVENATION_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(SPIRIT_LINK_BUFF_ID, SPIRIT_LINK_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(HERO_BUFF_ID, HERO_BUFF_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(EXTRADIMENSIONAL_COOPERATION_BUFF_ID, EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID, BUFFTYPE_POSITIVE, false)

        call SetupBuffInfo1(SCROLL_OF_PROTECTION_BUFF_ID, 0, BUFFTYPE_POSITIVE, false) // unused?
        call SetupBuffInfo1(SENSATUS_SHIELD_OF_HONOR_BUFF_ID, 0, BUFFTYPE_POSITIVE, false)
        call SetupBuffInfo1(SPEED_BLADE_BUFF_ID, 'A0CJ', BUFFTYPE_POSITIVE, false)
        //anti magic flag
        call SetupBuffInfo1('B01A', 'A085', BUFFTYPE_POSITIVE, true)

        call SetupBuffInfo2(LUCKY_PANTS_BUFF_ID, 'A09H', 0, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2(MANA_STARVATION_BUFF_ID, 'A09R', MANA_STARVATIO_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2(WISDOM_CHESTPLATE_BUFF_ID, 'A09S', 0, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2(CHEATER_MAGIC_BUFF_ID, 'A08G', CHEATER_MAGIC_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2('B02H', 'A0CI', ANCIENT_BLOOD_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2('B02B', CONTRACT_LIVING_BUFF_ID, 0, BUFFTYPE_BOTH, false, true)
        call SetupBuffInfo2('B025', 'A0AF', BLESSED_PROTECTIO_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B01F', 'A08D', REACTION_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        //scroll of transformation
        call SetupBuffInfo2('B028', 'A0CT', 0, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B01E', 'A08C', DIVINE_BUBBLE_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B02O', ERUPTION_IMMUNE_ABILITY_ID, ERUPTION_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B01K', 'A091', GRUNT_UNIT_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B02V', DRUNKEN_HAZE_IGNITE_BUFF_ID, DRUNKEN_HAZE_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2('B01D', 'A08B', LAST_BREATHS_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffInfo2('B02C', 'A086', MARTIAL_THEFT_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B029', 'A0BB', SKELETON_BRUTE_UNIT_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffInfo2('B01M', 'A092', YETI_UNIT_ID, BUFFTYPE_POSITIVE, true, true)
        
        //TODO
        call SetupBuffInfo1(DRIED_MUSHROOM_DUMMY_BUFF_ID, 0, BUFFTYPE_POSITIVE, false)
    endfunction

    //Remove all negative buffs from unit u
    private function SetupNegativeBuffs takes nothing returns nothing
        call SetupBuffInfo1(POLYMORPH_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SLOW_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(BURNING_OIL_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(LIQUID_FIRE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(HEX_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(EARTHQUAKE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(CRIPPLE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(WEB_GROUND_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(WEB_AIR_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SLEEP_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SLOW_POISON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SLOW_POISON_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(CORROSIZE_BREATH_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(POISON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(POISON_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(BLACK_ARROW_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(TORNADO_SLOW_AURA_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(DOOM_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SILENCE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // unused?
        call SetupBuffInfo1(COLD_ARROWS_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(SLOWED_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1('Blcb', 0, BUFFTYPE_NEGATIVE, false) // ???
        call SetupBuffInfo1(INCINERATE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(STUNNED_CUSTOM_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffInfo1(DISEASE_CLOUD_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // unused
        call SetupBuffInfo1(THUNDER_CLAP_BUFF_ID, THUNDER_CLAP_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // unused?
        call SetupBuffInfo1(WHIRLWIND_BUFF_ID, WHIRLWIND_ABILITY_ID, BUFFTYPE_NEGATIVE, false) //unused?

        call SetupBuffInfo1(DISEASE_BUFF_ID, PLAGUE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(DEATH_AND_DECAY_BUFF_ID, DEATH_AND_DECAY_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(ENSNARE_GENERAL_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffInfo1(ENSNARE_AIR_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffInfo1(ENSNARE_GROUND_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffInfo1(BLIZZARD_BUFF_ID, BLIZZARD_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(FLAME_STRIKE_BUFF_ID, FLAME_STRIKE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(BANISH_BUFF_ID, BANISH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(CLOUD_BUFF_ID, FOG_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(FAERIE_FIRE_BUFF_ID, FAERIE_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // also used by creeps change?
        call SetupBuffInfo1(ENTANGLING_ROOTS_BUFF_ID, ENTAGLING_ROOTS_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(SHADOW_STRIKE_BUFF_ID, SHADOW_STRIKE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(DRUNKEN_HAZE_BUFF_ID, DRUNKEN_HAZE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(HOWL_OF_TERROR_BUFF_ID, HOWL_OF_TERROR_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(BREATH_OF_FIRE_BUFF_ID, BREATH_OF_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(RAIN_OF_FIRE_BUFF_ID, RAIN_OF_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(STUNNED_BUFF_ID, STUN_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // used by: heart of darkness, hammer of the gods, dark hunter passive, and frost bolt
        call SetupBuffInfo1(PARASITE_MINION_BUFF_ID, PARASITE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(STUNNED_PAUSE_BUFF_ID, HURL_BOULDER_CREEP_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(COLD_ARROWS_STACKING_BUFF_ID, COLD_ARROWS_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(THE_CURSE_OF_DEMONS_BUFF_ID, DEMONS_CURSE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(FEAR_AURA_BUFF_ID, AURA_OF_FEAR_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(SLOW_AURA_BUFF_ID, SLOW_AURA_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(IMMOBILITY_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // wind rune
        call SetupBuffInfo1(SOUL_BURN_BUFF_ID, SOUL_BURN_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(ACID_BOMB_BUFF_ID, ACID_BOMB_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(BREATH_OF_FROST_BUFF_ID, ICY_BREATH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(UNHOLY_FRENZY_BUFF_ID, UNHOLY_FRENZY_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(NULL_VOID_ORB_BUFF_ID, 'A09L', BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(BLOODSTONE_BUFF_ID, 'A0AR', BUFFTYPE_NEGATIVE, false)
        
        call SetupBuffInfo1(MANA_STARVATION_NERF_BUFF_ID, MANA_STARVATIO_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1(MIDAS_TOUCH_BUFF_ID, MIDAS_TOUCH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffInfo1('A03V', TEMPORARY_INVISIBILITY_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffInfo1('Bcrs', CURSE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)

        call SetupBuffInfo2(INCINERATE_CUSTOM_BUFF_ID, 'A06L', INCINERATE_ABILITY_ID, BUFFTYPE_NEGATIVE, true, true)
        call SetupBuffInfo2(POISON_NON_STACKING_CUSTOM_BUFF_ID, 'A06P', ENVENOMED_WEAPONS_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(LIQUID_FIRE_CUSTOM_BUFF_ID, 'A06R', LIQUID_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(BLEED_BUFF_ID, 'A08O', URSA_WARRIOR_UNIT_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID, 'A095', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(FLIMSY_TOKEN_BUFF_ID, 'A09B', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(SPELLBANE_TOKEN_BUFF_ID, 'A09C', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2(VIGOUR_TOKEN_BUFF_ID, 'A09A', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B02P', FAN_OF_KNIVES_BUFF_ID, FAN_OF_KNIVES_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B02T', DARK_SEAL_BUFF_ID, DARK_SEAL_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B02X', 'A0DS', ABSOLUTE_COLD_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B02S', 'A0DF', DESTRUCTION_BLOCK_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B02X', 'A0DS', ABSOLUTE_COLD_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B01Y', DOUSING_HEX_BUFF_ID, DOUSING_HE_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffInfo2('B01Y', DOUSING_HEX_BUFF_ID, DOUSING_HE_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        //fishing rod
        call SetupBuffInfo2('B02U', 'A0DI', 0, BUFFTYPE_NEGATIVE, false, true)
    endfunction

    private function init takes nothing returns nothing
        call SetupPositiveBuffs()
        call SetupNegativeBuffs()
    endfunction
endlibrary
