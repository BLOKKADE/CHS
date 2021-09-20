library LuckyPants requires BuffSystem, CustomState
    function ActivateLuckyPants takes unit target returns nothing
        call SetBuff(target, 7, 10)
        call DestroyEffect(AddSpecialEffect("war3mapImported\\Heal Orange.mdx", GetUnitX(target), GetUnitY(target)))
        call CustomStateBonus.create(target, CustomState_Luck, 0.005, 7)
    endfunction
endlibrary