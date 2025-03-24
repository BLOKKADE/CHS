library ReplaceItem initializer init
    globals
        Table ReplaceItemTable
        Table ReplacedItemId
    endglobals
    
    // When an item is of PICKUP type register it in SetupItems and it will automatically be replaced with a new item when picked up

    function IsItemReplaced takes integer itemHid returns boolean
        return ReplacedItemId.boolean[itemHid]
    endfunction

    function SetItemReplaced takes integer itemHid returns nothing
        set ReplacedItemId.boolean[itemHid] = true
    endfunction

    function IsItemReplaceable takes integer itemId returns boolean
        return ReplaceItemTable[itemId] != 0
    endfunction

    function GetItemReplacement takes integer itemId returns integer
        return ReplaceItemTable[itemId]
    endfunction

    private function InitializeItemReplacement takes integer itemId1, integer itemId2 returns nothing
        set ReplaceItemTable[itemId1] = itemId2
    endfunction

    private function SetupItems takes nothing returns nothing
    endfunction

    private function init takes nothing returns nothing
        set ReplaceItemTable = Table.create()
        set ReplacedItemId = Table.create()
        call SetupItems()
    endfunction
endlibrary
