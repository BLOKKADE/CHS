library TerrestrialGlaive initializer init requires Table, AbilityData, StableSpells, FilteredSpellList, CastSpellOnTarget, AbilityCooldown
    globals
        Table TerrestrialGlaiveCooldown
        Table TerrestrialGlaiveSpellCast
    endglobals

    function TerrestrialGlaiveFilter takes unit u, integer abilId returns boolean
        return IsAbilityCasteable(abilId, false) and IsSpellResettable(abilId)
    endfunction

    function CastTerrestrialGlaive takes unit caster, unit target returns nothing
        local integer i = 0
        local integer hid = GetHandleId(caster)
        local IntegerList spellList = GetFilterList(hid, TERRESTRIAL_GLAIVE_ABILITY_ID)
        local integer random = GetRandomInt(0, spellList.size() - 1)
        local IntegerListItem node = spellList.first
        local integer abilId = 0
        local DummyOrder dummy
        local integer level = 0
        local AbilityModifiers abilMods = 0

        loop
            set abilId = node.data
            exitwhen i == random
            set node = node.next
            set i = i + 1
        endloop

        set level = GetUnitAbilityLevel(caster, abilId)
        set dummy = CastSpellAuto(caster, target, abilId, level, GetUnitX(target), GetUnitY(target), 600)

        call dummy.activate()
        call AbilStartCD(caster, TERRESTRIAL_GLAIVE_ABILITY_ID, BlzGetAbilityCooldown(abilId, level - 1))
    endfunction

    private function init takes nothing returns nothing
        set TerrestrialGlaiveCooldown = Table.create()
        set TerrestrialGlaiveSpellCast = Table.create()
    endfunction
endlibrary