library WisdomChestplate initializer init requires BuffSystem, CustomState
    globals
        Table WisdomChestplateTable
    endglobals

    function GetCustomStateBonus takes integer id returns CustomStateBonus
        return WisdomChestplateTable[id]
    endfunction

    function ActivateWisdomChestplate takes unit target, real damage returns nothing
        local integer handleId = GetHandleId(target)
        local real bonus = damage*0.2
        call SetBuff(target, 9, 5)
        if GetCustomStateBonus(handleId) == 0 or GetCustomStateBonus(handleId).stop then
            set WisdomChestplateTable[handleId] = CustomStateBonus.create(target, CustomState_Block, damage*0.2, 5)
        else
            if GetCustomStateBonus(handleId).bonus < bonus then
                set GetCustomStateBonus(handleId).stop = true
                set WisdomChestplateTable[handleId] = CustomStateBonus.create(target, CustomState_Block, damage*0.2, 5)
            elseif RAbsBJ(GetCustomStateBonus(handleId).bonus - bonus) < bonus * 0.3 then
                set GetCustomStateBonus(handleId).endTick = T32_Tick + (5*32)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set WisdomChestplateTable = Table.create()
    endfunction
endlibrary