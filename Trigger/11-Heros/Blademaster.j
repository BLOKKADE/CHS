library Blademaster initializer init requires AoeDamage, RandomShit
    globals
        Table BladestormAttackCounter
        Table BladestormAttackLimit
    endglobals

    function BladestormDamage takes unit u, real damage, boolean magic returns nothing
        local real x = GetUnitX(u)
        local real y = GetUnitY(u)
        local unit dummy = null
        
        if EffectVisible then
            set dummy = CreateUnit(GetOwningPlayer(u),PRIEST_1_UNIT_ID, x, y, 0  )
            call UnitAddAbility(dummy, 'A090')
            call IssueImmediateOrderById(dummy, 852164)
            call UnitApplyTimedLife(dummy, 'BTLF', 1)
        endif
        
        call ElemFuncStart(u, BLADE_MASTER_UNIT_ID)
        if magic then
            call AreaDamage(u, x, y, (damage * 0.5) + (35 * GetHeroLevel(u)), 297 + (3 * GetHeroLevel(u)), false, BLADE_MASTER_UNIT_ID)
        else
            call AreaDamagePhys(u, x, y, (damage * 0.5) + (35 * GetHeroLevel(u)), 297 + (3 * GetHeroLevel(u)), BLADE_MASTER_UNIT_ID)
        endif

        set dummy = null
    endfunction

    function BladestormReady takes unit u returns boolean
        local integer hid = GetHandleId(u)
        if BladestormAttackCounter[hid] >= BladestormAttackLimit[hid] then
            set BladestormAttackCounter[hid] = 0
            return true
        else
            set BladestormAttackCounter[hid] = BladestormAttackCounter[hid] + 1
        endif
        return false 
    endfunction

    private function init takes nothing returns nothing
        set BladestormAttackCounter = Table.create()
        set BladestormAttackLimit = Table.create()
    endfunction
endlibrary