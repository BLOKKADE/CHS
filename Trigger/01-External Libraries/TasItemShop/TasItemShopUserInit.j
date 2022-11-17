library TasItemShopUserInit initializer TasItemShopUserInit requires TasItemShop
    // This script  is meant to be used by vjass user to write init data for TasItemShop
    
    private function ShopCostFunction_ngme takes nothing returns nothing
    endfunction

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
        
        call TasItemShopAdd5('rst1', 'bgst', 'rin1', 'ciri', 'belv')
        call TasItemShopAdd('rag1', catAgi)
        call TasItemShopAdd5('rlif', 'ajen', 'clfm', 'ward', 'kpin')
        call TasItemShopAdd5('lgdh', 'rde4', 'pmna', 'rhth', 'ssil')
        call TasItemShopAdd5('spsh', 'lhst', 'afac', 'sbch', 'brac')
        call TasItemShopAdd5('rwiz', 'evtl', 'penr', 'prvt', 'rde3')
        call TasItemShopAdd5('hval', 'hcun', 'mcou', 'cnob', 'ckng')
        call TasItemShopAdd5('rat6', 'rat9', 'ratf', 'bspd', 'gcel')
        call TasItemShopAdd5('rde2', 'clsd', 'dsum', 'stel', 'desc')

        call TasItemShopAdd5('modt', 'ofro', 'thdm', 'hlst', 'mnst')
        call TasItemShopAdd5('pghe', 'pgma', 'pnvu', 'pres', 'ankh')
        call TasItemShopAdd5('shas', 'stwp', 'ofir', 'oli2', 'odef')
        call TasItemShopAdd5('oven', 'oslo', 'ocor', 'shtm', 'I001')
        call TasItemShopAdd5('klmm', 'crdt', 0, 0, 0)


        // setup custom shops
        // custom Shops are optional.
        // They can have a White or Blacklist of items they can(n't) sell and have a fixed cost modifier for Gold, Lumber aswell as a function for more dynamic things for Gold and Lumber.
        set shopObject = 'n000'
        // 'n000' can only sell this items (this items don't have to be in the pool of items)
        call TasItemShopAddShop5(shopObject, 'hlst', 'mnst', 'pghe', 'pgma', 'pnvu')
        call TasItemShopAddShop5(shopObject, 'pres', 'ankh', 'stwp', 'shas', 0)
        // enable WhiteListMode
        call TasItemShopSetMode(shopObject, true)
        
        // 'n001' can't sell this items (from the default pool of items)
        set shopObject = 'n001'
        call TasItemShopAddShop5(shopObject, 'hlst', 'mnst', 'pghe', 'pgma', 'pnvu')
        call TasItemShopAddShop5(shopObject, 'pres', 'ankh', 'stwp', 'shas', 0)
        // enable BlackListMode
        call TasItemShopSetMode(shopObject, false)
        
        // create an shopObject for 'ngme', has to pay 20% more than normal, beaware that this can be overwritten by GUI Example
        call TasItemShopCreateShop('ngme', false, 1.2, 1.2, function ShopCostFunction_ngme)
        //'I002' crown +100 was never added to the database but this shop can craft/sell it.
        set shopObject = 'n002'
        call TasItemShopAddShop5(shopObject, 'ckng', 'I001', 'I002', 'arsh', 0)
        call TasItemShopSetMode(shopObject, true)
        

        // Define skills/Buffs that change the costs in the shop
        // cursed Units have to pay +25%
        call TasItemShopAddHaggleSkill('Bcrs', 1.25, 1.25, 0, 0)

        // define Fusions
        // result created by 'xxx', 'xx' , 'x'+.
        // item can only be crafted by one way
        // can add any amount of material in the Lua version
        call TasItemFusionAdd2('bgst', 'rst1', 'rst1')
        call TasItemFusionAdd2('ciri', 'rin1', 'rin1')
        call TasItemFusionAdd2('belv', 'rag1', 'rag1')
        call TasItemFusionAdd2('hval', 'rag1', 'rst1')
        call TasItemFusionAdd2('hcun', 'rag1', 'rin1')
        call TasItemFusionAdd2('mcou', 'rst1', 'rin1')
        call TasItemFusionAdd2('ckng', 'cnob', 'cnob')
        call TasItemFusionAdd2('rat9', 'rat6', 'rat6')
        call TasItemFusionAdd2('ratf', 'rat9', 'rat9')
        call TasItemFusionAdd('rde4', 'rde3')
        call TasItemFusionAdd('rde3', 'rde2')
        call TasItemFusionAdd('rhth', 'prvt')
        call TasItemFusionAdd('pmna', 'penr')
        call TasItemFusionAdd2('arsh', 'rde3', 'rde2')

        call TasItemFusionAdd('lhst', 'sfog')

        // crown of Kings + 50
        call TasItemFusionAdd4('I001', 'ckng', 'ckng', 'ckng', 'ckng')
        call TasItemFusionAdd4('I001', 'ckng', 'ckng', 'bgst', 'bgst')
        call TasItemFusionAdd6('I001', 'ciri', 'ciri', 'belv', 'belv', 'cnob', 'cnob')
        // crown of Kings + 100, this is a joke you can not craft it because it was not added to buyAble Items
        call TasItemFusionAdd2('I002', 'I001', 'I001')


        call TasItemFusionAdd('modt', 'rst1')
        call TasItemFusionAdd('ofro', 'rst1')
        call TasItemFusionAdd('thdm', 'rst1')
        call TasItemFusionAdd('hlst', 'rst1')
        call TasItemFusionAdd('mnst', 'rst1')
        call TasItemFusionAdd('ocor', 'rst1')

        // define item Categories
        // uses the locals from earlier.
        // An item can have multiple categories just add them together like this: catStr + catAgi + catInt
        
        call TasItemSetCategory('rst1', catStr)
        call TasItemSetCategory('bgst', catStr)
        call TasItemSetCategory('rin1', catInt)
        call TasItemSetCategory('ciri', catInt)
        call TasItemSetCategory('rag1', catAgi)
        call TasItemSetCategory('belv', catAgi)

        call TasItemSetCategory('I001', catStr + catAgi + catInt)

        call TasItemSetCategory('ckng', catStr + catAgi + catInt)
        call TasItemSetCategory('mcou', catStr + catInt)
        call TasItemSetCategory('hval', catStr + catAgi)
        call TasItemSetCategory('hcun', catAgi + catInt)
        call TasItemSetCategory('cnob', catStr + catAgi + catInt)

        call TasItemSetCategory('rat9', catDmg)
        call TasItemSetCategory('rat6', catDmg)
        call TasItemSetCategory('ratf', catDmg)
        
        call TasItemSetCategory('rlif', catLifeReg)

        call TasItemSetCategory('ajen', catAura + catAtkSpeed + catMoveSpeed)
        call TasItemSetCategory('clfm', catAura + catDmg)
        call TasItemSetCategory('ward', catAura + catDmg)
        call TasItemSetCategory('kpin', catAura + catManaReg)
        call TasItemSetCategory('lgdh', catAura + catMoveSpeed + catLifeReg)
        call TasItemSetCategory('rde4', catArmor)
        call TasItemSetCategory('pmna', catMana)
        call TasItemSetCategory('rhth', catLife)
        call TasItemSetCategory('ssil', catActive)
        call TasItemSetCategory('lhst', catAura + catArmor)
        call TasItemSetCategory('afac', catAura + catDmg)
        call TasItemSetCategory('sbch', catAura + catDmg)
        call TasItemSetCategory('sbch', catAura + catLifeSteal)
        call TasItemSetCategory('brac', catMress)
        call TasItemSetCategory('spsh', catMress + catActive)
        call TasItemSetCategory('rwiz', catManaReg)
        call TasItemSetCategory('crys', catActive)
        call TasItemSetCategory('evtl', catEvade)
        call TasItemSetCategory('penr', catMana)
        call TasItemSetCategory('prvt', catLife)
        call TasItemSetCategory('rde3', catArmor)
        call TasItemSetCategory('bspd', catMoveSpeed)
        call TasItemSetCategory('gcel', catAtkSpeed)
        call TasItemSetCategory('rde2', catArmor)
        call TasItemSetCategory('clsd', catActive)
        call TasItemSetCategory('dsum', catActive + catMoveSpeed)
        call TasItemSetCategory('stel', catActive + catMoveSpeed)
        call TasItemSetCategory('desc', catActive + catMoveSpeed)
        call TasItemSetCategory('ofro', catDmg + catOrb)
        call TasItemSetCategory('modt', catLifeSteal + catOrb)
        call TasItemSetCategory('thdm', catActive)
        call TasItemSetCategory('hlst', catActive + catConsum + catLifeReg)
        call TasItemSetCategory('mnst', catActive + catConsum + catManaReg)
        call TasItemSetCategory('pghe', catActive + catConsum)
        call TasItemSetCategory('pgma', catActive + catConsum)
        call TasItemSetCategory('pnvu', catActive + catConsum)
        call TasItemSetCategory('pres', catActive + catConsum)
        call TasItemSetCategory('ankh', catConsum)
        call TasItemSetCategory('stwp', catActive + catConsum + catMoveSpeed)
        call TasItemSetCategory('shas', catActive + catConsum + catMoveSpeed)
        call TasItemSetCategory('ofir', catOrb + catDmg)
        call TasItemSetCategory('oli2', catOrb + catDmg)
        call TasItemSetCategory('odef', catOrb + catDmg)
        call TasItemSetCategory('oven', catOrb + catDmg)
        call TasItemSetCategory('oslo', catOrb + catDmg)
        call TasItemSetCategory('ocor', catOrb + catDmg)
        call TasItemSetCategory('shtm', catActive)
    endfunction
endlibrary