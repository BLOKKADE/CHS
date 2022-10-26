library FanOfKnives
    function FanOfKnivesDamageBonus takes unit source, unit target, real damage, integer level returns real
        local real bonus = 0
        local integer bonusCount = BlzGetAbilityManaCost(FAN_OF_KNIVES_BUFF_ID, 0)

        if GetUnitAbilityLevel(target, FAN_OF_KNIVES_BUFF_ID) > 0 then
            set bonus = bonusCount * ((level * 0.0035)+ 0.045)
            call BlzSetUnitAbilityManaCost(target, FAN_OF_KNIVES_BUFF_ID, 0, bonusCount + 1)
        else
            call TempAbil.create(target, FAN_OF_KNIVES_BUFF_ID, 5)
        endif

        return damage * (1 + bonus)
    endfunction
endlibrary