library Whiteout requires RuneInit, AbilityCooldown

    function CastWhiteout takes unit hero, unit target, integer lvl returns nothing
        local real cooldownIncrease = 2.0 + I2R(lvl) * 0.1

        if IsUnitEnemy(target, GetOwningPlayer(hero)) and BlzGetUnitAbilityCooldownRemaining(hero, WHITEOUT_ABILITY_ID) <= 0 then
            call AbilStartCD(hero, WHITEOUT_ABILITY_ID, 16)
            call AddCooldowns(target, cooldownIncrease)
        endif
    endfunction

endlibrary
