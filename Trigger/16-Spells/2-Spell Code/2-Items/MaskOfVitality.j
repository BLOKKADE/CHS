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
            set udg_NextDamageAbilitySource = MASK_OF_VITALITY_ITEM_ID
            call Damage.applySpell(u, p, damage, DAMAGE_TYPE_MAGIC)
            call GroupRemoveUnit(MaskOfVitalityGroup, p)
        endloop
    endfunction
endlibrary