library BlackArrow
    function CastBlackArrow takes unit caster, unit target, integer level returns nothing
        local unit temp
        if GetRandomInt(0, 1) < 1 then
            set temp = CreateUnit(GetOwningPlayer(caster), SKELETON_WARMAGE_1_UNIT_ID, GetUnitX(target), GetUnitY(target), GetRandomInt(1,360))
        else
            set temp = CreateUnit(GetOwningPlayer(caster), SKELETON_BATTLEMASTER_1_UNIT_ID, GetUnitX(target), GetUnitY(target), GetRandomInt(1,360))
        endif
        call UnitApplyTimedLife(temp ,'BTLF', 60)
        call SetUnitAnimation(temp, "birth")
        set temp = null
    endfunction
endlibrary