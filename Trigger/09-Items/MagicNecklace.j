library MagicNecklace initializer init requires Table
    globals
        Table MnXpBonus
        Table MagicNecklaceBonus
    endglobals

    function GetMagicNecklaceBonus takes unit source, unit target returns real
        if MagicNecklaceBonus.boolean[GetHandleId(target)] and UnitHasItemOfTypeBJ(source, 'I05G') then
            return MnXpBonus.real[GetHandleId(source)]
        else
            return 0.
        endif
    endfunction

    private function init takes nothing returns nothing
        set MagicNecklaceBonus = Table.create()
        set MnXpBonus = Table.create()
    endfunction
endlibrary