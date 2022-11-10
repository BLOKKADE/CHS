library WisdomChestplate initializer init requires TempAbilSystem, CustomState, RandomShit
    globals
        Table WisdomChestplateTable
    endglobals

    function GetCustomStateBonus takes integer id returns TempBonus
        return WisdomChestplateTable[id]
    endfunction

    function ActivateWisdomChestplate takes unit target, real damage returns nothing
        local integer handleId = GetHandleId(target)
        //local item it
        local real bonus = damage * 0.4
        call TempAbil.create(target, 'A09S', 5)
        if GetCustomStateBonus(handleId) == 0 or GetCustomStateBonus(handleId).enabled == false then
            //set it = GetItemOfTypeFromUnitBJ(target, WISDOM_CHESTPLATE_ITEM_ID)
            set WisdomChestplateTable[handleId] = TempBonus.create(target, BONUS_BLOCK, damage * 0.4, 5, WISDOM_CHESTPLATE_ITEM_ID).activate()
            call DestroyEffect(AddLocalizedSpecialEffect("war3mapImported\\Flicker.mdx", GetUnitX(target), GetUnitY(target)))
            //call BlzSetItemExtendedTooltip(it, ReplaceText("000", I2S(R2I(bonus)), BlzGetItemExtendedTooltip(it)))
        else
            if GetCustomStateBonus(handleId).bonus < bonus then
                set GetCustomStateBonus(handleId).enabled = false
                //set it = GetItemOfTypeFromUnitBJ(target, WISDOM_CHESTPLATE_ITEM_ID)
                set WisdomChestplateTable[handleId] = TempBonus.create(target, BONUS_BLOCK, damage * 0.4, 5, WISDOM_CHESTPLATE_ITEM_ID).activate()
                call DestroyEffect(AddLocalizedSpecialEffect("war3mapImported\\Flicker.mdx", GetUnitX(target), GetUnitY(target)))
                //call BlzSetItemExtendedTooltip(it, ReplaceText("000", I2S(R2I(bonus)), BlzGetItemExtendedTooltip(it)))
            elseif RAbsBJ(GetCustomStateBonus(handleId).bonus - bonus) < bonus * 0.3 then
                set GetCustomStateBonus(handleId).endTick = T32_Tick + (5 * 32)
            endif
        endif
    endfunction

    private function init takes nothing returns nothing
        set WisdomChestplateTable = Table.create()
    endfunction
endlibrary