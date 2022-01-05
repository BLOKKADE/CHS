library InnerFire requires RuneInit
    function CastInnerFire takes unit caster, unit target, integer lvl returns nothing
        if IsUnitSpellTargetCheck(caster, GetOwningPlayer(caster)) then
            call TempBonus.create(target, BONUS_DAMAGE, GetUnitBaseDamage(target, 0) * (0.1 * lvl), 15).addBuffLink('Binf')
            call TempBonus.create(target, BONUS_ARMOR, 10 * lvl, 15).addBuffLink('Binf')
        endif
    endfunction
endlibrary