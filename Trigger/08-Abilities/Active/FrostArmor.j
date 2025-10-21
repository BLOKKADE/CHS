library FrostArmor requires RuneInit, AbilityCooldown, DummyOrder, GetRandomUnit, CastSpellOnTarget

    function CastFrostArmorDelayed takes nothing returns nothing
        local timer t = GetExpiredTimer()
        local unit caster = LoadUnitHandle(udg_Hashtable, GetHandleId(t), 0)
        local integer lvl = LoadInteger(udg_Hashtable, GetHandleId(t), 1)
        local unit target
        local integer i = 0

        call RUH.reset().doHeroPriority().checkMagicImmune()
        call RUH.EnumUnits(GetUnitX(caster), GetUnitY(caster), 500, Target_Ally, GetOwningPlayer(caster))

        loop
            set target = RUH.GetRandomUnit(true)
            exitwhen target == null or i > 5

            call CastSpell(caster, target, FROST_ARMOR_ABILITY_ID, lvl, Order_Target, 0, 0).activate()

            set i = i + 1
        endloop

        call AbilStartCD(caster, FROST_ARMOR_ABILITY_ID, 8)

        call FlushChildHashtable(udg_Hashtable, GetHandleId(t))
        call DestroyTimer(t)
    endfunction

    function CastFrostArmorOnSpellCast takes unit caster, integer lvl returns nothing
        local timer t = CreateTimer()
        call SaveUnitHandle(udg_Hashtable, GetHandleId(t), 0, caster)
        call SaveInteger(udg_Hashtable, GetHandleId(t), 1, lvl)
        call TimerStart(t, 0.50, false, function CastFrostArmorDelayed)
    endfunction

endlibrary
