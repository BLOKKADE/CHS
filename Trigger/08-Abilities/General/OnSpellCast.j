library OnSpellCast initializer init

    globals
        HashTable SpellCooldown
    endglobals

    function OnSpellCastActions takes nothing returns nothing
        local integer abilId = GetSpellAbilityId()
        local integer level = GetUnitAbilityLevel(GetTriggerUnit(), abilId)
        if not SpellCooldown[abilId].real.has(level) then
            set SpellCooldown[abilId].real[abilId] = BlzGetAbilityCooldown(abilId, level - 1)
        endif
    endfunction


    //===========================================================================
    private function init takes nothing returns nothing
        local trigger trg = CreateTrigger()
        set SpellCooldown = HashTable.create()
        call TriggerRegisterAnyUnitEventBJ( trg, EVENT_PLAYER_UNIT_SPELL_CAST)
        call TriggerAddAction( trg, function OnSpellCastActions)
        set trg = null
    endfunction
endlibrary