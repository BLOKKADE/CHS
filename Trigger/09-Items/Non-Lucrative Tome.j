library NonLucrativeTome requires Functions, RandomShit, SpellsLearned, DraftOnBuy

    globals
        boolean array NonLucrativeTomeUsed
    endglobals

    function RemoveSpell takes integer pid, unit u, integer abilId returns nothing
        set HeroAbilityCount[pid + 1]= HeroAbilityCount[pid + 1] - 1
        if PlayerLastLearnedSpell[pid + 1] == abilId then
            set PlayerLastLearnedSpell[pid + 1] = GetLastLearnedSpell(u, SpellList_Normal, false)
        endif
        call SetHeroSpellListCount(u ,GetHeroSpellListCount(u,0) - 1 ,0 ) 
        call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"|cffbbff00Removed |r" + BlzGetAbilityTooltip(abilId, GetUnitAbilityLevel(u, abilId) - 1))    
        call UnitRemoveAbilityBJ(abilId,u)
        call FunResetAbility (abilId,u)
    endfunction

    function GetNextSpell takes unit u, integer i returns integer
        local integer id = 0

        loop
            set id = GetHeroSpellAtPosition(u, i)
            set i = i + 1
            exitwhen id != 0 or i > 10
        endloop
        return id
    endfunction

    function MoveSpellList takes unit u returns nothing
        local integer i = 0
        local integer id = 0

        loop
            set id = GetHeroSpellAtPosition(u ,i)
            if id == 0 then
                set id = GetNextSpell(u, i)
                if id != 0 then
                    call ResetHeroSpellPosition(u, id)
                    call SetHeroSpellPosition(u, i, id)
                endif
            endif
            set i = i + 1
            exitwhen i > 10
        endloop
    endfunction

    function NonLucrativeTomeBought takes unit u returns nothing
        local integer pid = GetPlayerId(GetOwningPlayer(u))
        local integer count = 0
        if NonLucrativeTomeUsed[pid] == false then
            set NonLucrativeTomeUsed[pid] = true

            //call SpellsLearnedDebug("pre nl", u, 0)

            if GetUnitAbilityLevel(u, PILLAGE_ABILITY_ID) > 0 then
                call RemoveSpell(pid, u, PILLAGE_ABILITY_ID)
                if AbilityMode != 0 then
                    call RemoveItemFromUpgradeShop(pid, PILLAGE_ITEM_ID)
                endif
                set count = 1
            endif

            if GetUnitAbilityLevel(u, LEARNABILITY_ABILITY_ID) > 0 then
                call RemoveSpell(pid, u, LEARNABILITY_ABILITY_ID)
                if AbilityMode != 0 then
                    call RemoveItemFromUpgradeShop(pid, LEARNABILITY_ITEM_ID)
                endif
                set count = count + 1
            endif

            if GetUnitAbilityLevel(u, HOLY_ENLIGHTENMENT_ABILITY_ID) > 0 then
                call RemoveSpell(pid, u, HOLY_ENLIGHTENMENT_ABILITY_ID)
                if AbilityMode != 0 then
                    call RemoveItemFromUpgradeShop(pid, HOLY_ENLIGHTENMENT_ITEM_ID)
                endif
                set count = count + 1
            endif

            if GetUnitAbilityLevel(u, MIDAS_TOUCH_ABILITY_ID) > 0 then
                call RemoveSpell(pid, u, MIDAS_TOUCH_ABILITY_ID)
                if AbilityMode != 0 then
                    call RemoveItemFromUpgradeShop(pid, MIDAS_TOUCH_ITEM_ID)
                endif
                set count = count + 1
            endif

            if count > 0 then
                call MoveSpellList(u)
                call RefreshUpgradeShop(pid, u)
                
                if AbilityMode == 2 then
                    set udg_Draft_NOSpellsLearned[pid+1] = udg_Draft_NOSpellsLearned[pid+1] - count
                endif
            endif

            if AbilityMode == 2 then
                
                call GenerateDraftSpells(pid+1, udg_Draft_NODraftSpells) 
            endif

            //call SpellsLearnedDebug("post nl", u, 0)

            call DestroyEffect(AddLocalizedSpecialEffectTarget("Abilities\\Spells\\Items\\TomeOfRetraining\\TomeOfRetrainingCaster.mdl", u, "origin"))
        else
            call DisplayTimedTextToPlayer(GetOwningPlayer(u), 0, 0, 10,"The |cfff76863Non-Lucrative Tome|r can only be used once per game.")
            call SetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD, GetPlayerState(GetOwningPlayer(u), PLAYER_STATE_RESOURCE_GOLD) + 20000)
        endif
    endfunction
endlibrary