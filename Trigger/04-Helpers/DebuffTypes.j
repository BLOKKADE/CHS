library DebuffTypes initializer init requires BuffRepository
    function SetupPositiveBuffs takes nothing returns nothing
        call SetupBuffAndAbil(INVULNERABLE_BUFF_ID, 0, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(ANTI_MAGIC_SHELL_BUFF_ID, ANTI_MAGIC_SHEL_ABILITY_ID, BUFFTYPE_POSITIVE, true)
        call SetupBuffAndAbil(AVATAR_BUFF_ID, ACTIVATE_AVATAR_ABILITY_ID, BUFFTYPE_POSITIVE, true) //unused?
        call SetupBuffAndAbil(BATTLE_ROAR_BUFF_ID, BATTLE_ROAR_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(BERSERK_BUFF_ID, BERSERK_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(FROST_ARMOR_BUFF_ID, FROST_ARMOR_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(INNER_FIRE_BUFF_ID, INNER_FIRE_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(LIGHTNING_SHIELD_BUFF_ID, LIGHTNING_SHIELD_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(REJUVENATION_BUFF_ID, REJUVENATION_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(SPIRIT_LINK_BUFF_ID, SPIRIT_LINK_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(HERO_BUFF_ID, HERO_BUFF_ABILITY_ID, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(EXTRADIMENSIONAL_COOPERATION_BUFF_ID, EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID, BUFFTYPE_POSITIVE, false)

        call SetupBuffAndAbil(SCROLL_OF_PROTECTION_BUFF_ID, 0, BUFFTYPE_POSITIVE, false) // unused?
        call SetupBuffAndAbil(SENSATUS_SHIELD_OF_HONOR_BUFF_ID, 0, BUFFTYPE_POSITIVE, false)
        call SetupBuffAndAbil(SPEED_BLADE_BUFF_ID, 'A0CJ', BUFFTYPE_POSITIVE, false)

        call SetupBuffAndAbil('B01A', 'A085', BUFFTYPE_POSITIVE, true)

        call SetupBuffAndBuffAbilAndAbil(LUCKY_PANTS_BUFF_ID, 'A09H', 0, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(MANA_STARVATION_BUFF_ID, 'A09R', MANA_STARVATIO_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(WISDOM_CHESTPLATE_BUFF_ID, 'A09S', 0, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(CHEATER_MAGIC_BUFF_ID, 'A08G', CHEATER_MAGIC_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil('B02H', 'A0CI', ANCIENT_BLOOD_ABILITY_ID, BUFFTYPE_POSITIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil('B02B', CONTRACT_LIVING_BUFF_ID, 0, BUFFTYPE_BOTH, false, true)
        call SetupBuffAndBuffAbilAndAbil('B025', 'A0AF', BLESSED_PROTECTIO_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffAndBuffAbilAndAbil('B01F', 'A08D', REACTION_ABILITY_ID, BUFFTYPE_POSITIVE, true, true)
        call SetupBuffAndBuffAbilAndAbil('B028', 'A0CT', 0, BUFFTYPE_POSITIVE, true, true)
        
        //TODO
        call SetupBuffAndAbil(DRIED_MUSHROOM_DUMMY_BUFF_ID, 0, BUFFTYPE_POSITIVE, false)
    endfunction

    //Remove all negative buffs from unit u
    function SetupNegativeBuffs takes nothing returns nothing
        call SetupBuffAndAbil(POLYMORPH_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SLOW_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(BURNING_OIL_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(LIQUID_FIRE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(HEX_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(EARTHQUAKE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(CRIPPLE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(WEB_GROUND_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(WEB_AIR_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SLEEP_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SLOW_POISON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SLOW_POISON_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(CORROSIZE_BREATH_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(POISON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(POISON_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(BLACK_ARROW_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(TORNADO_SLOW_AURA_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(DOOM_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SILENCE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // unused?
        call SetupBuffAndAbil(COLD_ARROWS_NON_STACKING_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(SLOWED_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil('Blcb', 0, BUFFTYPE_NEGATIVE, false) // ???
        call SetupBuffAndAbil(INCINERATE_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(STUNNED_CUSTOM_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) //unused?
        call SetupBuffAndAbil(DISEASE_CLOUD_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // unused
        call SetupBuffAndAbil(THUNDER_CLAP_BUFF_ID, THUNDER_CLAP_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // unused?
        call SetupBuffAndAbil(WHIRLWIND_BUFF_ID, WHIRLWIND_ABILITY_ID, BUFFTYPE_NEGATIVE, false) //unused?

        call SetupBuffAndAbil(DISEASE_BUFF_ID, PLAGUE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(DEATH_AND_DECAY_BUFF_ID, DEATH_AND_DECAY_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(ENSNARE_GENERAL_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffAndAbil(ENSNARE_AIR_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffAndAbil(ENSNARE_GROUND_BUFF_ID, ENSNARE_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffAndAbil(BLIZZARD_BUFF_ID, BLIZZARD_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(FLAME_STRIKE_BUFF_ID, FLAME_STRIKE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(BANISH_BUFF_ID, BANISH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(CLOUD_BUFF_ID, FOG_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(FAERIE_FIRE_BUFF_ID, FAERIE_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // also used by creeps change?
        call SetupBuffAndAbil(ENTANGLING_ROOTS_BUFF_ID, ENTAGLING_ROOTS_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(SHADOW_STRIKE_BUFF_ID, SHADOW_STRIKE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(DRUNKEN_HAZE_BUFF_ID, DRUNKEN_HAZE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(HOWL_OF_TERROR_BUFF_ID, HOWL_OF_TERROR_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(BREATH_OF_FIRE_BUFF_ID, BREATH_OF_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(RAIN_OF_FIRE_BUFF_ID, RAIN_OF_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(STUNNED_BUFF_ID, STUN_ABILITY_ID, BUFFTYPE_NEGATIVE, false) // used by: heart of darkness, hammer of the gods, dark hunter passive, and frost bolt
        call SetupBuffAndAbil(PARASITE_MINION_BUFF_ID, PARASITE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(STUNNED_PAUSE_BUFF_ID, HURL_BOULDER_CREEP_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(COLD_ARROWS_STACKING_BUFF_ID, COLD_ARROWS_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(THE_CURSE_OF_DEMONS_BUFF_ID, DEMONS_CURSE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(FEAR_AURA_BUFF_ID, AURA_OF_FEAR_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(SLOW_AURA_BUFF_ID, SLOW_AURA_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(IMMOBILITY_BUFF_ID, 0, BUFFTYPE_NEGATIVE, false) // wind rune
        call SetupBuffAndAbil(SOUL_BURN_BUFF_ID, SOUL_BURN_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(ACID_BOMB_BUFF_ID, ACID_BOMB_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(BREATH_OF_FROST_BUFF_ID, ICY_BREATH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(UNHOLY_FRENZY_BUFF_ID, UNHOLY_FRENZY_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(NULL_VOID_ORB_BUFF_ID, 'A09L', BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(BLOODSTONE_BUFF_ID, 'A0AR', BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(DOUSING_HEX_BUFF_ID, DOUSING_HE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(MANA_STARVATION_NERF_BUFF_ID, MANA_STARVATIO_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil(MIDAS_TOUCH_BUFF_ID, MIDAS_TOUCH_ABILITY_ID, BUFFTYPE_NEGATIVE, false)
        call SetupBuffAndAbil('A03V', TEMPORARY_INVISIBILITY_ABILITY_ID, BUFFTYPE_NEGATIVE, true)
        call SetupBuffAndAbil('Bcrs', CURSE_ABILITY_ID, BUFFTYPE_NEGATIVE, false)

        call SetupBuffAndBuffAbilAndAbil(INCINERATE_CUSTOM_BUFF_ID, 'A06L', INCINERATE_ABILITY_ID, BUFFTYPE_NEGATIVE, true, true)
        call SetupBuffAndBuffAbilAndAbil(POISON_NON_STACKING_CUSTOM_BUFF_ID, 'A06P', ENVENOMED_WEAPONS_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(LIQUID_FIRE_CUSTOM_BUFF_ID, 'A06R', LIQUID_FIRE_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(BLEED_BUFF_ID, 'A08O', URSA_WARRIOR_UNIT_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(ANCIENT_KNIFE_OF_THE_GODS_BUFF_ID, 'A095', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(FLIMSY_TOKEN_BUFF_ID, 'A09B', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(SPELLBANE_TOKEN_BUFF_ID, 'A09C', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil(VIGOUR_TOKEN_BUFF_ID, 'A09A', 0, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil('B02P', FAN_OF_KNIVES_BUFF_ID, FAN_OF_KNIVES_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
        call SetupBuffAndBuffAbilAndAbil('B02T', DARK_SEAL_BUFF_ID, DARK_SEAL_ABILITY_ID, BUFFTYPE_NEGATIVE, false, true)
    endfunction

    //Remove all buffs of buffType from unit u
    //0 = all, 1 = negative, 2 = positive
    function RemoveDebuff takes unit u, integer buffType returns nothing
        /*if buffType == 0 or buffType == 1 then
            call NegativeBuffs(u)
        endif

        if buffType == 0 or buffType == 2 then
            call PositiveBuffs(u)
        endif*/
    endfunction

    private function init takes nothing returns nothing
        call SetupPositiveBuffs()
        call SetupNegativeBuffs()
    endfunction
endlibrary
