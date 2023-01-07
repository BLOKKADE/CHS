library AbilityUpgradeShop requires DraftModeFunctions, RandomShit

    //globals used from draft mode: circle2 FloatingTextUpgrade udg_Draft_UpgradeBuildings[]

    globals
        boolean UpgradeShopInitialized = false
        private constant integer upgradeShopX = 1200
        private constant integer upgradeShopY = 200
    endglobals

    function RefreshUpgradeShop takes integer pid, unit u returns nothing
        local integer itemId = 0
        local integer i = 0
        loop
            set itemId = GetItemFromAbility(GetHeroSpellAtPosition(u, i))

            if itemId != 0 then
                call RemoveItemFromStock(udg_Draft_UpgradeBuildings[pid], itemId)
                call AddItemToStock(udg_Draft_UpgradeBuildings[pid], itemId, 1, 1)
            endif

            set i = i + 1
            exitwhen i > 10
        endloop
    endfunction

    function RemoveItemFromUpgradeShop takes integer pid, integer itemId returns nothing
        call RemoveItemFromStock(udg_Draft_UpgradeBuildings[pid], itemId)
    endfunction

    function AddItemToUpgradeShop takes integer pid, integer itemId returns nothing
        call AddItemToStock(udg_Draft_UpgradeBuildings[pid], itemId, 1, 1)
    endfunction

    function CreateUpgradeShop takes nothing returns nothing
        local unit u = CreateUnit(GetEnumPlayer(), DRAFT_UPGRADE_UNIT_ID, upgradeShopX, upgradeShopY, 0)

        set udg_Draft_UpgradeBuildings[GetPlayerId(GetEnumPlayer())] = u
        set u = null
    endfunction

    function InitUpgradeShop takes nothing returns nothing
        if UpgradeShopInitialized == false then
            set UpgradeShopInitialized = true
            set circle2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n037', upgradeShopX, upgradeShopY, 0)
            //set FloatingTextUpgrade = ShopText(upgradeShopX, upgradeShopY, "Upgrade abilities", 0, 255, 100)
            //call SetTextTagVisibility(FloatingTextUpgrade, true)
            call ForForce( PlayersWithHero, function CreateUpgradeShop) 
        endif
    endfunction
endlibrary