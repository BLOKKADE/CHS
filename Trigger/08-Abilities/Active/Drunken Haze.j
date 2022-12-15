library DrunkenHaze requires PeriodicDamage, CastSpellOnTarget
    function StartDrunkenHazeIgnition takes unit caster, unit target, integer damageSourceAbilityId, real amount returns nothing
        call TempAbil.create(target, DRUNKEN_HAZE_IGNITE_BUFF_ID, 10)
        //call BJDebugMsg("parasite: " + GetUnitName(target) + " : " + I2S(GetHandleId(target)) + " lvl: " + I2S(lvl))
        if damageSourceAbilityId == BREATH_OF_FIRE_ABILITY_ID then
            call PeriodicDamage.create(caster, target, amount * 2, true, 1., 10, 0, true, DRUNKEN_HAZE_IGNITE_BUFF_ID, DRUNKEN_HAZE_ABILITY_ID).start()
        else
            call PeriodicDamage.create(caster, target, amount * 0.5, true, 1., 10, 0, true, DRUNKEN_HAZE_IGNITE_BUFF_ID, DRUNKEN_HAZE_ABILITY_ID).start()
        endif
        
    endfunction
endlibrary