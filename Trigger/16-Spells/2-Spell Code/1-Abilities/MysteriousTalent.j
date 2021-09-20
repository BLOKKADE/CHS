library MysteriousTalent requires RandomShit, AbilityData, CastSpellOnTarget
    function MysteriousTalent takes unit caster returns nothing
        local integer i = 0
        local integer abilId
        local unit target
        local integer orderType = 0
        local real range = 0
        
        loop
            set abilId = GetInfoHeroSpell(caster, i)
            if IsAbilityCasteable(abilId) then
                //call BJDebugMsg("casteable")
                set orderType = GetAbilityOrderType(abilId)
                
                if orderType == Order_Target then
                    //call BJDebugMsg("target")
                    set target = GetRandomUnit(GetUnitX(caster), GetUnitY(caster), GetAbilityRange(caster, abilId), GetOwningPlayer(caster), GetAbilityTargetType(abilId), false, true)
                    //call BJDebugMsg(GetUnitName(target))
                    call CastSpell(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), orderType, GetUnitX(target), GetUnitY(target))
                else                   
                    if orderType == Order_Point then
                        //call BJDebugMsg("point")
                        set range = GetAbilityRange(caster, abilId)
                        set target = GetRandomUnit(GetUnitX(caster), GetUnitY(caster), range, GetOwningPlayer(caster), GetAbilityTargetType(abilId), false, true)
                        //call BJDebugMsg(GetUnitName(target))
                        if target == null then
                            call CastSpell(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), orderType, GetUnitX(caster)+GetRandomReal(0, range)*Cos(GetRandomReal(0,360)*bj_DEGTORAD), GetUnitY(caster)+GetRandomReal(0, range)*Sin(GetRandomReal(0,360)*bj_DEGTORAD))
                        else
                            call CastSpell(caster, target, abilId, GetUnitAbilityLevel(caster, abilId), orderType, GetUnitX(target), GetUnitY(target))
                        endif
                    elseif orderType == Order_Instant then
                        //call BJDebugMsg("instant")
                        call CastSpell(caster, null, abilId, GetUnitAbilityLevel(caster, abilId), orderType, GetUnitX(caster), GetUnitY(caster))
                    endif
                endif
            endif 
            set i = i + 1
            exitwhen i > 10
        endloop

        set target = null
    endfunction
endlibrary