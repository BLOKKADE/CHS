library CreepPeriodicAttack initializer init requires RandomShit

    globals
        private integer CurrentArenaIndex
    endglobals
    
    private function FilterForArenaCreep takes nothing returns boolean
        return (UnitAlive(GetFilterUnit()) == true) and (GetOwningPlayer(GetFilterUnit()) == Player(11))
    endfunction

    private function CreepAttackAction takes nothing returns nothing
        local location randomLocation = GetRandomLocInRect(PlayerArenaRects[CurrentArenaIndex])

        call IssuePointOrderLoc(GetEnumUnit(), "patrol", randomLocation)

        // Cleanup
        call RemoveLocation(randomLocation)
        set randomLocation = null
    endfunction

    private function CreepPeriodicAttackActions takes nothing returns nothing
        local group arenaCreeps

        set CurrentArenaIndex = 0
        loop
            exitwhen CurrentArenaIndex > 7

            // Get all creeps in arena
            set arenaCreeps = GetUnitsInRectMatching(PlayerArenaRects[CurrentArenaIndex], Condition(function FilterForArenaCreep))

            // Tell creeps to randomly patrol the arena
            call ForGroup(arenaCreeps, function CreepAttackAction)

            // Cleanup
            call DestroyGroup(arenaCreeps)
            set arenaCreeps = null

            set CurrentArenaIndex = CurrentArenaIndex + 1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set CreepPeriodicAttackTrigger = CreateTrigger()
        call TriggerRegisterTimerEventPeriodic(CreepPeriodicAttackTrigger, 6.00)
        call TriggerAddAction(CreepPeriodicAttackTrigger, function CreepPeriodicAttackActions)
    endfunction

endlibrary
