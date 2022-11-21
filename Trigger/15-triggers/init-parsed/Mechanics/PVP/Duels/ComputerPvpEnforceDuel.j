library ComputerPvpEnforceDuel initializer init requires RandomShit, PvpRoundRobin

    globals
        private rect TempArena
    endglobals
    
    private function IsDuelingComputerPlayer takes nothing returns boolean
        local unit currentUnit = GetFilterUnit()
        local player currentPlayer = GetOwningPlayer(currentUnit)
        local boolean isDuelingComputerPlayer = (IsUnitAliveBJ(currentUnit)==true) and (IsUnitInGroup(currentUnit, DuelingHeroGroup)==true) and (((GetPlayerSlotState(currentPlayer)!=PLAYER_SLOT_STATE_PLAYING)) or (GetPlayerController(currentPlayer)==MAP_CONTROL_COMPUTER))
        
        // Cleanup
        set currentUnit = null
        set currentPlayer = null

        return isDuelingComputerPlayer
    endfunction
 
    private function RandomlyAttackInArena takes nothing returns nothing
        local unit currentUnit = GetEnumUnit()
        local location randomLocation = GetRandomLocInRect(TempArena)
        
        // If the unit is still in the arena, attack somewhere in it
        if (RectContainsUnit(TempArena, currentUnit) == true) then
            call IssuePointOrderLocBJ(currentUnit, "attack", randomLocation)
        endif

        // Cleanup
        call RemoveLocation(randomLocation)
        set randomLocation = null
        set currentUnit = null
    endfunction
 
    private function ComputerPvpEnforceDuelActions takes nothing returns nothing
        local IntegerListItem node = DuelGameList.first
        local DuelGame currentDuelGame
        local group arenaUnits

        loop
            exitwhen node == 0
            
            set currentDuelGame = node.data

            if (currentDuelGame != 0 and (not currentDuelGame.isDuelOver)) then
                set TempArena = currentDuelGame.getDuelArena()

                // Find all computer player dueling heroes, make them randomly attack
                set arenaUnits = GetUnitsInRectMatching(TempArena, Condition(function IsDuelingComputerPlayer))
                call ForGroup(arenaUnits, function RandomlyAttackInArena)

                // Cleanup
                call DestroyGroup(arenaUnits)
                set arenaUnits = null
                set TempArena = null
            endif

            set node = node.next
        endloop
    endfunction
 
    private function init takes nothing returns nothing
        set ComputerPvpEnforceDuelTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(ComputerPvpEnforceDuelTrigger, 3.00)
        call TriggerAddAction(ComputerPvpEnforceDuelTrigger, function ComputerPvpEnforceDuelActions)
    endfunction
 
endlibrary
