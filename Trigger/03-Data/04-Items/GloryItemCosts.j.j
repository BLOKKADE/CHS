library GloryItemCosts initializer init requires Glory
    globals
        Table GloryItemCosts
    endglobals

    function IsGloryItem takes integer itemId returns boolean
        return GloryItemCosts.integer[itemId] != 0
    endfunction

    function GetItemGloryCost takes integer itemId returns integer
        return GloryItemCosts.integer[itemId]
    endfunction

    function BuyGloryItem takes integer pid, integer itemId returns boolean
        local integer cost = GetItemGloryCost(itemId)
        if Glory[pid] >= cost then
            set Glory[pid] = Glory[pid] - cost
            return true
        endif
        return false
    endfunction

    private function RefundGlory takes nothing returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(GetTriggerUnit()))
        local integer itemCost = GetItemGloryCost(GetItemTypeId(GetSoldItem()))

        if itemCost != 0 then
            set Glory[pid] = Glory[pid] + itemCost
            call ResourseRefresh(Player(pid))
        endif
    endfunction

    private function SetupGloryItemCosts takes nothing returns nothing
        set GloryItemCosts[GLORY_ABSOLUTE_ARCANE_COUNT_TOME_ITEM_ID] = 10000
        set GloryItemCosts[GLORY_ABSOLUTE_BLOOD_COUNT_TOME_ITEM_ID] = 6000
        set GloryItemCosts[GLORY_ABSOLUTE_DARK_COUNT_TOME_ITEM_ID] = 7000
        set GloryItemCosts[GLORY_ABSOLUTE_EARTH_COUNT_TOME_ITEM_ID] = 6000
        set GloryItemCosts[GLORY_ABSOLUTE_COLD_COUNT_TOME_ITEM_ID] = 8000
        set GloryItemCosts[GLORY_ABSOLUTE_FIRE_COUNT_TOME_ITEM_ID] = 6000
        set GloryItemCosts[GLORY_ABSOLUTE_LIGHT_COUNT_TOME_ITEM_ID] = 6000
        set GloryItemCosts[GLORY_ABSOLUTE_POISION_COUNT_TOME_ITEM_ID] = 7000
        set GloryItemCosts[GLORY_ABSOLUTE_WATER_COUNT_TOME_ITEM_ID] = 6000
        set GloryItemCosts[GLORY_ABSOLUTE_WILD_COUNT_TOME_ITEM_ID] = 10000
        set GloryItemCosts[GLORY_ABSOLUTE_WIND_COUNT_TOME_ITEM_ID] = 7000

        set GloryItemCosts[GLORY_ARMOR_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_ATTACK_DAMAGE_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_HIT_POINT_REGENERATION_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_MAGIC_PROTECTION_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_MAGIC_POWER_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_PHYS_POWER_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_MANA_REGENERATION_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_HIT_POINTS_TOME_ITEM_ID] = 100
        set GloryItemCosts[GLORY_MANA_TOME_ITEM_ID] = 100
        set GloryItemCosts[GLORY_PVP_BONUS_TOME_ITEM_ID] = 2000
        set GloryItemCosts[GLORY_STRENGTH_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_AGILITY_TOME_ITEM_ID] = 1400
        set GloryItemCosts[GLORY_INTELLIGENCE_TOME_ITEM_ID] = 1300
        set GloryItemCosts[GLORY_LUCK_TOME_ITEM_ID] = 2000
        set GloryItemCosts[GLORY_EVASION_TOME_ITEM_ID] = 1500
        set GloryItemCosts[GLORY_BLOCK_TOME_ITEM_ID] = 2000
        set GloryItemCosts[GLORY_MOVESPEED_TOME_ITEM_ID] = 10000

        set GloryItemCosts[ANCIENT_STAFF_TOME_ITEM_ID] = 10000
        set GloryItemCosts[ANCIENT_DAGGER_TOME_ITEM_ID] = 10000
        set GloryItemCosts[ANCIENT_AXE_TOME_ITEM_ID] = 10000
        set GloryItemCosts[VIGOUR_TOKEN_TOME_ITEM_ID] = 10000
        set GloryItemCosts[FLIMSY_TOKEN_TOME_ITEM_ID] = 10000
        set GloryItemCosts[SPELLBANE_TOKEN_TOME_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_ELUSION_TOME_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_VITALITY_TOME_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_PROTECTION_TOME_ITEM_ID] = 10000
        set GloryItemCosts[SWORD_OF_BLOODTHRIST_TOME_ITEM_ID] = 10000
        set GloryItemCosts[WISDOM_CHESTPLATE_TOME_ITEM_ID] = 10000
        set GloryItemCosts[LUCKY_PANTS_TOME_ITEM_ID] = 10000

        set GloryItemCosts[ANCIENT_STAFF_ITEM_ID] = 10000
        set GloryItemCosts[ANCIENT_DAGGER_ITEM_ID] = 10000
        set GloryItemCosts[ANCIENT_AXE_ITEM_ID] = 10000
        set GloryItemCosts[VIGOUR_TOKEN_ITEM_ID] = 10000
        set GloryItemCosts[FLIMSY_TOKEN_ITEM_ID] = 10000
        set GloryItemCosts[SPELL_BANE_TOKEN_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_ELUSION_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_VITALITY_ITEM_ID] = 10000
        set GloryItemCosts[MASK_OF_PROTECTION_ITEM_ID] = 10000
        set GloryItemCosts[SWORD_OF_BLOODTHRIST_ITEM_ID] = 10000
        set GloryItemCosts[WISDOM_CHESTPLATE_ITEM_ID] = 10000
        set GloryItemCosts[LUCKY_PANTS_ITEM_ID] = 10000
    endfunction

    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_PAWN_ITEM  )
        call TriggerAddAction(trg, function RefundGlory)
        set trg = null

        set GloryItemCosts = Table.create()

        call SetupGloryItemCosts()
    endfunction
endlibrary