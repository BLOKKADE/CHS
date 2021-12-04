library Pyromancer initializer init requires ElementalAbility, RandomShit

    globals
        Table ScorchedEarthDummy
        Table ScorchedEarthSource
        group PyromancerDamage
    endglobals

    function PyromancerFilter takes nothing returns boolean
        return IsUnitTarget(GetFilterUnit())
    endfunction

    function CreateScorches takes unit u, real x, real y, real area returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 4)
        set ScorchedEarthSource.boolean[GetHandleId(dummy.dummy)] = true
        call dummy.addActiveAbility('A0B5', 1, OrderId("flamestrike"))
        call dummy.setAbilityRealField('A0B5', ABILITY_RLF_AREA_OF_EFFECT, area)
        call dummy.point(x, y).activate()

        
    endfunction

    function PyromancerScorch takes unit source, unit target returns nothing
        local real x = GetUnitX(source)
        local real y = GetUnitY(source)
        local integer i = 5
        local real angle = Atan2(GetUnitY(target) - y, GetUnitX(target) - x)
        local real area = 99 + (1 * GetHeroLevel(source))
        local real xBonus = (area * 0.75) * Cos(GetAngleToTarget(source, target))
        local real yBonus = (area * 0.75) * Sin(GetAngleToTarget(source, target))
        local unit p
        
        call ElemFuncStart(source,'O005')

        call GroupClear(PyromancerDamage)

        loop
            set x = x + xBonus
            set y = y + yBonus
            if BlzGetUnitAbilityCooldownRemaining(source, 'A0B6') == 0 then
                call CreateScorches(source, x, y, area)
            endif
            call GroupEnumUnitsInRange(PyromancerDamage, x, y, area, Filter(function PyromancerFilter))
            set i = i - 1
            exitwhen i <= 0
        endloop

        if BlzGetUnitAbilityCooldownRemaining(source, 'A0B6') == 0 then
            call AbilStartCD(source, 'A0B6', 1)
        endif

        set i = BlzGroupGetSize(PyromancerDamage)

        loop
            set p = BlzGroupUnitAt(PyromancerDamage, i)
            if p != null and p != target and IsUnitEnemy(p, GetOwningPlayer(source)) then
                set GLOB_typeDmg = 2
                set DamageIsAttack = true
                call UnitDamageTarget(source, p, GetUnitDamage(source, 0), true, true, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
            endif
            set i = i - 1
            exitwhen i <= 0
        endloop

        set p = null
    endfunction

    private function init takes nothing returns nothing
        set ScorchedEarthSource = Table.create()
        set ScorchedEarthDummy = Table.create()
        set PyromancerDamage = CreateGroup()
    endfunction
endlibrary