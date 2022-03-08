library EconomyMode requires ShopIndex
    function RemoveEconomySpells takes nothing returns nothing
        call RemoveItemFromStock(GetShopById(PASSIVE_SPELLS_II_UNIT_ID), PILLAGE_ITEM_ID)
        call RemoveItemFromStock(GetShopById(PASSIVE_SPELLS_III_UNIT_ID), LEARNABILITY_ITEM_ID)
        call RemoveItemFromStock(GetShopById(ACTIVE_SPELLS_V_UNIT_ID), MIDAS_TOUCH_ITEM_ID)
        call RemoveItemFromStock(GetShopById(CHRONUS_SPELLS_UNIT_ID), HOLY_ENLIGHTENMENT_ITEM_ID)
    endfunction
endlibrary