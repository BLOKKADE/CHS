library BlinkStrike initializer init requires RandomShit
    globals
        private integer OwnerId
        Table BlinkStrikeEnabled
    endglobals

    private function UnitIsAlive takes nothing returns boolean
        return GetWidgetLife(GetFilterUnit()) > 0.405 and IsUnitEnemy(GetFilterUnit(), Player(OwnerId)) and GetUnitAbilityLevel(GetFilterUnit(), 'Aloc') == 0 and GetUnitAbilityLevel(GetFilterUnit(), 'Avul') == 0
    endfunction

    private function BlinkAndStrike takes unit caster, unit target, integer level returns nothing
        local real angle = Atan2(GetUnitY(target) - GetUnitY(caster), GetUnitX(target) - GetUnitX(caster))*(180.00/ 3.14159)
        local real newX = GetUnitX(target) +80.00*Cos(angle*(3.14159/ 180.00))
        local real newY = GetUnitY(target) +80.00*Cos(angle*(3.14159/ 180.00))

        call DestroyEffect(AddSpecialEffect(FX_BLINK, GetUnitX(caster), GetUnitY(caster)))
        call DestroyEffect(AddSpecialEffect(FX_BLINK, newX, newY))

        call SetUnitX(caster, newX)
        call SetUnitY(caster, newY)
        call BlzSetUnitFacingEx(caster, angle - 180)
        set BlinkStrikeEnabled.boolean[GetHandleId(caster)] = true

        set GLOB_typeDmg = 2
        call UnitDamageTarget(caster, target, SpellData[GetHandleId(caster)].real[7], false, false, ATTACK_TYPE_NORMAL, DAMAGE_TYPE_NORMAL, null)
        set BlinkStrikeEnabled.boolean[GetHandleId(caster)] = false
    endfunction

    function BlinkStrike takes unit caster, integer level returns nothing
        local group g = CreateGroup()
        local unit target
        local integer size = 0
        local integer i = 0

        set OwnerId = GetPlayerId(GetOwningPlayer(caster))

        call GroupEnumUnitsInRange(g, GetUnitX(caster), GetUnitY(caster), 600 + (20 * level), Filter(function UnitIsAlive))
        set size = BlzGroupGetSize(g)
        loop
            set target = BlzGroupUnitAt(g, i)
            set i = i + 1
            exitwhen i >= size or IsUnitType(target, UNIT_TYPE_HERO)
        endloop

        if i >= size then
            set target = BlzGroupUnitAt(g, GetRandomInt(0, size - 1))
        endif

        if target != null then
            call BlinkAndStrike(caster, target, level)
        endif

        call DestroyGroup(g)
        set g = null
        set target = null
    endfunction

    private function init takes nothing returns nothing
        set BlinkStrikeEnabled = Table.create()
    endfunction
endlibrary