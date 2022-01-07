library MaskOfVitality requires UnitHelpers

    function MaskOfVitality takes unit u returns nothing
        local unit p = null
        local real damage = GetUnitState(u, UNIT_STATE_MAX_LIFE) * 0.08
        //call BJDebugMsg("mov")
        call GroupClear(ENUM_GROUP)
        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(u), GetUnitY(u), 600, GetOwningPlayer(u), false, Target_Enemy)
        call SetUnitState(u, UNIT_STATE_LIFE, GetUnitState(u, UNIT_STATE_LIFE) - (GetUnitState(p, UNIT_STATE_MAX_LIFE) * 0.1))
        //call BJDebugMsg("mov: " + I2S(BlzGroupGetSize(ENUM_GROUP)))
        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            set udg_NextDamageAbilitySource = MASK_OF_VITALITY_ITEM_ID
            call Damage.applySpell(u, p, damage, DAMAGE_TYPE_MAGIC)
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction
endlibrary