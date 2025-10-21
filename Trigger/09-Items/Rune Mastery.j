library RuneMaster initializer init requires CustomState, RuneInit
    globals
        rect rectRune = null
        unit RuneMasterCaster
        HashTable RuneMasteryCdReduction
        integer RuneMasterUsedCount = 0 // NEW: Counter for used runes
    endglobals

    function ToggleRunestoneRuneMasteryCd takes unit u, integer abilId returns nothing
        set RuneMasteryCdReduction[GetHandleId(u)].boolean[abilId] = not RuneMasteryCdReduction[GetHandleId(u)].boolean[abilId]
    endfunction

    function IsRunestoneRuneMasteryCdResettable takes unit u, integer abilId returns boolean
        return RuneMasteryCdReduction[GetHandleId(u)].boolean[abilId]
    endfunction

    private function UseRunes takes nothing returns nothing
        local item it = GetFilterItem()
        local real dx
        local real dy
        local real luck = GetUnitCustomState(RuneMasterCaster, BONUS_LUCK)

        // Stop if we've already used 10 runes
        if RuneMasterUsedCount >= 10 then
            return
        endif

        if GetItemType(it) == ITEM_TYPE_POWERUP and RuneIndex[GetHandleId(it)] == GetPlayerId(GetOwningPlayer(RuneMasterCaster)) then
            set dx = GetItemX(it) - GetUnitX(RuneMasterCaster)
            set dy = GetItemY(it) - GetUnitY(RuneMasterCaster)

            if GetRandomInt(1, 100) < (10 + LuckyTriggerBonusChance(RuneMasterCaster)) * luck then
                call UnitAddItem(RuneMasterCaster, CreateRandomRune(GetRunePower(it) - GetUnitCustomState(RuneMasterCaster, BONUS_RUNEPOW) - GetHeroLevel(RuneMasterCaster), GetUnitX(RuneMasterCaster), GetUnitY(RuneMasterCaster), RuneMasterCaster))
            endif

            if SquareRoot(dx * dx + dy * dy) < 500 then
                call UnitAddItem(RuneMasterCaster, it)
                set RuneMasterUsedCount = RuneMasterUsedCount + 1 // Increment rune usage
            endif
        endif

        set it = null
    endfunction

    function CastRuneMaster takes unit caster returns nothing
        set RuneMasterCaster = caster
        set RuneMasterUsedCount = 0 // Reset counter before casting
        call MoveRectTo(rectRune, GetUnitX(caster), GetUnitY(caster))
        call EnumItemsInRect(rectRune, null, function UseRunes)
    endfunction

    private function init takes nothing returns nothing
        set rectRune = Rect(-500, -500, 500, 500)
        set RuneMasteryCdReduction = HashTable.create()
    endfunction
endlibrary
