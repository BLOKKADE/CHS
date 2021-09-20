library AncientRunes requires RuneInit
    function CastAncientRunes takes unit caster returns nothing
        local integer i = 0
        local integer pid = GetPlayerId(GetOwningPlayer(caster))
        local integer runeIndex = PlayerRunes[pid].integer[0]
        local item it
        local real dx
        local real dy
        if runeIndex > 0 then
            loop
                set it = RunesIndex.item[PlayerRunes[pid][i]]
                if it != null and PlayerRunes[pid][i] != 0 then
                    set dx = GetItemX(it) - GetUnitX(caster)
                    set dy = GetItemY(it) - GetUnitY(caster)
                    if SquareRoot(dx * dx + dy * dy) < 500 then
                        call UnitAddItem(caster, it)
                        set RunesIndex.item[PlayerRunes[pid][i]] = null
                        set PlayerRunes[pid][i] = 0
                    endif
                endif
                set i = i + 1
                exitwhen i > runeIndex
            endloop
        endif

        set it = null
        set PlayerRunes[pid][0] = 0
    endfunction
endlibrary