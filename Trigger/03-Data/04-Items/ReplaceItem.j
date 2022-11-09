library ReplaceItem initializer init
    globals
        Table ReplaceItemTable
        Table ReplacedItemId
    endglobals

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
        call InitializeItemReplacement('I0C1', 'I0CV')
        call InitializeItemReplacement('I0CM', 'I0CY')
        call InitializeItemReplacement('I0CO', 'I0CX')
        call InitializeItemReplacement('I07H', 'I0CW')
        call InitializeItemReplacement('I0CP', 'I0CZ')
    endfunction

    private function init takes nothing returns nothing
        set ReplaceItemTable = Table.create()
        set ReplacedItemId = Table.create()
        call SetupItems()
    endfunction
endlibrary
