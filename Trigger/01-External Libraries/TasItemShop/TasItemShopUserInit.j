library TasItemShopUserInit initializer TasItemShopUserInit requires TasItemShop
    // This script  is meant to be used by vjass user to write init data for TasItemShop
    
    // This runs right before the actually UI is created.
    // this is a good place to add items, categories, fusions shops etc.
    function TasItemShopUserInit takes nothing returns nothing
        local integer shopObject
        // this can all be done in GUI aswell, enable the next Line or remove all Text of this function if you only want to use GUI
        //if true then return end

        // define Categories: Icon, Text
        // the Categories are displayed in the order added.
        // it is a good idea to save the returned Value in a local to make the category setup later much easier to understand.
        // you can only have 31 categories
        local integer catDmg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSteelMelee", "COLON_DAMAGE")
        local integer catArmor = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanArmorUpOne", "COLON_ARMOR")
        local integer catStr = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNGauntletsOfOgrePower", "STRENGTH")
        local integer catAgi = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSlippersOfAgility", "AGILITY")
        local integer catInt = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNMantleOfIntelligence", "INTELLECT")
        local integer catLife = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPeriapt", "Life")
        local integer catLifeReg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNRegenerate", "LifeRegeneration")
        local integer catMana = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPendantOfMana", "Mana")
        local integer catManaReg = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNSobiMask", "ManaRegeneration")
        local integer catOrb = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness", "Orb")
        local integer catAura = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNLionHorn", "Aura")
        local integer catActive = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNStaffOfSilence", "Active")
        local integer catPower = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNControlMagic", "SpellPower")
        local integer catCooldown = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne", "Cooldown")
        local integer catAtkSpeed = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNHumanMissileUpOne", "Attackspeed")
        local integer catMress = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNRunedBracers", "Magic-Resistence")
        local integer catConsum = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNPotionGreenSmall", "ConsumAble")
        local integer catMoveSpeed = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNBootsOfSpeed", "COLON_MOVE_SPEED")
        local integer catCrit = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNCriticalStrike", "Crit")
        local integer catLifeSteal = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNVampiricAura", "Lifesteal")
        local integer catEvade = TasItemShopAddCategory("ReplaceableTextures\\CommandButtons\\BTNEvasion", "Evasion")
        
        // Item Shop I
        // Potions of greater healing, potion of greater mana, vampiric potions, ankh, suport potion of healing
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'pghe', 'pgma', 'vamp', 'I0BH', 'I020')
        // Super potion of mana, full restore, gauntlets of haste, boots of super speed, hood of cunning
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I021', 'I04G', 'I023', 'I04D', 'I01Q')
        // Gem of health, runed bracers
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I01P', 'I04C')

        // Item Shop II
        // Moonstone, volcanis armour, reavers acxe, aduxxors legendary blade, xesils legacy
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I03O', 'I03T', 'I04A', 'I015', 'I03P')
        // Sceptor of confusion, space invaders assault cuirass, sensatus shielf of honor, armor of the goddess, the divine source
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I03R', 'I04B', 'I016', 'I01D', 'I043')
        // Soul reaper, rapier of the gods
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I01C', 'I01E')

        // Item Shop III
        // Frost mourve, cload of sorrow, grass of immortality, scroll of power, anti magic flag
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04P', 'I04O', 'I04N', 'I04J', 'I04Q')
        // Gem stone, light armor, mask of death, medal of honor, heart of darkness
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04S', 'I076', 'I04T', 'I04U', 'I04V')
        // Stormhorn, double armor
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I04W', 'I052')

        // Item Shop IV
        // Legendary shield, bone armor, robes of the archmage, staff of lightning, heart of a hero
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I059', 'I07O', 'I05B', 'I05C', 'I05D')
        // Staff of absolute magic, relic of magic, magic necklace of absorption, pandas masters relic, urn of memories
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I05E', 'I05F', 'I05G', 'I05L', 'I05U')
        // dark shield, trident of pain
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I060', 'I061')

        // Item Shop V
        // Heros hammer, scroll of transformation, hammer of the gods, speed blade, mystical armor
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I064', 'I065', 'I066', 'I06B', 'I06E')
        // Hammer of the gods, magical blade, light magic shield, heavy mace, book of creatures
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I06H', 'I06I', 'I06K', 'I07I', 'I07K')
        // Titanium armor, strong chestmail
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I07M', 'I07P')

        // Item Shop VI
        // Staff of power, hold chain mail, snowwws wand, holy shield, fishing rod
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I080', 'I07U', 'I07V', 'I07W', 'I07T')
        // Universal chain mail, wanderers cape, good luck charm, shadow chain mail, archmade staff
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I07Y', 'I082', 'I083', 'I084', 'I086')
        // Mithril helmet, anti magic cape
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I091', 'I092')

        // Item Shop VII
        // Terrestrial glaive, battle runestone, conquerors bamboo stick, guide to rune mastery, banner of many
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0D1', 'I0BX', 'I0C2', 'I0BZ', 'I0BY')
        // Druidic focus, spiked shield, contract of the living, titanium spike, blokkades shield
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0BW', 'I0BV', 'I0BF', 'I0BE', 'I0BD')
        // Wizards gemstone, shadow blade
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I0BQ', 'I0CN')

        // PVE Shop I
        // Ring of masculature, ring of the bookworm, trainers ring, battle axe, unusual wooden shield
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I071', 'I072', 'I073', 'I075', 'I077')
        // Golden ring, bloody ace, amulet of blood, magic amulet, arena ring
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04R', 'I078', 'I079', 'I07B', 'I0AF')
        // Amulet of the night, strong shield
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I07E', 'I07F')

        // PVE Shop II
        // Golden armor, arcance infused sword, gladiators helmet, manifold staff, armor of the ancestors
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0C1', 'I0BN', 'I07A', 'I0A0', 'I07G')
        // Obsidian armor, chest of greed, book of necromancy, rapira, mana gem
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I07H', 'I05A', 'I06J', 'I0CP', 'I0CO')
        // Leather armor
        call TasItemShopAddShop(ITEM_SHOP_I_UNIT_ID, 'I0CM')

        // Runestone Shop
        // Arcane runestone, dark runestone, light runestone, poison runestone, wild runestone
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0B7', 'I0B5', 'I095', 'I0B8', 'I0B6')
        // Shining runestone, mysterious runestone, runestone of creation, fire runestone, water runestone
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I08L', 'I08M', 'I08N', 'I08P', 'I08Q')
        // Earth runestone, wind runestone
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I08R', 'I08S')

        // Elemental item shop
        // Decaying scythe, scorched scimitar, frost circlet, goblet of blood, pretty bright gem
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0BU', 'I0BO', 'I0BP', 'I0B9', 'I0AM')
        // Bloodstone, null void orb, blaze staff, staff of the archmage of water, fan
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0AK', 'I0AL', 'I08X', 'I08Y', 'I08Z')
        // Stone helmet, orb of the elements
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I090', 'I0CQ')

        call TasItemShopSetMode(ITEM_SHOP_I_UNIT_ID, true)

        // Ability Shop
        // call TasItemSetCategory('I001', catStr + catAgi + catInt)
    endfunction
endlibrary