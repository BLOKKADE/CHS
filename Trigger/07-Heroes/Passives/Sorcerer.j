library Sorcerer initializer init requires AbilityData, CastSpellOnTarget, StableSpells, FilteredSpellList
    globals
        Table SorcererAmount
        //Table SorcererList
    endglobals

    /*
    private function GetSorcererList takes integer hid returns IntegerList
        return SorcererList[hid]
    endfunction

    function SorcererHasActiveSpells takes unit u returns boolean
        //call BJDebugMsg("sorcerer list empty?: " + B2S(GetSorcererList(GetHandleId(u)).empty()))
        return not GetSorcererList(GetHandleId(u)).empty()
    endfunction

    function RemoveSorcererPassiveSpell takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        local IntegerList sorcererList = GetSorcererList(hid)
        if sorcererList != 0 then
            call sorcererList.removeElem(abilId)
        endif
    endfunction

    function SetSorcererPassiveSpells takes unit u, integer abilId returns nothing
        local integer hid = GetHandleId(u)
        local IntegerList sorcererList = 0
        if IsAbilityCasteable(abilId, false) and IsSpellResettable(abilId) then
            if SorcererList[hid] == 0 then
                set sorcererList = sorcererList.create()
                set SorcererList[hid] = sorcererList
                //call BJDebugMsg("created sorcerer list: ")
            endif
            //call BJDebugMsg("add: " + GetObjectName(abilId) + " added to sorcerer list")
            call GetSorcererList(hid).push(abilId)
        endif
    endfunction
    */

    function SorcerSpellListFilter takes unit u, integer abilId returns boolean
        return IsAbilityCasteable(abilId, false) and IsSpellResettable(abilId)
    endfunction

    function SorcererPassive takes unit caster, integer hid returns nothing
        local integer i = 0
        local integer amount = SorcererAmount[hid]
        local IntegerList sorcererList = GetFilterList(hid, SORCERER_UNIT_ID)
        local integer random = GetRandomInt(0, sorcererList.size() - 1)
        local IntegerListItem node = sorcererList.first
        local integer abilId = 0

        loop
            set random = GetRandomInt(0, sorcererList.size() - 1)
            set node = sorcererList.first
            set abilId = 0
            set i = 0

            loop
                set abilId = node.data
                exitwhen i == random
                set node = node.next
                set i = i + 1
            endloop

            call CastSpellAuto(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), 0, 0, 600).activate()
            set amount = amount - 1
            exitwhen amount == 0
        endloop
    endfunction

    private function init takes nothing returns nothing
        set SorcererAmount = Table.create()
    endfunction

endlibrary