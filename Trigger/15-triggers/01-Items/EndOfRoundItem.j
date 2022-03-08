library EndOfRoundItem

    function CheckEndOfRoundItem takes item it returns boolean
        return RoundNumber != GetItemUserData(it) 
    endfunction

    function GetValidEndOfRoundItems takes unit u, integer itemId returns integer
        local integer i = 0
        local integer count = 0
        local item it

        loop
            set it = UnitItemInSlot(u, i)
            if it != null then 
                if GetItemTypeId(it) == itemId then
                    if CheckEndOfRoundItem(it) then
                        set count = count + 1
                    endif
                endif
            endif
            set i = i + 1
            exitwhen i > 5
        endloop

        set it = null
        return count
    endfunction

    function RegisterEndOfRoundItem takes integer pid, item it returns nothing
        if it != null then
            if CurrentlyFighting[pid] or RectContainsUnit(udg_rect09, PlayerHeroes[pid + 1]) == false then
                call DisplayTimedTextToPlayer(Player(pid), 0, 0, 5, "Your |cff68eef3" + GetItemName(it) + "|r will start working |cff6cff40next round|r.")
                call SetItemUserData(it, RoundNumber)
            else
                call SetItemUserData(it, 0)
            endif
        endif
    endfunction
endlibrary