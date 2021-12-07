library SpiritTauren requires Stats, IdLibrary

    globals
        integer RuneBonus = 30
    endglobals

    function SpiritTaurenAbilityLevelBonus takes unit UnitHero returns nothing
        local integer AbilLvl
        local integer AbilId
        local integer i = TAUREN_ABILITIES.first()
        local integer maxIndex = TAUREN_ABILITIES.last()

        loop
            set AbilLvl = GetUnitAbilityLevel(UnitHero, TAUREN_ABILITIES.get(i))
            if AbilLvl > 0 and AbilLvl < 40 then
                call SetUnitAbilityLevel(UnitHero, TAUREN_ABILITIES.get(i), AbilLvl + 1) 
            endif
            set i = i + 1
            exitwhen i > maxIndex
        endloop
    endfunction

    function SpiritTaurenRuneBonusReset takes unit u, integer abilId returns nothing
        if TAUREN_ABILITIES.contains(abilId) then
            call AddUnitPowerRune(u,0 - RuneBonus)
        endif
    endfunction

    function SpiritTaurenRuneBonus takes unit u, integer abilId returns nothing
        if TAUREN_ABILITIES.contains(abilId) then
            call AddUnitPowerRune(u, RuneBonus)
        endif
    endfunction

endlibrary