library AbilityUpgradeShop requires DraftModeFunctions

    //globals used from draft mode: circle2 FloatingTextUpgrade udg_Draft_UpgradeBuildings[]

    globals
        boolean UpgradeShopInitialized = false
        private constant integer upgradeShopX = 1200
        private constant integer upgradeShopY = 200
    endglobals

    function RemoveItemFromUpgradeShop takes integer pid, integer itemId returns nothing
        call RemoveItemFromStock(udg_Draft_UpgradeBuildings[pid + 1], itemId)
    endfunction

    function AddItemToUpgradeShop takes integer pid, integer itemId returns nothing
        call AddItemToStock(udg_Draft_UpgradeBuildings[pid + 1], itemId, 1, 1)
    endfunction

    function CreateUpgradeShop takes nothing returns nothing
        local unit u = CreateUnit(GetEnumPlayer(), udg_Draft_UpgradeBuilding, upgradeShopX, upgradeShopY, 0)

        set udg_Draft_UpgradeBuildings[GetConvertedPlayerId(GetEnumPlayer())] = u
        set u = null
    endfunction

    function InitUpgradeShop takes nothing returns nothing
        if UpgradeShopInitialized == false then
            set UpgradeShopInitialized = true
            set circle2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n037', upgradeShopX, upgradeShopY, 0)
            //set FloatingTextUpgrade = ShopText(upgradeShopX, upgradeShopY, "Upgrade abilities", 0, 255, 100)
            //call SetTextTagVisibility(FloatingTextUpgrade, true)
            call ForForce( udg_force01, function CreateUpgradeShop) 
        endif
    endfunction
endlibrary