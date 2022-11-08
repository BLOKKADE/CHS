library LuckyPants requires BuffSystem, CustomState
    function ActivateLuckyPants takes unit target returns nothing
        call SetBuff(target, 7, 10)
        call DestroyEffect(AddLocalizedSpecialEffect("war3mapImported\\Heal Orange.mdx", GetUnitX(target), GetUnitY(target)))
        call TempBonus.create(target, BONUS_LUCK, 0.008, 7, LUCKY_PANTS_ITEM_ID)
    endfunction
endlibrary