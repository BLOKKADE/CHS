library Blademaster initializer init requires AoeDamage, RandomShit
    globals
        Table BladestormAttackCounter
    endglobals

    function BladestormDamage takes unit u, real damage, boolean magic returns nothing
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        local unit dummy = CreateUnit(GetOwningPlayer(u),'h015', x, y, 0  )

        call UnitAddAbility(dummy, 'A090')
        call IssueImmediateOrderById(dummy, 852164)
        call UnitApplyTimedLife(dummy, 'BTLF', 1)
        call ElemFuncStart(u, 'N00K')
        if magic then
            call AreaDamage(u, x, y, (damage * 0.5) + (20 * GetHeroLevel(u)), 298 + (2 * GetHeroLevel(u)), 'N00K')
        else
            call AreaDamagePhys(u, x, y, (damage * 0.5) + (20 * GetHeroLevel(u)), 298 + (2 * GetHeroLevel(u)), 'N00K')
        endif

        set dummy = null
    endfunction

    function BladestormReady takes unit u returns boolean
        local integer hid = GetHandleId(u)

        if BladestormAttackCounter[hid] >= 8 then
            set BladestormAttackCounter[hid] = 0
            return true
        else
            set BladestormAttackCounter[hid] = BladestormAttackCounter[hid] + 1
        endif
        return false 
    endfunction

    private function init takes nothing returns nothing
        set BladestormAttackCounter = Table.create()
    endfunction
endlibrary