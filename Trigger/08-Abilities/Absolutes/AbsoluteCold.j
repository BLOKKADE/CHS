library AbsoluteCold initializer init requires UnitHelpers, TempAbilSystem, DummyOrder

    globals
        Table AbsColdSlowImmunityTick
        Table AbsColdCdBonus
    endglobals

    function AbsoluteColdSlow takes unit source returns nothing
        local unit p = null
        local integer lvl = 0
        local integer hid = 0
        call GroupClear(ENUM_GROUP)

        call EnumTargettableUnitsInRange(ENUM_GROUP, GetUnitX(source), GetUnitY(source), 600, GetOwningPlayer(source), false, Target_Enemy)

        loop
            set p = FirstOfGroup(ENUM_GROUP)
            exitwhen p == null
            set hid = GetHandleId(p)
            if T32_Tick > AbsColdSlowImmunityTick.integer[hid] then
                set lvl = GetUnitAbilityLevel(p, 'A0DS')
                if lvl < 5 then
                    if lvl == 0 then
                        call TempAbil.create(p, 'A0DS', 20)
                    else
                        call SetUnitAbilityLevel(p, 'A0DS', lvl + 1)
                    endif
                    call BJDebugMsg("ac slow: " + I2S(GetUnitAbilityLevel(p, 'A0DS')))
                else
                    call BJDebugMsg("ac stun")
                    set GetUnitTempAbilityStruct(p, 'A0DS').stop = true
                    call DummyOrder.create(source, GetUnitX(p), GetUnitY(p), GetUnitFacing(p), 2).addActiveAbility(STUN_ABILITY_ID, 1, 852095).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_NORMAL, 2).setAbilityRealField(STUN_ABILITY_ID, ABILITY_RLF_DURATION_HERO, 2).target(p).activate()
                    set AbsColdSlowImmunityTick.integer[hid] = T32_Tick + (6 * 32)
                endif
            endif
            call GroupRemoveUnit(ENUM_GROUP, p)
        endloop
    endfunction

    private function init takes nothing returns nothing
        set AbsColdSlowImmunityTick= Table.create()
        set AbsColdCdBonus = Table.create()
    endfunction
endlibrary