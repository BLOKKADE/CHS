globals 

	integer array Absolute_item
	integer array Absolute_ability
    
	hashtable ITEM_SPELL = InitHashtable()
endglobals


function SaveItemAbility takes integer abilityId, integer itemId returns nothing
	call SaveInteger(ITEM_SPELL,abilityId,1,itemId)
	call SaveInteger(ITEM_SPELL,itemId,2,abilityId)    
endfunction

function GetItemAbility takes integer itemId returns integer
	return LoadInteger(ITEM_SPELL,itemId,2)
endfunction

function Trig_Spell_Initialization_Actions takes nothing returns nothing
	/*set udg_integers08[1]=BASH_ABILITY_ID
	set udg_integers08[2]= MANA_SHIELD_ABILITY_ID
	set udg_integers08[3]= CARRION_SWARM_ABILITY_ID
	set udg_integers08[4]= CRITICAL_STRIKE_ABILITY_ID
	set udg_integers08[5]= DEVOTION_AURA_ABILITY_ID
	set udg_integers08[6]= ENDURANCE_AURA_ABILITY_ID
	set udg_integers08[7]= EVASION_ABILITY_ID
	set udg_integers08[8]= FAN_OF_KNIVES_ABILITY_ID
	set udg_integers08[9]= FERAL_SPIRIT_ABILITY_ID
	set udg_integers08[10]= FLAME_STRIKE_ABILITY_ID
	set udg_integers08[11]= FORKED_LIGHTNING_ABILITY_ID
	set udg_integers08[12]= FROST_NOVA_ABILITY_ID
	set udg_integers08[13]= INCINERATE_ABILITY_ID
	set udg_integers08[14]= HOLY_LIGHT_ABILITY_ID
	set udg_integers08[15]= IMPALE_ABILITY_ID
	set udg_integers08[16]= SERPANT_WARD_ABILITY_ID
	set udg_integers08[17]= SHADOW_STRIKE_ABILITY_ID
	set udg_integers08[18]= THORNS_AURA_ABILITY_ID
	set udg_integers08[19]= THUNDER_CLAP_ABILITY_ID
	set udg_integers08[20]= UNHOLY_AURA_ABILITY_ID
	set udg_integers08[21]= VAMPIRISM_ABILITY_ID
	set udg_integers08[22]= WAR_STOMP_ABILITY_ID
	set udg_integers08[23]= LIFE_DRAIN_ABILITY_ID
	set udg_integers08[24]= CLEAVING_ATTACK_ABILITY_ID
	set udg_integers08[25]= SPIKED_CARAPACE_ABILITY_ID
	set udg_integers08[26]= ENTAGLING_ROOTS_ABILITY_ID
	set udg_integers08[27]= SUMMON_WATER_ELEMENTAL_ABILITY_ID
	set udg_integers08[28]= SHOCKWAVE_ABILITY_ID
	set udg_integers08[29]= SUMMON_LAVA_SPAWN_ABILITY_ID
	set udg_integers08[30]= DRAIN_AURA_ABILITY_ID
	set udg_integers08[31]= TRUESHOT_AURA_ABILITY_ID
	set udg_integers08[32]= IMMOLATION_ABILITY_ID
	set udg_integers08[33]= STORM_BOLT_ABILITY_ID
	set udg_integers08[34]= MIRROR_IMAGE_ABILITY_ID
	set udg_integers08[35]= CHAIN_LIGHTNING_ABILITY_ID
	set udg_integers08[36]= TRANQUILITY_DUMMY_ABILITY_ID
	set udg_integers08[37]= CLUSTER_ROCKETS_DUMMY_ABILITY_ID
	set udg_integers08[38]= WIND_WALK_ABILITY_ID
	set udg_integers08[39]= DRUNKEN_HAZE_ABILITY_ID
	set udg_integers08[40]= BREATH_OF_FIRE_ABILITY_ID
	set udg_integers08[41]= WHIRLWIND_ABILITY_ID
	set udg_integers08[42]= RESET_TIME_ABILITY_ID
	set udg_integers08[43]= ACID_BOMB_ABILITY_ID
	set udg_integers08[44]= STARFALL_DUMMY_ABILITY_ID
	set udg_integers08[45]= ANTI_MAGIC_SHEL_ABILITY_ID
	set udg_integers08[46]= FROST_ARMOR_ABILITY_ID
	set udg_integers08[47]= BLIZZARD_DUMMY_ABILITY_ID
	set udg_integers08[48]= RAIN_OF_FIRE_DUMMY_ABILITY_ID
	set udg_integers08[49]= STAMPEDE_DUMMY_ABILITY_ID
	set udg_integers08[50]= HOWL_OF_TERROR_ABILITY_ID
	set udg_integers08[51]= INFERNO_ABILITY_ID
	set udg_integers08[52]= HEALING_WAVE_ABILITY_ID
	set udg_integers08[53]= BANISH_ABILITY_ID
	set udg_integers08[54]= ACID_SPRAY_DUMMY_ABILITY_ID
	set udg_integers08[55]= 'AHav'
	set udg_integers08[56]= BATTLE_ROAR_ABILITY_ID
	set udg_integers08[57]= DEATH_AND_DECAY_ABILITY_ID
	set udg_integers08[58]= SUMMON_MOUNTAIN_GIANT_ABILITY_ID
	set udg_integers08[59]= BLOODLUST_ABILITY_ID
	set udg_integers08[60]= POCKET_FACTORY_ABILITY_ID
	set udg_integers08[61]= PULVERIZE_ABILITY_ID
	set udg_integers08[62]= CORROSIVE_SKIN_ABILITY_ID
	set udg_integers08[63]= CARRION_BEETLES_ABILITY_ID
	set udg_integers08[64]= WAR_DRUMS_ABILITY_ID
	set udg_integers08[65]= HARDENED_SKIN_ABILITY_ID
	set udg_integers08[66]= SEARING_ARROWS_ABILITY_ID
	set udg_integers08[67]= RAISE_DEAD_ABILITY_ID
	set udg_integers08[68]= BLACK_ARROW_ABILITY_ID
	set udg_integers08[69]= COLD_ARROWS_ABILITY_ID
	set udg_integers08[70]= FAERIE_FIRE_ABILITY_ID
	set udg_integers08[71]= PARASITE_ABILITY_ID
	set udg_integers08[72]= CURSE_ABILITY_ID
	set udg_integers08[73]= INNER_FIRE_ABILITY_ID
	set udg_integers08[74]= COMMAND_AURA_ABILITY_ID
	set udg_integers08[75]= DEVASTATING_BLOW_ABILITY_ID
	set udg_integers08[76]= SUMMON_HAWK_ABILITY_ID
	set udg_integers08[77]= SUMMON_BEAR_ABILITY_ID
	set udg_integers08[78]= SUMMON_QUILBEAST_ABILITY_ID
	set udg_integers08[79]= PHEONIX_ABILITY_ID
	set udg_integers08[80]= HEALING_WARD_ABILITY_ID
	set udg_integers08[81]= UNHOLY_FRENZY_ABILITY_ID
	set udg_integers08[82]= BERSERK_ABILITY_ID
	set udg_integers08[83]= REJUVENATION_ABILITY_ID
	set udg_integers08[84]= LIGHTNING_SHIELD_ABILITY_ID
	set udg_integers08[85]= VOLCANO_DUMMY_ABILITY_ID
	set udg_integers08[86]= ENSNARE_ABILITY_ID
	set udg_integers08[87]= LIQUID_FIRE_ABILITY_ID
	set udg_integers08[88]= PLAGUE_ABILITY_ID
	set udg_integers08[89]= PILLAGE_ABILITY_ID
	set udg_integers08[90]= ENVENOMED_WEAPONS_ABILITY_ID
	set udg_integers08[91]= MULTISHOT_ABILITY_ID
	set udg_integers08[92]= SLOW_AURA_ABILITY_ID
	set udg_integers08[93]= BLINK_ABILITY_ID
	set udg_integers08[94]= PHASE_SHIFT_ABILITY_ID
	set udg_integers08[95]= FINGER_OF_DEATH_ABILITY_ID
	set udg_integers08[96]= AURA_OF_IMMORTALITY_ABILITY_ID	
	set udg_integers08[97]= AURA_OF_FEAR_ABILITY_ID
	set udg_integers08[98]= AURA_OF_VULNERABILITY_ABILITY_ID
	set udg_integers08[99]= FINISHING_BLOW_ABILITY_ID
	set udg_integers08[100]= MEGA_SPEED_ABILITY_ID
	set udg_integers08[101]= THUNDER_FORCE_ABILITY_ID
	set udg_integers08[102]= AIR_FORCE_ABILITY_ID
	set udg_integers08[103]= FIRE_FORCE_ABILITY_ID    
	set udg_integers08[104]= LEARNABILITY_ABILITY_ID  
	set udg_integers08[105]= MANA_BONUS_ABILITY_ID    
	set udg_integers08[106]= POWER_OF_ICE_ABILITY_ID  
	set udg_integers08[107]= BRILLIANCE_AURA_ABILITY_ID 
	set udg_integers08[108]= FAST_MAGIC_ABILITY_ID
	set udg_integers08[109]= HERO_BUFF_ABILITY_ID
	set udg_integers08[110]= TEMPORARY_INVISIBILITY_ABILITY_ID  
	set udg_integers08[111]= RAPID_RECOVERY_ABILITY_ID  
	set udg_integers08[112]= CHRONUS_WIZARD_ABILITY_ID     
	set udg_integers08[113]= CHEATER_MAGIC_ABILITY_ID  
	set udg_integers08[114]= FEARLESS_DEFENDERS_ABILITY_ID 
	set udg_integers08[115]= DEMONS_CURSE_ABILITY_ID     
	set udg_integers08[116]= BLESSED_PROTECTIO_ABILITY_ID 
	set udg_integers08[117]= REINCARNATION_ABILITY_ID 
	set udg_integers08[118]= DRUNKEN_MASTER_ABILITY_ID 
	set udg_integers08[119]= DEMOLISH_ABILITY_ID    
	set udg_integers08[120]= DESTRUCTION_ABILITY_ID 
	set udg_integers08[121]= BRILLIANCE_AURA_ABILITY_ID 

                                          	
	set udg_integers09[1]= BASH_ITEM_ID
	set udg_integers09[2]= MANA_SHIELD_ITEM_ID
	set udg_integers09[3]= CARRION_SWARM_ITEM_ID
	set udg_integers09[4]= CRITICAL_STRIKE_ITEM_ID
	set udg_integers09[5]= DEVOTION_AURA_ITEM_ID
	set udg_integers09[6]= ENDURANCE_AURA_ITEM_ID
	set udg_integers09[7]= EVASION_ITEM_ID
	set udg_integers09[8]= FAN_OF_KNIVES_ITEM_ID
	set udg_integers09[9]= FERAL_SPIRIT_ITEM_ID
	set udg_integers09[10]= FLAME_STRIKE_ITEM_ID
	set udg_integers09[11]= FORKED_LIGHTNING_ITEM_ID
	set udg_integers09[12]= FROST_NOVA_ITEM_ID
	set udg_integers09[13]= INCINERATE_ITEM_ID
	set udg_integers09[14]= HOLY_LIGHT_ITEM_ID
	set udg_integers09[15]= IMPALE_ITEM_ID
	set udg_integers09[16]= SERPANT_WARD_ITEM_ID
	set udg_integers09[17]= SHADOW_STRIKE_ITEM_ID
	set udg_integers09[18]= THORNS_AURA_ITEM_ID
	set udg_integers09[19]= THUNDER_CLAP_ITEM_ID
	set udg_integers09[20]= UNHOLY_AURA_ITEM_ID
	set udg_integers09[21]= VAMPIRISM_ITEM_ID
	set udg_integers09[22]= WAR_STOMP_ITEM_ID
	set udg_integers09[23]= LIFE_DRAIN_ITEM_ID
	set udg_integers09[24]= CLEAVING_ATTACK_ITEM_ID
	set udg_integers09[25]= SPIKED_CARAPACE_ITEM_ID
	set udg_integers09[26]= ENTANGLING_ROOTS_ITEM_ID
	set udg_integers09[27]= SUMMON_WATER_ELEMENTAL_ITEM_ID
	set udg_integers09[28]= SHOCKWAVE_ITEM_ID
	set udg_integers09[29]= SUMMON_LAVA_SPAWN_ITEM_ID
	set udg_integers09[30]= DRAIN_AURA_ITEM_ID
	set udg_integers09[31]= TRUESHOT_AURA_ITEM_ID
	set udg_integers09[32]= IMMOLATION_ITEM_ID
	set udg_integers09[33]= STORM_BOLT_ITEM_ID
	set udg_integers09[34]= MIRROR_IMAGE_ITEM_ID
	set udg_integers09[35]= CHAIN_LIGHTNING_ITEM_ID
	set udg_integers09[36]= TRANQUILITY_ITEM_ID
	set udg_integers09[37]= CLUSTER_ROCKETS_ITEM_ID
	set udg_integers09[38]= WIND_WALK_ITEM_ID
	set udg_integers09[39]= DRUNKEN_HAZE_ITEM_ID
	set udg_integers09[40]= BREATH_OF_FIRE_ITEM_ID
	set udg_integers09[41]= WHIRLWIND_ITEM_ID
	set udg_integers09[42]= RESET_TIME_ITEM_ID
	set udg_integers09[43]= ACID_BOMB_ITEM_ID
	set udg_integers09[44]= STARFALL_ITEM_ID
	set udg_integers09[45]= ANTI_MAGIC_SHEL_ITEM_ID
	set udg_integers09[46]= FROST_ARMOR_ITEM_ID
	set udg_integers09[47]= BLIZZARD_ITEM_ID
	set udg_integers09[48]= RAIN_OF_FIRE_ITEM_ID
	set udg_integers09[49]= STAMPEDE_ITEM_ID
	set udg_integers09[50]= HOWL_OF_TERROR_ITEM_ID
	set udg_integers09[51]= INFERNO_ITEM_ID
	set udg_integers09[52]= HEALING_WAVE_ITEM_ID
	set udg_integers09[53]= BANISH_ITEM_ID
	set udg_integers09[54]= ACID_SPRAY_ITEM_ID
	set udg_integers09[55]= ACTIVATE_AVATAR_ITEM_ID
	set udg_integers09[56]= BATTLE_ROAR_ITEM_ID
	set udg_integers09[57]= DEATH_AND_DECAY_ITEM_ID
	set udg_integers09[58]= SUMMON_MOUNTAIN_GIANT_ITEM_ID
	set udg_integers09[59]= BLOODLUST_ITEM_ID
	set udg_integers09[60]= POCKET_FACTORY_ITEM_ID
	set udg_integers09[61]= PULVERIZE_ITEM_ID
	set udg_integers09[62]= CORROSIVE_SKIN_ITEM_ID
	set udg_integers09[63]= CARRION_BEETLES_ITEM_ID
	set udg_integers09[64]= WAR_DRUMS_ITEM_ID
	set udg_integers09[65]= HARDENED_SKIN_ITEM_ID
	set udg_integers09[66]= SEARING_ARROWS_ITEM_ID
	set udg_integers09[67]= NECROMANCERS_ARMY_ITEM_ID
	set udg_integers09[68]= BLACK_ARROW_ITEM_ID
	set udg_integers09[69]= COLD_ARROWS_ITEM_ID
	set udg_integers09[70]= FAERIE_FIRE_ITEM_ID
	set udg_integers09[71]= PARASITE_ITEM_ID
	set udg_integers09[72]= CURSE_ITEM_ID
	set udg_integers09[73]= INNER_FIRE_ITEM_ID
	set udg_integers09[74]= COMMAND_AURA_ITEM_ID
	set udg_integers09[75]= DEVASTATING_BLOW_ITEM_ID
	set udg_integers09[76]= SUMMON_HAWK_ITEM_ID
	set udg_integers09[77]= SUMMON_BEAR_ITEM_ID
	set udg_integers09[78]= SUMMON_QUILBEAST_ITEM_ID
	set udg_integers09[79]= PHOENIX_ITEM_ID
	set udg_integers09[80]= HEALING_WARD_ITEM_ID
	set udg_integers09[81]= UNHOLY_FRENZY_ITEM_ID
	set udg_integers09[82]= BERSERK_ITEM_ID
	set udg_integers09[83]= REJUVENATION_ITEM_ID
	set udg_integers09[84]= LIGHTNING_SHIELD_ITEM_ID
	set udg_integers09[85]= VOLCANO_ITEM_ID
	set udg_integers09[86]= ENSNARE_ITEM_ID
	set udg_integers09[87]= LIQUID_FIRE_ITEM_ID
	set udg_integers09[88]= PLAGUE_ITEM_ID
	set udg_integers09[89]= PILLAGE_ITEM_ID
	set udg_integers09[90]= ENVENOMED_WEAPONS_ITEM_ID
	set udg_integers09[91]= MULTISHOT_ITEM_ID
	set udg_integers09[92]= SLOW_AURA_ITEM_ID
	set udg_integers09[93]= BLINK_ITEM_ID
	set udg_integers09[94]= PHASE_SHIFT_ITEM_ID
	set udg_integers09[95]= FINGER_OF_DEATH_ITEM_ID
	set udg_integers09[96]= AURA_OF_IMMORTALITY_ITEM_ID
	set udg_integers09[97]= AURA_OF_FEAR_ITEM_ID
	set udg_integers09[98]= AURA_OF_VULNERABILITY_ITEM_ID
	set udg_integers09[99]= FINISHING_BLOW_ITEM_ID
	set udg_integers09[100]= MEGA_SPEED_ITEM_ID
	set udg_integers09[101]= THUNDER_FORCE_ITEM_ID
	set udg_integers09[102]= AIR_FORCE_ITEM_ID
	set udg_integers09[103]= FIRE_FORCE_ITEM_ID
	set udg_integers09[104]= LEARNABILITY_ITEM_ID   
	set udg_integers09[105]= MANA_BONUS_ITEM_ID      
	set udg_integers09[106]= POWER_OF_ICE_ITEM_ID      	
	set udg_integers09[107]= BRILLIANCE_AURA_ITEM_ID
	set udg_integers09[108]= FAST_MAGIC_ITEM_ID  
	set udg_integers09[109]= HERO_BUFF_ITEM_ID  
	set udg_integers09[110]= TEMPORARY_INVISIBILITY_ITEM_ID		
	set udg_integers09[111]= RAPID_RECOVERY_ITEM_ID	
	set udg_integers09[112]= CHRONUS_WIZARD_ITEM_ID
	set udg_integers09[113]= CHEATER_MAGIC_ITEM_ID    
	set udg_integers09[114]= FEARLESS_DEFENDERS_ITEM_ID  
	set udg_integers09[115]= DEMONS_CURSE_ITEM_ID 
	set udg_integers09[116]= BLESSED_PROTECTIO_ITEM_ID 
	set udg_integers09[117]= REINCARNATION_ITEM_ID 
	set udg_integers09[118]= DRUNKEN_MASTER_ITEM_ID 
	set udg_integers09[119]= DEMOLISH_ITEM_ID 
	set udg_integers09[120]= DESTRUCTION_ITEM_ID 
	set udg_integers09[121]= MANA_SHIELD_ABILITY_ID    
    
    
	set udg_integers08[122]= DIVINE_SHIELD_ABILITY_ID 
	set udg_integers09[122]= DIVINE_SHIELD_ITEM_ID    
    
	set udg_integers08[123]= 'ANtm' 
	set udg_integers09[123]= MIDAS_TOUCH_ITEM_ID
    
	set udg_integers08[124]= SILENCE_ABILITY_ID 
	set udg_integers09[124]= SILENCE_ITEM_ID 
    
	set udg_integers08[125]= STASIS_TRAP_ABILITY_ID 
	set udg_integers09[125]= STASIS_TRAP_ITEM_ID     
       

	set udg_integers08[126]= 'AUdp' 
	set udg_integers09[126]= DEATH_PACT_ITEM_ID
    
	set udg_integers08[127]= BIG_BAD_VOODOO_ABILITY_ID 
	set udg_integers09[127]= BIG_BAD_VOODOO_ITEM_ID        
  
	set udg_integers08[128]= ICY_BREATH_ABILITY_ID 
	set udg_integers09[128]= ICY_BREATH_ITEM_ID
 
	set udg_integers08[129]= SOUL_BURN_ABILITY_ID 
	set udg_integers09[129]= SOUL_BURN_ITEM_ID  
        
	set udg_integers08[130]= CLOUD_DUMMY_ABILITY_ID 
	set udg_integers09[130]= FOG_ITEM_ID    
    
	set udg_integers08[131]= TEMPORARY_POWER_ABILITY_ID 
	set udg_integers09[131]= TEMPORARY_POWER_ITEM_ID    
                   
	set udg_integers08[132]= MULTICAST_ABILITY_ID 
	set udg_integers09[132]= MULTICAST_ITEM_ID  

	set udg_integers08[133]= HEAVY_BLOW_ABILITY_ID 
	set udg_integers09[133]= HEAVY_BLOW_ITEM_ID 
 
	set udg_integers08[134]= COMBUSTION_ABILITY_ID 
	set udg_integers09[134]= COMBUSTION_ITEM_ID  

	set udg_integers08[135]= HOLY_ENLIGHTENMENT_ABILITY_ID 
	set udg_integers09[135]= HOLY_ENLIGHTENMENT_ITEM_ID 



	set udg_integers08[136]= CHAOS_MAGIC_ABILITY_ID 
	set udg_integers09[136]= CHAOS_MAGIC_ITEM_ID 

	set udg_integers08[137]= MONSOON_DUMMY_ABILITY_ID 
	set udg_integers09[137]= MONSOON_ITEM_ID 

	set udg_integers08[138]= ICE_ARMOR_ABILITY_ID 
	set udg_integers09[138]= ICE_ARMOR_ITEM_ID 


	set udg_integers08[139]= LAST_BREATHS_ABILITY_ID 
	set udg_integers09[139]= LAST_BREATHS_ITEM_ID 
    
	set udg_integers08[140]= FIRE_SHIELD_ABILITY_ID 
	set udg_integers09[140]= FIRE_SHIELD_ITEM_ID 
    
    
    
	set udg_integers08[141]= ANCIENT_TEACHING_ABILITY_ID 
	set udg_integers09[141]= ANCIENT_TEACHING_ITEM_ID 
    
    
	set udg_integers08[142]= CYCLONE_ABILITY_ID 
	set udg_integers09[142]= CYCLONE_ITEM_ID 
 
 
	set udg_integers08[143]= MYSTERIOUS_TALENT_ABILITY_ID 
	set udg_integers09[143]= MYSTERIOUS_TALENT_ITEM_ID 
    
    
	set udg_integers08[144]= STONE_PROTECTION_ABILITY_ID 
	set udg_integers09[144]= STONE_PROTECTION_ITEM_ID     
    
    
	set udg_integers08[145]= CRUELTY_ABILITY_ID 
	set udg_integers09[145]= CRUELTY_ITEM_ID 
  
	set udg_integers08[146]= REACTION_ABILITY_ID 
	set udg_integers09[146]= REACTION_ITEM_ID 
    
	set udg_integers08[147]= MAGIC_CRITICAL_HIT_ABILITY_ID 
	set udg_integers09[147]= MAGIC_CRITICAL_HIT_ITEM_ID     
    
	set udg_integers08[148]= MEGA_LUCK_ABILITY_ID 
	set udg_integers09[148]= MEGA_LUCK_ITEM_ID  
 
	set udg_integers08[149]= WILD_DEFENSE_ABILITY_ID 
	set udg_integers09[149]= SUMMON_WILD_DEFENSE_ITEM_ID  
    
    
	set udg_integers08[150]= 'A06Z' 
	set udg_integers09[150]= ANCIENT_RUNES_ITEM_ID  

    
	set udg_integers08[151]= EARTHQUAKE_ABILITY_ID 
	set udg_integers09[151]= EARTHQUAKE_ITEM_ID     
	set udg_integers08[152]= COLD_WIND_ABILITY_ID 
	set udg_integers09[152]= COLD_WIND_ITEM_ID  
	set udg_integers08[153]= RANDOM_SPELL_ABILITY_ID 
	set udg_integers09[153]= RANDOM_SPELL_ITEM_ID  
	set udg_integers08[154]= DIVINE_BUBBLE_ABILITY_ID 
	set udg_integers09[154]= DIVINE_BUBBLE_ITEM_ID  
	set udg_integers08[155]= ANCIENT_ELEMENT_ABILITY_ID 
	set udg_integers09[155]= ANCIENT_ELEMENT_ITEM_ID      
   
	set udg_integers08[156]= FROST_BOLT_ABILITY_ID 
	set udg_integers09[156]= FROST_BOLT_ITEM_ID   
    
	set udg_integers08[157]= FROSTBITE_OF_THE_SOUL_ABILITY_ID 
	set udg_integers09[157]= FROSTBITE_OF_THE_SOUL_ITEM_ID   
    
	set udg_integers08[158]= CUTTING_ABILITY_ID 
	set udg_integers09[158]= CUTTING_ITEM_ID       
    
	set udg_integers08[159]= DIVINE_GIFT_ABILITY_ID 
	set udg_integers09[159]= DIVINE_GIFT_ITEM_ID   
 
 
	set udg_integers08[160]= SAND_OF_TIME_ABILITY_ID 
	set udg_integers09[160]= SAND_OF_TIME_ITEM_ID   
    
	set udg_integers08[161]= WIZARDBANE_AURA_ABILITY_ID 
	set udg_integers09[161]= WIZARDBANE_AURA_ITEM_ID  
    
	set udg_integers08[162]= MARTIAL_RETRIBUTION_ABILITY_ID 
	set udg_integers09[162]= MARTIAL_RETRIBUTION_ITEM_ID  
    
	set udg_integers08[163]= PURGE_ABILITY_ID 
	set udg_integers09[163]= PURGE_ITEM_ID

	set udg_integers08[164]= BLINK_STRIKE_ABILITY_ID 
	set udg_integers09[164]= BLINK_STRIKE_ITEM_ID

	set udg_integers08[165]= EXTRADIMENSIONAL_CO_OPERATIO_ABILITY_ID 
	set udg_integers09[165]= EXTRADIMENSIONAL_CO_OPERATIO_ITEM_ID
    
	
    
    
    
	call SaveItemAbility(ABSOLUTE_BLOOD_ABILITY_ID,ABSOLUTE_BLOOD_ITEM_ID)
	call SaveItemAbility(ABSOLUTE_DARK_ABILITY_ID,ABSOLUTE_DARK_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_EARTH_ABILITY_ID,ABSOLUTE_EARTH_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_FIRE_ABILITY_ID,ABSOLUTE_FIRE_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_LIGHT_ABILITY_ID,ABSOLUTE_LIGHT_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_WATER_ABILITY_ID,ABSOLUTE_WATER_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_WILD_ABILITY_ID,ABSOLUTE_WILD_ITEM_ID)      
	call SaveItemAbility(ABSOLUTE_WIND_ABILITY_ID,ABSOLUTE_WIND_ITEM_ID)    
	call SaveItemAbility(ABSOLUTE_COLD_ABILITY_ID,ABSOLUTE_COLD_ITEM_ID)    
	*/
    
  



endfunction