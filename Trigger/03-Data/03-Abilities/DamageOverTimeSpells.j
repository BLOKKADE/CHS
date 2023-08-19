library DotSpells initializer init
    globals
        Table DotSpells
    endglobals

    function IsSpellDot takes integer abilId returns boolean
        return DotSpells.boolean[abilId]
    endfunction

    private function init takes nothing returns nothing
        set DotSpells = Table.create()
        
        set DotSpells.boolean[UNHOLY_FRENZY_ABILITY_ID] = true // checked duration normal/hero equal
        set DotSpells.boolean[ENTAGLING_ROOTS_ABILITY_ID] = true // checked duration normal longer
        set DotSpells.boolean[FLAME_STRIKE_ABILITY_ID] = true // checked duration normal longer
        set DotSpells.boolean[ACID_BOMB_ABILITY_ID] = true // checked duration normal/hero equal
        set DotSpells.boolean[SHADOW_STRIKE_ABILITY_ID] = true // checked duration normal/hero equal
        set DotSpells.boolean[ICY_BREATH_ABILITY_ID] = true // checked duration normal/hero equal
        set DotSpells.boolean[SOUL_BURN_ABILITY_ID] = true // checked duration normal longer

        // RESULT = DURATION NORMAL DUMMY DURATION
    endfunction
endlibrary