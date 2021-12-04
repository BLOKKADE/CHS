library SpiritTauren initializer init requires Stats

    globals
        Table TaurenActiveShopSpells
        integer TaurenSpellIndex = 0
        integer RuneBonus = 30
    endglobals

    function SpiritTaurenAbilityLevelBonus takes unit UnitHero returns nothing
        local integer AbilLvl
        local integer AbilId
        local integer i = 0

        loop
            set AbilLvl = GetUnitAbilityLevel(UnitHero, TaurenActiveShopSpells[i])
            if AbilLvl > 0 and AbilLvl < 40 then
                call SetUnitAbilityLevel(UnitHero, TaurenActiveShopSpells[i], AbilLvl + 1) 
            endif
            set i = i +1
            exitwhen i > TaurenSpellIndex
        endloop
    endfunction

    function SpiritTaurenRuneBonusReset takes unit u, integer abilId returns nothing
        if TaurenActiveShopSpells.boolean[abilId] then
            call AddUnitPowerRune(u,0 - RuneBonus)
        endif
    endfunction

    function SpiritTaurenRuneBonus takes unit u, integer abilId returns nothing
        if TaurenActiveShopSpells.boolean[abilId] then
            call AddUnitPowerRune(u, RuneBonus)
        endif
    endfunction

    private function SetTaurenSpells takes integer abilId returns nothing
        set TaurenActiveShopSpells[TaurenSpellIndex] = abilId
        set TaurenSpellIndex = TaurenSpellIndex  + 1
        set TaurenActiveShopSpells.boolean[abilId] = true
    endfunction

    private function init takes nothing returns nothing
        set TaurenActiveShopSpells = Table.create()
        call SetTaurenSpells('A0B7')
        call SetTaurenSpells('Auhf')
        call SetTaurenSpells('AOsh')
        call SetTaurenSpells('AEer')
        call SetTaurenSpells('ANdr')
        call SetTaurenSpells('AEim')
        call SetTaurenSpells('AHtb')
        call SetTaurenSpells('A0AT')
        call SetTaurenSpells('ACls')
        call SetTaurenSpells('A017')
        call SetTaurenSpells('A09X')
        call SetTaurenSpells('AOmi')
    endfunction
endlibrary