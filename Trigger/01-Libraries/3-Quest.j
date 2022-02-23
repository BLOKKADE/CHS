scope Quests initializer init
    globals
        string VERSION = "CHS 1.9.30-beta1"
    endglobals

    function AddQuest takes string title, string description, string icon, boolean required, boolean discovered, boolean completed returns nothing
        set bj_lastCreatedQuest = CreateQuest()
        call QuestSetTitle(bj_lastCreatedQuest, title)
        call QuestSetDescription(bj_lastCreatedQuest, description)
        call QuestSetIconPath(bj_lastCreatedQuest, icon)
        call QuestSetRequired(bj_lastCreatedQuest, required)
        call QuestSetDiscovered(bj_lastCreatedQuest, discovered)
        call QuestSetCompleted(bj_lastCreatedQuest, completed)
    endfunction

    function AddQuestItem takes quest q, string desc, boolean completed returns nothing
        set bj_lastCreatedQuestItem = QuestCreateItem(q)
        call QuestItemSetDescription(bj_lastCreatedQuestItem, desc)
        call QuestItemSetCompleted(bj_lastCreatedQuestItem, completed)
    endfunction
    
    function QuestSetUp takes nothing returns nothing
        call AddQuest("General Information", "Continuation of Custom Hero Survival 1.9.xx by Snowww & BLOKKADE.\nDevelopers: BLOKKADE, A Black Death.\nThanks to Barebacker for working on the descriptions.\nThanks to everyone on the Discord for feedback and suggestions.\n", "ReplaceableTextures\\PassiveButtons\\PASTimeEclipse3.blp", true, true, false)
        call AddQuestItem(bj_lastCreatedQuest, "Visit the discord to join our community!", false)
        call AddQuestItem(bj_lastCreatedQuest, "customherosurvival.com or discord.gg/dtTcyMGTyu", false)
        call AddQuestItem(bj_lastCreatedQuest, "Current version: " + VERSION, false)

        call AddQuest("Tags", "-[|cffffff00Plain|r]: This spell cannot be cast by Multicast, Mysterious Talent, Chaos Magic, Random Spells or Manifold Staff\n-[|cffff6464Summon|r]: This spell cannot be cast by Chaos Magic, but can be cast by Random Summons.\n-[|cff80ff80Luck|r]: This spell can be affected by the luck stat, some items/abilities will increase the chance of it occuring.\n-[|cff00ffffCrit|r]: This spell is counted as a crit, some items/abilities will affect it in different ways.\n-[|cffd45e29onhit|r]: This spell counts as an onhit effect, it can not trigger other [|cffd45e29onhit|r] effects and might be affected by some spells/abilities.\n-[|cff96ffffStable|r]: This ability cannot have its cooldown reset by Ancient Teaching, Sand of Time, Xesil's Legacy, Arcane Runestone or Cheater Magic.\n-[|cffc880ffUnpurgeable|r]: This ability can not be disabled through Purge.\n-[|cffff9696Lifesteal|r]: This ability might be affected in certain ways by some spells/items.\n-[Element]: This is an element which might have an Absolute Spell associated with it, those can be found in the Absolute Shop.", "ReplaceableTextures\\CommandButtons\\BTNbookAzyr.blp", true, true, false)
        call AddQuestItem(bj_lastCreatedQuest, "There are multiple tags for different spells and items in CHS.", false)
        call AddQuestItem(bj_lastCreatedQuest, "Here's a short list of the most important ones!", false)

        call AddQuest("Runes", "|cffffff00Rune of Attack|r: Increases attack damage.\n|cffffff00Rune of Earth|r: Damages and stuns nearby enemies.\n|cffffff00Rune of Power|r: Increases magic power.\n|cffffff00Rune of Healing|r: Heals the Hero.\n|cffffff00Rune of Life|r: Increases maximum hit points.\n|cffffff00Rune of Magic|r: Reduces the cooldown of abilities.\n|cffffff00Rune of Fire|r: Deals damage to nearby enemies.\n|cffffff00Rune of Chaos|r: Casts random spells at nearby enemies.\n|cffffff00Rune of Storm|r: Teleports enemies to the Hero and damages them.\n|cffffff00Rune of Wind|r: Immobilizes and deals damage per second to nearby enemies.\n|cffffff00Dark Rune|r: Silences nearby enemies.\n|cffffff00Light Rune|r: Deals damage to enemies based on the Hero's maximum hit points.\n|cffffff00Wild Rune|r: Permanently increases a random summon upgrade (attack, armor, hp).\n|cffffff00Poison Rune|r: Gives the Hero Envenomed Weapons and makes it work on magic damage.(can go higher than 30 levels).\n|cffffff00Blood Rune|r: Disables the lifesteal abilities/items of nearby enemies.", "ReplaceableTextures\\CommandButtons\\BTN_StoneTablet_AzsharaLogo.blp", true, true, false)
        call AddQuestItem(bj_lastCreatedQuest, "Runes can be spawned by certain items and abilities and all have different effects.", false)
        call AddQuestItem(bj_lastCreatedQuest, "The strength of rune effects is based on |cff3cff00Rune Power|r: increased by items/abilities.", false)

        //call AddQuest("Glossary Of Terms", "Damage\n-Physical: default damage, reduced by the targets armor and block, can be evaded. |n-Magic: increased by the sources magic power and the targets magic protection and block\n\n-Attack: attack damage. Can be physical or magic.\n-Spell: all abilities count as spell damage unless mentioned otherwise. Can be physical or magic.", "", true, true, false)
        
        call AddQuest("Commands", "-vk (player number, player name or player colour): starts a votekick against that player. \n-de, removes some fx (lifesteal, Air Force, etc), this increases performance.\n-zoom xxxx, zooms your camera in or out.\n-clear, clears all text off your screen.\n-hint, disables hints.\n-time, displays playtime\n-nis, disables income texts from other players\n\nSingleplayer Commands (activate when 1 player is left)\n-nx, starts the next round if used inbetween rounds\n-rt xxx, sets the timer to the next round to xxx (xxx needs to be a number)\n\nDebug Commands (enabled if map is started with 1 player)\n-dummy, spawns an invincible dummy at your heroes position (round cant end until it dies)\n-lvl xxx, adds xxx levels to your hero\n-glory xxx, gives you xxx glory", "ReplaceableTextures\\PassiveButtons\\PASScarlet_Aegis_Icon.blp", false, true, false)

        call AddQuest("Hotkeys", "|cff3cff00CTRL + Q|r to convert all lumber to gold. |cff3cff00CTRL + W|r to convert all gold to lumber.\nWhen buying an ability, creep upgrade, glory buff or time hold |cffeeff00SHIFT|r to buy as much of it as you can (does not convert resources).", "ReplaceableTextures\\CommandButtons\\BTNSpell_Holy_SealOfWrath.blp", false, true, false)

        call AddQuest("Credits", "Code\nBribe, Vexorian, Jesus4Lyf \n\nIcons\nPeeKay, Marcos DAB, Nightcrime, Dentothor, Darkfang, Kola, Mr. Goblin, JollyD, The Panda, Blood Raven, -Berz-,bu3ny \n\nModels\nJesusHipster, nGy, exfyre, Mythic, Hermit, xyzier_24, JetFangInferno", "ReplaceableTextures\\CommandButtons\\BTNPeasant.blp" , false, true, false)
        call AddQuestItem(bj_lastCreatedQuest, "Thanks to N1 for making the ability draft mode.", false)
        call AddQuestItem(bj_lastCreatedQuest, "Thanks to Komoset for making the loading screen.", false)
        call AddQuestItem(bj_lastCreatedQuest, "This list is incomplete. Is your name missing? Let us know.", false)

        call AddQuest("Selected Mode", "", "ReplaceableTextures\\CommandButtons\\BTNWisp.blp", false, true, false)
    endfunction
    
    private function init takes nothing returns nothing
        call QuestSetUp()
    endfunction
endscope