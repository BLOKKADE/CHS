library PetFollow initializer init requires RandomShit

    globals
        private timer PetFollowIntervalTimer

        private real FollowInternal = 5.0
    endglobals

    private function TellPetsToFollow takes nothing returns nothing
        local integer i = 0
        local PlayerStats ps

        loop 
            exitwhen i > 8 // Max players?

            set ps = PlayerStats.forPlayer(Player(i))

            if (ps != 0 and ps.getPet() != null) then
                call IssueTargetOrder(ps.getPet(), "move", PlayerHeroes[i + 1])
            endif

            set i = i + 1
        endloop
    endfunction

    private function init takes nothing returns nothing
        set PetFollowIntervalTimer = CreateTimer()

        call TimerStart(PetFollowIntervalTimer, FollowInternal, true, function TellPetsToFollow)
    endfunction

endlibrary