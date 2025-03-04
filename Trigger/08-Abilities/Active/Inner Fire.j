library InnerFire requires RuneInit, AbilityCooldown, DummyOrder, GetRandomUnit, CastSpellOnTarget
    
    function CastInnerFire takes unit caster, unit target, integer lvl returns nothing
        if IsUnitSpellTargetCheck(caster, GetOwningPlayer(caster)) then
            call UniqueTempBonus(target, BONUS_DAMAGE, GetUnitBaseDamage(target, 0) * (0.1 * lvl), 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
            call UniqueTempBonus(target, BONUS_ARMOR, 10 * lvl, 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
        endif
    endfunction

    function CastInnerFireOnSpellCast takes unit caster, integer lvl returns nothing
        local integer i = 0
        local DummyOrder dummy
        local unit target = null

        loop
            set target = GetRandomUnit(GetUnitX(caster), GetUnitY(caster), 600, GetOwningPlayer(caster), Target_Ally, true, false)

            if target == null then
                exitwhen true
            endif

            call CastSpell(caster, target, INNER_FIRE_ABILITY_ID, lvl, Order_Target, 0, 0).activate()

            set i = i + 1
            exitwhen i >= 5
        endloop

        call AbilStartCD(caster, INNER_FIRE_ABILITY_ID, 15)
    endfunction
endlibrary