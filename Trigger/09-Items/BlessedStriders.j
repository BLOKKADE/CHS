library BlessedStriders requires RemoveBuffs
    function UseBlessedStriders takes unit caster returns nothing
        local integer removed
        local real healAmount

        set removed = RemoveUnitBuffsAndHeal(caster, BUFFTYPE_NEGATIVE, false)
        set healAmount = removed * 0.10 * GetUnitState(caster, UNIT_STATE_MAX_LIFE)

        call SetUnitState(caster, UNIT_STATE_LIFE, GetUnitState(caster, UNIT_STATE_LIFE) + healAmount)

        //call BJDebugMsg("Blessed Striders healed " + R2S(healAmount) + " HP by removing " + I2S(removed) + " negative buff(s).")
    endfunction
endlibrary
