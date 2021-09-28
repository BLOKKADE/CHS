library ManifoldStaff requires RandomShit, AbilityData, DummyOrder

    globals
        private group ManifoldGroup = CreateGroup()
    endglobals

    function ManifoldStaff takes unit caster, unit target, integer abilId, integer lvl returns nothing
        local integer i = 0
        local unit p = null
        local real range = BlzGetAbilityRealLevelField(BlzGetUnitAbility(caster, abilId), ABILITY_RLF_CAST_RANGE, lvl-1)
        local integer limit = 10
        local boolean ally = false
        local player owner = GetOwningPlayer(caster)
        local real mana = BlzGetAbilityManaCost(abilId, lvl) * 0.4
        local real x = GetUnitX(caster)
        local real y = GetUnitY(caster)
        if GetAbilityOrderType(abilId) == Order_Target then
            set SpellData[GetHandleId(caster)].boolean[8] = true
            
            call GroupClear(ManifoldGroup)
            call GroupAddUnit(ManifoldGroup, target)
            call RUH.reset().excludeGroup(ManifoldGroup)
            
            if IsUnitAlly(target, owner) then
                call RUH.checkAlly()
            endif

            call RUH.EnumUnits(x, y, range, owner)
            call GroupRemoveUnit(ManifoldGroup, target)

            loop
                set p = RUH.GetRandomUnit(false)
                exitwhen p == null or limit == 0
                if not IsUnitInGroup(p, ManifoldGroup) then
                    set limit = limit - 1
                    call GroupAddUnit(ManifoldGroup, p)
                endif
            endloop

            loop
                set p = FirstOfGroup(ManifoldGroup)
                exitwhen p == null or GetUnitState(caster, UNIT_STATE_MANA) - mana <= 0
                call SetUnitState(caster, UNIT_STATE_MANA, GetUnitState(caster, UNIT_STATE_MANA) - mana)
                call GroupRemoveUnit(ManifoldGroup, p)
                call CastSpell(caster, p, abilId, lvl, Order_Target, x, y).activate()
            endloop

            set SpellData[GetHandleId(caster)].boolean[8] = false
        endif

        set owner = null
    endfunction
endlibrary