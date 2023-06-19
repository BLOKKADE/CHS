library CastSpellOnTarget requires UnitHelpers, AbilityData, GetRandomUnit

    //make sure to .activate() after calling this
    function CastSpell takes unit caster, unit target, integer abilId, integer level, integer orderType, real targetX, real targetY returns DummyOrder
        local integer order = GetAbilityOrder(abilId)
        local integer pid = GetPlayerId(GetOwningPlayer(caster))
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 21)
        call dummy.addActiveAbility(abilId, level, order)
        call dummy.setAbilityRealField(abilId, ABILITY_RLF_CAST_RANGE, 99999)

        if RuneOfChaosMagicPower.real[pid] != 0 then
            call AddUnitCustomState(dummy.dummy, BONUS_MAGICPOW, RuneOfChaosMagicPower.real[pid])
        endif

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
        
        return dummy
        //call BJDebugMsg("cs casted")
    endfunction

    function CastSpellAuto takes unit caster, unit target, integer abilId, integer abilLevel, real targetX, real targetY, real range returns DummyOrder
        local integer orderType = 0
        local integer targetType = 0
        local boolean getNewTarget = true
        if IsAbilityCasteable(abilId, false) then
            //call BJDebugMsg("casteable")
            set orderType = GetAbilityOrderType(abilId)
            set targetType = GetAbilityTargetType(abilId)

            if range == -1 then
                set range = GetAbilityRealField(caster, abilId, abilLevel, ABILITY_RLF_CAST_RANGE)
            elseif range > 600 then
                set range = 600
            endif

            //call BJDebugMsg(GetObjectName(abilId) + " : " + I2S(targetType) + " target: " + GetUnitName(target) + " range: " + R2S(range))
            if target != null and (targetType == Target_Enemy and IsUnitEnemy(target, GetOwningPlayer(caster))) or (targetType == Target_Ally and IsUnitAlly(target, GetOwningPlayer(caster)) or targetType == Target_Any) then
                set getNewTarget = false
                //call BJDebugMsg("no new target")
            endif
            
            if orderType == Order_Target then
                //call BJDebugMsg("target: " + GetUnitName(target))
                if getNewTarget then
                    if targetX != 0.0 and targetY != 0.0 then
                        set target = GetRandomUnit(targetX, targetY, range, GetOwningPlayer(caster), targetType, false, true)
                    else
                        set target = GetRandomUnit(GetUnitX(caster), GetUnitY(caster), range, GetOwningPlayer(caster), targetType, false, true)
                    endif
                endif

                //call BJDebugMsg(GetUnitName(target))
                return CastSpell(caster, target, abilId, abilLevel, orderType, GetUnitX(target), GetUnitY(target))
            else                   
                if orderType == Order_Point then
                    //call   BJDebugMsg("point")
                    if getNewTarget then
                        if targetX != 0.0 and targetY != 0.0 then
                            set target = GetRandomUnit(targetX, targetY, range, GetOwningPlayer(caster), targetType, false, true)
                        else
                            set target = GetRandomUnit(GetUnitX(caster), GetUnitY(caster), range, GetOwningPlayer(caster), targetType, false, true)
                        endif
                    endif
                    //call BJDebugMsg(GetUnitName(target))
                    if target == null then
                        if targetX != 0.0 and targetY != 0.0 then
                            return CastSpell(caster, target, abilId, abilLevel, orderType, targetX, targetY)
                        else
                            return CastSpell(caster, target, abilId, abilLevel, orderType, GetUnitX(caster)+ GetRandomReal(0, 200)* Cos(GetRandomReal(0,360)* bj_DEGTORAD), GetUnitY(caster)+ GetRandomReal(0, 200)* Sin(GetRandomReal(0,360)* bj_DEGTORAD))
                        endif
                    else
                        return CastSpell(caster, target, abilId, abilLevel, orderType, GetUnitX(target), GetUnitY(target))
                    endif
                elseif orderType == Order_Instant then
                    //call BJDebugMsg("instant")
                    return CastSpell(caster, null, abilId, abilLevel, orderType, GetUnitX(caster), GetUnitY(caster))
                endif
            endif
        endif 
        return false
    endfunction
endlibrary