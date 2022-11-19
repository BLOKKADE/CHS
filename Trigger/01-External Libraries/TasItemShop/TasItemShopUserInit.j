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
        
        // Item Shop
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'pghe', 'pgma', 'vamp', 'I0BH', 'I020')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I021', 'I04G', 'I023', 'I04D', 'I01Q')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I01P', 'I04C')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I03O', 'I03T', 'I04A', 'I015', 'I03P')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I03R', 'I04B', 'I016', 'I01D', 'I043')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I01C', 'I01E')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04P', 'I04O', 'I04N', 'I04J', 'I04Q')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04S', 'I076', 'I04T', 'I04U', 'I04V')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I04W', 'I052')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I059', 'I07O', 'I05B', 'I05C', 'I05D')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I05E', 'I05F', 'I05G', 'I05L', 'I05U')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I060', 'I061')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I064', 'I065', 'I066', 'I06B', 'I06E')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I06H', 'I06I', 'I06K', 'I07I', 'I07K')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I07M', 'I07P')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I080', 'I07U', 'I07V', 'I07W', 'I07T')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I07Y', 'I082', 'I083', 'I084', 'I086')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I091', 'I092')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0BX', 'I0C2', 'I0BZ', 'I0BY', 'I0BW')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0BV', 'I0BF', 'I0BE', 'I0BD', 'I0BQ')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I071', 'I072', 'I073', 'I075', 'I077')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I04R', 'I078', 'I079', 'I07B', 'I0AF')
        call TasItemShopAddShop2(ITEM_SHOP_I_UNIT_ID, 'I07E', 'I07F')
        call TasItemShopAddShop5(ITEM_SHOP_I_UNIT_ID, 'I0C1', 'I0BN', 'I07A', 'I0A0', 'I07G')
        call TasItemShopAddShop3(ITEM_SHOP_I_UNIT_ID, 'I07H', 'I05A', 'I06J')

        call TasItemShopSetMode(ITEM_SHOP_I_UNIT_ID, true)

        // Ability Shop
        // call TasItemSetCategory('I001', catStr + catAgi + catInt)
    endfunction
endlibrary