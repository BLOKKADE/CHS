library NonLucrativeTome requires Functions, RandomShit

    globals
        boolean array NonLucrativeTomeUsed
    endglobals

    function RemoveSpell takes integer pid, unit u, integer abilId returns nothing
        set udg_integers01[pid + 1]= udg_integers01[pid + 1] - 1
        if udg_integers05[pid + 1] == abilId then
            set udg_integers05[pid + 1] = GetLastLearnedSpell(GetHandleId(u), SpellList_Normal, false)
        endif
        call SaveCountHeroSpell(u ,LoadCountHeroSpell(u,0) - 1 ,0 ) 
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(abilId, GetUnitAbilityLevel(u, abilId) - 1))    
        call UnitRemoveAbilityBJ(abilId,u)
        call FunResetAbility (abilId,u)
    endfunction

    function GetNextSpell takes unit u, integer i returns integer
        local integer id = 0

        loop
            set id = GetInfoHeroSpell(u, i)
            set i = i + 1
            exitwhen id != 0 or i > 10
        endloop
        return id
    endfunction

    function MoveSpellList takes unit u returns nothing
        local integer i = 0
        local integer id = 0

        loop
            set id = GetInfoHeroSpell(u ,i)
            if id == 0 then
                set id = GetNextSpell(u, i)
                if id != 0 then
                    call RemoveInfoHeroSpell(u, id)
                    call SetInfoHeroSpell(u, i, id)
                endif
            endif
            set i = i + 1
            exitwhen i > 10
        endloop
    endfunction

    function NonLucrativeTomeBought takes unit u returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local boolean removed = false
        if NonLucrativeTomeUsed[pid] == false then
            set NonLucrativeTomeUsed[pid] = true

            if GetUnitAbilityLevel(u, 'Asal') > 0 then
                call RemoveSpell(pid, u, 'Asal')
                set removed = true
            endif

            if GetUnitAbilityLevel(u, 'A02W') > 0 then
                call RemoveSpell(pid, u, 'A02W')
                set removed = true
            endif

            if GetUnitAbilityLevel(u, 'A04K') > 0 then
                call RemoveSpell(pid, u, 'A04K')
                set removed = true
            endif

            if GetUnitAbilityLevel(u, 'A0A2') > 0 then
                call RemoveSpell(pid, u, 'A0A2')
                set removed = true
            endif

            if removed then
                call MoveSpellList(u)
            endif

            call DestroyEffect(AddSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
        else
            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"The |cfff76863Non-Lucrative Tome|r can only be used once per game.")
            call SetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD) + 20000)
        endif
    endfunction
endlibrary