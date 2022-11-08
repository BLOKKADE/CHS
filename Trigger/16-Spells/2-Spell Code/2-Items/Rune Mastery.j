library RuneMaster initializer init requires RuneInit
    globals
        rect rectRune = null
        unit RuneMasterCaster
    endglobals

    private function UseRunes takes nothing returns nothing
        local item it = GetFilterItem()
        local real dx
        local real dy
        local real luck = GetUnitCustomState(RuneMasterCaster, BONUS_LUCK)

        //call BJDebugMsg("rune id: " + I2S(RuneIndex[GetHandleId(it)]))
        if GetItemType(it) == ITEM_TYPE_POWERUP and RuneIndex[GetHandleId(it)] == GetPlayerId(GetOwningPlayer(RuneMasterCaster)) then
            set dx = GetItemX(it) - GetUnitX(RuneMasterCaster)
            set dy = GetItemY(it) - GetUnitY(RuneMasterCaster)

            if GetRandomInt(1, 100) < 10 * luck then
                call UnitAddItem(RuneMasterCaster, CreateRandomRune(GetRunePower(it) - GetUnitCustomState(RuneMasterCaster, BONUS_RUNEPOW) - GetHeroLevel(RuneMasterCaster), GetUnitX(RuneMasterCaster), GetUnitY(RuneMasterCaster), RuneMasterCaster))
            endif
            //call BJDebugMsg("rune")
            if SquareRoot(dx * dx + dy * dy) < 500 then
                //call BJDebugMsg("use")
                call UnitAddItem(RuneMasterCaster, it)
            endif
        endif

        set it = null
    endfunction

    function CastRuneMaster takes unit caster returns nothing
        //call BJDebugMsg("rune master 1")
        set RuneMasterCaster = caster
        call MoveRectTo(rectRune, GetUnitX(caster), GetUnitY(caster))
        //call CreateUnit(Player(0), 'hfoo', GetRectMaxX(rectRune), GetRectMaxY(rectRune), 0)
        //call CreateUnit(Player(0), 'hfoo', GetRectMaxX(rectRune), GetRectMinY(rectRune), 0)
        //call CreateUnit(Player(0), 'hfoo', GetRectMinX(rectRune), GetRectMaxY(rectRune), 0)
        //call CreateUnit(Player(0), 'hfoo', GetRectMinX(rectRune), GetRectMinY(rectRune), 0)
        call EnumItemsInRect(rectRune, null, function UseRunes)
        //call BJDebugMsg("rune master 2")
    endfunction

    private function init takes nothing returns nothing
        set rectRune = Rect(-500, -500, 500, 500)
    endfunction
endlibrary