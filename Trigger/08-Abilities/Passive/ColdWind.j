library ColdWind initializer init requires HideEffects, AreaDamage, AbilityCooldown, SpellFormula, Table
    globals
        Table ColdwindDamageBonus
        Table ColdWindDamageIncreased
    endglobals

    function CastColdWind takes unit source, integer abilLvl returns nothing
        local integer hid = GetHandleId(source)

        if not ColdWindDamageIncreased.boolean[hid] then
            set ColdwindDamageBonus[hid] = 0
        else
            call DestroyEffect(AddLocalizedSpecialEffectTarget("war3mapImported\\Ice Shard.mdx", source, "origin"))
        endif

        call AreaDamage(source, GetUnitX(source), GetUnitY(source), GetSpellValue(80, 14, abilLvl) * (1 + ColdwindDamageBonus[GetHandleId(source)]), 500, false, COLD_WIND_ABILITY_ID, false)
        call AbilStartCD(source, COLD_WIND_ABILITY_ID, 1)
        set ColdWindDamageIncreased.boolean[hid] = false
    endfunction

    private function init takes nothing returns nothing
        set ColdwindDamageBonus = Table.create()
        set ColdWindDamageIncreased = Table.create()
    endfunction
endlibrary