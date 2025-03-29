library Potions

    function PotionHeal takes real hitPoints, real mana returns nothing
        if hitPoints > 0 then
            call SetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE, GetUnitState(GetTriggerUnit(), UNIT_STATE_LIFE) + hitPoints)
        endif

        if mana > 0 then
            call SetUnitState(GetTriggerUnit(), UNIT_STATE_MANA, GetUnitState(GetTriggerUnit(), UNIT_STATE_MANA) + mana)
        endif
    endfunction
endlibrary