library ShopIndex initializer init
    
    globals
        Table ShopIndex
    endglobals

    function GetShopById takes integer unitTypeId returns unit
        return ShopIndex.unit[unitTypeId]
    endfunction

    function SetShopIndex takes unit u returns nothing
        set ShopIndex.unit[GetUnitTypeId(u)] = u
    endfunction

    private function init takes nothing returns nothing
        set ShopIndex = Table.create()
    endfunction
endlibrary