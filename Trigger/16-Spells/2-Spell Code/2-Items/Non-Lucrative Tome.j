library NonLucrativeTome requires Functions, RandomShit

    globals
        boolean array NonLucrativeTomeUsed
    endglobals

    function RemoveSpell takes integer pid, unit u, integer abilId returns nothing
        set udg_integers01[pid]=(udg_integers01[pid]- 1)
        if udg_integers05[pid] == abilId then
            set udg_integers05[pid] = GetLastLearnedSpell(GetHandleId(u), SpellList_Normal, false)
        endif
        call SaveCountHeroSpell(u ,LoadCountHeroSpell(u,0) - 1 ,0 ) 
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(abilId, GetUnitAbilityLevel(u, abilId) - 1))    
        call UnitRemoveAbilityBJ(abilId,u)
        call FunResetAbility (abilId,u)
    endfunction

    function NonLucrativeTomeBought takes unit u returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        if NonLucrativeTomeUsed[pid] == false then
            set NonLucrativeTomeUsed[pid] = true

            if GetUnitAbilityLevel(u, 'Asal') > 0 then
                call RemoveSpell(pid, u, 'Asal')
            endif

            if GetUnitAbilityLevel(u, 'A02W') > 0 then
                call RemoveSpell(pid, u, 'A02W')
            endif

            if GetUnitAbilityLevel(u, 'A04K') > 0 then
                call RemoveSpell(pid, u, 'A04K')
            endif

            if GetUnitAbilityLevel(u, 'A0A2') > 0 then
                call RemoveSpell(pid, u, 'A0A2')
            endif

            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
        endif
    endfunction
endlibrary