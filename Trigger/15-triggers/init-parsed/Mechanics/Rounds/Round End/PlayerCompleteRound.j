library PlayerCompleteRound initializer init requires RandomShit, CustomGameEvent

    // --- Helpers -------------------------------------------------------------

    // Convert XP thresholds into stat bonuses via manuscript items.
    // Handles multiple thresholds sequentially without forcing unwanted level-ups.
    function ProcessManuscriptThresholds takes unit u returns nothing
        local player owner = GetOwningPlayer(u)
        local integer xp
        local boolean processed

        loop
            set xp = GetHeroXP(u)
            exitwhen xp < 20000

            set processed = false

            // Agility level bonus
            if UnitHasItemType(u, AGILITY_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(u) != STOMP_TREE_UNIT_ID and not UnitHasItemType(u, STRENGTH_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(u, INTELLIGENCE_MANUSCRIPT_ITEM_ID) then
                call AddStatLevelBonus(u, BONUS_AGILITY, 1)
                call UnitAddItemById(u, EXPERIENCE_20000_TOME_ITEM_ID)
                call DisplayTextToPlayer(owner, 0, 0, "|cffffffffYour agility per level has been increased by 1!|r")
                // subtract 20,000 XP to prevent leveling
                call SetHeroXP(u, xp - 20000, false)
                set processed = true
            endif

            // Strength level bonus
            if not processed and UnitHasItemType(u, STRENGTH_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(u) != STOMP_TREE_UNIT_ID and not UnitHasItemType(u, AGILITY_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(u, INTELLIGENCE_MANUSCRIPT_ITEM_ID) then
                call AddStatLevelBonus(u, BONUS_STRENGTH, 1)
                call UnitAddItemById(u, EXPERIENCE_20000_TOME_ITEM_ID)
                call DisplayTextToPlayer(owner, 0, 0, "|cffffffffYour strength per level has been increased by 1!|r")
                call SetHeroXP(u, xp - 20000, false)
                set processed = true
            endif

            // Intelligence level bonus
            if not processed and UnitHasItemType(u, INTELLIGENCE_MANUSCRIPT_ITEM_ID) and GetUnitTypeId(u) != STOMP_TREE_UNIT_ID and not UnitHasItemType(u, STRENGTH_MANUSCRIPT_ITEM_ID) and not UnitHasItemType(u, AGILITY_MANUSCRIPT_ITEM_ID) then
                call AddStatLevelBonus(u, BONUS_INTELLIGENCE, 1)
                call UnitAddItemById(u, EXPERIENCE_20000_TOME_ITEM_ID)
                call DisplayTextToPlayer(owner, 0, 0, "|cffffffffYour intelligence per level has been increased by 1!|r")
                call SetHeroXP(u, xp - 20000, false)
                set processed = true
            endif

            // If nothing matched (no valid manuscript or conflicting items), stop.
            if not processed then
                exitwhen true
            endif
        endloop

        set owner = null
    endfunction

    // Add XP in chunks of up to 20,000 and process manuscript thresholds after each chunk.
    function AddHeroXPChunked takes unit u, integer totalXP returns nothing
        local integer remaining = totalXP
        local integer chunk

        loop
            exitwhen remaining <= 0

            set chunk = IMinBJ(remaining, 20000)
            call AddHeroXPSwapped(chunk, u, true)
            set remaining = remaining - chunk

            // Immediately convert if threshold(s) reached
            call ProcessManuscriptThresholds(u)
        endloop
    endfunction

    // --- Original round-end flow -------------------------------------------

    function EndroundForCreeps takes EventInfo eventInfo returns nothing
        if not eventInfo.isPvp then
            //destroy round creep groups to prevent leaks
            call ReleaseGroup(PlayerRoundCreeps[eventInfo.roundNumber].group[GetPlayerId(eventInfo.p)])
            set PlayerRoundCreeps[eventInfo.roundNumber].group[GetPlayerId(eventInfo.p)] = null
        endif
    endfunction

    private function CreepFilter takes nothing returns boolean
        return (UnitAlive(GetFilterUnit()) == true) and (GetOwningPlayer(GetFilterUnit()) == Player(11))
    endfunction

    private function PlayerCompleteRoundConditions takes nothing returns boolean
        local unit killingUnit = GetKillingUnit()
        local group playerArenaCreeps
        local boolean isValid
        local player currentPlayer

        if ((killingUnit == null) or (GetOwningPlayer(GetTriggerUnit()) != Player(11)) or (GetOwningPlayer(killingUnit) == Player(11))) then
            // Cleanup
            set killingUnit = null
            return false
        endif

        set playerArenaCreeps = GetUnitsInRectMatching(PlayerArenaRects[GetPlayerId(GetOwningPlayer(GetKillingUnit()))], Condition(function CreepFilter))
        set currentPlayer = GetOwningPlayer(killingUnit)
        set isValid = (CountUnitsInGroup(playerArenaCreeps) == 0) and (IsPlayerInForce(currentPlayer, DefeatedPlayers) != true) and (IsPlayerInForce(currentPlayer, RoundPlayersCompleted) != true)
        
        // Cleanup
        call DestroyGroup(playerArenaCreeps)
        set killingUnit = null
        set currentPlayer = null

        return isValid
    endfunction

    private function PlayerCompleteRoundActions takes nothing returns nothing
        local player p = GetOwningPlayer(GetKillingUnit())
        local integer pid = GetPlayerId(p)
        local real duration = (T32_Tick - RoundStartTick) / 32
        local real playerCountSub = RMaxBJ(7 - (duration * (7.0 / 17.0)), 0)
        local integer roundClearXpBonus = R2I(playerCountSub * (4 * Pow(RoundNumber, 2)))
        local string color = "|cff7bff00"

        if GameModeShort == true then
            set roundClearXpBonus = roundClearXpBonus * 3
        endif

        if (GetUnitTypeId(PlayerHeroes[pid]) == TINKER_UNIT_ID) then
            set roundClearXpBonus = roundClearXpBonus * 2
        endif

        if CreepAntagonisationReward[pid] then
            set roundClearXpBonus = roundClearXpBonus * 2
            set color = "|cff00b7ff"
            set CreepAntagonisationReward[pid] = false
        endif

        if (RoundNumber == 5) then
            set udg_boolean09 = false
        endif

        set BettingPlayerCount = PlayerCount / 2
        if (BettingPlayerCount > 3) then
            set BettingPlayerCount = 3
        endif

        call ForceAddPlayer(RoundPlayersCompleted, p)
        call SetCurrentlyFighting(p, false)
        call CustomGameEvent_FireEvent(EVENT_PLAYER_ROUND_COMPLETE, EventInfo.create(p, 0, RoundNumber))
        set RoundFinishedCount = RoundFinishedCount + 1
        call SetUnitInvulnerable(PlayerHeroes[pid], true)
        set ShowCreepAbilButton[pid] = false

        if (PlayerDiedInRound[pid]) then
            set PlayerDiedInRound[pid] = false
            if ModeNoDeath then
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffff7300has died!|r")
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffff7300has died and lost a life!|r |cffbe5ffd" + I2S(Lives[pid]) + " remaining.|r")
            endif
        else
            if (roundClearXpBonus == 0) then
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00has survived the level!|r")
            else
                call DisplayTimedTextToForce(GetPlayersAll(), 5.00, GetPlayerNameColour(p) + " |cffffcc00has survived the level!|r " + color + "(+" + I2S(roundClearXpBonus) + " exp)|r")
                // CHANGED: give XP in chunks and convert 20,000 XP thresholds instantly
                call AddHeroXPChunked(PlayerHeroes[pid], roundClearXpBonus)
            endif
        endif

        call CreateNUnitsAtLoc(1, PRIEST_1_UNIT_ID, p, RectMidArenaCenter, bj_UNIT_FACING)
        call UnitApplyTimedLifeBJ(2.00, 'BTLF', GetLastCreatedUnit())
        call GroupAddUnit(GroupEmptyArenaCheck, GetLastCreatedUnit())

        // Cleanup
        set p = null
    endfunction

    private function init takes nothing returns nothing
        set PlayerCompleteRoundTrigger = CreateTrigger()
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.EndroundForCreeps)
        call TriggerRegisterAnyUnitEventBJ(PlayerCompleteRoundTrigger, EVENT_PLAYER_UNIT_DEATH)
        call TriggerAddCondition(PlayerCompleteRoundTrigger, Condition(function PlayerCompleteRoundConditions))
        call TriggerAddAction(PlayerCompleteRoundTrigger, function PlayerCompleteRoundActions)
    endfunction

endlibrary
