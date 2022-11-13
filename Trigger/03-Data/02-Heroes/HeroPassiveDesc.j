library HeroPassiveDesc initializer init
    globals
        HashTable HeroPassiveDesc

        integer HeroPassive_Icon    = 1
        integer HeroPassive_Desc    = 2
        integer HeroPassive_Lvlup   = 3
    endglobals

    function GetHeroPassiveDescription takes integer unitTypeId, integer heroPassiveField returns string
        return HeroPassiveDesc[unitTypeId].string[heroPassiveField]
    endfunction

    private function InitHeroDesc takes integer unitTypeId, integer heroPassiveField, string data returns nothing
        set HeroPassiveDesc[unitTypeId].string[heroPassiveField] = data
    endfunction

    private function SetupHeroPassives takes nothing returns nothing
        call InitHeroDesc(LIEUTENANT_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSpellBreaker.blp" )
        call InitHeroDesc(LIEUTENANT_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Battlemaster: Gains bonus +1 bonus attack damage per point in agility and intelligence.")
        call InitHeroDesc(LIEUTENANT_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +5 to two random stats. (|cff68eef3Every 10 levels|r) Battlemaster: +1 bonus to each stat on level up." )

        call InitHeroDesc(ABOMINATION_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNAbomination.blp" )
        call InitHeroDesc(ABOMINATION_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Disease Cloud: Deals |cffff00ffmagic damage|r to nearby enemies every second. ")
        call InitHeroDesc(ABOMINATION_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Disease Cloud: +40 damage." )
        
        call InitHeroDesc(DRUID_OF_THE_CLAY_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheClaw.blp" )
        call InitHeroDesc(DRUID_OF_THE_CLAY_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Animal Affection: Summon attack damage, armor, magic power and magic resistance are increased by a percentage of the Hero's amount. [|cff9e5d07Summon|r] spells have 50% reduced cooldown. ")
        call InitHeroDesc(DRUID_OF_THE_CLAY_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +1% Animal Affection summon stat increase." )
        
        call InitHeroDesc(MAULER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroPaladin.blp" )
        call InitHeroDesc(MAULER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Lightbringer: Gets a free point towards the [|cffd2d2d2Light|r] element just for existing. ")
        call InitHeroDesc(MAULER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 10 levels|r) Lightbringer: +1 point towards [|cffd2d2d2Light|r].")
    
        call InitHeroDesc(BLOOD_MAGE_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince.blp" )
        call InitHeroDesc(BLOOD_MAGE_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Mana Lifeforce: Gains 1 magic power per 60 intelligence")
        call InitHeroDesc(BLOOD_MAGE_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +7 intelligence." )
        
        call InitHeroDesc(MORTAR_TEAM_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNMortarTeam.blp" )
        call InitHeroDesc(MORTAR_TEAM_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Mortar Might: Increases physical power. ")
        call InitHeroDesc(MORTAR_TEAM_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Mortar Might: +2 physical power bonus." )
                    
        call InitHeroDesc(NAGA_SIREN_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNNagaSummoner.blp" )
        call InitHeroDesc(NAGA_SIREN_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Water Addiction: Starts with Absolute Water. +1 bonus attack damage per intelligence. 10% of her attack damage is added to all spell damage dealt. ")
        call InitHeroDesc(NAGA_SIREN_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Water Addiction: +0.1% attack damage added to spell damage. (Every 50 levels) + 1 bonus attack damage per intelligence" )
        
        call InitHeroDesc(AVATAR_SPIRIT_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNPossession.blp" )
        call InitHeroDesc(AVATAR_SPIRIT_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Glow In The Dark: When the Hero has more [|cffd2d2d2Light|r] than [|cff000000Dark|r] abilities it gains bonus armor and attack damage, if it has more [|cff000000Dark|r] than [|cffd2d2d2Light|r] abilities it gains bonus magic protection and magic power.")
        call InitHeroDesc(AVATAR_SPIRIT_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Glow In The Dark: [|cffd2d2d2Light|r] mode: +1% armor, +20 attack damage. [|cff000000Dark|r] mode: +0.3 magic protection, +0.3 magic power." )
            
        call InitHeroDesc(DEMON_HUNTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroDemonHunter.blp" )
        call InitHeroDesc(DEMON_HUNTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Feedback: Every time the Hero attacks it drains enemy mana, giving it to himself. ")
        call InitHeroDesc(DEMON_HUNTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Feedback: +20 mana drained." )
        
        call InitHeroDesc(DEADLORD_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNTichondrius.blp" )
        call InitHeroDesc(DEADLORD_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Vampire: Lifesteal on all damage dealt by the Hero and its summons. Killing an enemy restores 10% of its maximum hit points. [|cffff9696Lifesteal|r]")
        call InitHeroDesc(DEADLORD_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Vampire: +0.5% lifesteal" )
        
        call InitHeroDesc(PYROMANCER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNChaosSpaceOrc.blp" )
        call InitHeroDesc(PYROMANCER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Scorched Earth: Once every second when the Hero deals [|cffff0000Fire|r] damage it sets the ground on fire for 2 seconds. Units within the fire have a chance to miss any damage dealt and have a higher chance to get hit by crits. [|cff96ffffStable|r] The Pyromancer's attacks deal [|cffff0000Fire|r] damage in a line.")
        call InitHeroDesc(PYROMANCER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +35 maximum attack damage. Scorched Earth: +0.5% miss chance, +0.1% crit chance. +1 area of effect." )
        
        call InitHeroDesc(TAUREN_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSpiritWalker.blp" )
        call InitHeroDesc(TAUREN_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Spirit Mage: Gains +0.1 Rune Power for every active spell it has. All [Element] damage deals 5% bonus damage based on how many of that [Element] the Hero has.")
        call InitHeroDesc(TAUREN_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Spirit Mage: +0.0025 Rune Power per active spell. +0.05% damage per [Element]")
        
        call InitHeroDesc(MYSTIC_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheTalon.blp" )
        call InitHeroDesc(MYSTIC_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Faerie Friend: At the start of every round the Mystic summons a Faerie Dragon to aid it in battle. The Faerie Dragon can be targeted but can not be damaged.")
        call InitHeroDesc(MYSTIC_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +40 summon damage. Faerie Dragon: Bonus attack speed. (|cff68eef3Every 3 levels|r) increases Faerie Dragon damage." )
            
        call InitHeroDesc(PIT_LORD_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNPitLord.blp" )
        call InitHeroDesc(PIT_LORD_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Hellforged: Starts with Absolute Fire. 1 magic power increases |cffff8080physical power|r by 1. |cffc0c0c0Hellforged and Absolute Fire become 25% less effective for every |r [|cff00f7ffWater|r] |cffc0c0c0spell learned.|r")
        call InitHeroDesc(PIT_LORD_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Hellforged: +0.5% Absolute Fire magic power bonus." )
            
        call InitHeroDesc(THUNDER_WITCH_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSorceress.blp" )
        call InitHeroDesc(THUNDER_WITCH_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Thunder Bolt: Deals |cffff00ffmagic damage|r to 2 nearby enemies every second. [|cff96ffffStable|r]. Your magic power is doubled for Thunder Bolt.")
        call InitHeroDesc(THUNDER_WITCH_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Thunder Bolt: +30 damage. (|cff68eef3Every 30 levels|r) +1 target." )
                
        call InitHeroDesc(WOLF_RIDER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNThrall.blp" )
        call InitHeroDesc(WOLF_RIDER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Speed Freak: Whenever the Hero finishes a round within 6 seconds it permanently gains 10 bonus agility. The Hero's lowest stats are automatically boosted to 35% of its highest stat when they drop lower.")
        call InitHeroDesc(WOLF_RIDER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Speed Freak: +1 bonus agility gained." )
                
        call InitHeroDesc(BLADE_MASTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroBlademaster.blp" )
        call InitHeroDesc(BLADE_MASTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Bladestorm: Every 9 attacks it creates a Bladestorm, dealing 50% of its attack damage to nearby enemies as |cffff8080physical damage|r.")
        call InitHeroDesc(BLADE_MASTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Bladestorm: +35 damage, +3 area of effect. (|cff68eef3Every 20 levels|r) reduces attacks required by 1." )
                                                    
        call InitHeroDesc(ORC_CHAMPION_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNChaosGrom.blp" )
        call InitHeroDesc(ORC_CHAMPION_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Valiant Strike: All damage dealt by the Hero and its summons have 20% of the Hero's strength added to it.")
        call InitHeroDesc(ORC_CHAMPION_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Valiant Strike: +1% damage from strength. +3 armor and +6 hit point regeneration." )
        
        call InitHeroDesc(TROLL_HEADHUNTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeadHunterBerserker.blp" )
        call InitHeroDesc(TROLL_HEADHUNTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Troll Anatomy: Gains bonus hit point regen based on 40% of its strength. ")
        call InitHeroDesc(TROLL_HEADHUNTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Troll Anatomy: +1.5% strength conversion." )
                        
        call InitHeroDesc(TINKER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroTinker.blp" )
        call InitHeroDesc(TINKER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Quick Learner: Gains double the round clear experience bonus.")
        call InitHeroDesc(TINKER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Gains 55 * hero level experience." )
        
        call InitHeroDesc(BEAST_MASTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNBeastMaster.blp" )
        call InitHeroDesc(BEAST_MASTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 3 levels|r) Increases the level of all summons by 1." )
            
        call InitHeroDesc(FALLEN_RANGER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNBansheeRanger.blp" )
        call InitHeroDesc(FALLEN_RANGER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Fear Aura: Reduces the armor of nearby enemies. ")
        call InitHeroDesc(FALLEN_RANGER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Fear Aura: +3 armor reduction." )
        
        call InitHeroDesc(HUNTRESS_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHuntress.blp" )
        call InitHeroDesc(HUNTRESS_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Moon Chakrum: Damages 8 nearby enemies every time the Hero attacks, dealing 25% of her attack in |cffff00ffmagic damage|r. ")
        call InitHeroDesc(HUNTRESS_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Moon Chakrum: +0.25% of her attack damage" )
            
        call InitHeroDesc(SKELETON_BRUTE_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSkeletalOrc.blp" )
        call InitHeroDesc(SKELETON_BRUTE_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Reinforced Bone: When the Hero takes 20% or more of its max HP in damage at once it cannot take damage again for 1 second. 10s cooldown. [|cff96ffffStable|r]. When one of its summons dies the Hero restores 2% of its max HP and the summon explodes, dealing 50% of its attack damage as |cffff00ffmagic damage|r to enemies.")
        call InitHeroDesc(SKELETON_BRUTE_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Reinforced Bone: +0.01 second invulnerability. +0.05% of maximum hit points restored. +1% of attack damage explosion damage." )
                
        call InitHeroDesc(SORCERER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNJaina.blp" )
        call InitHeroDesc(SORCERER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Mysterious Sorcery: Once every 50 seconds automatically cast 1 of your active spells at a random target in a 600 AOE. |cffc0c0c0Cannot cast abilities with the|r [|cffffff00plain|r] |cffc0c0c0or |r |n[|cff96ffffStable|r] |cffc0c0c0tag.|r |cffc0c0c0Can cast the same spell multiple times. Max 15 seconds cooldown from leveling. |r[|cff96ffffStable|r]")
        call InitHeroDesc(SORCERER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Mysterious Sorcery: 0.2 seconds cooldown reduction. (|cff68eef3Every 35 levels|r) +1 target." )
                    
        call InitHeroDesc(URSA_WARRIOR_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNFurbolgElder.blp" )
        call InitHeroDesc(URSA_WARRIOR_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Bleed: Every time it attacks it causes enemies to bleed for 3 seconds, dealing 30% of its attack in |cffff8080physical damage|r per second.")
        call InitHeroDesc(URSA_WARRIOR_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +10 attack damage." )
                            
        call InitHeroDesc(WAR_GOLEM_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNFleshGolem.blp" )
        call InitHeroDesc(WAR_GOLEM_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Construct: Receives 50% bonus hit points from its strength stat. When it has more than 100.000 hit points it cannot take more than 10% of its maximum hit points in damage in one hit.")
        call InitHeroDesc(WAR_GOLEM_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Construct: +1% bonus hit points from strength." )
            
        call InitHeroDesc(WITCH_DOCTOR_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNOrcWarlockRed.blp" )
        call InitHeroDesc(WITCH_DOCTOR_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Absolute Magic: Starts with a bonus absolute slot.")
        call InitHeroDesc(WITCH_DOCTOR_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 30 levels|r) Absolute Magic: Gets a free point towards all elements he has Absolute Spells for. (|cff68f386Every 25 levels|r) Gets a bonus Absolute slot. (max 10)" ) 
        
        call InitHeroDesc(RANGER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSylvanusWindrunner.blp" )
        call InitHeroDesc(RANGER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Ranger Crit: 15% chance to deal 10% bonus |cffff8080physical damage|r. [|cff80ff80Luck|r][|cff00ffffCrit|r]")
        call InitHeroDesc(RANGER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +2% base damage to all critical hits.")
        
        call InitHeroDesc(DARK_HUNTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNUnbroken.blp" )
        call InitHeroDesc(DARK_HUNTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Void Bash: When the Hero damages an enemy it has a 20% chance to deal 50 bonus |cffff00ffmagical damage|r and stun it for 0.2 seconds. [|cff80ff80Luck|r]")
        call InitHeroDesc(DARK_HUNTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Void Bash: +50 damage" )
                
        call InitHeroDesc(DOOM_GUARD_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNDoomGuard.blp" )
        call InitHeroDesc(DOOM_GUARD_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Hellfire: Deals |cffff00ffmagic damage|r per second to a random nearby enemy for 8 seconds. 1 second cooldown. [|cff96ffffStable|r]")
        call InitHeroDesc(DOOM_GUARD_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Hellfire: +25 damage per second." )
                    
        call InitHeroDesc(ROCK_GOLEM_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNRockGolem.blp" )
        call InitHeroDesc(ROCK_GOLEM_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Stone Edge: When the Golem is damaged it deals 50% of its block in |cffff8080physical damage|r to nearby enemy units within 400 range. 1 second cooldown. [|cff96ffffStable|r]")
        call InitHeroDesc(ROCK_GOLEM_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Stone Edge: +1% block damage. +1% block." )
        
        call InitHeroDesc(COLD_KNIGHT_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNRevenant.blp" )
        //   call InitHeroDesc(COLD_KNIGHT_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNFrostRevenant.blp" )
        call InitHeroDesc(COLD_KNIGHT_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Frost Aura: Reduces the attack speed and movement speed of enemies.")
        call InitHeroDesc(COLD_KNIGHT_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Frost Aura: +6% attack speed reduction . +0.5% movespeed reduction (max 95%)" )

        call InitHeroDesc(LICH_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroLich.blp" )
        call InitHeroDesc(LICH_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Flash Freeze: When the Hero deals [|cff00f7ffWater|r], [|cff8080ffCold|r], or [|cff000000Dark|r] damage it has a 25% chance to use Flash Freeze on the enemy, dealing |cffff00ffmagical damage|r in an area around the target based on 100% of its intelligence. [|cff80ff80Luck|r]")
        call InitHeroDesc(LICH_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Flash Freeze: +1% of intelligence damage." ) 
        
        call InitHeroDesc(GNOME_MASTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroMountainKing.blp" )
        call InitHeroDesc(GNOME_MASTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Gnome Stomp: At the start of every fight it deals |cffff00ffmagical damage|r and stuns all heroes for 1 second and creeps for 2 seconds. ")
        call InitHeroDesc(GNOME_MASTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Gnome Stomp: +55 damage, +0.04 seconds hero stun, +0.08 seconds creep stun." )

        call InitHeroDesc(GREEDY_GOBLIN_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroAlchemist.blp" )
        call InitHeroDesc(GREEDY_GOBLIN_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Greed: Gains 25 bonus gold and experience whenever it kills a unit. |cffc0c0c01% less effective for each level of Pillage. Pillage and Learnability are 22% less effective.|r")
        call InitHeroDesc(GREEDY_GOBLIN_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Greed: +3 bonus gold and +4 experience" ) 

        call InitHeroDesc(CENTAUR_ARCHER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNCentaurArcher.blp" )
        call InitHeroDesc(CENTAUR_ARCHER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Horsepower: Attacks deal 100% bonus |cffff8080physical damage|r + 6% of the targets total hit points once every 2 seconds. [|cff00ffffCrit|r]")
        call InitHeroDesc(CENTAUR_ARCHER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Horsepower: +5% damage." )

        call InitHeroDesc(OGRE_WARRIOR_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNOgre.blp" )
        call InitHeroDesc(OGRE_WARRIOR_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Ogre Stomp: Once every 6 seconds when the Hero deals [|cffd45e19Earth|r] or |cffff8080physical damage|r it damages nearby enemies for 100% of its strength in |cffff00ffmagic damage|r and stuns and reduces their block by 20% for 1 second. Cooldown is reduced by 0.5 seconds for every unit hit.")
        call InitHeroDesc(OGRE_WARRIOR_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Ogre Stomp: +60 damage" )

        call InitHeroDesc(TIME_WARRIOR_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNGhostOfKelThuzad.blp" )
        call InitHeroDesc(TIME_WARRIOR_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Xesil's Legacy: Active spells still require mana but do not reduce it when cast. 20% chance to reset the cooldown of an ability/item when cast. |cffc0c0c0Overrides the item of the same name. Does not reset the cooldown of spells with the|r [|cff96ffffStable|r] |cffc0c0c0tag.|r|n|cffc0c0c0Reset chance can not go over 90%.")
        call InitHeroDesc(TIME_WARRIOR_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Xesil's Legacy: +0.1% chance. +100 mana, +1 mana regeneration." )

        call InitHeroDesc(OGRE_MAGE_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNOgreMagi.blp" )
        call InitHeroDesc(OGRE_MAGE_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Ogre's Luck: Whenever the Hero casts an ability it has a 15% chance to cast it again at 50% mana cost. [|cff80ff80Luck|r] ")
        call InitHeroDesc(OGRE_MAGE_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Ogre's Luck: +2% chance." )

        call InitHeroDesc(TROLL_BERSERKER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNForestTroll.blp" )
        call InitHeroDesc(TROLL_BERSERKER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Steadfast Pacing: Starts with maximum movement speed. Its movement speed can't be lowered by enemy abilities or items." )
        call InitHeroDesc(TROLL_BERSERKER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +1% attack cooldown reduction." )

        call InitHeroDesc(YETI_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNWendigo.blp" )
        call InitHeroDesc(YETI_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Yeti Strength: Gives the Hero +20 strength and immunity to |cffff8080physical|r [|cff00ffffCrit|r] damage if it hass less than 50 armor. Gains +10% strength and +10% armor limit from its passive for every [|cff8080ffCold|r] spell it has.")
        call InitHeroDesc(YETI_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Yeti Strength: +20 bonus strength, +2 armor limit." )
        
        call InitHeroDesc(SATYR_TRICKSTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNSatyr.blp" )
        call InitHeroDesc(SATYR_TRICKSTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Trickshot: When the Satyr evades an attack it counterattacks, dealing 100% of its attack damage in |cffff8080physical damage|r back to the attacker.[|cffd45e29onhit|r]")
        call InitHeroDesc(SATYR_TRICKSTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Trickshot: +2% damage. +0.5 evasion." )

        call InitHeroDesc(MURLOC_WARRIOR_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNMurlocNightCrawler.blp" )
        call InitHeroDesc(MURLOC_WARRIOR_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Fish Hook: Increases all stats by 1 every time the Hero attacks an enemy or takes damage, lasts until the end of the fight. (Max 2 billion)")
        call InitHeroDesc(MURLOC_WARRIOR_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: (|cff68eef3Every 10 levels|r) Fish Hook: +1 stat per attack." )
        
        call InitHeroDesc(MEDIVH_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNMedivh.blp" )
        call InitHeroDesc(MEDIVH_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Maximum Magic: Gives the hero +15 magic power but the hero can't deal [|cff00ffffCrit|r] damage" )
        call InitHeroDesc(MEDIVH_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +2 magic power." )
        
        call InitHeroDesc(GHOUL_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNGhoul.blp" )
        call InitHeroDesc(GHOUL_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Cannibal Frenzy: Attacks deal +2.5% of the target's current hit points in |cff00ffffpure damage|r, this bonus damage ignores armor and block and has 100% lifesteal on it.")
        call InitHeroDesc(GHOUL_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Cannibal Frenzy: +0.025% attack damage." )

        call InitHeroDesc(BANSHEE_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNBanshee.blp" )
        call InitHeroDesc(BANSHEE_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Banshee's Curse: The Hero's mana is increased by 40% of its maximum hit points. When the Hero takes damage its mana is reduced instead of its hit points. When it reaches 0 mana it dies." )
        
        call InitHeroDesc(GRUNT_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNGrunt.blp" )
        call InitHeroDesc(GRUNT_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: The Grunt's Grunt: At the start of every fight the Hero gains 20 bonus attack damage and strength for 10 seconds. ")
        call InitHeroDesc(GRUNT_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: Grunt's Grunt: +20 attack damage and strength, +0.1 seconds duration." )
        
        call InitHeroDesc(SEER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNDranaiMage.blp" )
        call InitHeroDesc(SEER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Magical Insight: The Hero's |cffff8080physical damage|r dealt becomes |cffff00ffmagic damage|r and its |cffff00ffmagic damage|r dealt becomes |cffff8080physical damage|r. |cffc0c0c0Most spells are affected by enemy armor, and not the Hero's magic power. Seer's passive can be disabled by the Staff of Power.|r" )
    
        call InitHeroDesc(ARENA_MASTER_UNIT_ID, HeroPassive_Icon, "ReplaceableTextures\\CommandButtons\\BTNHeroTaurenChieftain.blp" )
        call InitHeroDesc(ARENA_MASTER_UNIT_ID, HeroPassive_Desc, "|cff00ffffPassive|r: Passionate Student: All Rings in PVE Shop I are twice as effective.")
        call InitHeroDesc(ARENA_MASTER_UNIT_ID, HeroPassive_Lvlup, "|cffffff00Level Up Bonus|r: +200 glory." )
    endfunction

    private function init takes nothing returns nothing
        set HeroPassiveDesc = HashTable.create()
        call SetupHeroPassives()
    endfunction
endlibrary