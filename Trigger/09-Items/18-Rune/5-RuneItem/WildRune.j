globals
    hashtable udg_Hashtable = InitHashtable()
endglobals

library WildRune requires RandomShit

    function WildRune_RemoveAbility takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local integer id = GetHandleId(t)
        local unit u = LoadUnitHandle(udg_Hashtable, id, 0)

        call UnitRemoveAbility(u, 'WRBB')
        call FlushChildHashtable(udg_Hashtable, id)
        call DestroyTimer(t)

        set u = null
        set t = null
    endfunction

    function WildRune takes nothing returns boolean
        local unit u = GLOB_RUNE_U
        local timer t = CreateTimer()
        local integer id = GetHandleId(t)

        call UnitAddAbility(u, 'WRBB')
        call UnitMakeAbilityPermanent(u, false, 'WRBB')

        call SaveUnitHandle(udg_Hashtable, id, 0, u)
        call TimerStart(t, 5.0, false, function WildRune_RemoveAbility)

        return false
    endfunction

endlibrary
