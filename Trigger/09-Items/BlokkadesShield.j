library BlokkadesShield initializer init requires RandomShit, CustomGameEvent

    globals
        Table BlokShieldAttackCount
        Table BlokShieldCharges
        Table BlokShieldStartTick
        Table BlokShieldDmgReductionTick
    endglobals

    function SetBlokShieldCharges takes unit u, integer hid returns nothing
        call SetItemCharges(GetUnitItem(u, 'I0BD') , BlokShieldCharges[hid])
    endfunction

    function ActivateBlokkadeShield takes unit u returns nothing
        local integer hid = GetHandleId(u)
        if T32_Tick - BlokShieldDmgReductionTick[hid] > 64 and BlokShieldCharges[hid] > 0 then
            //call BJDebugMsg("bs activate")
            set BlokShieldCharges[hid] = BlokShieldCharges[hid] - 1
            set BlokShieldDmgReductionTick[hid] = T32_Tick
            call SetBlokShieldCharges(u, hid)
        endif
    endfunction

    private function OnGameRoundStart takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)

        if GetUnitAbilityLevel(eventInfo.hero, BLOKKADE_SHIELD_ABIL_ID) > 0 then
            set BlokShieldCharges[hid] = 0
            set BlokShieldStartTick[hid] = T32_Tick
            set BlokShieldAttackCount[hid] = 0
            call SetBlokShieldCharges(eventInfo.hero, hid)
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local integer hid = GetHandleId(eventInfo.hero)

        if GetUnitAbilityLevel(eventInfo.hero, BLOKKADE_SHIELD_ABIL_ID) > 0 then
            set BlokShieldCharges[hid] = BlokShieldCharges[hid] + 6
            call SetBlokShieldCharges(eventInfo.hero, hid)
        endif
    endfunction

    private function init takes nothing returns nothing
        set BlokShieldAttackCount = Table.create()
        set BlokShieldCharges = Table.create()
        set BlokShieldStartTick = Table.create()
        set BlokShieldDmgReductionTick = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnGameRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_START, CustomEvent.OnRoundStart)
    endfunction
endlibrary