library MaskOfVitality requires UnitHelpers

    globals
        group MaskOfVitalityGroup = CreateGroup()
    endglobals

    function MaskOfVitality takes unit u returns nothing
        local unit p = null
        local real damage = GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.08
        //call BJDebugMsg("mov")
        call GroupClear(MaskOfVitalityGroup)
        call EnumTargettableUnitsInRange(MaskOfVitalityGroup, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false)
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_MAX_LIFE) * 0.1))
        //call BJDebugMsg("mov: " + I2S(BlzGroupGetSize(MaskOfVitalityGroup)))
        loop
            set p = FirstOfGroup(MaskOfVitalityGroup)
            exitwhen p == null
            call UnitDamageTarget(u, p, damage, false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_MAGIC, null)
            call GroupRemoveUnit(MaskOfVitalityGroup, p)
        endloop
    endfunction
endlibrary