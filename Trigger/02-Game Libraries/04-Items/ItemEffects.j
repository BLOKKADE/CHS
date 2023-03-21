library ItemEffects initializer init
    globals
        Table ItemEffects
    endglobals

    struct ItemAbilData
        unit source
        integer itemId
        integer itemDiff
        integer itemUniqueDiff
    endstruct

    function interface ItemEffect takes ItemAbilData data returns nothing

    function SetupItemAbility takes integer itemid, integer abil1, integer abil2, integer abil3, integer abil4 returns nothing

    endfunction

    function GetItemEffect takes integer itemId returns ItemEffect
        return ItemEffects.integer[itemId]
    endfunction

    function AddItemEffect takes integer itemId, ItemEffect itemEffectFunc returns nothing
        set ItemEffects.integer[itemId] = ItemEffects
    endfunction

    private function init takes nothing returns nothing
        set ItemEffects = HashTable.create()
    endfunction
endlibrary