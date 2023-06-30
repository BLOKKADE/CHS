library Shockwave initializer init requires Table, CustomGameEvent
    globals
        private HashTable ShockwaveDamageBonus
        private real Multiplier = 1.1
        private real MultiplierLimit = 5
    endglobals

    function ResetShockwaveDamageBonus takes integer sourceHid returns nothing
        call ShockwaveDamageBonus[sourceHid].flush()
    endfunction

    function UpdateShockwaveDamageBonus takes integer sourceHid, integer targetHid returns nothing
        if ShockwaveDamageBonus[sourceHid].real[targetHid] >= MultiplierLimit or ShockwaveDamageBonus[sourceHid].real[targetHid] == 0 then
            set ShockwaveDamageBonus[sourceHid].real[targetHid] = 1
        else
            set ShockwaveDamageBonus[sourceHid].real[targetHid] = ShockwaveDamageBonus[sourceHid].real[targetHid] * Multiplier
        endif
    endfunction

    function GetShockwaveDamageBonus takes integer sourceHid, integer targetHid returns real
        return ShockwaveDamageBonus[sourceHid].real[targetHid]
    endfunction
    
    private function OnRoundStart takes EventInfo eventInfo returns nothing
        if GetUnitAbilityLevel(eventInfo.hero, SHOCKWAVE_ABILITY_ID) != 0 then
            call ResetShockwaveDamageBonus(GetHandleId(eventInfo.hero))
        endif
    endfunction

    private function init takes nothing returns nothing
        set ShockwaveDamageBonus = HashTable.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary
