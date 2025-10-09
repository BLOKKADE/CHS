library RandomShit requires AbilityData, SpellbaneToken, StableSpells, IdLibrary, GetObjectElement
    globals
        integer Global_i = 0
        unit Global_u = null

        boolean EffectVisible = true
    endglobals

    function ElemFuncStart takes unit u, integer id returns nothing
        if ObjectHasAnyElement(id) then
            set GLOB_ELEM_U = u
            set GLOB_ELEM_I = id
            call ExecuteFunc("ElementStartAbilityS")
        endif
    endfunction 

    function SetUnitMaxHp takes unit u, integer amount returns nothing
        local real percent = GetUnitLifePercent(u)
        call BlzSetUnitMaxHP(u, amount)  
        call SetUnitLifePercentBJ(u, percent)
    endfunction
    
    function SetUnitMaxMana takes unit u, integer amount returns nothing
        local real percent = GetUnitManaPercent(u)
        call BlzSetUnitMaxMana(u, amount)  
        call SetUnitManaPercentBJ(u, percent)
    endfunction

    function SetUnitProcHp takes unit u, real bonus returns nothing
        local real BonusOldHp = LoadReal(HT,GetHandleId(u),- 412446)
        local real Hp = I2R(BlzGetUnitMaxHP(u))- BonusOldHp
        local real BonusNewHp = Hp * bonus
        call SetUnitMaxHp(u,R2I(Hp + BonusNewHp) )  
        call SaveReal(HT,GetHandleId(u),- 412446, I2R(R2I(BonusNewHp)))
    endfunction

    function RemoveHeroAbilities takes unit u returns nothing
        local integer i = 0
        local integer abilId = 0
        loop
            set abilId = GetHeroSpellAtPosition(u, i)
            if abilId != 0 then
                call UnitRemoveAbility(u, abilId)

                if HasDummySpell(u, abilId) then
                    call UnitRemoveAbility(u, GetDummySpell(u, abilId))
                endif
            endif
            set i = i + 1
            exitwhen i > 20
        endloop
    endfunction
endlibrary