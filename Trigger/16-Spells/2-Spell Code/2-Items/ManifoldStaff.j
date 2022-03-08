library ManifoldStaff requires RandomShit, AbilityData, DummyOrder, CastSpellOnTarget

    function ManifoldStaff takes unit caster, unit target, integer abilId, integer lvl returns nothing
        local integer i = 0
        local unit p = null
        local real range = BlzGetAbilityRealLevelField(BlzGetUnitAbility(caster, abilId), ABILITY_RLF_CAST_RANGE, lvl - 1)
        local integer limit = 10
        local boolean ally = false
        local player owner = GetOwningPlayer(caster)
        local real mana = BlzGetAbilityManaCost(abilId, lvl - 1) * 0.6
        local real x = GetUnitX(caster)
        local real y = GetUnitY(caster)
        local integer orderType = GetAbilityOrderType(abilId)

        if GetUnitTypeId(caster) == TIME_WARRIOR_UNIT_ID then
            set mana = 0
        endif

        if orderType == Order_Target or IsAbilityManifoldable(abilId) then
            set SpellData[GetHandleId(caster)].boolean[8] = true
            
            call GroupClear(ENUM_GROUP)
            call GroupAddUnit(ENUM_GROUP, target)
            call RUH.reset().excludeGroup(ENUM_GROUP)

            call RUH.EnumUnits(x, y, range, GetAbilityTargetType(abilId), owner)
            call GroupRemoveUnit(ENUM_GROUP, target)

            loop
                set p = RUH.GetRandomUnit(false)
                exitwhen p == null or limit == 0
                if not IsUnitInGroup(p, ENUM_GROUP) then
                    set limit = limit - 1
                    call GroupAddUnit(ENUM_GROUP, p)
                endif
            endloop

            //call BJDebugMsg("mana cost: " + R2S(mana))
            loop
                set p = FirstOfGroup(ENUM_GROUP)
                //call BJDebugMsg("new mana: " + R2S(GetUnitState(caster, UNIT_STATE_MANA) - mana))
                exitwhen p == null or GetUnitState(caster, UNIT_STATE_MANA) - mana <= 0
                call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - mana)
                call GroupRemoveUnit(ENUM_GROUP, p)
                call CastSpell(caster, p, abilId, lvl, Order_Target, x, y).activate()
            endloop

            set SpellData[GetHandleId(caster)].boolean[8] = false
        endif

        set owner = null
    endfunction
endlibrary