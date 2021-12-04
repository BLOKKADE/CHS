library Stats initializer init requires EditAbilityInfo
    globals
        private abilityintegerlevelfield array StatField

        integer Stat_Str = 0
        integer Stat_Agi = 1
        integer Stat_Int = 2
    endglobals

    function GetUnitStatAbility takes unit u returns ability
        if GetUnitAbilityLevel(u, 'A0B4') == 0 then
            call UnitAddAbility(u, 'A0B4')
        endif

        return BlzGetUnitAbility(u, 'A0B4')
    endfunction

    function UnitGetStat takes unit u, integer stat returns integer
        return BlzGetAbilityIntegerLevelField(GetUnitStatAbility(u), StatField[stat], 0)
    endfunction

    function UnitSetStat takes unit u, integer stat, integer bonus returns nothing
        call SetAbilityIntegerField(u, 'A0B4', 1, StatField[stat], bonus)
    endfunction
    
    function UnitAddStat takes unit u, integer stat, integer bonus returns nothing
        call SetAbilityIntegerField(u, 'A0B4', 1, StatField[stat], UnitGetStat(u, stat) + bonus)
    endfunction

    private function init takes nothing returns nothing
        set StatField[Stat_Str] = ABILITY_ILF_STRENGTH_BONUS_ISTR
        set StatField[Stat_Agi] = ABILITY_ILF_AGILITY_BONUS
        set StatField[Stat_Int] = ABILITY_ILF_INTELLIGENCE_BONUS
    endfunction
endlibrary