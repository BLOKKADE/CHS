library FanOfKnives requires EditAbilityInfo
    function FanOfKnivesDamageBonus takes unit source, unit target, real damage, integer level returns real
        local real bonus = ((level * 0.0035) + 0.045)
        local real prevDamage = BlzGetAbilityRealLevelField(BlzGetUnitAbility(target, FAN_OF_KNIVES_BUFF_ID), ABILITY_RLF_CAST_RANGE, 0)

        
        if GetUnitAbilityLevel(target, FAN_OF_KNIVES_BUFF_ID) != 0 then
            set damage = BlzGetAbilityRealLevelField(BlzGetUnitAbility(target, FAN_OF_KNIVES_BUFF_ID), ABILITY_RLF_CAST_RANGE, 0) * (1 + ((level * 0.0035) + 0.045))
            //call BJDebugMsg("fok, prev dmg: " + R2S(prevDamage) + ", new dmg: " + R2S(damage))
            call SetAbilityRealField(target, FAN_OF_KNIVES_BUFF_ID, 1, ABILITY_RLF_CAST_RANGE, damage)
        else
            call TempAbil.create(target, FAN_OF_KNIVES_BUFF_ID, 5)
            call SetAbilityRealField(target, FAN_OF_KNIVES_BUFF_ID, 1, ABILITY_RLF_CAST_RANGE, damage)
        endif

        return damage
    endfunction
endlibrary