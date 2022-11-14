library PvpCountdownTimer initializer init requires RandomShit

    private function Trig_Countdown_Func001Func001C takes nothing returns boolean
        return CountdownCount > 0 and RoundNumber==1 and SpawnedHeroCount < PlayerCount
    endfunction

    private function Trig_Countdown_Func001Func002C takes nothing returns boolean
        return CountdownCount > 0 and udg_boolean09 == false
    endfunction

    private function PvpCountdownTimerConditions takes nothing returns boolean
        return Trig_Countdown_Func001Func001C() or Trig_Countdown_Func001Func002C()
    endfunction

    private function PvpCountdownTimerActions takes nothing returns nothing
        local integer playerArenaIndex = 0
        local location currentArenaLocation

        loop
            // Only display a number in the arena if there is a duel in it
            if (PlayerArenaRects[playerArenaIndex] != null) then
                // Tag needs to be in the center of the arena
                set currentArenaLocation = GetRectCenter(PlayerArenaRects[playerArenaIndex])

                // Display the number
                call CreateTextTagLocBJ(I2S(CountdownCount) + " ...", currentArenaLocation, 0.00, 40.00, 100, I2R(CountdownCount * 20), I2R(CountdownCount * 20), 0)
                call SetTextTagPermanentBJ(GetLastCreatedTextTag(), false)
                call SetTextTagFadepointBJ(GetLastCreatedTextTag(), 0.80)
                call SetTextTagLifespanBJ(GetLastCreatedTextTag(), 1.00)
                call PlaySoundBJ(udg_sound09) // Ticking noise

                // Cleanup
                call RemoveLocation(currentArenaLocation)
                set currentArenaLocation = null
            endif

            set playerArenaIndex = playerArenaIndex + 1

            exitwhen playerArenaIndex == 8
        endloop

        set CountdownCount = CountdownCount - 1

        // After a second, call this same trigger
        call TriggerSleepAction(1.00)
        call ConditionalTriggerExecute(GetTriggeringTrigger())
    endfunction

    private function init takes nothing returns nothing
        set PvpCountdownTimerTrigger = CreateTrigger()
        call TriggerAddCondition(PvpCountdownTimerTrigger, Condition(function PvpCountdownTimerConditions))
        call TriggerAddAction(PvpCountdownTimerTrigger, function PvpCountdownTimerActions)
    endfunction

endlibrary
