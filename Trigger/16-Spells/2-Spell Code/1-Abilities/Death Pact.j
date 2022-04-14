library DeathPact
    function CastDeathPact takes unit caster, unit target, integer level returns nothing
        local real bonus = (0.05 * level) * GetUnitState(target, UNIT_STATE_LIFE)
        if (not IsHeroUnitId(GetUnitTypeId(target))) and GetUnitState(caster, UNIT_STATE_LIFE) <= GetUnitState(caster, UNIT_STATE_MAX_LIFE) then
            call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + bonus)
            call KillUnit(target)
        endif
    endfunction
endlibrary