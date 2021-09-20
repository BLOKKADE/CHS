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
    boolean DraftInitialised = false
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
endfunction

function GenerateDraftSpells takes integer PlayerNumber, integer NOSpells returns nothing
    local integer chosenSpell = 0 
    local integer i = 0
    call RemoveDraftSpells(PlayerNumber, NOSpells)
    // call DisplayTextToForce( GetPlayersAll(), ( "Player Id: " + I2S(PlayerNumber) ) )
    loop
        exitwhen i == NOSpells
        set chosenSpell = GetRandomInt(0, udg_Draft_PlayerSpellsMaxIndex[PlayerNumber] - udg_Draft_NOSpellsLearned[PlayerNumber])        
        call AddItemToStock( udg_Draft_DraftBuildings[PlayerNumber], LoadIntegerBJ(PlayerNumber, chosenSpell, udg_Draft_PlayerSpells), 1, 1)    
        set DisplayedSpells[PlayerNumber].integer[i] = LoadIntegerBJ(PlayerNumber, chosenSpell, udg_Draft_PlayerSpells)
        call SaveIntegerBJ( LoadIntegerBJ(PlayerNumber, udg_Draft_PlayerSpellsMaxIndex[PlayerNumber], udg_Draft_PlayerSpells), PlayerNumber, chosenSpell, udg_Draft_PlayerSpells) // 
        set udg_Draft_PlayerSpellsMaxIndex[PlayerNumber] = udg_Draft_PlayerSpellsMaxIndex[PlayerNumber] - 1
        set i = i + 1
       // call DisplayTextToForce( GetPlayersAll(), ( "loop: " + I2S(i) ) )
    endloop

endfunction

/*  THIS VERSION Spawns the buildings next to each other
    Only run once for the initial building creation, called by CreateDraftBuildings below.
    Calls GenerateDraftSpells once. 
    The first line might leak. 

function CreateDraftBuildingsLoop takes nothing returns nothing
    local location spawn = OffsetLocation(GetRectCenter(GetPlayableMapRect()), 200*(I2R(GetConvertedPlayerId(GetEnumPlayer())-5)), 500)
    set udg_Draft_DraftBuildings[GetConvertedPlayerId(GetEnumPlayer())] = CreateUnitAtLoc(GetEnumPlayer(), udg_Draft_DraftBuilding, spawn, 0)
    call GenerateDraftSpells(GetConvertedPlayerId(GetEnumPlayer()), udg_Draft_NODraftSpells)
    call RemoveLocation(spawn)
    set spawn = OffsetLocation(GetRectCenter(GetPlayableMapRect()), 200*(I2R(GetConvertedPlayerId(GetEnumPlayer())-5)), 700)
    set udg_Draft_UpgradeBuildings[GetConvertedPlayerId(GetEnumPlayer())] = CreateUnitAtLoc(GetEnumPlayer(), udg_Draft_UpgradeBuilding, spawn, 0)
    call RemoveLocation(spawn)
    set spawn = null
endfunction
*/
/*  THIS VERSION Spawns the buildings on top of each other
    Only run once for the initial building creation, called by CreateDraftBuildings below.
    Calls GenerateDraftSpells once. 
    The first line might leak. 
*/

function CreateDraftBuildingsLoop takes nothing returns nothing
    set udg_Draft_DraftBuildings[GetConvertedPlayerId(GetEnumPlayer())] = CreateUnit(GetEnumPlayer(), udg_Draft_DraftBuilding, 0 - OffsetX, OffsetY, 0)
    set udg_Draft_UpgradeBuildings[GetConvertedPlayerId(GetEnumPlayer())] = CreateUnit(GetEnumPlayer(), udg_Draft_UpgradeBuilding, OffsetX, OffsetY, 0)
    call GenerateDraftSpells(GetConvertedPlayerId(GetEnumPlayer()), udg_Draft_NODraftSpells)
endfunction

function CreateDraftBuildings takes nothing returns nothing
    if DraftInitialised == false then
        set DraftInitialised = true
        set circle1 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n038', 0-OffsetX, OffsetY, 0)
        set circle2 = CreateUnit(Player(PLAYER_NEUTRAL_PASSIVE), 'n037', OffsetX, OffsetY, 0)
        call ForForce( udg_force01, function CreateDraftBuildingsLoop )
    endif
endfunction

function DisableVision takes nothing returns nothing
    local integer i = 1
    local integer j
    loop
        set j = 1
        loop  
            if ( i != j ) then
                call SetPlayerAlliance(ConvertedPlayer(i), ConvertedPlayer(j), ALLIANCE_SHARED_VISION, false) 
            endif
            set j = j + 1 
            exitwhen j>8
        endloop
        
        set i = i + 1
        exitwhen i > 8
    endloop
endfunction

// Takes id for ability Draft Mode Rules
function SetDraftModeRules takes integer DraftRules returns nothing
    call BlzSetAbilityExtendedTooltip(DraftRules, "You get to choose between " + I2S(udg_Draft_NODraftSpells) + " spells each time.|nDraft spells refresh each time you buy one.|nEach spell only shows up once per game per player.", 0)
endfunction