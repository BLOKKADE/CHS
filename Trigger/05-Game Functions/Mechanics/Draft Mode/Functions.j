library DraftModeFunctions requires TimerUtils, DisableSpells
    /*
    Generates NOSpells in PlayerNumber's Draft store. 
    It chooses a random index, say X, among the remaining spells for that particular player and adds that to the store.
    The function then overwrites the spell at index X with the last spell and decreases the upper bound on the rng. 
    */

    globals
        integer OffsetX = 200
        integer OffsetY = 500
        HashTable DisplayedSpells
        unit circle1 = null
        unit circle2 = null
        unit draftBuilding1 = null
        unit draftBuilding2 = null
        boolean DraftInitialised = false
        texttag FloatingTextBuy = null
        texttag FloatingTextUpgrade = null
    endglobals

    function RemoveDraftSpells takes integer playerNumber, integer NOSpells returns nothing
        local integer i = 0
        loop    
            if DisplayedSpells[playerNumber].integer[i] != 0 then
                call RemoveItemFromStock(udg_Draft_DraftBuildings[playerNumber], DisplayedSpells[playerNumber].integer[i])
            endif
            set i = i + 1
            exitwhen i == NOSpells
        endloop

        call RemoveItemFromStock(udg_Draft_DraftBuildings[playerNumber], NON_LUCRATIVE_TOME_ITEM_ID)
    endfunction

    function AddDraftSpellToStore takes integer PlayerNumber, integer ChosenSpell, integer i returns nothing
        call AddItemToStock(udg_Draft_DraftBuildings[PlayerNumber], LoadIntegerBJ(PlayerNumber, ChosenSpell, udg_Draft_PlayerSpells), 1, 1)    
        set DisplayedSpells[PlayerNumber].integer[i] = LoadIntegerBJ(PlayerNumber, ChosenSpell, udg_Draft_PlayerSpells)
        call SaveIntegerBJ(LoadIntegerBJ(PlayerNumber, udg_Draft_PlayerSpellsMaxIndex[PlayerNumber], udg_Draft_PlayerSpells), PlayerNumber, ChosenSpell, udg_Draft_PlayerSpells) // 
        set udg_Draft_PlayerSpellsMaxIndex[PlayerNumber] = udg_Draft_PlayerSpellsMaxIndex[PlayerNumber] - 1
    endfunction

    private struct DraftTimerData
        integer spellAmount
        integer playerNumber
    endstruct

    function GenerateDraftTimer takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local DraftTimerData timerData = GetTimerData(t)
        local integer ChosenSpell = 0 
        local integer i = 0
        
        // call DisplayTextToForce(GetPlayersAll(), ("Player Id: " + I2S(PlayerNumber) ) )
        loop
            exitwhen i >= timerData.spellAmount
            set ChosenSpell = GetRandomInt(1, udg_Draft_PlayerSpellsMaxIndex[timerData.playerNumber] - udg_Draft_NOSpellsLearned[timerData.playerNumber])        
            call AddDraftSpellToStore(timerData.playerNumber, ChosenSpell, i)
            set i = i + 1
            // call DisplayTextToForce(GetPlayersAll(), ("loop: " + I2S(i) ) )
        endloop

        if not NonLucrativeTomeUsed[timerData.playerNumber] then
            call AddItemToStock(udg_Draft_DraftBuildings[timerData.playerNumber], NON_LUCRATIVE_TOME_ITEM_ID, 1, 1)
        endif

        call timerData.destroy()
        call ReleaseTimer(t)
        set t = null
    endfunction

    function GenerateDraftSpells takes integer PlayerNumber, integer NOSpells returns nothing
        local timer t = NewTimer()
        local DraftTimerData timerData = DraftTimerData.create()
        set timerData.spellAmount = NOSpells
        set timerData.playerNumber = PlayerNumber 
        call SetTimerData(t, timerData)
        call TimerStart(t, 1, false, function GenerateDraftTimer)
        call RemoveDraftSpells(PlayerNumber, NOSpells)
        set t = null
    endfunction

    /*
    Guarantees that Pillage, Transmute, Holy Enlightenment and Learnability are added to the first draft
    */
    function GenerateInitialDraftSpells takes integer PlayerNumber, integer NOSpells returns nothing
        if (NOSpells - 4 > 0 ) then
            call GenerateDraftSpells(PlayerNumber, NOSpells - 4) // Generate Draft Spells uses indices i : 0 =< i < 2nd argument
        endif
        call AddDraftSpellToStore(PlayerNumber, EconomicSpellIndex.integer[1], NOSpells - 4) // Learnability
        call AddDraftSpellToStore(PlayerNumber, EconomicSpellIndex.integer[2], NOSpells - 3) // Transmute
        call AddDraftSpellToStore(PlayerNumber, EconomicSpellIndex.integer[3], NOSpells - 2) // Pillage
        call AddDraftSpellToStore(PlayerNumber, EconomicSpellIndex.integer[4], NOSpells - 1) // Holy Enlightenment
    endfunction

    function CreateDraftBuildingsLoop takes nothing returns nothing
        local integer pid = GetPlayerId(GetEnumPlayer())
        set udg_Draft_DraftBuildings[pid] = CreateUnit(GetEnumPlayer(), DRAFT_BUY_UNIT_ID, 0 - OffsetX, OffsetY, 0)
        set udg_Draft_UpgradeBuildings[pid] = CreateUnit(GetEnumPlayer(), DRAFT_UPGRADE_UNIT_ID, OffsetX, OffsetY, 0)

        call AddItemToStock(udg_Draft_DraftBuildings[pid], NON_LUCRATIVE_TOME_ITEM_ID, 1, 1)

        if IncomeMode == 3 then
            call GenerateDraftSpells(pid, udg_Draft_NODraftSpells)
        else
            call GenerateInitialDraftSpells(pid, udg_Draft_NODraftSpells)
        endif

        call DisableEconomicSpells(pid)
    endfunction

    function ShopText takes integer x, integer y, string text, integer r, integer g, integer b returns texttag
        local texttag floatingtext = CreateTextTag()
        call SetTextTagText(floatingtext, text, 0.023)
        call SetTextTagPos(floatingtext, x, y, 100.0)
        call SetTextTagColor(floatingtext, r, g, b, 255)
        call SetTextTagPermanent(floatingtext, true)
        return floatingtext
    endfunction

    function SetBuildingVisibleForPlayer takes player p, unit u, integer skin returns nothing
        if p == GetLocalPlayer() then
            call BlzSetUnitSkin(u, skin)
        endif
    endfunction

    private function SetBuildingVisibleForOwningPlayers takes nothing returns nothing
        local integer pid = GetPlayerId(GetEnumPlayer())

        call SetBuildingVisibleForPlayer(GetEnumPlayer(), udg_Draft_DraftBuildings[pid], 'nbsm')
        call SetBuildingVisibleForPlayer(GetEnumPlayer(), udg_Draft_UpgradeBuildings[pid], 'nbsm')
    endfunction

    function CreateDraftBuildings takes nothing returns nothing
        if DraftInitialised == false then
            set DraftInitialised = true
            set circle1 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n038', 0 - OffsetX, OffsetY, 0)
            set FloatingTextBuy = ShopText(0 - OffsetX, OffsetY, "Buy abilities", 255, 100, 0)
            set circle2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n037', OffsetX, OffsetY, 0)
            set FloatingTextUpgrade = ShopText(OffsetX, OffsetY, "Upgrade abilities", 0, 255, 100)
            set draftBuilding1 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'h00I', 0 - OffsetX, OffsetY, 0)
            set draftBuilding2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'h00I', OffsetX, OffsetY, 0)
            call ForForce(PlayersWithHero, function CreateDraftBuildingsLoop)
            call ForForce(PlayersWithHero, function SetBuildingVisibleForOwningPlayers)
        endif
    endfunction

    // Takes id for ability Draft Mode Rules
    function SetDraftModeRules takes integer DraftRules returns nothing
        call BlzSetAbilityExtendedTooltip(DraftRules, "You get to choose between " + I2S(udg_Draft_NODraftSpells) + " spells each time.|nDraft spells refresh each time you buy one.|nEach spell only shows up once per game per player.", 0)
    endfunction
    
endlibrary