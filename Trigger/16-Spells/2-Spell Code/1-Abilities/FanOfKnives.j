library FanOfKnives
    function FanOfKnivesDamageBonus takes unit source, unit target, real damage, integer level returns real
        local real bonus = ((level * 0.0035) + 0.045)
        local integer prevDamage = BlzGetAbilityManaCost(FAN_OF_KNIVES_BUFF_ID, 0)

        
        if GetUnitAbilityLevel(target, FAN_OF_KNIVES_BUFF_ID) != 0 then
            set damage = prevDamage * (1 + bonus)
            call BJDebugMsg("fok, prev dmg: " + I2S(prevDamage) + ", new dmg: " + R2S(damage))
            call BlzSetUnitAbilityManaCost(target, FAN_OF_KNIVES_BUFF_ID, 0, R2I(damage))
        else
            call TempAbil.create(target, FAN_OF_KNIVES_BUFF_ID, 5)
        endif

        return damage
    endfunction
endlibrary