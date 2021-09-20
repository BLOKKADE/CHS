library CastSpellOnTarget requires UnitHelpers, AbilityData, ChannelOrder

    function GetAbilityRange takes unit u, integer abilityId returns real
        return BlzGetAbilityRealLevelField(BlzGetUnitAbility(u, abilityId), ABILITY_RLF_CAST_RANGE, GetUnitAbilityLevel(u, abilityId) - 1)
    endfunction

    function CastSpell takes unit caster, unit target, integer abilId, integer level, integer orderType, real targetX, real targetY returns nothing
        local integer order = GetAbilityOrder(abilId)
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 21)
        call dummy.addActiveAbility(abilId, level, order)
        call dummy.setAbilityRealField(abilId, ABILITY_RLF_CAST_RANGE, 99999)

        if orderType == Order_Instant then
            //call BJDebugMsg("cs instant")
            call dummy.instant()
        elseif orderType == Order_Target then
            //call BJDebugMsg("cs target")
            call dummy.target(target)
        elseif orderType == Order_Point then
            //call BJDebugMsg("cs point")
            call dummy.point(targetX, targetY)
        endif
        call dummy.activate()
        //call BJDebugMsg("cs casted")
    endfunction
endlibrary