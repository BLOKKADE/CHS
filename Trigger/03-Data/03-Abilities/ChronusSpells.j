library ChronusSpells initializer init
    globals
        Table ChronusSpells
    endglobals

    function IsTimeManipCdIncreasedByChronusSpell takes integer abilId returns boolean
        return ChronusSpells[abilId].boolean[1]
    endfunction

    function IsSpellChronus takes integer abilId returns boolean
        return ChronusSpells.boolean[abilId]
    endfunction

    private function SetupChronusSpell takes integer abilId, boolean timemanip returns nothing
        set ChronusSpells[abilId].boolean[0] = true
        set ChronusSpells[abilId].boolean[1] = timemanip
    endfunction

    private function init takes nothing returns nothing
        set ChronusSpells = HashTable.create()

        call SetupChronusSpell(HERO_BUFF_ABILITY_ID, true)
        call SetupChronusSpell(TEMPORARY_INVISIBILITY_ABILITY_ID, true)
        call SetupChronusSpell(TEMPORARY_POWER_ABILITY_ID, true)
        call SetupChronusSpell(CHEATER_MAGIC_ABILITY_ID, true)
        call SetupChronusSpell(BLESSED_PROTECTIO_ABILITY_ID, true)
        call SetupChronusSpell(FEARLESS_DEFENDERS_ABILITY_ID, true)
        call SetupChronusSpell(RAPID_RECOVERY_ABILITY_ID, true)
        call SetupChronusSpell(HOLY_ENLIGHTENMENT_ABILITY_ID, true)
    endfunction
endlibrary