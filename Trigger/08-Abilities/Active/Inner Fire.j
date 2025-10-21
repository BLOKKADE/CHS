library InnerFire requires RuneInit, AbilityCooldown, DummyOrder, GetRandomUnit, CastSpellOnTarget

    function CastInnerFire takes unit caster, unit target, integer lvl returns nothing
        if IsUnitSpellTargetCheck(caster, GetOwningPlayer(caster)) then
            call UniqueTempBonus(target, BONUS_DAMAGE, GetUnitBaseDamage(target, 0) * (0.1 * lvl), 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
            call UniqueTempBonus(target, BONUS_ARMOR, 10 * lvl, 15, INNER_FIRE_ABILITY_ID, INNER_FIRE_BUFF_ID)
        endif
    endfunction

    function CastInnerFireDelayed takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit caster = LoadUnitHandle(udg_Hashtable, GetHandleId(t), 0)
        local integer lvl = LoadInteger(udg_Hashtable, GetHandleId(t), 1)
        local unit target
        local integer i = 0

        call RUH.reset().doHeroPriority().checkMagicImmune()
        call RUH.EnumUnits(GetUnitX(caster), GetUnitY(caster), 500, Target_Ally, GetOwningPlayer(caster))

        loop
            set target = RUH.GetRandomUnit(true)
            exitwhen target == null

            call CastSpell(caster, target, INNER_FIRE_ABILITY_ID, lvl, Order_Target, 0, 0).activate()

            set i = i + 1
            exitwhen i > 5
        endloop

        call AbilStartCD(caster, INNER_FIRE_ABILITY_ID, 15)

        call FlushChildHashtable(udg_Hashtable, GetHandleId(t))
        call DestroyTimer(t)
    endfunction

    function CastInnerFireOnSpellCast takes unit caster, integer lvl returns nothing
        local timer t = CreateTimer()
        call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 0, caster)
        call SaveInteger(udg_Hashtable, GetHandleId(t), 1, lvl)
        call TimerStart(t, 0.50, false, function CastInnerFireDelayed)
    endfunction

endlibrary
