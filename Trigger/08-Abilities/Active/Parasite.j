library Parasite initializer init requires PeriodicDamage, DummyOrder

    globals
        HashTable ParasiteLimit
    endglobals

    function SummonParasite takes integer pid, unit target returns nothing
        local unit summon
        local real angle = GetUnitFacing(target) + 180.0 // Directly behind
        local real distance = 40.0 // How far behind
        local real x = GetUnitX(target) + distance * CosBJ(angle)
        local real y = GetUnitY(target) + distance * SinBJ(angle)

        set ParasiteLimit[pid].integer[GetHandleId(target)] = T32_Tick + (9 * 32)

        set summon = CreateUnit(Player(pid), PARASITE_1_UNIT_ID, x, y, GetUnitFacing(target))
        call UnitApplyTimedLife(summon, PARASITE_MINION_BUFF_ID, 20)
        set summon = null
    endfunction


    function CastParasite takes unit caster, unit target, integer lvl returns nothing
        local DummyOrder dummy = DummyOrder.create(caster, GetUnitX(caster), GetUnitY(caster), GetUnitFacing(caster), 6)
        call dummy.addActiveAbility(PARASITE_2_ABILITY_ID, 1, 852601)
        call dummy.target(target)
        call dummy.activate()
        //call BJDebugMsg("parasite: " + GetUnitName(target) + " : " + I2S(GetHandleId(target)) + " lvl: " + I2S(lvl))
        call PeriodicDamage.create(caster, target, 30 * lvl, true, 1., 30, 0, true, PARASITE_BUFF_ID, PARASITE_ABILITY_ID).start()
    endfunction

    private function init takes nothing returns nothing
        set ParasiteLimit = HashTable.create()
    endfunction

endlibrary
