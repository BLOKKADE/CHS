library InnerFire requires RuneInit
    function CastInnerFire takes unit caster, unit target, integer lvl returns nothing
        if IsUnitSpellTargetCheck(caster, GetOwningPlayer(caster)) then
            call UniqueTempBonus(target, BONUS_DAMAGE, GetUnitBaseDamage(target, 0) * (0.1 * lvl), 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
            call UniqueTempBonus(target, BONUS_ARMOR, 10 * lvl, 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
        endif
    endfunction
endlibrary