library HeroData initializer init
    globals
        hashtable HT_data = InitHashtable()
    endglobals

    private function init takes nothing returns nothing
        call SaveStr(HT_data,'E000',1, "ReplaceableTextures\\CommandButtons\\BTNSpellBreaker.blp" )        //letinant
        call SaveStr(HT_data,'E000',3, "|cffffff00Level Up Bonus|r: +8 to two random stats." )

        call SaveStr(HT_data,'H005',1, "ReplaceableTextures\\CommandButtons\\BTNAbomination.blp" )       // amb
        call SaveStr(HT_data,'H005',2, "|cff00ffffPassive|r: Disease Cloud: Damages nearby enemies every second. ")
        call SaveStr(HT_data,'H005',3, "|cffffff00Level Up Bonus|r: Disease Cloud: +40 damage." )
        
        call SaveStr(HT_data,'H006',1, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheClaw.blp" )       // druid1
        call SaveStr(HT_data,'H006',3, "|cffffff00Level Up Bonus|r: +800 summon hit points, +6 summon armor." )
        
        call SaveStr(HT_data,'H002',1, "ReplaceableTextures\\CommandButtons\\BTNHeroPaladin.blp" )       // paladin
        call SaveStr(HT_data,'H002',2, "|cff00ffffPassive|r: Lightbringer: Gets a free point towards the [|cffd2d2d2Light|r] element just for existing. ")
        call SaveStr(HT_data,'H002',3, "|cffffff00Level Up Bonus|r: (Every 8 levels) Lightbringer: +1 point towards [|cffd2d2d2Light|r].")   
    
        call SaveStr(HT_data,'H001',1, "ReplaceableTextures\\CommandButtons\\BTNHeroBloodElfPrince.blp" )       // mage
        call SaveStr(HT_data,'H001',2, "|cff00ffffPassive|r: Mana Lifeforce: Gains 1 magic power per 1000 total mana ")
        call SaveStr(HT_data,'H001',3, "|cffffff00Level Up Bonus|r: +250 mana." )   
        
        call SaveStr(HT_data,'H004',1, "ReplaceableTextures\\CommandButtons\\BTNMortarTeam.blp" )       // mortal team
        call SaveStr(HT_data,'H004',2, "|cff00ffffPassive|r: Mortar Aura: Increases all physical damage dealt by a percentage. ")
        call SaveStr(HT_data,'H004',3, "|cffffff00Level Up Bonus|r: Mortar Aura: +3% physical damage bonus." )    
                    
        call SaveStr(HT_data,'H003',1, "ReplaceableTextures\\CommandButtons\\BTNNagaSummoner.blp" )       // naga
        call SaveStr(HT_data,'H003',3, "|cffffff00Level Up Bonus|r: Increases intelligence by a random amount between 1 and 11. Repeats if strength is at 0 and again if agility is at 0." )    
        
        call SaveStr(HT_data,'O003',1, "ReplaceableTextures\\CommandButtons\\BTNPossession.blp" )       // avatar
        call SaveStr(HT_data,'O003',2, "|cff00ffffPassive|r: Glow In The Dark: When the Hero has more {Light] than [Dark] abilities it gains bonus armor and attack damage, if it has more [Dark] than [Light] abilities it gains bonus magic protection and magic power.")
        call SaveStr(HT_data,'O003',3, "|cffffff00Level Up Bonus|r: Glow In The Dark: [Light] mode: +1% armor, +35 attack damage. [Dark] mode: +0.3 magic protection, +0.75 magic power." )                    
            
        call SaveStr(HT_data,'O004',1, "ReplaceableTextures\\CommandButtons\\BTNHeroDemonHunter.blp" )       // Demon Hunter
        call SaveStr(HT_data,'O004',2, "|cff00ffffPassive|r: Feedback: Every time the Hero attacks it drains enemy mana, giving it to himself. ")
        call SaveStr(HT_data,'O004',3, "|cffffff00Level Up Bonus|r: Feedback: +20 mana burned." )                    
        
        call SaveStr(HT_data,'O002',1, "ReplaceableTextures\\CommandButtons\\BTNTichondrius.blp" )       // Dread lord
        call SaveStr(HT_data,'O002',2, "|cff00ffffPassive|r: Vampire: Lifesteal on all damage dealt by the player. Killing an enemy restores 10% of its maximum hit points. [|cffff9696Lifesteal|r]")
        call SaveStr(HT_data,'O002',3, "|cffffff00Level Up Bonus|r: Vampire: +0.5% lifesteal" )  
        
        call SaveStr(HT_data,'O005',1, "ReplaceableTextures\\CommandButtons\\BTNChaosSpaceOrc.blp" )       // Pyromancer
        call SaveStr(HT_data,'O005',3, "|cffffff00Level Up Bonus|r: +35 maximum attack damage." )  
        
        call SaveStr(HT_data,'O000',1, "ReplaceableTextures\\CommandButtons\\BTNSpiritWalker.blp" )       // tauren
        call SaveStr(HT_data,'O000',2, "|cff00ffffPassive|r: Spirit Mage: Spells in the Active Spells I shop can go up to level 40. ")
        call SaveStr(HT_data,'O000',3, "|cffffff00Level Up Bonus|r: (Every 2 levels) Increases the level of all spells from Active Spells I by 1." )
        
        call SaveStr(HT_data,'O008',1, "ReplaceableTextures\\CommandButtons\\BTNDruidOfTheTalon.blp" )       // Mystic
        call SaveStr(HT_data,'O008',2, "|cff00ffffPassive|r: Faerie Friend: A Faerie Dragon follows it, attacking enemies. Faerie Dragon attacks count as Mystic attacks, it has the same attack speed.")
        call SaveStr(HT_data,'O008',3, "|cffffff00Level Up Bonus|r: +40 summon damage. Faerie Dragon: +3% attack speed. (Every 3 levels) increases Faerie Dragon damage." )
            
        call SaveStr(HT_data,'O007',1, "ReplaceableTextures\\CommandButtons\\BTNPitLord.blp" )       // Pit Lord
        call SaveStr(HT_data,'O007',2, "|cff00ffffPassive|r: Rain of Fire: automatically casts Rain of Fire when it deals damage once every 2 seconds. ")
        call SaveStr(HT_data,'O007',3, "|cffffff00Level Up Bonus|r: Rain of Fire: +30 initial damage, +10 damage per second." )
            
        call SaveStr(HT_data,'O001',1, "ReplaceableTextures\\CommandButtons\\BTNSorceress.blp" )       // Thunder Witch
        call SaveStr(HT_data,'O001',2, "|cff00ffffPassive|r: Thunder Bolt: Damages 2 nearby enemies every second. [|cff96ffffStable|r] ")
        call SaveStr(HT_data,'O001',3, "|cffffff00Level Up Bonus|r: Thunder Bolt: +30 damage." )
                
        call SaveStr(HT_data,'U000',1, "ReplaceableTextures\\CommandButtons\\BTNThrall.blp" )       // Trall
        call SaveStr(HT_data,'U000',3, "|cffffff00Level Up Bonus|r: +20 agility if the Hero's agility is lower than twice its Strength. +10 agility if the Hero's agility is lower than its strength. +5 agility if neither of those are true." )
                
        call SaveStr(HT_data,'N00K',1, "ReplaceableTextures\\CommandButtons\\BTNHeroBlademaster.blp" )       // Blade master
        call SaveStr(HT_data,'N00K',2, "|cff00ffffPassive|r: Bladestorm: Every 9 attacks it creates a Bladestorm, dealing 50% of its attack damage to nearby enemies as physical damage.")
        call SaveStr(HT_data,'N00K',3, "|cffffff00Level Up Bonus|r: Bladestorm: +20 damage, +3 area of effect." )
                                                    
        call SaveStr(HT_data,'N024',1, "ReplaceableTextures\\CommandButtons\\BTNChaosGrom.blp" )       // Grom
        call SaveStr(HT_data,'N024',2, "|cff00ffffPassive|r: Valiant Strike: All physical damage dealt by the player has 100% of the Hero's strength added to it.")
        call SaveStr(HT_data,'N024',3, "|cffffff00Level Up Bonus|r: +3 armor and +6 hit point regeneration." )
        
        call SaveStr(HT_data,'N00I',1, "ReplaceableTextures\\CommandButtons\\BTNHeadHunterBerserker.blp" )       // Troll Head Hunter
        call SaveStr(HT_data,'N00I',2, "|cff00ffffPassive|r: Troll Anatomy: Gains bonus hit point regen based on 40% of its strength. ")
        call SaveStr(HT_data,'N00I',3, "|cffffff00Level Up Bonus|r: Troll Anatomy: +1.5% strength conversion." )
                        
        call SaveStr(HT_data,'N00L',1, "ReplaceableTextures\\CommandButtons\\BTNHeroTinker.blp" )       // Tinker
        call SaveStr(HT_data,'N00L',3, "|cffffff00Level Up Bonus|r: Gains 55 * hero level experience." )
        
        call SaveStr(HT_data,'N00P',1, "ReplaceableTextures\\CommandButtons\\BTNBeastMaster.blp" )       // Beast master
        call SaveStr(HT_data,'N00P',3, "|cffffff00Level Up Bonus|r: (Every 4 levels) Increases the level of all summons by 1." )
            
        call SaveStr(HT_data,'N00B',1, "ReplaceableTextures\\CommandButtons\\BTNBansheeRanger.blp" )       // Fallen Ranger
        call SaveStr(HT_data,'N00B',2, "|cff00ffffPassive|r: Fear Aura: Reduces the armor of nearby enemies. ")
        call SaveStr(HT_data,'N00B',3, "|cffffff00Level Up Bonus|r: Fear Aura: +3 armor reduction." )
        
        call SaveStr(HT_data,'N00R',1, "ReplaceableTextures\\CommandButtons\\BTNHuntress.blp" )       // Luna
        call SaveStr(HT_data,'N00R',2, "|cff00ffffPassive|r: Moon Chakrum: Damages 8 nearby enemies every time the Hero attacks, dealing 50% of her attack damage in magic damage. ")
        call SaveStr(HT_data,'N00R',3, "|cffffff00Level Up Bonus|r: Moon Chakrum: +0.5% of her attack damage" )
            
        call SaveStr(HT_data,'N00O',1, "ReplaceableTextures\\CommandButtons\\BTNSkeletalOrc.blp" )       // Brute Skelet
        call SaveStr(HT_data,'N00O',2, "|cff00ffffPassive|r: Skeleton Army: Summons a skeleton every time it kills an enemy unit.")
        call SaveStr(HT_data,'N00O',3, "|cffffff00Level Up Bonus|r: +2 armor, +5 summon armor." )
                
        call SaveStr(HT_data,'H008',1, "ReplaceableTextures\\CommandButtons\\BTNJaina.blp" )       // Sorser
        call SaveStr(HT_data,'H008',2, "|cff00ffffPassive|r: Lightning Strike: Damages 3 nearby enemies whenever the Hero casts a spell. ")
        call SaveStr(HT_data,'H008',3, "|cffffff00Level Up Bonus|r: Lightning Strike: +50 damage." )
                    
        call SaveStr(HT_data,'N00Q',1, "ReplaceableTextures\\CommandButtons\\BTNFurbolgElder.blp" )       // Ursa
        call SaveStr(HT_data,'N00Q',2, "|cff00ffffPassive|r: Bleed: Every time it attacks it causes enemies to bleed for 3 seconds, dealing 30% of its attack damage per second. ")
        call SaveStr(HT_data,'N00Q',3, "|cffffff00Level Up Bonus|r: +25 attack damage." )
                            
        call SaveStr(HT_data,'N00C',1, "ReplaceableTextures\\CommandButtons\\BTNFleshGolem.blp" )       // War golem
        call SaveStr(HT_data,'N00C',2, "|cff00ffffPassive|r: Construct: Receives 50% bonus hit points from its strength stat. ")
        call SaveStr(HT_data,'N00C',3, "|cffffff00Level Up Bonus|r: Construct: +1% bonus hit points from strength." )         
            
        call SaveStr(HT_data,'O006',1, "ReplaceableTextures\\CommandButtons\\BTNOrcWarlockRed.blp" )       // warlock
        call SaveStr(HT_data,'O006',2, "|cff00ffffPassive|r: Absolute Magic: Starts with a bonus absolute slot.")
        call SaveStr(HT_data,'O006',3, "|cffffff00Level Up Bonus|r: (Every 20 levels) Absolute Magic: Gets a free point towards all elements he has Absolute Spells for. (Every 15 levels) Gets a bonus Absolute slot. (max 10)" ) 
        
        call SaveStr(HT_data,'H007',1, "ReplaceableTextures\\CommandButtons\\BTNSylvanusWindrunner.blp" )       // sylvane
        call SaveStr(HT_data,'H007',2, "|cff00ffffPassive|r: Ranger Crit: 11% chance to deal 5% bonus physical damage. [|cff80ff80Luck|r][|cff00ffffCrit|r]")
        call SaveStr(HT_data,'H007',3, "|cffffff00Level Up Bonus|r: +5% base damage to all critical hits.")       
        
        call SaveStr(HT_data,'H000',1, "ReplaceableTextures\\CommandButtons\\BTNUnbroken.blp" )       // void
        call SaveStr(HT_data,'H000',2, "|cff00ffffPassive|r: Void Bash: 18% chance on attacks to deal 25 bonus damage and stun for 0.17 seconds. ")
        call SaveStr(HT_data,'H000',3, "|cffffff00Level Up Bonus|r: Void Bash: +50 damage" )     
                
        call SaveStr(HT_data,'H016',1, "ReplaceableTextures\\CommandButtons\\BTNDoomGuard.blp" )       // DOOMguard
        call SaveStr(HT_data,'H016',2, "|cff00ffffPassive|r: Hellfire: Deals initial damage and damage per second to nearby enemies for 8 seconds, every 8 seconds. [|cff96ffffStable|r]")
        call SaveStr(HT_data,'H016',3, "|cffffff00Level Up Bonus|r: Hellfire: +50 initial damage, +10 damage per second." )                      
                    
        call SaveStr(HT_data,'H017',1, "ReplaceableTextures\\CommandButtons\\BTNRockGolem.blp" )       // golem
        call SaveStr(HT_data,'H017',2, "|cff00ffffPassive|r: Stone Edge: When the Golem is damaged it deals 50% of its block in damage to nearby enemy units within 400 range. 1 second cooldown.")
        call SaveStr(HT_data,'H017',3, "|cffffff00Level Up Bonus|r: Stone Edge: +1% block damage. +0.5% block." )       
        
        call SaveStr(HT_data,'N02K',1, "ReplaceableTextures\\CommandButtons\\BTNRevenant.blp" )  
    //   call SaveStr(HT_data,'N02K',1, "ReplaceableTextures\\CommandButtons\\BTNFrostRevenant.blp" )       // cold
        call SaveStr(HT_data,'N02K',2, "|cff00ffffPassive|r: Frost Aura: Reduces the attack speed and movement speed of enemies. ")
        call SaveStr(HT_data,'N02K',3, "|cffffff00Level Up Bonus|r: Frost Aura: +6% attack speed reduction . +0.5% movespeed reduction (max 95%)" )  

        call SaveStr(HT_data,'H018',1, "ReplaceableTextures\\CommandButtons\\BTNHeroLich.blp" )       // Lich
        call SaveStr(HT_data,'H018',2, "|cff00ffffPassive|r: Flash Freeze: When the Hero deals magic damage it deals bonus damage in an area around the target based on 100% of its intelligence once every 6 seconds. ")
        call SaveStr(HT_data,'H018',3, "|cffffff00Level Up Bonus|r: Flash Freeze: +60 damage." ) 
        
        call SaveStr(HT_data,'H019',1, "ReplaceableTextures\\CommandButtons\\BTNHeroMountainKing.blp" )       // Gnome master
        call SaveStr(HT_data,'H019',2, "|cff00ffffPassive|r: Gnome Stomp: At the start of every fight it deals damage and stuns all nearby heroes for 1 second and creeps for 2 seconds. ")
        call SaveStr(HT_data,'H019',3, "|cffffff00Level Up Bonus|r: Gnome Stomp: +55 damage, +0.04 seconds hero stun, +0.08 seconds creep stun." )             

        call SaveStr(HT_data,'N02P',1, "ReplaceableTextures\\CommandButtons\\BTNHeroAlchemist.blp" )       // Greed goblin
        call SaveStr(HT_data,'N02P',2, "|cff00ffffPassive|r: Greed: Gains 25 bonus gold and experience whenever it kills a unit. |cffc0c0c01% less effective for each level of PillagePillage and Learnability are 22% less effective.|r.")
        call SaveStr(HT_data,'N02P',3, "|cffffff00Level Up Bonus|r: Greed: +3 bonus gold and +4 experience" ) 

        call SaveStr(HT_data,'H01B',1, "ReplaceableTextures\\CommandButtons\\BTNCentaurArcher.blp" )       // Cent archer
        call SaveStr(HT_data,'H01B',2, "|cff00ffffPassive|r: Horsepower: Attacks deal 100% bonus damage + 6% of the targets total hit points once every 2 seconds.")
        call SaveStr(HT_data,'H01B',3, "|cffffff00Level Up Bonus|r: Horsepower: +5% damage." )

        call SaveStr(HT_data,'H01C',1, "ReplaceableTextures\\CommandButtons\\BTNOgre.blp" )       // ogre
        call SaveStr(HT_data,'H01C',2, "|cff00ffffPassive|r: Ogre Stomp: Once every 6 seconds when the Hero deals physical damage it damages nearby enemies for 100% of its strength and stuns them for 1 second.")
        call SaveStr(HT_data,'H01C',3, "|cffffff00Level Up Bonus|r: Ogre Stomp: +60 damage" )

        call SaveStr(HT_data,'H01D',1, "ReplaceableTextures\\CommandButtons\\BTNGhostOfKelThuzad.blp" )       //Xesil
        call SaveStr(HT_data,'H01D',2, "|cff00ffffPassive|r: Xesil's Legacy: 15% chance to reset a spells cooldown when cast. |cffc0c0c0Overrides the item of the same name if stronger and is overriden if weaker.|r [|cff80ff80Luck|r]")
        call SaveStr(HT_data,'H01D',3, "|cffffff00Level Up Bonus|r: Xesil's Legacy: +0.1% chance. +100 mana, +1 mana regeneration." )

        call SaveStr(HT_data,'H01E',1, "ReplaceableTextures\\CommandButtons\\BTNOgreMagi.blp" )       //OGRE MAGE
        call SaveStr(HT_data,'H01E',2, "|cff00ffffPassive|r: Ogre's Luck: Whenever the Hero casts an ability it has a 15% chance to cast it again. [|cff80ff80Luck|r] ")
        call SaveStr(HT_data,'H01E',3, "|cffffff00Level Up Bonus|r: Ogre's Luck: +2% chance." )

        call SaveStr(HT_data,'O00A',1, "ReplaceableTextures\\CommandButtons\\BTNForestTroll.blp" )       //OGRE MAGE
        call SaveStr(HT_data,'O00A',3, "|cffffff00Level Up Bonus|r: +1% attack speed." )

        call SaveStr(HT_data,'O00B',1, "ReplaceableTextures\\CommandButtons\\BTNWendigo.blp" )       //Yeti
        call SaveStr(HT_data,'O00B',2, "|cff00ffffPassive|r: Yeti Strength: Gives the Hero +20 strength if it hass less than 50 armor. ")
        call SaveStr(HT_data,'O00B',3, "|cffffff00Level Up Bonus|r: Yeti Strength: +20 bonus, +2 armor limit." )
        
        call SaveStr(HT_data,'O00C',1, "ReplaceableTextures\\CommandButtons\\BTNSatyr.blp" )       //Satyr
        call SaveStr(HT_data,'O00C',2, "|cff00ffffPassive|r: Trickshot: When the Satyr evades an attack it counters, dealing 100% of its attack damage back to the attacker.")
        call SaveStr(HT_data,'O00C',3, "|cffffff00Level Up Bonus|r: Trickshot: +2% damage. +0.5 evasion." )

        call SaveStr(HT_data,'H01F',1, "ReplaceableTextures\\CommandButtons\\BTNMurlocNightCrawler.blp" )       //Murlock
        call SaveStr(HT_data,'H01F',2, "|cff00ffffPassive|r: Fish Hook: Increases all stats by 1 every time the Hero attacks an enemy, lasts until the end of the fight. ")
        call SaveStr(HT_data,'H01F',3, "|cffffff00Level Up Bonus|r: (Every 10 levels) Fish Hook: +1 stat per attack." )
        
        call SaveStr(HT_data,'H01G',1, "ReplaceableTextures\\CommandButtons\\BTNMedivh.blp" )       //Mediv
        call SaveStr(HT_data,'H01G',3, "|cffffff00Level Up Bonus|r: +2 magic power." )
        
        call SaveStr(HT_data,'H01H',1, "ReplaceableTextures\\CommandButtons\\BTNGhoul.blp" )       //ghoul
        call SaveStr(HT_data,'H01H',2, "|cff00ffffPassive|r: Cannibal Frenzy: +1% attack damage and 100% lifesteal on that damage. ")
        call SaveStr(HT_data,'H01H',3, "|cffffff00Level Up Bonus|r: Cannibal Frenzy: +1% attack damage." )

        call SaveStr(HT_data,'H01I',1, "ReplaceableTextures\\CommandButtons\\BTNBanshee.blp" )       //banshee
        call SaveStr(HT_data,'H01I',2, "|cff00ffffPassive|r: Banshee's Curse: 75% of the Hero's maximum hit points are added to its mana. When the Hero takes damage its mana is reduced instead of its hit points. When it reaches 0 mana it dies." )
        
        call SaveStr(HT_data,'H01J',1, "ReplaceableTextures\\CommandButtons\\BTNGrunt.blp" )       //grunt
        call SaveStr(HT_data,'H01J',2, "|cff00ffffPassive|r: The Grunt's Grunt: At the start of every fight the Hero gains 20 bonus attack damage and strength for 10 seconds. ")
        call SaveStr(HT_data,'H01J',3, "|cffffff00Level Up Bonus|r: Grunt's Grunt: +20 attack damage and strength, +0.1 seconds duration." )
        
        call SaveStr(HT_data,'H01L',1, "ReplaceableTextures\\CommandButtons\\BTNDranaiMage.blp" )       //seer
        call SaveStr(HT_data,'H01L',2, "|cff00ffffPassive|r: Magical Insight: The Hero's physical damage dealt becomes magic damage and its magic damage dealt becomes physical damage." )
    
        call SaveStr(HT_data,'H00A',1, "ReplaceableTextures\\CommandButtons\\BTNHeroTaurenChieftain.blp" )       //Areana master
        call SaveStr(HT_data,'H00A',3, "|cffffff00Level Up Bonus|r: +200 glory." )
    endfunction
endlibrary