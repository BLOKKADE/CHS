library FanOfKnives
    function FanOfKnivesDamageBonus takes unit source, unit target, real damage, integer level returns real
        local real bonus = ((level * 0.0035) + 0.045)
        local real prevDamage = BlzGetAbilityRealField(BlzGetUnitAbility(target, FAN_OF_KNIVES_BUFF_ID), ABILITY_RLF_CAST_RANGE)

        
        if GetUnitAbilityLevel(target, FAN_OF_KNIVES_BUFF_ID) != 0 then
            set damage = prevDamage * (1 + bonus)
            call BJDebugMsg("fok, prev dmg: " + R2S(prevDamage) + ", new dmg: " + R2S(damage))
            call SetAbilityRealField(target, FAN_OF_KNIVES_BUFF_ID, 1, ABILITY_RLF_CAST_RANGE, damage)
        else
            call TempAbil.create(target, FAN_OF_KNIVES_BUFF_ID, 5)
        endif

        return damage
    endfunction
endlibrary