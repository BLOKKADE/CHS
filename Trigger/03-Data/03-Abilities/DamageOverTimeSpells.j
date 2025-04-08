library DotSpells initializer init requires Table
    //============================================================================
    globals
        Table DotSpells
        Table DotSpellField

        private constant integer DURATION_RLF_ID = 'adur'
    endglobals

    function IsSpellDot takes integer abilId returns boolean
        return DotSpells.boolean[abilId]
    endfunction

    function GetDotSpellField takes integer abilId returns abilityreallevelfield
        return ConvertAbilityRealLevelField(DotSpellField.integer[abilId]) 
    endfunction

    private function SetupDotSpell takes integer abilID, integer fieldId returns nothing
        set DotSpells.boolean[abilID] = true
        set DotSpellField.integer[abilID] = fieldId
    endfunction

    private function init takes nothing returns nothing
        set DotSpells = Table.create()
        set DotSpellField = Table.create()
        
        call SetupDotSpell(FLAME_STRIKE_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(ACID_BOMB_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(SOUL_BURN_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(UNHOLY_FRENZY_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(ENTAGLING_ROOTS_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(SHADOW_STRIKE_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(ICY_BREATH_ABILITY_ID, DURATION_RLF_ID)
        call SetupDotSpell(STAMPEDE_ABILITY_ID, DURATION_RLF_ID)
    endfunction
endlibrary