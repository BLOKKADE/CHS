library TimeManipulation initializer init requires AbilityCooldown
    globals
        HashTable TimeManipulationTable
    endglobals

    function TimeManipulationStart takes unit source, boolean chronusActivated returns nothing
        local integer hid = GetHandleId(source)
        local integer mult = 1

        if chronusActivated then
            set mult = 3
        endif
            
        //call BJDebugMsg("spell longest: " + R2S(TimeManipulationTable[hid].real[0]) + " + 10")
        //call BJDebugMsg("count bonus: " + R2S((TimeManipulationTable[hid].real[2])) + ", unit: " + I2S(hid))
        set TimeManipulationTable[hid].real[0] = 10 + (TimeManipulationTable[hid].real[2] * ((12.5 - ( 0.25 * GetUnitAbilityLevel(source, TIME_MANIPULATION_ABILITY_ID) )) * mult))
        call AbilStartCD(source, TIME_MANIPULATION_ABILITY_ID, TimeManipulationTable[hid].real[0])
        set TimeManipulationTable[hid].real[2] = TimeManipulationTable[hid].real[2] + 1
    endfunction

    function HeroHasChronusSpell takes unit u returns boolean
        local integer i = 0
        local integer abilId = 0
        loop
            set abilId = GetHeroSpellAtPosition(u, i)
            if abilId != 0 and IsTimeManipCdIncreasedByChronusSpell(abilId) then
                return true
            endif
            set i = i + 1
            exitwhen i > 10
        endloop

        return false
    endfunction

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)

        if GetUnitAbilityLevel(eventInfo.hero, TIME_MANIPULATION_ABILITY_ID) > 0 then
            set TimeManipulationTable[hid].boolean[1] = false
            set TimeManipulationTable[hid].real[2] = 0
            call BlzEndUnitAbilityCooldown(eventInfo.hero, TIME_MANIPULATION_ABILITY_ID)
        endif
    endfunction

    private function OnGameRoundstart takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)

        if GetUnitAbilityLevel(eventInfo.hero, TIME_MANIPULATION_ABILITY_ID) > 0 then
            set TimeManipulationTable[hid].boolean[1] = true
            call TimeManipulationStart(eventInfo.hero, HeroHasChronusSpell(eventInfo.hero))
        endif
    endfunction

    private function init takes nothing returns nothing
        set TimeManipulationTable = HashTable.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnGameRoundstart)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.OnRoundEnd)
    endfunction 
endlibrary
