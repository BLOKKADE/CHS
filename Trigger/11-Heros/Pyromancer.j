library Pyromancer initializer init requires ElementalAbility, RandomShit

    globals
        Table ScorchedEarthDummy
        Table ScorchedEarthSource
        group PyromancerDamage
        group PyromancerTemp
    endglobals

    function PyromancerFilter takes nothing returns boolean
        return IsUnitTarget(GetFilterUnit())
    endfunction

    function CreateScorches takes unit u, real x, real y, real area returns nothing
        local DummyOrder dummy = DummyOrder.create(u, GetUnitX(u), GetUnitY(u), GetUnitFacing(u), 4)
        set ScorchedEarthSource.boolean[GetDummyId(dummy.dummy)] = true
        call dummy.addActiveAbility('A0B5', 1, OrderId("flamestrike"))
        call dummy.setAbilityRealField('A0B5', ABILITY_RLF_AREA_OF_EFFECT, area)
        call dummy.point(x, y).activate()
    endfunction

    function PyromancerScorch takes unit source, unit target returns nothing
        local real x = GetUnitX(source)
        local real y = GetUnitY(source)
        local integer i = 3
        local real angle = GetAngleToTarget(source, target)
        local real area = 149 + (1 * GetHeroLevel(source))
        local real xBonus = (area * 0.75) * Cos(angle)
        local real yBonus = (area * 0.75) * Sin(angle)
        local unit p
        
        call ElemFuncStart(source,PYROMANCER_UNIT_ID)

        set PyromancerDamage = NewGroup()
        set PyromancerTemp = NewGroup()

        loop
            set x = x + xBonus
            set y = y + yBonus
            call GroupEnumUnitsInArea(PyromancerTemp, x, y, area, Filter(function PyromancerFilter))
            call GroupAddGroup(PyromancerTemp, PyromancerDamage)
            set i = i - 1
            exitwhen i <= 0
        endloop

        if BlzGetUnitAbilityCooldownRemaining(source, 'A0B6') == 0 then
            call AbilStartCD(source, 'A0B6', 1)
        endif

        set i = BlzGroupGetSize(PyromancerDamage)
        loop
            set p = FirstOfGroup(PyromancerDamage)
            exitwhen p == null
            if p != target and IsUnitEnemy(p, GetOwningPlayer(source)) then
                //set GLOB_typeDmg = 2
                //set DamageIsAttack = true
                set udg_NextDamageAbilitySource = PYROMANCER_UNIT_ID
                set udg_NextDamageIsAttack = true
                call Damage.applyPhys(source, p, GetUnitDamage(source, 0), true, ATTACK_TYPE_NORMAL, WEAPON_TYPE_WHOKNOWS)
            endif
            call GroupRemoveUnit(PyromancerDamage, p)
        endloop

        call ReleaseGroup(PyromancerDamage)
        call ReleaseGroup(PyromancerTemp)
        set PyromancerDamage = null
        set PyromancerTemp = null
        set p = null
    endfunction

    private function init takes nothing returns nothing
        set ScorchedEarthSource = Table.create()
        set ScorchedEarthDummy = Table.create()
    endfunction
endlibrary