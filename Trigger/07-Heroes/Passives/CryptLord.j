library CryptLord initializer init requires ElementalAbility, RandomShit, EditAbilityInfo
    globals
        Table LocustDummies
        Table CryptLordLocustCount
    endglobals

    private function OnRoundEnd takes EventInfo eventInfo returns nothing
        local integer hid
        local unit p

        if GetUnitTypeId(eventInfo.hero) == CRYPT_LORD_UNIT_ID then
            set hid  = GetHandleId(eventInfo.hero)
            if BlzGroupGetSize(LocustDummies.group[hid]) > 0 then

                loop
                    set p = BlzGroupUnitAt(LocustDummies.group[hid], 0)
                    
                    if p != null then
                        set GetDummyOrder(GetDummyId(p)).stopDummy = true
                        call GroupRemoveUnit(LocustDummies.group[hid], p)
                        call GetFollowUnitStruct(p).destroy()
                    else
                        exitwhen true
                    endif
                endloop
            endif
        endif
    endfunction

    private function OnRoundStart takes EventInfo eventInfo returns nothing
        local DummyOrder dummy
        local integer hid

        if GetUnitTypeId(eventInfo.hero) == CRYPT_LORD_UNIT_ID then
            set hid = GetHandleId(eventInfo.hero)
            set dummy = DummyOrder.create(eventInfo.hero, GetUnitX(eventInfo.hero), GetUnitY(eventInfo.hero), GetUnitFacing(eventInfo.hero), 9999)
            call ElemFuncStart(eventInfo.hero, CRYPT_LORD_UNIT_ID)
            call dummy.addActiveAbility('A02S', 1, 852556)
            call dummy.setAbilityIntegerField('A02S', ABILITY_ILF_NUMBER_OF_SWARM_UNITS, (CryptLordLocustCount[hid]))
            call dummy.instant().activate()
            call FollowUnitStruct.create(dummy.dummy, eventInfo.hero, 999999, 1)

            if LocustDummies.group[hid] == null then
                set LocustDummies.group[hid] = NewGroup()
            endif
            call GroupRefresh(LocustDummies.group[hid])
            call GroupAddUnit(LocustDummies.group[hid], dummy.dummy)
        endif
    endfunction

    private function init takes nothing returns nothing
        set LocustDummies = Table.create()
        set CryptLordLocustCount = Table.create()
        call CustomGameEvent_RegisterEventCode(EVENT_GAME_ROUND_START, CustomEvent.OnRoundStart)
        call CustomGameEvent_RegisterEventCode(EVENT_PLAYER_ROUND_COMPLETE, CustomEvent.OnRoundEnd)
    endfunction
endlibrary