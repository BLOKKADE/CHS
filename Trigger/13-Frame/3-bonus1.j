library HeroData initializer init
    globals
        hashtable HT_data = InitHashtable()
    endglobals

    private function init takes nothing returns nothing
        call SaveStr(HT_data,LIEUTENANT_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSpellBreaker.blp" )        //letinant
        call SaveStr(HT_data,LIEUTENANT_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +8 to two random stats." )

        call SaveStr(HT_data,ABOMINATION_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNAbomination.blp" )       // amb
        call SaveStr(HT_data,ABOMINATION_UNIT_ID,2, "|cff00ffffPassive|r: Disease Cloud: Deals |cffff00ffmagic damage|r to nearby enemies every second. ")
        call SaveStr(HT_data,ABOMINATION_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Disease Cloud: +40 damage." )
        
        call SaveStr(HT_data,DRUID_OF_THE_CLAY_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheClaw.blp" )       // druid1
        call SaveStr(HT_data,DRUID_OF_THE_CLAY_UNIT_ID,2, "|cff00ffffPassive|r: Animal Affection: Summon attack damage, armor, magic power and magic resistance are increased by a percentage of the Hero's amount. [|cff9e5d07Summon|r] spells have 50% reduced cooldown. ")
        call SaveStr(HT_data,DRUID_OF_THE_CLAY_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +1% Animal Affection summon stat increase." )
        
        call SaveStr(HT_data,MAULER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroPaladin.blp" )       // paladin
        call SaveStr(HT_data,MAULER_UNIT_ID,2, "|cff00ffffPassive|r: Lightbringer: Gets a free point towards the [|cffd2d2d2Light|r] element just for existing. ")
        call SaveStr(HT_data,MAULER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 8 levels|r) Lightbringer: +1 point towards [|cffd2d2d2Light|r].")   
    
        call SaveStr(HT_data,BLOOD_MAGE_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince.blp" )       // mage
        call SaveStr(HT_data,BLOOD_MAGE_UNIT_ID,2, "|cff00ffffPassive|r: Mana Lifeforce: Gains 1 magic power per 1000 total mana ")
        call SaveStr(HT_data,BLOOD_MAGE_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +250 mana." )   
        
        call SaveStr(HT_data,'H004',1, "ReplaceableTextures\\CommandButtons\\BTNMortarTeam.blp" )       // mortal team
        call SaveStr(HT_data,'H004',2, "|cff00ffffPassive|r: Mortar Aura: Increases all |cffff8080physical damage|r dealt by a percentage. ")
        call SaveStr(HT_data,'H004',3, "|cffffff00Level Up Bonus|r: Mortar Aura: +3% physical damage bonus." )    
                    
        call SaveStr(HT_data,NAHA_SIREN_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNNagaSummoner.blp" )       // naga
        call SaveStr(HT_data,NAHA_SIREN_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Increases intelligence by a random amount between 1 and 11. Repeats if strength is at 0 and again if agility is at 0." )    
        
        call SaveStr(HT_data,AVATAR_SPIRIT_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNPossession.blp" )       // avatar
        call SaveStr(HT_data,AVATAR_SPIRIT_UNIT_ID,2, "|cff00ffffPassive|r: Glow In The Dark: When the Hero has more [|cffd2d2d2Light|r] than [|cff000000Dark|r] abilities it gains bonus armor and attack damage, if it has more [|cff000000Dark|r] than [|cffd2d2d2Light|r] abilities it gains bonus magic protection and magic power.")
        call SaveStr(HT_data,AVATAR_SPIRIT_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Glow In The Dark: [|cffd2d2d2Light|r] mode: +1% armor, +20 attack damage. [|cff000000Dark|r] mode: +0.3 magic protection, +0.75 magic power." )                    
            
        call SaveStr(HT_data,DEMON_HUNTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroDemonHunter.blp" )       // Demon Hunter
        call SaveStr(HT_data,DEMON_HUNTER_UNIT_ID,2, "|cff00ffffPassive|r: Feedback: Every time the Hero attacks it drains enemy mana, giving it to himself. ")
        call SaveStr(HT_data,DEMON_HUNTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Feedback: +20 mana drained." )                    
        
        call SaveStr(HT_data,DEADLORD_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNTichondrius.blp" )       // Dread lord
        call SaveStr(HT_data,DEADLORD_UNIT_ID,2, "|cff00ffffPassive|r: Vampire: Lifesteal on all damage dealt by the Hero and its summons. Killing an enemy restores 10% of its maximum hit points. [|cffff9696Lifesteal|r]")
        call SaveStr(HT_data,DEADLORD_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Vampire: +0.5% lifesteal" )  
        
        call SaveStr(HT_data,PYROMANCER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNChaosSpaceOrc.blp" )       // Pyromancer
        call SaveStr(HT_data,PYROMANCER_UNIT_ID,2, "|cff00ffffPassive|r: Scorched Earth: Once every second when the Hero deals [|cffff0000Fire|r] damage it sets the ground on fire for 2 seconds. Units within the fire have a chance to miss any damage dealt and have a higher chance to get hit by crits. [|cff96ffffStable|r] The Pyromancer's attacks deal damage in a line.")
        call SaveStr(HT_data,PYROMANCER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +35 maximum attack damage. Scorched Earth: +0.5% miss chance, +0.1% crit chance. +1 area of effect." )  
        
        call SaveStr(HT_data,TAUREN_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSpiritWalker.blp" )       // tauren
        call SaveStr(HT_data,TAUREN_UNIT_ID,2, "|cff00ffffPassive|r: Spirit Mage: Gains +5 Rune Power for every active spell it has. All [Element] damage deals 5% bonus damage based on how many of the [Element] the Hero has.")
        call SaveStr(HT_data,TAUREN_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Spirit Mage: +0.25 Rune Power per active spell. +0.05% damage per [Element]")
        
        call SaveStr(HT_data,MYSTIC_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheTalon.blp" )       // Mystic
        call SaveStr(HT_data,MYSTIC_UNIT_ID,2, "|cff00ffffPassive|r: Faerie Friend: At the start of every round the Mystic summons an invulnerable Faerie Dragon to aid it in battle.")
        call SaveStr(HT_data,MYSTIC_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +40 summon damage. Faerie Dragon: +3% attack speed. (|cff68eef3Every 3 levels|r) increases Faerie Dragon damage." )
            
        call SaveStr(HT_data,PIT_LORD_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNPitLord.blp" )       // Pit Lord
        call SaveStr(HT_data,PIT_LORD_UNIT_ID,2, "|cff00ffffPassive|r: Hellforged: Starts with Absolute Fire. 1 magic power increases |cffff8080physical damage|r dealt by 1%. |cffc0c0c0Hellforged and Absolute Fire become 25% less effective for every |r [|cff00f7ffWater|r] |cffc0c0c0spell learned.|r")
        call SaveStr(HT_data,PIT_LORD_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Hellforged: +0.5% Absolute Fire magic power bonus." )
            
        call SaveStr(HT_data,THUNDER_WITCH_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSorceress.blp" )       // Thunder Witch
        call SaveStr(HT_data,THUNDER_WITCH_UNIT_ID,2, "|cff00ffffPassive|r: Thunder Bolt: Deals |cffff00ffmagic damage|r to 2 nearby enemies every second. [|cff96ffffStable|r]. Your magic power is doubled for Thunder Bolt.")
        call SaveStr(HT_data,THUNDER_WITCH_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Thunder Bolt: +30 damage. (|cff68eef3Every 30 levels|r) +1 target." )
                
        call SaveStr(HT_data,'U000',1, "ReplaceableTextures\\CommandButtons\\BTNThrall.blp" )       // Trall
        call SaveStr(HT_data,'U000',2, "|cff00ffffPassive|r: Speed Freak: Whenever the Hero finishes a round within 6 seconds it permanently gains 10 bonus agility. The Hero's lowest stats are automatically boosted to 50% of its highest stat when they drop lower.")
        call SaveStr(HT_data,'U000',3, "|cffffff00Level Up Bonus|r: Speed Freak: +1 bonus agility gained." )
                
        call SaveStr(HT_data,BLADE_MASTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroBlademaster.blp" )       // Blade master
        call SaveStr(HT_data,BLADE_MASTER_UNIT_ID,2, "|cff00ffffPassive|r: Bladestorm: Every 9 attacks it creates a Bladestorm, dealing 50% of its attack damage to nearby enemies as |cffff8080physical damage|r.")
        call SaveStr(HT_data,BLADE_MASTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Bladestorm: +35 damage, +3 area of effect. (|cff68eef3Every 20 levels|r) reduces attacks required by 1." )
                                                    
        call SaveStr(HT_data,ORC_CHAMPION_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNChaosGrom.blp" )       // Grom
        call SaveStr(HT_data,ORC_CHAMPION_UNIT_ID,2, "|cff00ffffPassive|r: Valiant Strike: All damage dealt by the Hero and its summons have 20% of the Hero's strength added to it.")
        call SaveStr(HT_data,ORC_CHAMPION_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Valiant Strike: +1% damage from strength. +3 armor and +6 hit point regeneration." )
        
        call SaveStr(HT_data,TROLL_HEADHUNTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeadHunterBerserker.blp" )       // Troll Head Hunter
        call SaveStr(HT_data,TROLL_HEADHUNTER_UNIT_ID,2, "|cff00ffffPassive|r: Troll Anatomy: Gains bonus hit point regen based on 40% of its strength. ")
        call SaveStr(HT_data,TROLL_HEADHUNTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Troll Anatomy: +1.5% strength conversion." )
                        
        call SaveStr(HT_data,'N00L',1, "ReplaceableTextures\\CommandButtons\\BTNHeroTinker.blp" )       // Tinker
        call SaveStr(HT_data,'N00L',3, "|cffffff00Level Up Bonus|r: Gains 55 * hero level experience." )
        
        call SaveStr(HT_data,BEAST_MASTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNBeastMaster.blp" )       // Beast master
        call SaveStr(HT_data,BEAST_MASTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 3 levels|r) Increases the level of all summons by 1." )
            
        call SaveStr(HT_data,FALLEN_RANGER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNBansheeRanger.blp" )       // Fallen Ranger
        call SaveStr(HT_data,FALLEN_RANGER_UNIT_ID,2, "|cff00ffffPassive|r: Fear Aura: Reduces the armor of nearby enemies. ")
        call SaveStr(HT_data,FALLEN_RANGER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Fear Aura: +3 armor reduction." )
        
        call SaveStr(HT_data,'N00R',1, "ReplaceableTextures\\CommandButtons\\BTNHuntress.blp" )       // Luna
        call SaveStr(HT_data,'N00R',2, "|cff00ffffPassive|r: Moon Chakrum: Damages 8 nearby enemies every time the Hero attacks, dealing 50% of her attack in |cffff00ffmagic damage|r. ")
        call SaveStr(HT_data,'N00R',3, "|cffffff00Level Up Bonus|r: Moon Chakrum: +0.5% of her attack damage" )
            
        call SaveStr(HT_data,SKELETON_BRUTE_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSkeletalOrc.blp" )       // Brute Skelet
        call SaveStr(HT_data,SKELETON_BRUTE_UNIT_ID,2, "|cff00ffffPassive|r: Reinforced Bone: When the Hero takes 30% or more of its max HP in damage at once it cannot take damage again for 1 second. 10s cooldown. [|cff96ffffStable|r]. When one of its summons die the Hero restores 2% of its max HP and the summon explodes, dealing 50 |cffff00ffmagic damage|r to enemies.")
        call SaveStr(HT_data,SKELETON_BRUTE_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Reinforced Bone: +0.01 second invulnerability. +0.05% of maximum hit points restored. +30 explosion damage." )
                
        call SaveStr(HT_data,SORCERER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNJaina.blp" )       // Sorser
        call SaveStr(HT_data,SORCERER_UNIT_ID,2, "|cff00ffffPassive|r: Lightning Strike: Deals |cffff00ffmagic damage|r to 3 nearby enemies whenever the Hero casts a spell. ")
        call SaveStr(HT_data,SORCERER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Lightning Strike: +50 damage." )
                    
        call SaveStr(HT_data,URSA_WARRIOR_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNFurbolgElder.blp" )       // Ursa
        call SaveStr(HT_data,URSA_WARRIOR_UNIT_ID,2, "|cff00ffffPassive|r: Bleed: Every time it attacks it causes enemies to bleed for 3 seconds, dealing 30% of its attack in |cffff8080physical damage|r per second. ")
        call SaveStr(HT_data,URSA_WARRIOR_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +10 attack damage." )
                            
        call SaveStr(HT_data,WAR_GOLEM_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNFleshGolem.blp" )       // War golem
        call SaveStr(HT_data,WAR_GOLEM_UNIT_ID,2, "|cff00ffffPassive|r: Construct: Receives 50% bonus hit points from its strength stat. ")
        call SaveStr(HT_data,WAR_GOLEM_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Construct: +1% bonus hit points from strength." )         
            
        call SaveStr(HT_data,WITCH_DOCTOR_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNOrcWarlockRed.blp" )       // warlock
        call SaveStr(HT_data,WITCH_DOCTOR_UNIT_ID,2, "|cff00ffffPassive|r: Absolute Magic: Starts with a bonus absolute slot.")
        call SaveStr(HT_data,WITCH_DOCTOR_UNIT_ID,3, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 25 levels|r) Absolute Magic: Gets a free point towards all elements he has Absolute Spells for. (|cff68f386Every 20 levels|r) Gets a bonus Absolute slot. (max 10)" ) 
        
        call SaveStr(HT_data,RANGER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSylvanusWindrunner.blp" )       // sylvane
        call SaveStr(HT_data,RANGER_UNIT_ID,2, "|cff00ffffPassive|r: Ranger Crit: 11% chance to deal 5% bonus |cffff8080physical damage|r. [|cff80ff80Luck|r][|cff00ffffCrit|r]")
        call SaveStr(HT_data,RANGER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +5% base damage to all critical hits.")       
        
        call SaveStr(HT_data,DARK_HUNTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNUnbroken.blp" )       // void
        call SaveStr(HT_data,DARK_HUNTER_UNIT_ID,2, "|cff00ffffPassive|r: Void Bash: When the Hero damages an enemy it has a 20% chance to deal 50 bonus |cffff00ffmagical damage|r and stun it for 0.2 seconds. ")
        call SaveStr(HT_data,DARK_HUNTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Void Bash: +50 damage" )     
                
        call SaveStr(HT_data,DOOM_GUARD_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNDoomGuard.blp" )       // DOOMguard
        call SaveStr(HT_data,DOOM_GUARD_UNIT_ID,2, "|cff00ffffPassive|r: Hellfire: Deals initial |cffff00ffmagic damage|r and |cffff00ffmagic damage|r per second to nearby enemies for 8 seconds, every 8 seconds. [|cff96ffffStable|r]")
        call SaveStr(HT_data,DOOM_GUARD_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Hellfire: +50 initial damage, +10 damage per second." )                      
                    
        call SaveStr(HT_data,ROCK_GOLEM_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNRockGolem.blp" )       // golem
        call SaveStr(HT_data,ROCK_GOLEM_UNIT_ID,2, "|cff00ffffPassive|r: Stone Edge: When the Golem is damaged it deals 50% of its block in |cffff8080physical damage|r to nearby enemy units within 400 range. 1 second cooldown. [|cff96ffffStable|r]")
        call SaveStr(HT_data,ROCK_GOLEM_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Stone Edge: +1% block damage. +1% block." )       
        
        call SaveStr(HT_data,COLD_KNIGHT_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNRevenant.blp" )  
        //   call SaveStr(HT_data,COLD_KNIGHT_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNFrostRevenant.blp" )       // cold
        call SaveStr(HT_data,COLD_KNIGHT_UNIT_ID,2, "|cff00ffffPassive|r: Frost Aura: Reduces the attack speed and movement speed of enemies.")
        call SaveStr(HT_data,COLD_KNIGHT_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Frost Aura: +6% attack speed reduction . +0.5% movespeed reduction (max 95%)" )  

        call SaveStr(HT_data,LICH_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroLich.blp" )       // Lich
        call SaveStr(HT_data,LICH_UNIT_ID,2, "|cff00ffffPassive|r: Flash Freeze: When the Hero deals |cffff00ffmagic damage|r it uses Flash Freeze on the enemy, dealing |cffff00ffmagical damage|r in an area around the target based on 100% of its intelligence once every 6 seconds. ")
        call SaveStr(HT_data,LICH_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Flash Freeze: +60 damage." ) 
        
        call SaveStr(HT_data,GNOME_MASTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroMountainKing.blp" )       // Gnome master
        call SaveStr(HT_data,GNOME_MASTER_UNIT_ID,2, "|cff00ffffPassive|r: Gnome Stomp: At the start of every fight it deals |cffff00ffmagical damage|r and stuns all nearby heroes for 1 second and creeps for 2 seconds. ")
        call SaveStr(HT_data,GNOME_MASTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Gnome Stomp: +55 damage, +0.04 seconds hero stun, +0.08 seconds creep stun." )             

        call SaveStr(HT_data,'N02P',1, "ReplaceableTextures\\CommandButtons\\BTNHeroAlchemist.blp" )       // Greed goblin
        call SaveStr(HT_data,'N02P',2, "|cff00ffffPassive|r: Greed: Gains 25 bonus gold and experience whenever it kills a unit. |cffc0c0c01% less effective for each level of PillagePillage and Learnability are 22% less effective.|r.")
        call SaveStr(HT_data,'N02P',3, "|cffffff00Level Up Bonus|r: Greed: +3 bonus gold and +4 experience" ) 

        call SaveStr(HT_data,CENTAUR_ARCHER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNCentaurArcher.blp" )       // Cent archer
        call SaveStr(HT_data,CENTAUR_ARCHER_UNIT_ID,2, "|cff00ffffPassive|r: Horsepower: Attacks deal 100% bonus |cffff8080physical damage|r + 6% of the targets total hit points once every 2 seconds.")
        call SaveStr(HT_data,CENTAUR_ARCHER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Horsepower: +5% damage." )

        call SaveStr(HT_data,OGRE_WARRIOR_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNOgre.blp" )       // ogre
        call SaveStr(HT_data,OGRE_WARRIOR_UNIT_ID,2, "|cff00ffffPassive|r: Ogre Stomp: Once every 6 seconds when the Hero deals |cffff8080physical damage|r it damages nearby enemies for 100% of its strength in |cffff00ffmagic damage|r and stuns them for 1 second.")
        call SaveStr(HT_data,OGRE_WARRIOR_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Ogre Stomp: +60 damage" )

        call SaveStr(HT_data,TIME_WARRIOR_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNGhostOfKelThuzad.blp" )       //Xesil
        call SaveStr(HT_data,TIME_WARRIOR_UNIT_ID,2, "|cff00ffffPassive|r: Xesil's Legacy: 15% chance to reset a spells cooldown when cast. |cffc0c0c0Overrides the item of the same name if stronger and is overriden if weaker. Does not reset the cooldown of spells with the|r [|cff96ffffStable|r] |cffc0c0c0tag.|r[|cff80ff80Luck|r]")
        call SaveStr(HT_data,TIME_WARRIOR_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Xesil's Legacy: +0.1% chance. +100 mana, +1 mana regeneration." )

        call SaveStr(HT_data,OGRE_MAGE_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNOgreMagi.blp" )       //OGRE MAGE
        call SaveStr(HT_data,OGRE_MAGE_UNIT_ID,2, "|cff00ffffPassive|r: Ogre's Luck: Whenever the Hero casts an ability it has a 15% chance to cast it again. [|cff80ff80Luck|r] ")
        call SaveStr(HT_data,OGRE_MAGE_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Ogre's Luck: +2% chance." )

        call SaveStr(HT_data,TROLL_BERSERKER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNForestTroll.blp" )       //OGRE MAGE
        call SaveStr(HT_data,TROLL_BERSERKER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +1% base attack speed." )

        call SaveStr(HT_data,YETI_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNWendigo.blp" )       //Yeti
        call SaveStr(HT_data,YETI_UNIT_ID,2, "|cff00ffffPassive|r: Yeti Strength: Gives the Hero +20 strength if it hass less than 50 armor. Gains +10% strength and +10% armor limit from its passive for every [|cff8080ffCold|r] spell it has.")
        call SaveStr(HT_data,YETI_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Yeti Strength: +20 bonus strength, +2 armor limit." )
        
        call SaveStr(HT_data,SATYR_TRICKSTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNSatyr.blp" )       //Satyr
        call SaveStr(HT_data,SATYR_TRICKSTER_UNIT_ID,2, "|cff00ffffPassive|r: Trickshot: When the Satyr evades an attack it counterattacks, dealing 100% of its attack damage in |cffff8080physical damage|r back to the attacker.")
        call SaveStr(HT_data,SATYR_TRICKSTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Trickshot: +2% damage. +0.5 evasion." )

        call SaveStr(HT_data,'H01F',1, "ReplaceableTextures\\CommandButtons\\BTNMurlocNightCrawler.blp" )       //Murlock
        call SaveStr(HT_data,'H01F',2, "|cff00ffffPassive|r: Fish Hook: Increases all stats by 1 every time the Hero attacks an enemy or takes damage, lasts until the end of the fight. (Max 2 billion)")
        call SaveStr(HT_data,'H01F',3, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 10 levels|r) Fish Hook: +1 stat per attack." )
        
        call SaveStr(HT_data,MEDIVH_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNMedivh.blp" )       //Mediv
        call SaveStr(HT_data,MEDIVH_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +2 magic power." )
        
        call SaveStr(HT_data,GHOUL_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNGhoul.blp" )       //ghoul
        call SaveStr(HT_data,GHOUL_UNIT_ID,2, "|cff00ffffPassive|r: Cannibal Frenzy: Attacks deal +2.5% of the target's maximum hit points in |cff00ffffpure damage|r, this bonus damage ignores armor and block and has 100% lifesteal on it.")
        call SaveStr(HT_data,GHOUL_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Cannibal Frenzy: +0.025% attack damage." )

        call SaveStr(HT_data,BANSHEE_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNBanshee.blp" )       //banshee
        call SaveStr(HT_data,BANSHEE_UNIT_ID,2, "|cff00ffffPassive|r: Banshee's Curse: The Hero's mana is increased by 75% of its maximum hit points. When the Hero takes damage its mana is reduced instead of its hit points. When it reaches 0 mana it dies." )
        
        call SaveStr(HT_data,GRUNT_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNGrunt.blp" )       //grunt
        call SaveStr(HT_data,GRUNT_UNIT_ID,2, "|cff00ffffPassive|r: The Grunt's Grunt: At the start of every fight the Hero gains 20 bonus attack damage and strength for 10 seconds. ")
        call SaveStr(HT_data,GRUNT_UNIT_ID,3, "|cffffff00Level Up Bonus|r: Grunt's Grunt: +20 attack damage and strength, +0.1 seconds duration." )
        
        call SaveStr(HT_data,SEER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNDranaiMage.blp" )       //seer
        call SaveStr(HT_data,SEER_UNIT_ID,2, "|cff00ffffPassive|r: Magical Insight: The Hero's |cffff8080physical damage|r dealt becomes |cffff00ffmagic damage|r and its |cffff00ffmagic damage|r dealt becomes |cffff8080physical damage|r. |cffc0c0c0This means most spells are affected by enemy armor and not affected by the Hero's magic power.|nSeer's passive can be disabled by the Staff of Power.|r" )
    
        call SaveStr(HT_data,ARENA_MASTER_UNIT_ID,1, "ReplaceableTextures\\CommandButtons\\BTNHeroTaurenChieftain.blp" )       //Arena master
        call SaveStr(HT_data,ARENA_MASTER_UNIT_ID,2, "|cff00ffffPassive|r: Passionate Student: All Rings in PVE Shop I are twice as effective.")
        call SaveStr(HT_data,ARENA_MASTER_UNIT_ID,3, "|cffffff00Level Up Bonus|r: +200 glory." )
    endfunction
endlibrary